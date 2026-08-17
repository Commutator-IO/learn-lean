#!/usr/bin/env node
/**
 * Lit les deux listes d'annales et écrit `public/exams.json`.
 *
 * Les listes sont tenues en markdown dans `exams/`, parce qu'elles se lisent
 * aussi bien sur GitHub que sur le site. Les reprendre ici plutôt que de les
 * ressaisir garantit qu'une session ajoutée à la liste apparaît sur le site
 * sans qu'on y pense — et qu'aucune session du site ne manque à la liste.
 *
 * Le dépôt n'héberge aucun PDF : tous les liens pointent vers l'APMEP, qui
 * archive les annales et à qui elles appartiennent.
 */

import { readdir, readFile, writeFile } from 'node:fs/promises';
import { resolve, join } from 'node:path';

const SITE = resolve(import.meta.dirname, '..');
const EXAMS = resolve(SITE, '..', 'exams');
const SORTIE = resolve(SITE, 'public');

const SOURCES = [
  { id: 'brevet', titre: 'Brevet', fichier: 'annales-brevet.md' },
  { id: 'bac', titre: 'Baccalauréat', fichier: 'annales-bac.md' },
];

const LIEN = /\[[^\]]*\]\(([^)]+)\)/;

/**
 * Les sessions d'un fichier d'annales.
 *
 * Le brevet range les séries professionnelle et technologique dans un bloc
 * `<details>` : on s'arrête à son ouverture, la série générale étant la seule
 * qui corresponde au programme formalisé ici.
 */
function sessions(md) {
  const out = [];
  let annee = null;
  let ignorer = false;

  for (const ligne of md.split('\n')) {
    const titre = /^## (\d{4})\s*$/.exec(ligne);
    if (titre) {
      annee = Number(titre[1]);
      ignorer = false;
      continue;
    }
    if (ligne.startsWith('<details')) ignorer = true;
    if (ligne.startsWith('</details')) ignorer = false;
    if (ignorer || annee === null) continue;
    if (!ligne.startsWith('| ') || ligne.startsWith('|---')) continue;

    const cellules = ligne.split('|').map((c) => c.trim());
    if (cellules.length < 5) continue;
    const [, session, sujet, corrige] = cellules;
    if (session === 'Session') continue;

    const lienSujet = LIEN.exec(sujet)?.[1];
    if (!lienSujet) continue;
    out.push({
      annee,
      session,
      sujet: lienSujet,
      corrige: LIEN.exec(corrige)?.[1] ?? null,
    });
  }
  return out;
}

/**
 * Les exercices d'une session, lus dans l'index de son dossier.
 *
 * Un sujet d'examen n'est pas un chapitre : il mêle les notions, et ses
 * questions ne sont pas toutes des propositions. L'index le découpe question par
 * question, en disant pour chacune la notion, le thème, et l'énoncé Lean qui en
 * dérive — ou l'absence d'énoncé, qui est le renseignement le plus intéressant.
 *
 * Le tableau markdown reste la source : il se lit sur GitHub, et l'on n'a pas
 * deux listes à tenir d'accord.
 */
function exercices(md, contexte) {
  const out = [];
  let partie = null;
  let points = null;

  for (const ligne of md.split('\n')) {
    const titre = /^## (.+?)(?:\s*\((\d+) points?\))?\s*$/.exec(ligne);
    if (titre) {
      partie = titre[1].trim();
      points = titre[2] ? Number(titre[2]) : null;
      continue;
    }
    if (!ligne.startsWith('| ') || ligne.startsWith('|---') || !partie) continue;

    const c = ligne.split('|').map((x) => x.trim());
    if (c.length < 7 || c[1] === 'Question') continue;
    const [, question, notions, theme, theoreme, statut] = c;

    // « 4a. Médiane des totaux » : le numéro sert au tri, l'intitulé au texte.
    const m = /^([\dA-Za-z.]+)\.\s*(.+)$/.exec(question);
    const noms = theoreme
      .split(',')
      .map((x) => x.replace(/`/g, '').trim())
      .filter((x) => x && x !== '—');

    out.push({
      ...contexte,
      partie,
      points,
      numero: m ? m[1] : question,
      intitule: (m ? m[2] : question).replace(/`/g, ''),
      notions: notions.split(',').map((x) => x.trim()).filter(Boolean),
      theme,
      theoremes: noms,
      // ☑ démontré · ◐ énoncé écrit, preuve en cours · ☐ proposition pas encore
      // écrite · ✗ pas une proposition mathématique. La distinction entre les deux
      // dernières est celle que la page cherche à rendre visible.
      statut:
        statut === '☑'
          ? 'démontré'
          : statut === '◐'
            ? 'en cours'
            : statut === '☐'
              ? 'à écrire'
              : 'non formalisable',
    });
  }
  return out;
}

