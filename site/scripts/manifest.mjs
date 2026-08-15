#!/usr/bin/env node
/**
 * Apparie chaque déclaration Lean de `courses/` avec sa transcription française,
 * et écrit ce que le site lit : `public/index.json` et `public/chapters/*.json`.
 *
 * L'appariement ne repose sur aucune convention de nommage : chaque bloc du
 * document LaTeX se termine par un renvoi `\source{…}{Fichier.lean#L42}`,
 * engendré par `tools/generate-tex.py` à partir du fichier Lean lui-même. C'est
 * cette ligne — fichier et numéro de ligne — qui sert de clé. Elle est donc
 * exacte par construction, et `generate-tex.py --liens` la remet à jour quand
 * une preuve change de longueur.
 *
 * Rien n'est versionné de ce que ce script produit : le site se reconstruit à
 * partir des fichiers `.lean` et `.tex`, qui restent la seule source.
 *
 *   npm run manifest
 */

import { readdir, readFile, writeFile, mkdir, rm } from 'node:fs/promises';
import { resolve, join, basename } from 'node:path';
import { texToHtml } from './latex.mjs';

const SITE = resolve(import.meta.dirname, '..');
const DEPOT = resolve(SITE, '..');
const COURS = resolve(DEPOT, 'courses');
const LIVRE = resolve(DEPOT, 'book', 'textes');
const SORTIE = resolve(SITE, 'public');

const NIVEAUX = { '01-college': 'collège', '02-lycee': 'lycée' };

/**
 * Les thèmes, lus dans `courses/themes.json`.
 *
 * Le dépôt range ses chapitres par cycle, parce que les programmes le sont ;
 * le site les présente par notion, parce qu'on ne lit pas un cycle mais un
 * sujet. Le même fichier sert au livre : l'ordre est le même des deux côtés.
 */
async function themes() {
  const src = JSON.parse(await readFile(join(COURS, 'themes.json'), 'utf8'));
  return src.themes;
}

