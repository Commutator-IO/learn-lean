"""Produit un document LaTeX lisible à partir d'un fichier Lean de cours.

Rien n'est rédigé ici : tout le texte vient du fichier `.lean` lui-même.

  - le commentaire de tête `/- … -/`      → introduction du document ;
  - les sections `/-! ## Titre -/`        → sections LaTeX ;
  - les docstrings `/-- … -/`             → énoncé et démonstration en français ;
  - la déclaration Lean qui suit          → lien GitHub vers ses lignes ;
  - les commentaires libres `/- … -/`     → remarques entre deux énoncés.

Le document se termine par la citation de Lean recommandée par ses auteurs
(<https://lean-lang.org/learn/#how-to-cite-lean>).

Le code Lean n'est pas recopié dans le document : chaque énoncé renvoie au fichier
source, sur la branche et aux lignes exactes de sa déclaration.

    python3 outils/generer-tex.py                 # tous les fichiers de cours/
    python3 outils/generer-tex.py chemin/vers/Fichier.lean

Le `.tex` est écrit à côté du `.lean`, et **n'est jamais réécrit s'il existe déjà** :
les démonstrations en français qu'on y ajoute (voir la skill `transcrire-preuve-lean`)
sont donc conservées. Pour repartir d'un squelette neuf, supprimer le `.tex`.

Il se compile avec `tectonic` ou `pdflatex`.
"""

import re, sys, os, subprocess, unicodedata

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

# --- lien vers la source ----------------------------------------------------

def camel(titre):
    """Nom de fichier en CamelCase à partir d'un titre."""
    t = unicodedata.normalize("NFKD", titre).encode("ascii", "ignore").decode()
    t = re.sub(r"^\d+[-_. ]*", "", t)
    return "".join(m.capitalize() for m in re.split(r"[^A-Za-z0-9]+", t) if m)

def racine_depot(chemin):
    return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def base_github(racine):
    """URL GitHub du dépôt, sur la branche courante, déduite du remote `origin`."""
    def git(*args):
        return subprocess.run(("git", "-C", racine) + args, capture_output=True,
                              text=True).stdout.strip()
    remote = git("remote", "get-url", "origin")
    branche = git("rev-parse", "--abbrev-ref", "HEAD") or "main"
    m = re.match(r"(?:git@github\.com:|https://github\.com/)(.+?)(?:\.git)?$", remote)
    if not m:
        return None
    return f"https://github.com/{m.group(1)}/blob/{branche}"

# --- lecture du fichier Lean ------------------------------------------------

# les modificateurs (noncomputable, private…) précèdent le mot-clé
DECLARATION = re.compile(
    r"^(?:noncomputable |private |protected |partial |unsafe )*"
    r"(theorem|lemma|def|abbrev|instance|example)\s+([^\s({\[:]*)")

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
            debut, fin = i - len(corps) + 1, i          # lignes 1-indexées
            blocs.append(("declaration", (m.group(1) if m else "", m.group(2) if m else "",
                                          doc, debut, fin)))
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
\usepackage[margin=2.5cm]{geometry}
\usepackage[hidelinks]{hyperref}

\theoremstyle{definition}
\newtheorem{definition}{Définition}
\theoremstyle{plain}
\newtheorem{theoreme}{Théorème}
\newtheorem{lemme}[theoreme]{Lemme}

