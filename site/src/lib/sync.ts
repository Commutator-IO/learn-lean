import { useEffect, type RefObject } from 'react'

/**
 * Défilement lié des deux volets.
 *
 * Deux règles, et la seconde est celle qui coûte le plus cher à oublier.
 *
 * **Un seul volet pilote à la fois.** Celui que la molette, le doigt ou le
 * clavier vient de toucher devient le pilote ; lui seul émet une position, et
 * l'autre s'y aligne. Sans cette règle, les deux volets se renvoient leurs
 * événements de défilement indéfiniment — A pousse B, dont le défilement
 * repousse A — et la page tremble.
 *
 * **L'alignement est continu, pas discret.** Les deux textes n'ont ni la même
 * longueur ni le même rythme : une démonstration de quinze lignes de Lean peut
 * tenir en trois lignes de français, et l'inverse arrive aussi. Faire
 * correspondre des pourcentages de hauteur mettrait donc en face l'un de
 * l'autre un théorème et le milieu d'une autre démonstration. Mais se contenter
 * de caler déclaration sur déclaration ne suffit pas non plus : entre deux
 * ancres le volet suiveur ne bougerait pas, puis sauterait d'un bloc — ce qui
 * se voit et se lit mal.
 *
 * On repère donc la position du pilote *entre* deux déclarations — la fraction
 * du chemin parcouru de l'une à l'autre — et on place le suiveur à la même
 * fraction entre les siennes. Le mouvement est alors continu des deux côtés, et
 * les deux textes restent en face l'un de l'autre là où ils se correspondent
 * vraiment : aux déclarations.
 */

export type Pilote = 'lean' | 'tex' | 'clic' | null

/** Une position : entre la déclaration `ligne` et la suivante, à la fraction `f`. */
export type Cible = {
  ligne: number
  suivante: number | null
  f: number
  par: Exclude<Pilote, null>
} | null

/** Marge sous l'en-tête collant du volet : une ancre qui affleure compte comme atteinte. */
const MARGE = 20

type Ancre = { ligne: number; haut: number }

/** Les ancres du volet, avec leur position par rapport au haut de celui-ci. */
function ancres(el: HTMLElement): Ancre[] {
  const haut = el.getBoundingClientRect().top
  return [...el.querySelectorAll<HTMLElement>('[data-decl]')].map((a) => ({
    ligne: Number(a.dataset.decl),
    haut: a.getBoundingClientRect().top - haut,
  }))
}

/** Où en est le volet : la déclaration en tête, la suivante, et la fraction entre les deux. */
function position(el: HTMLElement): Cible | null {
  const liste = ancres(el)
  if (liste.length === 0) return null

  let i = 0
  while (i + 1 < liste.length && liste[i + 1].haut <= MARGE) i++
  const courante = liste[i]
  const suivante = liste[i + 1]

  // Avant la première déclaration, on n'interpole pas : le volet est dans son
  // en-tête, et le suiveur doit simplement remonter au même endroit.
  if (courante.haut > MARGE) return { ligne: courante.ligne, suivante: null, f: 0, par: 'lean' }

  // Après la dernière, on interpole sur ce qui reste à faire défiler, sans quoi
  // le suiveur resterait bloqué sur la dernière ancre pendant tout le pied de
  // page.
  const bas = suivante ? suivante.haut : el.scrollHeight - el.scrollTop - el.clientHeight + MARGE
  const etendue = bas - courante.haut
  const f = etendue > 0 ? Math.min(1, Math.max(0, (MARGE - courante.haut) / etendue)) : 0

  return { ligne: courante.ligne, suivante: suivante?.ligne ?? null, f, par: 'lean' }
}

/**
 * Amène le volet à la position demandée.
 *
 * Un clic ne se traite pas comme un défilement. Défiler, c'est suivre un
 * mouvement : on interpole entre deux ancres pour que les deux volets avancent
 * du même pas. Cliquer, c'est demander à voir *un bloc* — et un bloc à moitié
 * coupé par le bas de l'écran n'est pas montré. On amène donc son haut sous
 * l'en-tête, puis, s'il dépasse encore et qu'il tient dans la hauteur
 * disponible, on remonte juste ce qu'il faut pour en montrer la fin.
 */
function aligner(el: HTMLElement, cible: NonNullable<Cible>, clic: boolean) {
  const liste = ancres(el)
  const courante = liste.find((a) => a.ligne === cible.ligne)
  if (!courante) return

  if (clic) {
    const bas = el.querySelector<HTMLElement>(`[data-decl-bas="${cible.ligne}"]`)
    const hauteurBloc = bas
      ? bas.getBoundingClientRect().bottom - el.getBoundingClientRect().top - courante.haut
      : 0
    // Le bloc tient à l'écran : on le cale sous l'en-tête, ce qui l'affiche en
    // entier. Sinon on montre son début, seul choix possible.
    const place = el.clientHeight - 2 * MARGE
    const decalage =
      hauteurBloc > 0 && hauteurBloc < place
        ? courante.haut - Math.max(MARGE, (el.clientHeight - hauteurBloc) / 2)
        : courante.haut - MARGE
    el.scrollBy({ top: decalage, behavior: 'smooth' })
    return
  }

  const suivante = cible.suivante === null ? undefined : liste.find((a) => a.ligne === cible.suivante)
  const bas = suivante
    ? suivante.haut
    : el.scrollHeight - el.scrollTop - el.clientHeight + MARGE
  const vise = courante.haut + cible.f * (bas - courante.haut)

  el.scrollBy({ top: vise - MARGE, behavior: 'auto' })
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
  onDefile: (p: NonNullable<Cible>) => void
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

  // Émission : le volet pilote annonce sa position, au plus une fois par image.
  useEffect(() => {
    const el = conteneur.current
    if (!el || !lie) return
    let prevu = false
    const onScroll = () => {
      if (pilote.current !== moi || prevu) return
      prevu = true
      requestAnimationFrame(() => {
        prevu = false
        const p = position(el)
        if (p) onDefile({ ...p, par: moi })
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
    aligner(el, cible, cible.par === 'clic')
  }, [conteneur, cible, moi, lie])
}
