r"""Assemble le livre : les dix-sept chapitres en un seul document LaTeX.

Le livre ne contient pas une ligne de mathématiques de plus que les documents de
chapitre : il les reprend tels quels, dans l'ordre des programmes, et n'ajoute
que le texte de liaison écrit à la main dans `book/textes/` (voir la skill
`write-course-book`).

    python3 tools/generate-book.py            # écrit book/cours-complet.tex
    python3 tools/generate-book.py --liste    # affiche les identifiants attendus
                                              # dans book/textes/

Le fichier produit n'est pas versionné : il se reconstruit des chapitres, qui
restent la source. Il se compile avec `tectonic book/cours-complet.tex`.

Les niveaux de titre suivent : le `\section{Fichier}` d'un chapitre devient une
section du livre, ses `\subsection` restent des sous-sections, et le chapitre
lui-même devient un `\chapter`. Un chapitre dont tout tient en un seul fichier
Lean ne montre pas ce niveau intermédiaire, qui ne dirait rien.
"""

import os, re, sys

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
COURS = os.path.join(RACINE, "courses")
LIVRE = os.path.join(RACINE, "book")
TEXTES = os.path.join(LIVRE, "textes")

PARTIES = [
    ("01-college", "Collège", "college.md"),
    ("02-lycee", "Lycée — filière S", "lycee.md"),
]


def titre_chapitre(dossier):
    """Le titre lisible du chapitre, lu dans son index."""
    index = os.path.join(dossier, "README.md")
    if os.path.exists(index):
        for ligne in open(index, encoding="utf-8"):
            if ligne.startswith("# "):
                return ligne[2:].strip()
    return os.path.basename(dossier)


def sections_du_chapitre(dossier):
    """Le titre français de chaque fichier Lean, et leur ordre, lus dans l'index.

    Le document de chapitre range ses fichiers par ordre alphabétique — c'est
    l'ordre du disque, pas celui du programme. L'index, lui, suit le programme :
    il donne à la fois le bon ordre et un titre lisible, `Entiers, divisibilité`
    plutôt que `EntiersDivisibilite`.
    """
    index = os.path.join(dossier, "README.md")
    ordre, titre_courant = [], None
    for ligne in open(index, encoding="utf-8"):
        if ligne.startswith("## "):
            titre_courant = ligne[3:].strip()
        m = re.match(r"Fichier : `([^`]+)\.lean`", ligne)
        if m and titre_courant:
            ordre.append((m.group(1), titre_courant))
    return ordre


def chapitres(partie):
    base = os.path.join(COURS, partie)
    for nom in sorted(os.listdir(base)):
        dossier = os.path.join(base, nom)
        if not os.path.isdir(dossier):
            continue
        tex = [f for f in sorted(os.listdir(dossier)) if f.endswith(".tex")]
        lean = [f for f in os.listdir(dossier) if f.endswith(".lean")]
        if not tex or not lean:
            continue
        yield f"{partie}__{nom}", dossier, os.path.join(dossier, tex[0])


def corps(chemin, sections):
    """Le corps d'un document de chapitre, prêt à être inséré dans le livre.

    Les sections sont remises dans l'ordre de l'index — celui du programme — et
    reçoivent leur titre français. Un chapitre d'un seul fichier perd ce niveau,
    qui n'apprendrait rien au lecteur du livre.
    """
    src = open(chemin, encoding="utf-8").read()
    debut = src.index(r"\begin{document}") + len(r"\begin{document}")
    fin = src.index(r"\end{document}")
    corps = src[debut:fin]

    # Ce qui appartient au document isolé et non au livre : sa page de titre,
    # sa citation de fin, et les réglages de composition déjà faits par le
    # préambule du livre.
    corps = corps.replace(r"\maketitle", "").replace(r"\sloppy", "")
    corps = re.sub(r"\\vfill\s*\n\\noindent\\rule.*?\\par\}", "", corps, flags=re.S)
    corps = "\n".join(l for l in corps.split("\n") if not l.lstrip().startswith("%"))

    if len(sections) <= 1:
        return re.sub(r"\\section\{[^}]*\}\s*", "", corps, count=1).strip()

    # Découpe par `\section{Module}`, puis remontage dans l'ordre de l'index.
    morceaux, courant, entete = {}, None, []
    for bloc in re.split(r"(\\section\{[^}]*\})", corps):
        m = re.match(r"\\section\{([^}]*)\}", bloc)
        if m:
            courant = m.group(1)
            morceaux[courant] = []
        elif courant is None:
            entete.append(bloc)
        else:
            morceaux[courant].append(bloc)

    out = ["".join(entete).strip()]
    for module, titre in sections:
        if module not in morceaux:
            continue
        out += ["", r"\section{" + titre + "}", "".join(morceaux[module]).strip()]
    return "\n".join(x for x in out if x).strip()


def liaison(identifiant):
    """Le texte de liaison écrit à la main, s'il existe."""
    chemin = os.path.join(TEXTES, f"{identifiant}.tex")
    if not os.path.exists(chemin):
        return None
    return open(chemin, encoding="utf-8").read().strip()


def assembler():
    manquants = []
    out = [open(os.path.join(LIVRE, "preambule.tex"), encoding="utf-8").read().rstrip()]
    out += ["", r"\begin{document}", r"\maketitle", r"\sloppy", ""]

    ouverture = liaison("livre")
    if ouverture:
        out += [r"\chapter*{Avant-propos}", r"\addcontentsline{toc}{chapter}{Avant-propos}",
                ouverture, ""]
    else:
        manquants.append("livre")

    out += [r"\tableofcontents", r"\cleardoublepage", ""]

    for partie, titre, _ in PARTIES:
        out += [r"\part{" + titre + "}"]
        intro = liaison(partie)
        if intro:
            out += [intro, ""]
        else:
            manquants.append(partie)

        for identifiant, dossier, tex in chapitres(partie):
            sections = sections_du_chapitre(dossier)
            out += [r"\chapter{" + titre_chapitre(dossier) + "}"]
            intro = liaison(identifiant)
            if intro:
                out += [intro, ""]
            else:
                manquants.append(identifiant)
            out += [corps(tex, sections), ""]

    out += [r"\end{document}", ""]

    cible = os.path.join(LIVRE, "cours-complet.tex")
    open(cible, "w", encoding="utf-8").write("\n".join(out))
    return cible, manquants


def liste():
    print("livre                     ouverture du livre")
    for partie, titre, _ in PARTIES:
        print(f"{partie:<25} ouverture de la partie « {titre} »")
        for identifiant, dossier, _ in chapitres(partie):
            print(f"{identifiant:<25} {titre_chapitre(dossier)}")


if __name__ == "__main__":
    if "--liste" in sys.argv:
        liste()
        raise SystemExit(0)

    cible, manquants = assembler()
    n = sum(1 for p, _, _ in PARTIES for _ in chapitres(p))
    print(f"{os.path.relpath(cible, RACINE)} : {n} chapitres")
    if manquants:
        print(f"textes de liaison manquants ({len(manquants)}) :")
        for m in manquants:
            print("  book/textes/" + m + ".tex")
