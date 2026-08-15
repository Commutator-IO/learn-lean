r"""Produit un document LaTeX lisible à partir d'un fichier Lean de cours.

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

    python3 tools/generate-tex.py                 # tous les fichiers de courses/
    python3 tools/generate-tex.py chemin/vers/Fichier.lean

Le `.tex` est écrit à côté du `.lean`, et **n'est jamais réécrit s'il existe déjà** :
les démonstrations en français qu'on y ajoute (voir la skill `transcribe-lean-proof`)
sont donc conservées. Pour repartir d'un squelette neuf, supprimer le `.tex`.

Modifier une preuve décale les lignes du fichier Lean, et les renvois `\source` du
document deviennent faux. Pour les remettre à jour sans toucher aux transcriptions :

    python3 tools/generate-tex.py --liens

Les renvois sont réécrits dans l'ordre des déclarations. Si leur nombre a changé —
énoncé ajouté ou supprimé — le document concerné est laissé tel quel et signalé :
il faut alors y insérer ou en retirer le bloc à la main.

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

# Les exposants qui traînent sous un radical : `√(a²)` doit donner
# \(\sqrt{a^{2}}\), et non un carré Unicode que la police mathématique n'a pas.
EXPOSANTS = {"²": "^{2}", "³": "^{3}", "⁴": "^{4}", "ⁿ": "^{n}", "ᵐ": "^{m}"}

def racines(latex):
    r"""Referme les radicaux sur leur opérande.

    La conversion se fait caractère par caractère : `√` devient `\sqrt{}`, et
    l'opérande reste dehors — un radical vide suivi d'un `2`. On recolle donc
    après coup ce que `√` gouverne : le groupe parenthésé qui suit, ou le mot
    qui suit.
    """
    vide = r"\(\sqrt{}\)"

    def contenu(x):
        for c, r in EXPOSANTS.items():
            x = x.replace(c, r)
        return x

    sortie, i = [], 0
    while True:
        j = latex.find(vide, i)
        if j == -1:
            sortie.append(latex[i:])
            return "".join(sortie)
        sortie.append(latex[i:j])
        reste = latex[j + len(vide):]
        m = re.match(r"\(([^()]*)\)", reste)          # √(a + b)
        if m is None:
            m = re.match(r"[A-Za-z0-9²³⁴ⁿᵐ]+", reste)   # √2, √ab, √x²
            arg, suite = (m.group(0), reste[m.end():]) if m else ("", reste)
        else:
            arg, suite = m.group(1), reste[m.end():]
        sortie.append(r"\(\sqrt{" + contenu(arg) + r"}\)" if arg else vide)
        latex, i = suite, 0

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
    return racines("".join(sortie))

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
    return racines("".join(sortie))

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

ENTETE = r"""%% Fichier engendré par tools/generate-tex.py à partir de %(source)s.
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
\newtheorem{exemple}{Exemple}
\theoremstyle{plain}
\newtheorem{theoreme}{Théorème}
\newtheorem{lemme}[theoreme]{Lemme}

%% Un exemple ne se démontre pas : on explique ce qu'il montre.
\newenvironment{explication}{\begin{proof}[Explication]}{\end{proof}}