/** Les modificateurs précèdent le mot-clé, comme dans generate-tex.py. */
const DECLARATION =
  /^(?:noncomputable |private |protected |partial |unsafe )*(theorem|lemma|def|abbrev|instance|example)\s+([^\s({[:]*)/;

/**
 * Découpe un fichier Lean en déclarations documentées.
 *
 * Même règle que le générateur LaTeX : une docstring `/-- … -/`, puis les
 * lignes de la déclaration jusqu'à la première ligne vide. Les fichiers du
 * dépôt respectent cette forme — c'est elle qui rend les deux vues jumelles.
 */
function declarations(source) {
  const lignes = source.split('\n');
  const out = [];
  let section = null;

  for (let i = 0; i < lignes.length; ) {
    const ligne = lignes[i];

    if (ligne.startsWith('/-!')) {
      let texte = ligne.slice(3);
      while (!texte.includes('-/')) texte += '\n' + lignes[++i];
      section = texte.slice(0, texte.indexOf('-/')).replace(/#/g, '').trim();
      i++;
      continue;
    }

    if (ligne.startsWith('/--')) {
      const debutDoc = i + 1;
      let doc = ligne.slice(3);
      while (!doc.includes('-/')) doc += '\n' + lignes[++i];
      doc = doc.slice(0, doc.indexOf('-/')).trim();
      i++;
      const corps = [];
      while (i < lignes.length && lignes[i].trim() !== '') corps.push(lignes[i++]);
      const m = DECLARATION.exec(corps[0] ?? '');
      out.push({
        sorte: m?.[1] ?? '',
        nom: m?.[2] ?? '',
        doc,
        section,
        ligneDoc: debutDoc,
        ligne: i - corps.length + 1,
        finLigne: i,
        code: corps.join('\n'),
      });
      continue;
    }
    i++;
  }
  return out;
}

/**
 * Retire les titres de section, accolades comprises.
 *
 * Le titre est enlevé et non rendu : la structure du chapitre vient du fichier
 * Lean, qui la porte déjà. Reste à l'enlever proprement. Une expression
 * régulière s'arrête à la première accolade fermante, or un titre contient
 * volontiers du code — `\subsection{Puissances ; \texttt{aᵐ × aⁿ}}` — dont
 * l'accolade est intérieure : la fin du titre et l'accolade orpheline
 * retombaient alors dans le texte, où elles s'affichaient telles quelles. On
 * compte donc les accolades.
 */
function sansTitres(tex) {
  const debut = /\\(?:sub)*section\*?\{/g;
  let out = '';
  let i = 0;
  let m;
  while ((m = debut.exec(tex)) !== null) {
    out += tex.slice(i, m.index);
    let j = m.index + m[0].length;
    let profondeur = 1;
    while (j < tex.length && profondeur > 0) {
      if (tex[j] === '\\') j++;
      else if (tex[j] === '{') profondeur++;
      else if (tex[j] === '}') profondeur--;
      j++;
    }
    i = j;
    debut.lastIndex = j;
  }
  return out + tex.slice(i);
}

/**
 * Découpe un document LaTeX en blocs, un par déclaration.
 *
 * Chaque bloc va de la fin du précédent jusqu'à son `\source`. On y lit
 * l'énoncé (l'environnement `theoreme`, `lemme` ou `definition`) et, s'il y en
 * a une, la démonstration.
 */
function blocsTex(source) {
  // Le préambule n'est pas du texte : il décrit la mise en page. On part donc
  // du corps, et l'on jette les commentaires LaTeX et les commandes de
  // composition, qui n'ont rien à dire à un lecteur.
  const corpsDoc = source.slice(source.indexOf('\\begin{document}'));
  const tex = corpsDoc
    .split('\n')
    .filter((l) => !l.trimStart().startsWith('%'))
    .join('\n')
    .replace(/\\begin\{document\}|\\maketitle|\\sloppy|\\vfill/g, '');

  const blocs = new Map();
  const re = /\\source\{[^}]*\}\{([^}]*?)\\#L(\d+)\}/g;
  let debut = 0;
  let m;
  while ((m = re.exec(tex)) !== null) {
    const corps = tex.slice(debut, m.index);
    debut = re.lastIndex;
    const fichier = m[1].replace(/\\#.*$/, '');
    const cle = `${fichier}#${m[2]}`;

    const enonce = /\\begin\{(theoreme|lemme|definition|exemple)\}([\s\S]*?)\\end\{\1\}/.exec(corps);
    // La démonstration d'un exemple s'appelle une explication : deux
    // environnements, un seul champ — le libellé se décide à l'affichage.
    const preuve = /\\begin\{(?:proof|explication)\}([\s\S]*?)\\end\{(?:proof|explication)\}/.exec(corps);
    // Ce qui précède l'énoncé dans le bloc : les remarques libres du fichier
    // Lean, qui appartiennent au fil du texte et non à un théorème.
    const avant = enonce ? corps.slice(0, enonce.index) : corps;
    const remarque = sansTitres(avant).trim();

    blocs.set(cle, {
      enonceHtml: enonce ? texToHtml(enonce[2].trim()) : '',
      preuveHtml: preuve ? texToHtml(preuve[1].trim()) : '',
      remarqueHtml: remarque ? texToHtml(remarque) : '',
    });
  }
  return blocs;
}

/** Le titre d'un chapitre, l'état et la liste de ses énoncés, lus dans son index. */
async function indexChapitre(dossier) {
  const md = await readFile(join(dossier, 'README.md'), 'utf8');
  const titre = /^# (.+)$/m.exec(md)?.[1] ?? basename(dossier);
  const lignes = md.split('\n').filter((l) => l.startsWith('| ') && !l.startsWith('|---'));
  const statuts = { total: 0, demontres: 0, encours: 0 };
  const enonces = [];
  for (const l of lignes) {
    const cellules = l.split('|').map((c) => c.trim());
    const statut = cellules[cellules.length - 2];
    if (!'☑◐☐✗'.includes(statut)) continue;
    statuts.total++;
    if (statut === '☑') statuts.demontres++;
    if (statut === '◐') statuts.encours++;
    enonces.push({ enonce: cellules[1], niveau: cellules[2], statut });
  }
  return { titre, statuts, enonces };
}

async function chapitre(chemin) {
  const [programme, nom] = chemin.split('/');
  {
    const dossier = join(COURS, programme, nom);
    const fichiers = (await readdir(dossier)).sort();
    const leans = fichiers.filter((f) => f.endsWith('.lean'));
    const { titre, statuts, enonces } = await indexChapitre(dossier);

    // Un chapitre annoncé dans un thème mais pas encore démontré n'a pas de
    // fichier Lean. Il reste au sommaire, avec la liste de ce qui est à faire :
    // le retirer donnerait à lire une progression qui saute une étape sans le
    // dire.
    if (leans.length === 0) {
      return {
        id: chemin,
        dossier: nom,
        programme,
        niveau: NIVEAUX[programme] ?? programme,
        titre,
        statuts,
        modules: [],
        enonces,
      };
    }
    const tex = fichiers.find((f) => f.endsWith('.tex'));
    const blocs = tex ? blocsTex(await readFile(join(dossier, tex), 'utf8')) : new Map();

    const modules = [];
    for (const lean of leans) {
      const source = await readFile(join(dossier, lean), 'utf8');
      const decls = declarations(source).map((d) => ({
        ...d,
        ...(blocs.get(`${lean}#${d.ligne}`) ?? {
          enonceHtml: '',
          preuveHtml: '',
          remarqueHtml: '',
        }),
      }));
      modules.push({
        nom: lean,
        // Le fichier entier, pour le volet de gauche : on lit la preuve dans
        // son contexte, imports et espace de noms compris.
        source,
        declarations: decls,
      });
    }

    return {
      id: chemin,
      dossier: nom,
      programme,
      niveau: NIVEAUX[programme] ?? programme,
      titre,
      statuts,
      modules,
    };
  }
}

const chemin = (id) => join(SORTIE, 'chapters', `${id.replace('/', '__')}.json`);

/**
 * Les textes de liaison du livre, rendus en HTML.
 *
 * Ils n'existaient jusqu'ici que dans le PDF ; la version lisible en ligne les
 * reprend, sans quoi elle ne serait pas le même livre. Un chapitre sans texte
 * d'ouverture n'est pas une erreur : le fichier est simplement absent.
 */
async function livre() {
  const out = { livre: '', parties: {}, chapitres: {} };
  let fichiers = [];
  try {
    fichiers = await readdir(LIVRE);
  } catch {
    return out;
  }
  for (const f of fichiers) {
    if (!f.endsWith('.tex')) continue;
    const id = f.replace(/\.tex$/, '');
    const html = texToHtml((await readFile(join(LIVRE, f), 'utf8')).trim());
    if (id === 'livre') out.livre = html;
    else if (id.includes('__')) out.chapitres[id.replace('__', '/')] = html;
    else out.parties[id] = html;
  }
  return out;
}

async function main() {
  await rm(join(SORTIE, 'chapters'), { recursive: true, force: true });
  await mkdir(join(SORTIE, 'chapters'), { recursive: true });

  const index = { themes: [], engendre: 'npm run manifest' };
  const vus = new Set();

  for (const theme of await themes()) {
    const liste = [];
    for (const ch of theme.chapitres) {
      const c = await chapitre(ch);
      if (!c) continue;
      vus.add(ch);
      await writeFile(chemin(c.id), JSON.stringify(c));
      liste.push(c);
    }
    index.themes.push({
      id: theme.id,
      titre: theme.titre,
      sousTitre: theme.sousTitre,
      chapitres: liste.map((c) => ({
        id: c.id,
        titre: c.titre,
        niveau: c.niveau,
        statuts: c.statuts,
        modules: c.modules.map((m) => ({ nom: m.nom, declarations: m.declarations.length })),
      })),
    });
  }

  // Un chapitre qu'aucun thème ne recouvre n'apparaîtrait nulle part : on le
  // signale plutôt que de le laisser disparaître en silence.
  for (const programme of Object.keys(NIVEAUX)) {
    for (const nom of await readdir(join(COURS, programme))) {
      const dossier = join(COURS, programme, nom);
      let leans = [];
      try {
        leans = (await readdir(dossier)).filter((f) => f.endsWith('.lean'));
      } catch {
        continue;
      }
      if (leans.length && !vus.has(`${programme}/${nom}`)) {
        console.warn(`chapitre hors thème : ${programme}/${nom} — voir courses/themes.json`);
      }
    }
  }

  await writeFile(join(SORTIE, 'index.json'), JSON.stringify(index, null, 2));
  await writeFile(join(SORTIE, 'book.json'), JSON.stringify(await livre()));

  const n = index.themes.reduce((a, t) => a + t.chapitres.length, 0);
  const d = index.themes.reduce(
    (a, t) => a + t.chapitres.reduce((b, c) => b + c.statuts.demontres, 0),
    0,
  );
  console.log(`public/index.json : ${index.themes.length} thèmes, ${n} chapitres, ${d} démontrés`);
}

await main();
