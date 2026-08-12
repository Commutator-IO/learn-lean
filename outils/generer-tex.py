"""Produit un document LaTeX lisible à partir d'un fichier Lean de cours.

Rien n'est rédigé ici : tout le texte vient du fichier `.lean` lui-même.

  - le commentaire de tête `/- … -/`      → introduction du document ;
  - les sections `/-! ## Titre -/`        → sections LaTeX ;
  - les docstrings `/-- … -/`             → énoncé et démonstration en français ;
  - la déclaration Lean qui suit          → bloc de code, symboles convertis ;
  - les commentaires libres `/- … -/`     → remarques entre deux énoncés.

    python3 outils/generer-tex.py                 # tous les fichiers de cours/
    python3 outils/generer-tex.py chemin/vers/Fichier.lean

Le `.tex` est écrit à côté du `.lean`. Il se compile avec `tectonic` ou `pdflatex`.
"""

import re, sys, os

# --- conversion des symboles ------------------------------------------------

MATH = {
    "∣": r"\mid", "∤": r"\nmid", "∀": r"\forall", "∃": r"\exists", "≤": r"\le",
    "≥": r"\ge", "≠": r"\ne", "→": r"\to", "↔": r"\leftrightarrow", "⟺": r"\iff",
    "⟹": r"\implies", "∨": r"\lor", "∧": r"\land", "¬": r"\lnot", "∈": r"\in",
    "∉": r"\notin", "×": r"\times", "·": r"\cdot", "∘": r"\circ", "≡": r"\equiv",
    "ℕ": r"\mathbb{N}", "ℤ": r"\mathbb{Z}", "ℚ": r"\mathbb{Q}", "ℝ": r"\mathbb{R}",
    "√": r"\sqrt{}", "π": r"\pi", "ε": r"\varepsilon", "λ": r"\lambda",
    "α": r"\alpha", "β": r"\beta", "γ": r"\gamma", "δ": r"\delta", "σ": r"\sigma",
    "μ": r"\mu", "ℓ": r"\ell", "∑": r"\sum", "∏": r"\prod", "∫": r"\int",
    "⊆": r"\subseteq", "∅": r"\emptyset", "⁻¹": r"^{-1}",
}
# Rendus en mode mathématique dans le code comme dans la prose.
MATH.update({"⟨": r"\langle", "⟩": r"\rangle", "▸": r"\triangleright",
             "≫": r"\gg", "…": r"\dots"})
# Typographie française : guillemets et tiret cadratin, écrits en commandes pour
# rester lisibles quel que soit le moteur TeX.
TEXTE = {"«": r"\og{}", "»": r"\fg{}", "—": r"\textemdash{}", "–": r"\textendash{}"}

SPECIAUX = {"\\": r"\textbackslash{}", "{": r"\{", "}": r"\}", "$": r"\$",
            "&": r"\&", "#": r"\#", "%": r"\%", "_": r"\_", "^": r"\textasciicircum{}",
            "~": r"\textasciitilde{}"}

def code_latex(texte):
    """Échappe un extrait de code pour l'environnement `alltt`, en rendant les
    symboles mathématiques Unicode par leur commande LaTeX."""
    sortie = []
    for c in texte:
        if c in SPECIAUX:
            sortie.append(SPECIAUX[c])
        elif c in MATH:
            sortie.append(f"\\({MATH[c]}\\)")
        elif c in TEXTE:
            sortie.append(TEXTE[c])
        else:
            sortie.append(c)
    return "".join(sortie)

def prose_latex(texte):
    """Rend un commentaire français : `code` en machine à écrire, symboles en math."""
    morceaux = re.split(r"`([^`]*)`", texte)
    sortie = []
    for i, m in enumerate(morceaux):
        if i % 2:
            sortie.append(r"\texttt{" + code_latex(m) + "}")
        else:
            for c, r in SPECIAUX.items():
                if c != "\\":
                    m = m.replace(c, r)
            for c, r in MATH.items():
                m = m.replace(c, f"\\({r}\\)")
            for c, r in TEXTE.items():
                m = m.replace(c, r)
            sortie.append(m)
    return "".join(sortie)

# --- lecture du fichier Lean ------------------------------------------------

DECLARATION = re.compile(r"^(theorem|lemma|def|abbrev|instance|example)\s+([^\s({\[:]*)")