%% Renvoi à la déclaration Lean, une ligne après la démonstration, aligné à droite.
\newcommand{\source}[2]{\par\smallskip\noindent\hfill{\footnotesize\href{#1}{\texttt{#2}}}\par\smallskip}

\title{%(titre)s}
\date{}

\begin{document}
\maketitle
%% Les identifiants Lean en machine à écrire ne se coupent pas : on tolère des
%% espacements plus lâches plutôt que des lignes qui débordent.
\sloppy
"""

# Référence de Lean, donnée discrètement en pied de document
# (https://lean-lang.org/learn/#how-to-cite-lean)
CITATION = r"""\vfill
\noindent\rule{0.35\linewidth}{0.4pt}\par
\noindent{\footnotesize Leonardo de Moura et Sebastian Ullrich,
\emph{The Lean~4 Theorem Prover and Programming Language},
\emph{Automated Deduction — CADE~28}, Springer, 2021, p.~625--635,
\href{https://doi.org/10.1007/978-3-030-79876-5_37}{doi:10.1007/978-3-030-79876-5\_37}.\par}
"""

def environnement(sorte, nom):
    if sorte in ("def", "abbrev", "instance"):
        return "definition"
    return "lemme" if nom.startswith("lemme") else "theoreme"

def titre_chapitre(dossier):
    """Titre lisible du chapitre, lu dans son index."""
    index = os.path.join(dossier, "README.md")
    if os.path.exists(index):
        for ligne in open(index, encoding="utf-8"):
            if ligne.startswith("# "):
                return ligne[2:].strip()
    return os.path.basename(dossier)

def convertir(dossier):
    """Un document par chapitre : une section par fichier Lean du dossier."""
    fichiers = sorted(f for f in os.listdir(dossier) if f.endswith(".lean"))
    if not fichiers:
        return None, 0
    racine = racine_depot(dossier)
    base = base_github(racine)
    titre = titre_chapitre(dossier)
    chemin_tex = os.path.join(dossier, camel(titre) + ".tex")
    if os.path.exists(chemin_tex):
        return chemin_tex, None

    out = [ENTETE % {"source": os.path.basename(dossier), "titre": prose_latex(titre)}]
    total = 0
    for fichier in fichiers:
        intro, blocs = lire(os.path.join(dossier, fichier))
        relatif = os.path.relpath(os.path.abspath(os.path.join(dossier, fichier)), racine)
        out += [r"\section{" + code_latex(os.path.splitext(fichier)[0]) + "}", ""]
        if intro:
            out += [r"\noindent", prose_latex(intro), ""]
        total += ecrire_blocs(out, blocs, base, relatif, fichier)
    out += [CITATION, r"\end{document}", ""]
    open(chemin_tex, "w", encoding="utf-8").write("\n".join(out))
    return chemin_tex, total

def ecrire_blocs(out, blocs, base, relatif, source):
    """Ajoute au document les blocs d'un fichier Lean ; renvoie le nombre d'énoncés."""
    total = 0
    for sorte, contenu in blocs:
        if sorte == "section":
            out += [r"\subsection{" + prose_latex(contenu) + "}", ""]
        elif sorte == "remarque":
            out += [r"\noindent", prose_latex(contenu), ""]
        else:
            mot, nom, doc, debut, fin = contenu
            env = environnement(mot, nom)
            lignes = f"L{debut}"
            # « # » est le caractère de paramètre de TeX : il doit être échappé
            # jusque dans une URL passée à \href.
            lien = f"{base}/{relatif}#{lignes}".replace("#", r"\#") if base else ""
            reperage = code_latex(f"{source}#{lignes}")
            out += [r"\begin{" + env + "}",
                    prose_latex(doc),
                    r"\end{" + env + "}"]
            if env != "definition":
                # la démonstration transcrite vient s'insérer ici, avant le renvoi
                out.append(r"% démonstration à transcrire (skill transcrire-preuve-lean)")
            out += [r"\source{" + lien + "}{" + reperage + "}", ""]
            total += 1
    return total

def tous_les_fichiers():
    """Les dossiers de chapitre contenant au moins un fichier Lean."""
    racine = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/cours"
    for dossier, _, fichiers in os.walk(racine):
        if any(f.endswith(".lean") for f in fichiers):
            yield dossier

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print(__doc__)
        raise SystemExit(1)
    fichiers = [sys.argv[1]] if len(sys.argv) == 2 else list(tous_les_fichiers())
    if not fichiers:
        print("aucun fichier .lean dans cours/")
    for chemin in fichiers:
        tex, n = convertir(chemin)
        if n is None:
            print(f"{tex} : déjà présent, laissé tel quel")
        else:
            print(f"{tex} : {n} déclarations")
