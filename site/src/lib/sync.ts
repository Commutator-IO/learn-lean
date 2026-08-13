import { useEffect, type RefObject } from 'react'

/**
 * Défilement lié des deux volets.
 *
 * Le principe tient en une règle : **un seul volet pilote à la fois**. Celui
 * que la molette, le doigt ou le clavier vient de toucher devient le pilote ;
 * lui seul émet une position, et l'autre s'y aligne. Sans cette règle, les deux
 * volets se renvoient leurs événements de défilement indéfiniment — A pousse B,
 * dont le défilement repousse A — et la page tremble.
 *
 * L'alignement se fait sur les déclarations, pas sur les pixels : les deux
 * textes n'ont ni la même longueur ni le même rythme, et faire correspondre des
 * pourcentages de hauteur mettrait en face l'un de l'autre un théorème et le
 * milieu d'une autre démonstration. Chaque volet porte donc des ancres
 * `data-decl="<ligne>"`, la ligne du fichier Lean servant d'identifiant commun.
 */

export type Pilote = 'lean' | 'tex' | 'clic' | null
export type Cible = { ligne: number; par: Exclude<Pilote, null> } | null

/** La déclaration la plus haute encore visible dans le volet. */
function declarationEnTete(conteneur: HTMLElement): number | null {
  const ancres = conteneur.querySelectorAll<HTMLElement>('[data-decl]')
  const haut = conteneur.getBoundingClientRect().top
  let courante: number | null = null
  for (const a of ancres) {
    // 24 px de marge : une ancre qui affleure le bord haut compte comme
    // atteinte, sinon l'alignement retarde d'une déclaration.
    if (a.getBoundingClientRect().top - haut <= 24) courante = Number(a.dataset.decl)
    else break
  }
  return courante ?? (ancres.length ? Number(ancres[0].dataset.decl) : null)
}

export function useSyncScroll({
  conteneur,
  moi,
  cible,
  lie,
  pilote,
  onDefile,
}: {
  conteneur: RefObject<HTMLElement | null>
  moi: 'lean' | 'tex'
  cible: Cible
  lie: boolean
  pilote: RefObject<Pilote>
  onDefile: (ligne: number) => void
}) {
  // Prise du pilotage : c'est le geste de l'utilisateur qui désigne le volet
  // maître, pas le défilement lui-même — un défilement programmé en produit un
  // aussi, et on ne saurait plus qui mène.
  useEffect(() => {
    const el = conteneur.current
    if (!el) return
    const prendre = () => {
      pilote.current = moi
    }
    el.addEventListener('wheel', prendre, { passive: true })
    el.addEventListener('pointerdown', prendre)
    el.addEventListener('keydown', prendre)
    return () => {
      el.removeEventListener('wheel', prendre)
      el.removeEventListener('pointerdown', prendre)
      el.removeEventListener('keydown', prendre)
    }
  }, [conteneur, moi, pilote])

  // Émission : le volet pilote annonce la déclaration qu'il a en tête, au plus
  // une fois par image.
  useEffect(() => {
    const el = conteneur.current
    if (!el || !lie) return
    let prevu = false
    const onScroll = () => {
      if (pilote.current !== moi || prevu) return
      prevu = true
      requestAnimationFrame(() => {
        prevu = false
        const ligne = declarationEnTete(el)
        if (ligne !== null) onDefile(ligne)
      })
    }
    el.addEventListener('scroll', onScroll, { passive: true })
    return () => el.removeEventListener('scroll', onScroll)
  }, [conteneur, moi, lie, pilote, onDefile])

  // Réception : on suit la cible dès qu'elle vient d'ailleurs. Un clic défile
  // en douceur — c'est un déplacement voulu ; un défilement lié se cale
  // sèchement, sinon l'animation court après une cible qui a déjà bougé.
  useEffect(() => {
    const el = conteneur.current
    if (!el || !cible || cible.par === moi) return
    if (cible.par !== 'clic' && !lie) return
    const ancre = el.querySelector<HTMLElement>(`[data-decl="${cible.ligne}"]`)
    if (!ancre) return
    const decalage = ancre.getBoundingClientRect().top - el.getBoundingClientRect().top
    el.scrollBy({ top: decalage - 16, behavior: cible.par === 'clic' ? 'smooth' : 'auto' })
  }, [conteneur, cible, moi, lie])
}
