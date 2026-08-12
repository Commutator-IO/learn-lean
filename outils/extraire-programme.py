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

def college():
    """Domaine -> [(niveau, sous-thème, [objectifs])] pour les cycles 3 et 4."""
    plan = []
    for nom in ("cycle3", "cycle4"):
        lignes = texte(nom)
        # le sommaire répète les titres : on démarre au second passage du 1er domaine
        depart = 0
        for i, l in enumerate(lignes):
            if l.strip() == "Nombres et calculs" and i > 5:
                depart = i
                break
        domaine = niveau = theme = None
        rubrique, tampon = None, []

        def vider():
            if rubrique in ("Objectifs d’apprentissage", "Objectifs d'apprentissage") and tampon:
                objectifs = items(tampon)
                if objectifs and domaine and theme:
                    plan.append((domaine, niveau, theme, objectifs))

        for ligne in lignes[depart:]:
            nu = ligne.strip()
            indente = ligne.startswith(" ")
            if not nu:
                continue
            if nu in RUBRIQUES and not indente:
                vider(); rubrique, tampon = nu, []
                continue
            if nu in NIVEAUX and not indente:
                vider(); rubrique, tampon = None, []
                niveau, theme = nu, None
                continue
            if not indente and re.match(r"^[A-ZÉÀÇ][^.!?]{3,70}$", nu) and not nu.endswith(":"):
                vider(); rubrique, tampon = None, []
                # un domaine réapparait en tête de page, un thème suit un niveau
                if nu in DOMAINES_COLLEGE:
                    domaine, theme = nu, None
                else:
                    theme = nu
                continue
            if rubrique:
                tampon.append(ligne)
        vider()
    return plan

DOMAINES_COLLEGE = {"Nombres et calculs", "Grandeurs et mesures", "Espace et géométrie",
                    "Organisation et gestion de données", "Proportionnalité, fonctions",
                    "Organisation et gestion de données et probabilités",
                    "La pensée informatique", "Algèbre", "Les fractions",
                    "Les nombres entiers et décimaux"}

def lycee(nom):
    """[(domaine, thème, [(énoncé, exigible)])] pour un programme de lycée."""
    lignes = texte(nom)
    depart = next((i for i, l in enumerate(lignes) if l.strip() == "Programme" and i > 3), 0)
    plan, domaine, theme = [], None, None
    rubrique, contenus, demos = None, [], []

    def vider():
        if theme and (contenus or demos):
            exig = " ".join(demos).lower()
            plan.append((domaine, theme,
                         [(c, any(mot in exig for mot in c.lower().split()[:4] if len(mot) > 5))
                          for c in contenus] + [(d, True) for d in demos if d not in contenus]))

    for ligne in lignes[depart + 1:]:
        nu = ligne.strip()
        if not nu:
            continue
        if nu in RUBRIQUES and not ligne.startswith("      "):
            rubrique = nu
            continue
        if not ligne.startswith(" ") and re.match(r"^[A-ZÉÀÇ][^.!?]{3,70}$", nu):
            vider()
            contenus, demos, rubrique = [], [], None
            if nu in DOMAINES_LYCEE:
                domaine, theme = nu, None
            else:
                theme = nu
            continue
        if rubrique == "Contenus":
            contenus.append(ligne)
        elif rubrique == "Démonstrations":
            demos.append(ligne)
    vider()
    return [(d, t, [(e, x) for e, x in lst]) for d, t, lst in plan]

DOMAINES_LYCEE = {"Nombres et calculs", "Géométrie", "Fonctions", "Statistiques et probabilités",
                  "Algorithmique et programmation", "Vocabulaire ensembliste et logique",
                  "Algèbre", "Analyse", "Probabilités et statistiques", "Automatismes"}

if __name__ == "__main__":
    print("collège :", len(college()), "blocs")
    for n in ("seconde", "premiere", "terminale"):
        print(n, ":", len(lycee(n)), "thèmes")
