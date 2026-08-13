import { useEffect, useRef } from 'react'
import { colorier } from '../lib/lean.ts'
import type { Declaration, Module } from '../lib/types.ts'

/**
 * Le volet de gauche : le fichier Lean, entier.
 *
 * Entier, et pas seulement la déclaration courante : une preuve se lit dans son
 * contexte — les `open`, les variables de section, les définitions posées plus
 * haut. Découper le fichier donnerait des extraits qui ne compilent pas, ce qui
 * est exactement ce que ce dépôt cherche à ne pas faire.
 *
 * Chaque déclaration porte une ancre `#L<ligne>`, celle-là même que le document
 * LaTeX cite dans ses renvois : les deux volets partagent donc leur système de
 * repérage avec le dépôt.
 */
export function LeanPane({
  module,
  chapitre,
  courante,
  onChoisir,
}: {
  module: Module
  chapitre: string
  courante: Declaration | null
  onChoisir: (d: Declaration) => void
}) {
  const lignes = colorier(module.source)
  const conteneur = useRef<HTMLDivElement>(null)

  // Le volet suit la déclaration choisie dans l'autre volet. `block: 'center'`
  // plutôt que 'start' : une preuve de dix lignes collée en haut de l'écran se
  // lit mal, on veut la voir dans son voisinage.
  useEffect(() => {
    if (!courante || !conteneur.current) return
    const cible = conteneur.current.querySelector(`[data-ligne="${courante.ligne}"]`)
    cible?.scrollIntoView({ block: 'center', behavior: 'smooth' })
  }, [courante])

  // Quelle déclaration couvre quelle ligne, pour surligner le bloc courant.
  const parLigne = new Map<number, Declaration>()
  for (const d of module.declarations) {
    for (let l = d.ligne; l <= d.finLigne; l++) parLigne.set(l, d)
  }

  return (
    <div ref={conteneur} className="h-full overflow-auto bg-ink-50/60">
      <div className="sticky top-0 z-10 flex items-center gap-2 border-b border-ink-200 bg-white px-4 py-2 text-[12px] text-ink-500">
        <span className="font-mono text-ink-700">{module.nom}</span>
        <a
          className="ml-auto underline underline-offset-2 hover:text-ink-800"
          href={`https://github.com/Commutator-IO/learn-lean/blob/main/courses/${chapitre}/${module.nom}`}
        >
          voir sur GitHub
        </a>
      </div>

      <pre className="px-0 py-3 font-mono text-[12.5px] leading-[1.55]">
        {lignes.map((jetons, i) => {
          const numero = i + 1
          const d = parLigne.get(numero)
          const active = courante && d === courante
          return (
            <div
              key={numero}
              data-ligne={d?.ligne === numero ? numero : undefined}
              onClick={d ? () => onChoisir(d) : undefined}
              className={[
                'flex gap-3 px-4',
                d ? 'cursor-pointer' : '',
                active ? 'bg-brand-50' : d ? 'hover:bg-ink-100/70' : '',
              ].join(' ')}
            >
              <span className="w-8 shrink-0 select-none text-right text-ink-300">{numero}</span>
              <span className="whitespace-pre-wrap break-words">
                {jetons.map((j, k) => (
                  <span key={k} className={j.classe === 'texte' ? undefined : `jeton-${j.classe}`}>
                    {j.texte}
                  </span>
                ))}
              </span>
            </div>
          )
        })}
      </pre>
    </div>
  )
}
