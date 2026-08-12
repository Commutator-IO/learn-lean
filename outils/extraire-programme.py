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

NIVEAUX = {"Sixième": "6e", "Cinquième": "5e", "Quatrième": "4e", "Troisième": "3e",
           # le cycle 3 couvre aussi l'école élémentaire, hors sujet ici
           "Cours moyen première année": None, "Cours moyen deuxième année": None}
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
    sortie, creux_puce = [], 0
    for ligne in lignes:
        nu = ligne.strip()
        if not nu:
            continue
        creux = len(ligne) - len(ligne.lstrip())
        puce = re.match(r"^[−–\-•]\s*(.*)", nu)
        if puce:
            sortie.append(puce.group(1))
            creux_puce = creux
        elif sortie and (creux > creux_puce or nu[0].islower()):
            sortie[-1] += " " + nu
        else:
            sortie.append(nu)
            creux_puce = creux
    return [re.sub(r"\s+", " ", i).strip(" .;") for i in sortie if len(i) > 3]

def sommaire(lignes, profondeurs):
    """Hiérarchie tirée du sommaire, et indice de la première ligne du corps.

    Le corps du document reprend la première entrée du sommaire : sa deuxième
    occurrence marque donc la fin du sommaire."""
    debut = next(i for i, l in enumerate(lignes) if l.strip() == "Sommaire")
    plan, fin, premiere = [], debut + 1, None
    for i, ligne in enumerate(lignes[debut + 1:], debut + 1):
        nu = ligne.strip()
        fin = i
        if not nu:
            continue
        if premiere is None:
            premiere = nu
        elif nu == premiere:
            break
        creux = len(ligne) - len(ligne.lstrip())
        if creux in profondeurs:
            plan.append((profondeurs[creux], nu))
    return plan, fin

def college():
    """[(domaine, niveau, thème, [objectifs])] pour les cycles 3 et 4."""
    resultat = []
    for nom in ("cycle3", "cycle4"):
        lignes = texte(nom)
        plan, debut = sommaire(lignes, {0: "titre", 2: "theme", 3: "theme"})
        titres = {t for p, t in plan if p == "titre"}
        themes = {t for p, t in plan if p == "theme"}
        domaines = titres - set(NIVEAUX) - RUBRIQUES
        domaine = niveau = theme = None
        rubrique, tampon = None, []

        def vider():
            if rubrique and rubrique.startswith("Objectifs") and tampon and theme and niveau:
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
    plan, _ = sommaire(lignes, {3: "domaine", 5: "theme", 6: "theme"})
    domaines = [t for p, t in plan if p == "domaine"]
    themes = [t for p, t in plan if p == "theme" and t not in
              ("Objectifs", "Histoire des mathématiques")]
    debut = next(i for i, l in enumerate(lignes)
                 if l.strip() == "Programme" and i > 30)
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


# --- écriture des listes ------------------------------------------------------

# Un objectif qui commence par l'un de ces verbes décrit un geste, pas une
# proposition : il ne se démontre pas, et reçoit le statut « — ».
GESTES = ("construire", "tracer", "reconnaitre", "reconnaître", "utiliser", "calculer",
          "placer", "lire", "représenter", "résoudre", "effectuer", "déterminer",
          "mesurer", "estimer", "convertir", "comparer", "ranger", "écrire", "passer",
          "modéliser", "programmer", "choisir", "interpréter", "exploiter", "produire",
          "réaliser", "compléter", "dénombrer", "organiser", "traiter", "vérifier",
          "contrôler", "simplifier", "décomposer", "additionner", "soustraire",
          "multiplier", "diviser", "encadrer", "arrondir", "repérer", "extraire",
          "manipuler", "mobiliser", "s’initier", "expérimenter", "trier", "classer")

def statut(enonce):
    premier = enonce.split()[0].lower().strip("’'")
    if "démontrer" in enonce.lower() or "démonstration" in enonce.lower():
        return "☐"
    return "—" if premier in GESTES else "☐"

def echapper(texte):
    return texte.replace("|", "\\|")

def conserves(quoi):
    """Chapitre des énoncés rédigés à la main, conservés à la suite du programme."""
    chemin = os.path.join(ROOT, "outils", f"enonces-conserves-{quoi}.md")
    if not os.path.exists(chemin):
        return []
    lignes = open(chemin, encoding="utf-8").read().split("\n")
    numero = 0
    for l in lignes:
        if l.startswith("## "):
            numero += 1
    return lignes

