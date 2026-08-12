"""Reconstruit college.md et lycee.md à partir des programmes officiels 2025-2026.

Les listes d'énoncés ne sont pas rédigées à la main : elles sont extraites des
annexes publiées au Bulletin officiel, dans leur formulation d'origine.

  cycle 3 (6e)   BO n° 16 du 17 avril 2025, arrêté du 10-4-2025
  cycle 4        BO n° 10 du 5 mars 2026, arrêté du 18-2-2026
  seconde        BO n° 14 du 2 avril 2026
  spé première   BO n° 14 du 2 avril 2026
  spé terminale  BO n° 14 du 2 avril 2026

Au collège, le programme distingue « Automatismes » (gestes à automatiser) et
« Objectifs d'apprentissage » : seuls les seconds sont repris, les premiers ne
donnant pas d'énoncés. Au lycée, ce sont les « Contenus » qui sont repris, et les
items figurant dans la rubrique « Démonstrations » sont signalés comme tels.

    python3 outils/extraire-programme.py        # télécharge, extrait, écrit les .md

Dépend de `pdftotext` (poppler) et d'un accès réseau.
"""

import os, re, subprocess, sys, urllib.parse

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.join(ROOT, ".programmes")
BASE = "https://www.education.gouv.fr/sites/default/files/"

SOURCES = {
    "cycle3": ("programme-de-math-matiques-pour-le-cycle-3-439827.pdf",
               "BO n° 16 du 17 avril 2025"),
    "cycle4": ("document/Annexe 2 – Programme de mathématiques pour le cycle 4-480716.pdf",
               "BO n° 10 du 5 mars 2026"),
    "seconde": ("document/Annexe – Programme d&#039;enseignement de mathématiques de la "
                "classe de seconde générale et technologique-515402.pdf",
                "BO n° 14 du 2 avril 2026"),
    "premiere": ("document/Annexe – Programme d&#039;enseignement de spécialité de "
                 "mathématiques de la classe de première de la voie générale-515408.pdf",
                 "BO n° 14 du 2 avril 2026"),
    "terminale": ("document/Annexe – Programme de l&#039;enseignement de spécialité de "
                  "mathématiques de la classe terminale de la voie générale-515414.pdf",
                  "BO n° 14 du 2 avril 2026"),
}

NIVEAUX = {"Sixième": "6e", "Cinquième": "5e", "Quatrième": "4e", "Troisième": "3e"}
RUBRIQUES = {"Automatismes", "Objectifs d’apprentissage", "Objectifs d'apprentissage",
             "Prolongements possibles : mises en perspective historiques et culturelles",
             "Contenus", "Capacités attendues", "Démonstrations", "Exemple d’algorithme",
             "Exemples d’algorithme", "Approfondissements possibles", "Commentaires",
             "Exemples d’activités", "Prolongements possibles"}

def texte(nom):
    """Télécharge le PDF si besoin et renvoie son texte."""
    os.makedirs(CACHE, exist_ok=True)
    pdf, txt = f"{CACHE}/{nom}.pdf", f"{CACHE}/{nom}.txt"
    if not os.path.exists(txt):
        if not os.path.exists(pdf):
            url = BASE + urllib.parse.quote(SOURCES[nom][0], safe="/")
            subprocess.run(["curl", "-sSfL", "-A", "Mozilla/5.0", "-o", pdf, url], check=True)
        subprocess.run(["pdftotext", "-layout", pdf, txt], check=True)
    return open(txt, encoding="utf-8").read().split("\n")

def items(lignes):
    """Regroupe les lignes d'une rubrique en items, en recollant les continuations."""
    sortie = []
    for ligne in lignes:
        nu = ligne.strip()
        if not nu:
            continue
        debut = re.match(r"^[−–\-•]\s*(.*)", nu)
        if debut:
            sortie.append(debut.group(1))
        elif sortie and (ligne.startswith("   ") or nu[0].islower()):
            sortie[-1] += " " + nu
        else:
            sortie.append(nu)
    return [re.sub(r"\s+", " ", i).strip(" .;") for i in sortie if len(i) > 3]

