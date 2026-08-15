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

import json, os, re, sys

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
COURS = os.path.join(RACINE, "courses")
LIVRE = os.path.join(RACINE, "book")
TEXTES = os.path.join(LIVRE, "textes")

NIVEAUX = {"01-college": "collège", "02-lycee": "lycée"}


def themes():
    """Les thèmes et leurs chapitres, dans l'ordre de lecture.

    Le livre ne suit pas les cycles mais les notions : la divisibilité de
    sixième et l'arithmétique de terminale sont le même sujet, et les séparer
    en deux parties obligerait à traverser le livre pour suivre une idée.
    L'ordre est celui de `courses/themes.json`, partagé avec le site.
    """
    with open(os.path.join(COURS, "themes.json"), encoding="utf-8") as f:
        return json.load(f)["themes"]


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


def chapitres(theme):
    """Les chapitres d'un thème : identifiant, dossier, document."""
    for chemin in theme["chapitres"]:
        dossier = os.path.join(COURS, *chemin.split("/"))
        if not os.path.isdir(dossier):
            continue
        tex = [f for f in sorted(os.listdir(dossier)) if f.endswith(".tex")]
        lean = [f for f in os.listdir(dossier) if f.endswith(".lean")]
        if not tex or not lean:
            continue
        yield chemin.replace("/", "__"), dossier, os.path.join(dossier, tex[0])


def annonces():
    """Les chapitres qu'un thème appelle mais qui n'ont pas encore de preuve.

    Le livre n'imprime que ce qui est écrit ; un chapitre sans fichier Lean en
    est donc absent. Le taire serait laisser croire à un oubli — on le nomme.
    """
    out = []
    for theme in themes():
        for chemin in theme["chapitres"]:
            dossier = os.path.join(COURS, *chemin.split("/"))
            if not os.path.isdir(dossier):
                out.append(chemin)
            elif not any(f.endswith(".lean") for f in os.listdir(dossier)):
                out.append(chemin)
    return out


def orphelins():
    """Les chapitres qu'aucun thème ne recouvre : un oubli se signale."""
    connus = {c for t in themes() for c in t["chapitres"]}
    out = []
    for programme in NIVEAUX:
        base = os.path.join(COURS, programme)
        for nom in sorted(os.listdir(base)):
            dossier = os.path.join(base, nom)
            if not os.path.isdir(dossier):
                continue
            if not any(f.endswith(".lean") for f in os.listdir(dossier)):
                continue
            if f"{programme}/{nom}" not in connus:
                out.append(f"{programme}/{nom}")
    return out


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

    # Les figures sont rangées à côté du document de chapitre et appelées par un
    # chemin relatif, `\input{figures/x}`. Le livre se compile depuis book/ : le
    # chemin doit donc être réécrit, faute de quoi la figure disparaîtrait du
    # livre alors qu'elle est bien là dans le chapitre isolé.
    relatif = os.path.relpath(os.path.dirname(chemin), LIVRE)
    corps = corps.replace(r"\input{figures/", r"\input{" + relatif + "/figures/")
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

    for theme in themes():
        out += [r"\part{" + theme["titre"] + "}"]
        intro = liaison(theme["id"])
        if intro:
            out += [intro, ""]
        else:
            manquants.append(theme["id"])

        for identifiant, dossier, tex in chapitres(theme):
            sections = sections_du_chapitre(dossier)
            # Le niveau figure dans le titre du chapitre : le lecteur suit une
            # notion d'un bout à l'autre, mais doit savoir de quelle classe
            # relève ce qu'il lit.
            niveau = NIVEAUX[identifiant.split("__")[0]]
            out += [r"\chapter[" + titre_chapitre(dossier) + "]{"
                    + titre_chapitre(dossier)
                    + r"\\[2pt]\normalsize\normalfont\textit{" + niveau + "}}"]
            intro = liaison(identifiant)
            if intro:
                out += [intro, ""]
            else:
                manquants.append(identifiant)
            out += [corps(tex, sections), ""]

    # La bibliographie ferme le livre : les deux logiciels dont il dépend
    # demandent à être cités, et leurs entrées BibTeX sont reproduites pour
    # qu'on puisse les reprendre.
    biblio = os.path.join(LIVRE, "bibliographie.tex")
    if os.path.exists(biblio):
        out += [open(biblio, encoding="utf-8").read().strip(), ""]

    out += [r"\end{document}", ""]

    cible = os.path.join(LIVRE, "cours-complet.tex")
    open(cible, "w", encoding="utf-8").write("\n".join(out))
    return cible, manquants


def liste():
    print("livre                     ouverture du livre")
    for theme in themes():
        print(f"{theme['id']:<25} ouverture du thème « {theme['titre']} »")
        for identifiant, dossier, _ in chapitres(theme):
            print(f"{identifiant:<25} {titre_chapitre(dossier)}")


if __name__ == "__main__":
    if "--liste" in sys.argv:
        liste()
        raise SystemExit(0)

    cible, manquants = assembler()
    n = sum(1 for t in themes() for _ in chapitres(t))
    print(f"{os.path.relpath(cible, RACINE)} : {len(themes())} thèmes, {n} chapitres")
    perdus = orphelins()
    if perdus:
        print(f"chapitres hors thème ({len(perdus)}) — à ajouter à courses/themes.json :")
        for c in perdus:
            print("  " + c)
    attendus = annonces()
    if attendus:
        print(f"chapitres annoncés mais pas encore démontrés, absents du livre ({len(attendus)}) :")
        for c in attendus:
            print("  " + c)
    if manquants:
        print(f"textes de liaison manquants ({len(manquants)}) :")
        for m in manquants:
            print("  book/textes/" + m + ".tex")
