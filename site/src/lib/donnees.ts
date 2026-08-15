/**
 * Charge un fichier de données du site.
 *
 * Ces fichiers — le sommaire, les chapitres, le livre, les annales — sont
 * engendrés à chaque construction mais gardent leur nom, contrairement au code,
 * dont Vite signe les fichiers. GitHub Pages les sert avec `max-age=600` : un
 * onglet resté ouvert lisait donc un sommaire vieux de dix minutes, où un
 * chapitre renommé gardait son ancien titre alors que le reste de la page était
 * à jour.
 *
 * `no-cache` ne veut pas dire « ne mets pas en cache » mais « revalide avant de
 * servir » : le serveur répond presque toujours « rien n'a changé », et la
 * page reste aussi rapide.
 */
export async function donnees<T>(chemin: string): Promise<T> {
  const r = await fetch(chemin, { cache: 'no-cache' })
  return (await r.json()) as T
}
