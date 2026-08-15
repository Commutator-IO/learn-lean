#!/usr/bin/env python3
"""Retrouve, pour chaque résultat de Mathlib employé dans `courses/`, sa source.

Une preuve de ce dépôt qui tient en une ligne — `exact Nat.dvd_add hb hc` — ne
montre rien : le raisonnement est ailleurs, dans une bibliothèque que le lecteur
n'ouvrira pas. Ce script écrit l'adresse de cet ailleurs. Le site en fait un lien,
et la transcription française s'en sert pour dire ce que la démonstration
empruntée fait réellement, plutôt que de citer un nom.

La résolution se fait ici, en local, parce qu'elle demande les sources de Mathlib ;
son résultat est versionné dans `courses/appuis.json`, que le site lit sans avoir
besoin de Lean. À relancer quand un fichier `.lean` cite un nouveau nom :

    python3 tools/liens-mathlib.py
"""

import json
import os
import re
import sys

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SORTIE = os.path.join(RACINE, "courses", "appuis.json")

# Les dépôts fouillés, avec l'adresse publique de leurs sources. Le noyau de Lean
# vient en dernier : une partie de l'arithmétique des entiers y est démontrée, et
# non dans Mathlib — `Nat.le_of_dvd` par exemple. Ses sources ne sont pas dans
# `.lake` mais dans la toolchain installée par elan.
DEPOTS = [
    ("mathlib", ".lake/packages/mathlib", "Mathlib",
     "https://github.com/leanprover-community/mathlib4/blob"),
    ("batteries", ".lake/packages/batteries", "Batteries",
     "https://github.com/leanprover-community/batteries/blob"),
    ("lean4", None, "Init",
     "https://github.com/leanprover/lean4/blob"),
]

def racine_toolchain():
    """Le dossier des sources de la toolchain, lu dans `lean-toolchain`."""
    nom = open(os.path.join(RACINE, "lean-toolchain"), encoding="utf-8").read().strip()
    dossier = nom.replace("/", "--").replace(":", "---")
    return os.path.expanduser(f"~/.elan/toolchains/{dossier}/src/lean")

# Les mots qui introduisent une déclaration nommée, modificateurs compris.
DECLARATION = re.compile(
    r"^(?:@\[[^\]]*\]\s*)?"
    r"(?:noncomputable |private |protected |nonrec |partial |unsafe |scoped |local )*"
    r"(?:theorem|lemma|def|abbrev|instance|structure|inductive|class|opaque|alias)\s+"
    r"([A-Za-z_][A-Za-z0-9_'’.!?]*)")

OUVRE = re.compile(r"^(namespace|section)\s+([A-Za-z_][A-Za-z0-9_'.]*)\s*$")
FERME = re.compile(r"^end(?:\s+([A-Za-z_][A-Za-z0-9_'.]*))?\s*$")

# Ce qu'on considère comme un nom de bibliothèque : les deux formes que les
# fichiers du dépôt n'emploient pas pour leurs variables locales. Même règle que
# `lien()` dans site/src/lib/lean.ts — les deux doivent rester d'accord.
QUALIFIE = re.compile(r"^[A-Z][A-Za-z0-9]*(?:\.[A-Za-z_][A-Za-z0-9_']*)+$")
SERPENT = re.compile(r"^[a-z][a-z0-9]*(?:_[a-z0-9']+)+$")
IDENTIFIANT = re.compile(r"[A-Za-z_][A-Za-z0-9_'.]*")


def declarations_du_depot(chemin, sous_dossier):
    """Tous les noms complets déclarés, avec leur fichier et leur ligne."""
    out = {}
    base = racine_toolchain() if chemin is None else os.path.join(RACINE, chemin)
    racine_src = os.path.join(base, sous_dossier)
    if not os.path.isdir(racine_src):
        return out
    for dossier, _, fichiers in os.walk(racine_src):
        for f in sorted(fichiers):
            if not f.endswith(".lean"):
                continue
            absolu = os.path.join(dossier, f)
            relatif = os.path.relpath(absolu, base)
            pile = []
            for n, ligne in enumerate(open(absolu, encoding="utf-8", errors="replace"), 1):
                nu = ligne.rstrip()
                m = OUVRE.match(nu)
                if m:
                    pile.append((m.group(1), m.group(2)))
                    continue
                m = FERME.match(nu)
                if m:
                    nom = m.group(1)
                    if nom is None:
                        if pile:
                            pile.pop()
                    else:
                        # `end A.B` referme autant de niveaux qu'il en nomme.
                        while pile:
                            _, ouvert = pile.pop()
                            if ouvert == nom or nom.endswith("." + ouvert) or ouvert.endswith("." + nom):
                                break
                    continue
                m = DECLARATION.match(nu)
                if m:
                    prefixe = ".".join(p for k, p in pile if k == "namespace")
                    nom = f"{prefixe}.{m.group(1)}" if prefixe else m.group(1)
                    # Le premier venu gagne : Mathlib redéclare peu, et une
                    # redéclaration serait un `alias` qu'on ne veut pas préférer.
                    out.setdefault(nom, (relatif, n))
    return out