def lire(chemin):
    """Découpe le fichier en blocs : intro, sections, remarques, déclarations."""
    lignes = open(chemin, encoding="utf-8").read().split("\n")
    blocs, i, intro = [], 0, None

    def bloc_commentaire(i, ouvrant, fermant):
        """Renvoie (contenu, index suivant) pour un commentaire multi-lignes."""
        contenu, ligne = [], lignes[i][len(ouvrant):]
        while True:
            if fermant in ligne:
                contenu.append(ligne[:ligne.index(fermant)])
                return "\n".join(contenu).strip(), i + 1
            contenu.append(ligne)
            i += 1
            ligne = lignes[i]

    while i < len(lignes):
        ligne = lignes[i]
        if ligne.startswith("/-!"):
            texte, i = bloc_commentaire(i, "/-!", "-/")
            titre = texte.lstrip("#").strip()
            blocs.append(("section", titre))
        elif ligne.startswith("/--"):
            doc, i = bloc_commentaire(i, "/--", "-/")
            corps = []
            while i < len(lignes) and lignes[i].strip() != "":
                corps.append(lignes[i])
                i += 1
            m = DECLARATION.match(corps[0]) if corps else None
            blocs.append(("declaration", (m.group(1) if m else "", m.group(2) if m else "",
                                          doc, "\n".join(corps))))
        elif ligne.startswith("/-"):
            texte, i = bloc_commentaire(i, "/-", "-/")
            if intro is None and not blocs:
                intro = texte
            else:
                blocs.append(("remarque", texte))
        else:
            i += 1
    return intro, blocs

# --- écriture du document ---------------------------------------------------

ENTETE = r"""%% Fichier engendré par outils/generer-tex.py à partir de %(source)s.
%% Ne pas éditer à la main : tout le texte provient des commentaires du fichier Lean.
\documentclass[11pt,a4paper]{article}

%% Compile aussi bien avec pdflatex qu'avec xelatex ou tectonic.
\usepackage{iftex}
\ifPDFTeX
  \usepackage[T1]{fontenc}
  \usepackage[utf8]{inputenc}
\else
  \usepackage{fontspec}
\fi
\usepackage[french]{babel}
\usepackage{amsmath,amssymb,amsthm}
\usepackage{alltt}
\usepackage[margin=2.5cm]{geometry}

\theoremstyle{definition}
\newtheorem{definition}{Définition}
\theoremstyle{plain}
\newtheorem{theoreme}{Théorème}
\newtheorem{lemme}[theoreme]{Lemme}

%% Nom Lean de l'énoncé, sous celui-ci : les identifiants sont trop longs pour
%% tenir sur la ligne de titre d'un théorème.
\newcommand{\nom}[1]{\par\smallskip{\footnotesize\raggedright Lean~: \texttt{#1}\par}}

\title{%(titre)s}
\date{}

\begin{document}
\maketitle
%% Les identifiants Lean en machine à écrire ne se coupent pas : on tolère des
%% espacements plus lâches plutôt que des lignes qui débordent.
\sloppy
"""

def environnement(sorte, nom):
    if sorte in ("def", "abbrev", "instance"):
        return "definition"
    return "lemme" if nom.startswith("lemme") else "theoreme"

def convertir(chemin_lean):
    intro, blocs = lire(chemin_lean)
    source = os.path.basename(chemin_lean)
    titre = os.path.splitext(source)[0]

    out = [ENTETE % {"source": source, "titre": r"\texttt{" + code_latex(titre) + "}"}]
    if intro:
        out.append(r"\noindent")
        out.append(prose_latex(intro))
        out.append("")

    for sorte, contenu in blocs:
        if sorte == "section":
            out += [r"\section{" + prose_latex(contenu) + "}", ""]
        elif sorte == "remarque":
            out += [r"\noindent", prose_latex(contenu), ""]
        else:
            mot, nom, doc, corps = contenu
            env = environnement(mot, nom)
            out += [r"\begin{" + env + "}",
                    prose_latex(doc),
                    r"\nom{" + code_latex(nom) + "}",
                    r"\end{" + env + "}",
                    r"{\footnotesize\begin{alltt}",
                    code_latex(corps),
                    r"\end{alltt}}",
                    ""]

    out += [r"\end{document}", ""]
    chemin_tex = os.path.splitext(chemin_lean)[0] + ".tex"
    open(chemin_tex, "w", encoding="utf-8").write("\n".join(out))
    return chemin_tex, sum(1 for s, _ in blocs if s == "declaration")

def tous_les_fichiers():
    racine = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/cours"
    for dossier, _, fichiers in os.walk(racine):
        for f in sorted(fichiers):
            if f.endswith(".lean"):
                yield os.path.join(dossier, f)

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print(__doc__)
        raise SystemExit(1)
    fichiers = [sys.argv[1]] if len(sys.argv) == 2 else list(tous_les_fichiers())
    if not fichiers:
        print("aucun fichier .lean dans cours/")
    for chemin in fichiers:
        tex, n = convertir(chemin)
        print(f"{tex} : {n} déclarations")