/** La ligne où chaque théorème est déclaré, pour pouvoir y renvoyer. */
function lignesDesTheoremes(source) {
  const out = {};
  source.split('\n').forEach((ligne, i) => {
    const m = /^(?:theorem|lemma) ([^\s({[:]+)/.exec(ligne);
    if (m) out[m[1]] = i + 1;
  });
  return out;
}

async function annales() {
  const out = [];
  let dossiers = [];
  try {
    dossiers = (await readdir(EXAMS, { withFileTypes: true }))
      .filter((d) => d.isDirectory() && /^\d{4}$/.test(d.name))
      .map((d) => d.name)
      .sort();
  } catch {
    return out;
  }

  for (const annee of dossiers) {
    const fichiers = await readdir(join(EXAMS, annee));
    // Un index par session ; `README.md` n'est que le sommaire de l'année.
    for (const index of fichiers.filter((f) => f.endsWith('.md') && f !== 'README.md')) {
      const md = await readFile(join(EXAMS, annee, index), 'utf8');
      const lean = index.replace(/\.md$/, '.lean');
      const lignes = fichiers.includes(lean)
        ? lignesDesTheoremes(await readFile(join(EXAMS, annee, lean), 'utf8'))
        : {};

      // L'en-tête de l'index porte la session et l'adresse du sujet.
      const titre = /^# (.+)$/m.exec(md)?.[1] ?? index;
      const session = /^\*(.+?)\*/m.exec(md)?.[1] ?? titre;
      const sujet = /\[sujet\]\(([^)]+)\)/.exec(md)?.[1] ?? null;
      const epreuve = /brevet/i.test(titre) ? 'brevet' : 'bac';

      out.push(
        ...exercices(md, {
          annee: Number(annee),
          epreuve,
          session,
          sujet,
          source: fichiers.includes(lean) ? `exams/${annee}/${lean}` : null,
        }).map((e) => ({
          ...e,
          lignes: e.theoremes.map((n) => lignes[n] ?? null),
        })),
      );
    }
  }
  return out;
}

async function main() {
  const examens = [];
  for (const s of SOURCES) {
    const md = await readFile(join(EXAMS, s.fichier), 'utf8');
    const liste = sessions(md);
    examens.push({ id: s.id, titre: s.titre, fichier: s.fichier, sessions: liste });
    console.log(`${s.fichier} : ${liste.length} sessions`);
  }
  // Un identifiant stable et un rang, pour la clé de liste et le tri « ordre du
  // sujet » — l'index du fichier est cet ordre.
  const exos = (await annales()).map((e, i) => ({
    ...e,
    rang: i,
    id: `${e.epreuve}-${e.annee}-${e.partie}-${e.numero}`
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')
      .replace(/[^A-Za-z0-9]+/g, '-')
      .toLowerCase(),
  }));
  console.log(
    `exercices : ${exos.length} — ` +
      `${exos.filter((e) => e.statut === 'démontré').length} démontrés, ` +
      `${exos.filter((e) => e.statut === 'non formalisable').length} sans énoncé`,
  );
  await writeFile(join(SORTIE, 'exams.json'), JSON.stringify({ examens, exercices: exos }));
}

await main();
