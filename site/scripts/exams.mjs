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

import { readFile, writeFile } from 'node:fs/promises';
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

async function main() {
  const examens = [];
  for (const s of SOURCES) {
    const md = await readFile(join(EXAMS, s.fichier), 'utf8');
    const liste = sessions(md);
    examens.push({ id: s.id, titre: s.titre, fichier: s.fichier, sessions: liste });
    console.log(`${s.fichier} : ${liste.length} sessions`);
  }
  await writeFile(join(SORTIE, 'exams.json'), JSON.stringify({ examens }));
}

await main();
