"""Régénère lakefile.toml à partir de courses/ et de exams/.

Les dossiers de chapitre portent des noms lisibles et ordonnés
(`courses/lycee/06-integration`), qui ne sont pas des identifiants Lean valides.
On les déclare donc comme `srcDir` d'une bibliothèque : les noms de modules sont
alors ceux des fichiers seuls (`Integration.lean` → module `Integration`), et le
nom du dossier n'apparaît jamais dans un `import`.

Chaque chapitre devient une bibliothèque, dont les `globs` listent les fichiers
`.lean` réellement présents. Un chapitre sans fichier donne une bibliothèque vide,
ce qui est accepté par Lake.

À relancer après avoir ajouté ou supprimé un fichier `.lean` :

    python3 tools/generate-lakefile.py

Les blocs `[[require]]` du lakefile existant (Mathlib…) sont conservés.
"""

import os, re, unicodedata

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LAKEFILE = ROOT + "/lakefile.toml"

def camel(nom):
    nom = unicodedata.normalize("NFKD", nom).encode("ascii", "ignore").decode()
    nom = re.sub(r"^\d+[-_]?", "", nom)          # 06-integration -> integration
    return "".join(w.capitalize() for w in re.split(r"[^a-zA-Z0-9]+", nom) if w)

def chapitres():
    for programme in sorted(os.listdir(ROOT + "/courses")):
        chemin = f"{ROOT}/courses/{programme}"
        if not os.path.isdir(chemin):
            continue
        for chapitre in sorted(os.listdir(chemin)):
            dossier = f"{chemin}/{chapitre}"
            if not os.path.isdir(dossier):
                continue
            modules = sorted(f[:-5] for f in os.listdir(dossier) if f.endswith(".lean"))
            yield (camel(programme) + camel(chapitre),
                   f"courses/{programme}/{chapitre}", modules)

def annales():
    """Les sujets d'examen décomposés, une bibliothèque par année.

    Ils ne sont pas des chapitres de cours : un exercice de brevet n'a pas de
    place dans une progression. Mais leurs énoncés se démontrent de la même
    façon, et se compilent donc de la même façon.
    """
    racine = ROOT + "/exams"
    if not os.path.isdir(racine):
        return
    for annee in sorted(os.listdir(racine)):
        dossier = f"{racine}/{annee}"
        if not os.path.isdir(dossier):
            continue
        modules = sorted(f[:-5] for f in os.listdir(dossier) if f.endswith(".lean"))
        if modules:
            yield f"Annales{annee}", f"exams/{annee}", modules


def requires_existants():
    if not os.path.exists(LAKEFILE):
        return []
    contenu = open(LAKEFILE, encoding="utf-8").read()
    return re.findall(r"^\[\[require\]\].*?(?=^\[\[|\Z)", contenu, re.S | re.M)

libs = list(chapitres()) + list(annales())
noms = [n for n, _, _ in libs]

out = ["# Fichier généré par tools/generate-lakefile.py — à régénérer après avoir",
       "# ajouté un fichier .lean dans courses/ ou exams/. Les blocs [[require]] sont",
       "# conservés.",
       "",
       'name = "learn-lean"',
       f"defaultTargets = [{', '.join(chr(34) + n + chr(34) for n in noms)}]",
       ""]

for bloc in requires_existants():
    out += [bloc.strip(), ""]

for nom, srcdir, modules in libs:
    out += ["[[lean_lib]]",
            f'name = "{nom}"',
            f'srcDir = "{srcdir}"',
            "globs = [" + ", ".join(f'"{m}"' for m in modules) + "]",
            ""]

open(LAKEFILE, "w", encoding="utf-8").write("\n".join(out))

total = sum(len(m) for _, _, m in libs)
print(f"lakefile.toml : {len(libs)} bibliothèques, {total} fichier(s) .lean déclaré(s)")
for nom, srcdir, modules in libs:
    if modules:
        print(f"  {nom} ({srcdir}) : {', '.join(modules)}")