%% Un énoncé écrit mais non démontré : la preuve Lean est un `sorry`.
\newcommand{\admis}{\par\smallskip\noindent\textit{Admis : l'énoncé est écrit en Lean, sa démonstration reste à faire.}\par}

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
    """L'environnement LaTeX qui convient à une déclaration Lean.

    Un `example` est anonyme en Lean : il ne sert à rien d'autre qu'à montrer un
    cas — un calcul mené jusqu'au bout, un contre-exemple. Il devient donc un
    « Exemple » et non un « Théorème », ce que le lecteur du livre doit voir
    aussi nettement que le lecteur du fichier Lean.
    """
    if sorte == "example":
        return "exemple"
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

def document_du_chapitre(dossier):
    """Le chemin du document du chapitre : celui qui existe, sinon celui du titre.

    Le nom vient du titre de l'index — mais un chapitre peut être renommé, et le
    document déjà écrit ne suit pas. Reprendre alors le fichier présent plutôt
    que d'en créer un second : deux documents pour un chapitre, c'est la
    transcription perdue d'un côté et un doublon vide de l'autre.
    """
    presents = [f for f in sorted(os.listdir(dossier)) if f.endswith(".tex")]
    if len(presents) == 1:
        return os.path.join(dossier, presents[0])
    return os.path.join(dossier, camel(titre_chapitre(dossier)) + ".tex")

def convertir(dossier):
    """Un document par chapitre : une section par fichier Lean du dossier."""
    fichiers = sorted(f for f in os.listdir(dossier) if f.endswith(".lean"))
    if not fichiers:
        return None, 0
    racine = racine_depot(dossier)
    base = base_github(racine)
    titre = titre_chapitre(dossier)
    chemin_tex = document_du_chapitre(dossier)
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
                out.append(r"% démonstration à transcrire (skill transcribe-lean-proof)")
            out += [r"\source{" + lien + "}{" + reperage + "}", ""]
            total += 1
    return total

def renvois(dossier):
    """Les renvois attendus, dans l'ordre des déclarations du chapitre."""
    racine = racine_depot(dossier)
    base = base_github(racine)
    attendus = []
    for fichier in sorted(f for f in os.listdir(dossier) if f.endswith(".lean")):
        _, blocs = lire(os.path.join(dossier, fichier))
        relatif = os.path.relpath(os.path.abspath(os.path.join(dossier, fichier)), racine)
        for sorte, contenu in blocs:
            if sorte == "declaration":
                debut = contenu[3]
                lien = f"{base}/{relatif}#L{debut}".replace("#", r"\#") if base else ""
                attendus.append(r"\source{" + lien + "}{"
                                + code_latex(f"{fichier}#L{debut}") + "}")
    return attendus

def rafraichir_liens(dossier):
    """Réécrit les `\\source` d'un `.tex` existant d'après les lignes actuelles du Lean.

    Renvoie (chemin, nombre de renvois modifiés) ou (chemin, None) si le nombre de
    déclarations ne correspond plus."""
    chemin_tex = document_du_chapitre(dossier)
    if not os.path.exists(chemin_tex):
        return None, 0
    lignes = open(chemin_tex, encoding="utf-8").read().split("\n")
    positions = [i for i, l in enumerate(lignes) if l.startswith(r"\source{")]
    attendus = renvois(dossier)
    if len(positions) != len(attendus):
        return chemin_tex, None
    modifies = 0
    for i, nouveau in zip(positions, attendus):
        if lignes[i] != nouveau:
            lignes[i] = nouveau
            modifies += 1
    if modifies:
        open(chemin_tex, "w", encoding="utf-8").write("\n".join(lignes))
    return chemin_tex, modifies

def tous_les_fichiers():
    """Les dossiers de chapitre contenant au moins un fichier Lean."""
    racine = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/courses"
    for dossier, _, fichiers in os.walk(racine):
        if any(f.endswith(".lean") for f in fichiers):
            yield dossier

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print(__doc__)
        raise SystemExit(1)
    if len(sys.argv) == 2 and sys.argv[1] == "--liens":
        for chemin in tous_les_fichiers():
            tex, n = rafraichir_liens(chemin)
            if tex is None:
                continue
            if n is None:
                print(f"{tex} : le nombre de déclarations a changé, document laissé tel quel")
            elif n:
                print(f"{tex} : {n} renvoi(s) mis à jour")
        raise SystemExit(0)
    fichiers = [sys.argv[1]] if len(sys.argv) == 2 else list(tous_les_fichiers())
    if not fichiers:
        print("aucun fichier .lean dans courses/")
    for chemin in fichiers:
        tex, n = convertir(chemin)
        if n is None:
            print(f"{tex} : déjà présent, laissé tel quel")
        else:
            print(f"{tex} : {n} déclarations")
