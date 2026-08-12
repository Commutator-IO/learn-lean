"""Génère et tient à jour l'index de cours/ à partir des tableaux de
college.md et lycee.md.

Arborescence produite :

    cours/<programme>/<NN-chapitre>/README.md   index des énoncés du chapitre
    cours/<programme>/<NN-chapitre>/*.lean      à écrire à la main, progressivement

Le script ne crée que les README.md d'index, jamais de .lean, et il est non
destructif : un index déjà présent n'est pas réécrit. Pour le reconstruire après
avoir modifié college.md ou lycee.md, supprimer l'index concerné et relancer.

    python3 outils/generer-cours.py
"""

import re, os, unicodedata

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# (fichier source, sous-dossier de cours/, intitulé)
SOURCES = [
    ("college.md", "01-college", "Programme du collège"),
    ("lycee.md",   "02-lycee", "Programme du lycée (filière S)"),
]

def ascii_(s):
    s = re.sub(r"`[^`]*`", " ", s)
    return unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode()

def slug(s):
    s = re.sub(r"[^a-zA-Z0-9]+", "-", ascii_(s)).strip("-").lower()
    return "-".join(w for w in s.split("-") if w)[:80] or "enonce"

def short_slug(s, words=6):
    return "-".join(slug(s).split("-")[:words])

def camel(s):
    return "".join(w.capitalize() for w in slug(s).split("-"))

# Un chapitre de cours ne retient que ce qui s'énonce et se démontre : définitions,
# propriétés, théorèmes. Les objectifs d'apprentissage qui décrivent un geste ou une
# compétence sont écartés, et ceux qui enrobent une proposition sont dépouillés de leur
# verbe d'apprentissage.
VERBES = (r"connaitre et savoir démontrer", r"connaitre et utiliser", r"connaitre",
          r"connaître", r"savoir que", r"savoir", r"comprendre et connaitre",
          r"comprendre", r"démontrer que", r"démontrer", r"définir et tracer",
          r"définir", r"caractériser", r"établir", r"admettre", r"découvrir",
          r"appréhender", r"faire le lien entre", r"étudier", r"aborder", r"mobiliser")
QUEUES = (r"et savoir l[ae] démontrer", r"et savoir le démontrer", r"et sa démonstration",
          r"et savoir les démontrer")
INDICES = ("théorème", "propriété", "démontr", "égalité", "somme", "produit", "quotient",
           "= ", "⟺", "⟹", "∣", "si ", "alors", "divis", "réciproque", "formule",
           "définition", "caractéris", "inégalité", "limite", "dérivée", "converge",
           "est ", "sont ", "vaut", "n’est pas", "irrationnel", "premier")

GESTES = ("mettre", "utiliser", "construire", "tracer", "placer", "calculer", "résoudre",
          "effectuer", "représenter", "convertir", "reconnaitre", "reconnaître", "lire",
          "comparer", "produire", "exploiter", "traiter", "organiser", "estimer",
          "déterminer", "appliquer", "vérifier", "simplifier", "passer", "modéliser")

def enonce_utile(texte, statut):
    """Renvoie l'énoncé nettoyé, ou None si l'item ne se démontre pas.

    On ne garde que ce qui s'énonce : une définition, une propriété, un théorème. Un
    objectif d'apprentissage n'est retenu que si le retrait du verbe d'apprentissage
    laisse une proposition — pas un geste, pas un fragment de phrase."""
    if statut.strip() == "—":
        return None
    net = re.sub(r"\s*\*\(hors programme 2026\)\*\s*$", "", texte.strip())
    for queue in QUEUES:
        net = re.sub(queue + r"\s*$", "", net, flags=re.I).strip(" ,;")
    for verbe in VERBES:
        m = re.match(verbe + r"\s+(.*)", net, flags=re.I)
        if m:
            net = m.group(1).strip()
            break
    else:
        if not any(i in net.lower() for i in INDICES):
            return None
    net = re.sub(r"^(la|le|les|l’|l\')\s*définitions? (de|du|des|d’|d\')\s*", "Définition de ",
                 net, flags=re.I)
    net = re.sub(r"^Définition de (un|une)\b", r"Définition d’\1", net)
    if net.lower().startswith(("et ", "ou ", "puis ")):
        return None
    if net.split()[0].lower().strip("’'") in GESTES:
        return None
    if len(net) < 8:
        return None
    return net[0].upper() + net[1:]

def theoreme(enonce):
    return "-".join(slug(enonce).split("-")[:8]).replace("-", "_")