def ecrire_college():
    plan = college()
    ordre = []
    for domaine, _, _, _ in plan:
        if domaine not in ordre:
            ordre.append(domaine)
    out = ["# Programme du collège — objectifs d'apprentissage",
           "",
           "Liste extraite telle quelle des programmes officiels, par",
           "`python3 outils/extraire-programme.py` :",
           "",
           "- **6e** — programme de mathématiques du cycle 3, [BO n° 16 du 17 avril 2025]"
           "(https://www.education.gouv.fr/bo/2025/Hebdo16/MENE2504620A), en application"
           " depuis la rentrée 2025 ;",
           "- **5e, 4e, 3e** — programme du cycle 4, [BO n° 10 du 5 mars 2026]"
           "(https://www.education.gouv.fr/bo/2026/Hebdo10/MENE2602912A), en application en 5e"
           " à la rentrée 2026, en 4e en 2027, en 3e en 2028.",
           "",
           "Seuls les « objectifs d'apprentissage » sont repris ; les « automatismes » et les",
           "« prolongements possibles » du texte officiel ne donnent pas d'énoncés.",
           "",
           "Statuts : ☐ à formaliser · ◐ preuve en cours · ☑ démontré · ✗ non formalisable en",
           "l'état · **—** l'objectif décrit un geste (construire, calculer, tracer…) et non une",
           "proposition : il n'y a rien à démontrer.",
           "",
           "Se prolonge par le [programme du lycée](lycee.md). Fiches : [`cours/01-college/`]"
           "(cours/01-college/README.md).",
           "",
           "---",
           ""]
    for n, domaine in enumerate(ordre, 1):
        out += [f"## {n}. {domaine}", ""]
        for d, niveau, theme, objectifs in plan:
            if d != domaine:
                continue
            out += [f"### {niveau} — {theme}", "",
                    "| Objectif d'apprentissage | Niveau | Démontré |", "|---|---|---|"]
            for o in objectifs:
                out.append(f"| {echapper(o)} | {niveau} | {statut(o)} |")
            out.append("")
        out.append("---")
        out.append("")
    out += conserves("college")
    open(os.path.join(ROOT, "college.md"), "w", encoding="utf-8").write("\n".join(out))
    return sum(len(o) for _, _, _, o in plan)

CLASSES = [("seconde", "Seconde générale et technologique", "2de",
            "https://www.education.gouv.fr/bo/2026/Hebdo14/MENE2602914A"),
           ("premiere", "Première — enseignement de spécialité", "1re",
            "https://www.education.gouv.fr/bo/2026/Hebdo14/MENE2602917A"),
           ("terminale", "Terminale — enseignement de spécialité", "Tle",
            "https://www.education.gouv.fr/bo/2026/Hebdo14/MENE2602919A")]

def ecrire_lycee():
    out = ["# Programme du lycée — contenus",
           "",
           "Liste extraite telle quelle des programmes officiels, par",
           "`python3 outils/extraire-programme.py`. Les trois textes sont parus au",
           "[BO n° 14 du 2 avril 2026](https://www.education.gouv.fr/bo/2026/Hebdo14/) :",
           "seconde et spécialité de première en application à la rentrée 2026, spécialité de",
           "terminale à la rentrée 2027.",
           "",
           "Ce sont les « contenus » du texte officiel qui sont repris. Les énoncés dont le",
           "programme exige la démonstration portent la mention **démonstration exigible** :",
           "ce sont les premiers à formaliser.",
           "",
           "Statuts : ☐ à formaliser · ◐ preuve en cours · ☑ démontré · ✗ non formalisable en",
           "l'état · **—** l'item décrit un geste ou une notation, et non une proposition.",
           "",
           "Suite du [programme du collège](college.md). Fiches :"
           " [`cours/02-lycee/`](cours/02-lycee/README.md).",
           "",
           "---",
           ""]
    total = 0
    for n, (nom, titre, sigle, lien) in enumerate(CLASSES, 1):
        out += [f"## {n}. {titre}", "", f"Source : <{lien}>", ""]
        for domaine, theme, enonces in lycee(nom):
            out += [f"### {domaine} — {theme}", "",
                    "| Contenu | Classe | Démontré |", "|---|---|---|"]
            for enonce, exigible in enonces:
                texte_ = echapper(enonce) + (" **(démonstration exigible)**" if exigible else "")
                out.append(f"| {texte_} | {sigle} | {'☐' if exigible else statut(enonce)} |")
                total += 1
            out.append("")
        out += ["---", ""]
    out += conserves("lycee")
    open(os.path.join(ROOT, "lycee.md"), "w", encoding="utf-8").write("\n".join(out))
    return total

if __name__ == "__main__":
    print("college.md :", ecrire_college(), "objectifs")
    print("lycee.md   :", ecrire_lycee(), "contenus")
