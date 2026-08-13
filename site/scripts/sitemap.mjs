#!/usr/bin/env node
/**
 * Écrit `dist/sitemap.xml` : les pages que la construction publie réellement.
 *
 * Le fichier est dérivé de `dist/`, et non d'une liste tenue à la main. Les
 * routes existent déjà à trois endroits — les entrées Rollup de
 * `vite.config.ts`, la navigation de `Frame.tsx`, et les dossiers sur le
 * disque — et une quatrième liste serait celle que personne ne met à jour. Un
 * plan de site incomplet n'est qu'incomplet ; un plan qui annonce une page en
 * 404 apprend à un robot à se méfier du fichier entier.
 *
 * Tourne après `vite build`, depuis `npm run build`.
 */

import { readdir, readFile, writeFile, stat } from 'node:fs/promises';
import { resolve, relative, posix } from 'node:path';

const RACINE = resolve(import.meta.dirname, '..');
const DIST = resolve(RACINE, 'dist');

/**
 * L'origine, lue dans le fichier qui dit déjà à GitHub Pages quoi servir.
 *
 * `public/CNAME` est le seul endroit où le domaine est écrit, et le workflow
 * échoue si l'artefact ne le contient pas — Pages perdrait sinon le domaine.
 * C'est donc la seule chaîne qui mérite ici d'être crue, et elle ne peut pas
 * devenir fausse sans que le déploiement casse d'abord.
 */
async function origine() {
  const hote = (await readFile(resolve(RACINE, 'public', 'CNAME'), 'utf8')).trim();
  const base = (process.env.BASE_PATH ?? '/').replace(/\/$/, '');
  return `https://${hote}${base}`;
}

async function parcourir(dossier) {
  const out = [];
  for (const e of await readdir(dossier, { withFileTypes: true })) {
    const chemin = resolve(dossier, e.name);
    if (e.isDirectory()) out.push(...(await parcourir(chemin)));
    else out.push(chemin);
  }
  return out;
}

/**
 * L'adresse d'un fichier construit, ou `null` s'il n'est pas une page.
 *
 * Seuls les `index.html` en sont : le reste de `dist/` — les paquets, les
 * chapitres en JSON, le PDF du livre — n'est pas une page sur laquelle un
 * lecteur atterrit.
 */
function adresse(chemin) {
  const rel = posix.join(...relative(DIST, chemin).split(/[\\/]/));
  if (!rel.endsWith('index.html')) return null;
  const dossier = rel.slice(0, -'index.html'.length);
  return `/${dossier}`;
}

async function principal() {
  const base = await origine();
  const fichiers = await parcourir(DIST);

  const pages = [];
  for (const f of fichiers) {
    const url = adresse(f);
    if (!url) continue;
    const { mtime } = await stat(f);
    pages.push({ url, date: mtime.toISOString().slice(0, 10) });
  }
  pages.sort((a, b) => a.url.localeCompare(b.url));

  const xml = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
    ...pages.map(
      (p) =>
        `  <url><loc>${base}${p.url}</loc><lastmod>${p.date}</lastmod>` +
        `<priority>${p.url === '/' ? '1.0' : '0.8'}</priority></url>`,
    ),
    '</urlset>',
    '',
  ].join('\n');

  await writeFile(resolve(DIST, 'sitemap.xml'), xml);
  console.log(`dist/sitemap.xml : ${pages.length} pages`);
}

await principal();