def sommaire(lignes, profondeurs):
    """Hiérarchie tirée du sommaire : [(niveau_indentation, titre)] jusqu'au corps."""
    debut = next(i for i, l in enumerate(lignes) if l.strip() == "Sommaire")
    plan, vus = [], set()
    for ligne in lignes[debut + 1:]:
        nu = ligne.strip()
        if not nu:
            continue
        creux = len(ligne) - len(ligne.lstrip())
        if nu in vus:                      # le corps recommence : le sommaire est fini
            break
        if creux in profondeurs:
            plan.append((profondeurs[creux], nu))
            vus.add(nu)
    return plan

def college():
    """[(domaine, niveau, thème, [objectifs])] pour les cycles 3 et 4."""
    resultat = []
    for nom in ("cycle3", "cycle4"):
        lignes = texte(nom)
        plan = sommaire(lignes, {0: "titre", 3: "theme"})
        titres = {t for p, t in plan if p == "titre"}
        themes = {t for p, t in plan if p == "theme"}
        domaines = titres - set(NIVEAUX)
        debut = next(i for i, l in enumerate(lignes)
                     if i > 5 and l.strip() in domaines and not l.startswith(" "))
        domaine = niveau = theme = None
        rubrique, tampon = None, []

        def vider():
            if rubrique and rubrique.startswith("Objectifs") and tampon and theme:
                objectifs = items(tampon)
                if objectifs:
                    resultat.append((domaine, niveau, theme, objectifs))

        for ligne in lignes[debut:]:
            nu = ligne.strip()
            if not nu:
                continue
            if nu in RUBRIQUES:
                vider(); rubrique, tampon = nu, []
            elif nu in NIVEAUX:
                vider(); rubrique, tampon = None, []
                niveau, theme = NIVEAUX[nu], None
            elif nu in domaines:
                vider(); rubrique, tampon = None, []
                domaine, theme = nu, None
            elif nu in themes and not rubrique:
                vider(); theme = nu
            elif nu in themes and rubrique and not ligne.startswith(" "):
                vider(); rubrique, tampon = None, []
                theme = nu
            elif rubrique:
                tampon.append(ligne)
        vider()
    return resultat

def lycee(nom):
    """[(domaine, thème, [(énoncé, démonstration exigible)])] pour un programme de lycée."""
    lignes = texte(nom)
    plan = sommaire(lignes, {3: "domaine", 5: "theme", 6: "theme"})
    domaines = [t for p, t in plan if p == "domaine"]
    themes = [t for p, t in plan if p == "theme"]
    debut = next(i for i, l in enumerate(lignes) if l.strip() == "Programme" and i > 3)
    resultat, domaine, theme = [], None, None
    rubrique, contenus, demos = None, [], []

    def vider():
        if not theme:
            return
        listes = items(contenus), items(demos)
        if any(listes):
            cles = [d.lower()[:40] for d in listes[1]]
            enonces = [(c, any(k in c.lower() for k in cles)) for c in listes[0]]
            enonces += [(d, True) for d in listes[1]
                        if not any(d.lower()[:40] in c.lower() for c, _ in enonces)]
            resultat.append((domaine, theme, enonces))

    for ligne in lignes[debut + 1:]:
        nu = ligne.strip()
        if not nu:
            continue
        if nu in RUBRIQUES and not ligne.startswith("    "):
            rubrique = nu
        elif nu in domaines and not ligne.startswith(" "):
            vider(); contenus, demos, rubrique = [], [], None
            domaine, theme = nu, None
        elif nu in themes and not ligne.startswith(" "):
            vider(); contenus, demos, rubrique = [], [], None
            theme = nu
        elif rubrique == "Contenus":
            contenus.append(ligne)
        elif rubrique == "Démonstrations":
            demos.append(ligne)
    vider()
    return resultat

if __name__ == "__main__":
    print("collège :", len(college()), "blocs")
    for n in ("seconde", "premiere", "terminale"):
        print(n, ":", len(lycee(n)), "thèmes")