def noms_employes():
    """Les identifiants de bibliothèque cités par les fichiers Lean du dépôt."""
    noms = set()
    for dossier, _, fichiers in os.walk(os.path.join(RACINE, "courses")):
        for f in fichiers:
            if not f.endswith(".lean"):
                continue
            for ligne in open(os.path.join(dossier, f), encoding="utf-8"):
                nu = ligne.split("--")[0]
                for mot in IDENTIFIANT.findall(nu):
                    if QUALIFIE.match(mot) or SERPENT.match(mot):
                        noms.add(mot)
    return noms


def noms_du_depot():
    """Les noms déclarés dans `courses/` : ce ne sont pas des emprunts."""
    noms = set()
    for dossier, _, fichiers in os.walk(os.path.join(RACINE, "courses")):
        for f in fichiers:
            if not f.endswith(".lean"):
                continue
            for ligne in open(os.path.join(dossier, f), encoding="utf-8"):
                m = DECLARATION.match(ligne.rstrip())
                if m:
                    noms.add(m.group(1))
    return noms


def revision(paquet):
    """La révision figée du paquet, lue dans le manifeste de lake.

    Le noyau n'y figure pas : sa version est celle de `lean-toolchain`, et le
    dépôt de Lean l'étiquette telle quelle.
    """
    if paquet == "lean4":
        return open(os.path.join(RACINE, "lean-toolchain"), encoding="utf-8").read().strip().split(":")[-1]
    manifeste = json.load(open(os.path.join(RACINE, "lake-manifest.json"), encoding="utf-8"))
    for p in manifeste.get("packages", []):
        if p.get("name") == paquet:
            return p.get("rev") or p.get("inputRev") or "master"
    return "master"


def main():
    employes = noms_employes() - noms_du_depot()
    tout, index = {}, {}
    for paquet, chemin, sous_dossier, base_url in DEPOTS:
        base = racine_toolchain() if chemin is None else os.path.join(RACINE, chemin)
        if not os.path.isdir(base):
            print(f"{base} absent — relancer après `lake build`", file=sys.stderr)
            continue
        declares = declarations_du_depot(chemin, sous_dossier)
        rev = revision(paquet)
        index[paquet] = len(declares)
        for nom, (fichier, ligne) in declares.items():
            if nom in tout:
                continue
            chemin_public = f"src/{fichier}" if paquet == "lean4" else fichier
            tout[nom] = {
                "paquet": paquet,
                "fichier": fichier,
                "ligne": ligne,
                "url": f"{base_url}/{rev}/{chemin_public}#L{ligne}",
            }

    trouves = {}
    for nom in employes:
        if nom in tout:
            trouves[nom] = tout[nom]
            continue
        # Un nom peut être cité sous une forme dérivée : `Nat.prime_def.symm`
        # désigne le champ `symm` du théorème `Nat.prime_def`. On renvoie alors au
        # résultat qui le porte, plutôt que de perdre le lien.
        #
        # La tête gardée doit rester qualifiée : sans cette exigence, `L.p` — où
        # `L` est une variable locale — se résoudrait au premier objet de Mathlib
        # qui se trouve s'appeler `L`, et le lecteur atterrirait sur les fonctions
        # L des formes modulaires.
        tete = nom
        while tete.count(".") >= 2:
            tete = tete.rsplit(".", 1)[0]
            if tete in tout:
                trouves[nom] = dict(tout[tete], via=tete)
                break

    os.makedirs(os.path.dirname(SORTIE), exist_ok=True)
    with open(SORTIE, "w", encoding="utf-8") as f:
        json.dump(dict(sorted(trouves.items())), f, ensure_ascii=False, indent=1)
        f.write("\n")

    manquants = sorted(employes - set(trouves))
    print(f"{SORTIE} : {len(trouves)} résultats situés sur {len(employes)} noms cités")
    for paquet, n in index.items():
        print(f"  {paquet} : {n} déclarations lues")
    if manquants:
        print(f"  {len(manquants)} sans source — noms engendrés (`to_additive`), "
              f"notations, ou déclarations de ce dépôt :")
        for nom in manquants[:12]:
            print(f"    {nom}")
        if len(manquants) > 12:
            print(f"    … et {len(manquants) - 12} autres")


if __name__ == "__main__":
    main()