def lire(chemin):
    """chapitres : [(numéro, titre, [(sous-section, énoncé, niveau, admis)])]"""
    chapitres, courant, sous, colonnes = [], None, None, 3
    for line in open(chemin, encoding="utf-8").read().split("\n"):
        m = re.match(r"## (\d+)\. (.+)", line)
        if line.startswith("## "):
            courant = (m.group(1), m.group(2).strip(), []) if m else None
            sous = None
            if courant:
                chapitres.append(courant)
        elif line.startswith("### "):
            sous = line[4:].strip()
        elif line.startswith("| Énoncé "):
            colonnes = len(line.split("|")) - 2
        elif line.startswith("| ") and not line.startswith("|---") and courant:
            cells = [c.strip() for c in re.split(r"(?<!\\)\|", line)[1:-1]]
            if len(cells) == colonnes and colonnes in (3, 4):
                admis = cells[2] if colonnes == 4 else ""
                utile = enonce_utile(cells[0], cells[-1])
                if utile:
                    courant[2].append((sous, utile, cells[1], cells[-1].strip()))
    return [c for c in chapitres if c[2]]

cree = []

def ecrire(chemin, lignes):
    """Crée le fichier s'il manque, sinon le laisse tel quel."""
    if os.path.exists(chemin):
        return False
    open(chemin, "w", encoding="utf-8").write("\n".join(lignes))
    cree.append(os.path.relpath(chemin, ROOT))
    return True

os.makedirs(ROOT + "/cours", exist_ok=True)

racine = ["# Cours",
          "",
          "Un dossier par chapitre des deux programmes. Chaque dossier contient un index",
          "des énoncés à démontrer et accueille les fichiers `.lean` au fur et à mesure.",
          "",
          "| Programme | Dossier | Source |",
          "|---|---|---|"]

for source, dossier, intitule in SOURCES:
    chapitres = lire(f"{ROOT}/{source}")
    base = f"{ROOT}/cours/{dossier}"
    os.makedirs(base, exist_ok=True)

    index = [f"# {intitule}",
             "",
             f"Index dérivé de [{source}](../../{source}) · retour à l'[index du cours](../README.md).",
             "",
             "| Chapitre | Dossier | Énoncés |",
             "|---|---|---|"]

    for num, titre, items in chapitres:
        sous_dossier = f"{num.zfill(2)}-{short_slug(titre)}"
        os.makedirs(f"{base}/{sous_dossier}", exist_ok=True)

        groupes, ordre = {}, []
        for sous, enonce, niveau, statut in items:
            key = sous or titre
            if key not in groupes:
                groupes[key] = []
                ordre.append(key)
            groupes[key].append((enonce, niveau, statut))

        chap = [f"# {titre}", "",
                f"*{intitule}* — énoncés tirés de [{source}](../../../{source}) · "
                f"retour à l'[index](../README.md).",
                "",
                "Statuts : ☐ à faire · ◐ preuve en cours (`sorry`) · ☑ démontré · "
                "✗ non formalisable en l'état.",
                "",
                "Les fichiers `.lean` de ce dossier sont à écrire au fur et à mesure ; la",
                "colonne *Théorème* donne le nom suggéré, à ajuster librement.",
                ""]

        for key in ordre:
            fichier = f"{camel(key)}.lean"
            chap += [f"## {key}", "", f"Fichier : `{fichier}`", ""]
            chap += ["| Énoncé | Niveau | Théorème | Statut |", "|---|---|---|---|"]
            for enonce, niveau, statut in groupes[key]:
                chap.append("| " + " | ".join(
                    [enonce, niveau, f"`{theoreme(enonce)}`", statut or "☐"]) + " |")
            chap.append("")

        ecrire(f"{base}/{sous_dossier}/README.md", chap)
        index.append(f"| {num}. {titre} | [`{sous_dossier}/`]({sous_dossier}/README.md) | "
                     f"{len(items)} |")

    total = sum(len(items) for _, _, items in chapitres)
    index += ["", f"**{total} énoncés** au total.", ""]
    ecrire(f"{base}/README.md", index)
    racine.append(f"| {intitule} | [`{dossier}/`]({dossier}/README.md) | "
                  f"[{source}](../{source}) |")

racine += ["",
           "## Écrire les preuves",
           "",
           "Un fichier `.lean` par section d'un chapitre, nommé dans l'index du chapitre",
           "(`Triangles.lean`, `Integration.lean`…). Quand un énoncé est traité, mettre à jour",
           "son statut dans l'index du chapitre, et dans `college.md` ou `lycee.md`.",
           "",
           "## Régénérer les index",
           "",
           "```bash",
           "python3 outils/generer-cours.py",
           "```",
           "",
           "Le script ne crée que les `README.md` manquants, jamais de `.lean`, et ne réécrit",
           "aucun fichier existant. Après modification de `college.md` ou `lycee.md`, supprimer",
           "l'index concerné et relancer pour le reconstruire.",
           ""]
ecrire(ROOT + "/cours/README.md", racine)

if cree:
    print(f"{len(cree)} fichier(s) créé(s) :")
    for c in cree:
        print("  +", c)
else:
    print("cours/ est à jour.")
