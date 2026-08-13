import { useRef } from 'react'
import { useSyncScroll, type Cible, type Pilote } from '../lib/sync.ts'
import type { Declaration, Module } from '../lib/types.ts'

/**
 * Le volet de droite : le même chapitre, rédigé en français.
 *
 * Le HTML vient du document LaTeX du chapitre, rendu à la construction. Il
 * n'est donc pas une paraphrase du Lean produite ici : c'est le texte que
 * compile aussi le PDF, au caractère près.
 */

const ETIQUETTE: Record<string, string> = {
  theorem: 'Théorème',
  lemma: 'Lemme',
  def: 'Définition',
  abbrev: 'Définition',
  instance: 'Instance',
  example: 'Exemple',
}

export function TexPane({
  module,
  courante,
  cible,
  lie,
  pilote,
  onChoisir,
  onDefile,
}: {
  module: Module
  courante: Declaration | null
  cible: Cible
  lie: boolean
  pilote: React.RefObject<Pilote>
  onChoisir: (d: Declaration) => void
  onDefile: (ligne: number) => void
}) {
  const conteneur = useRef<HTMLDivElement>(null)

  useSyncScroll({ conteneur, moi: 'tex', cible, lie, pilote, onDefile })

  let sectionCourante: string | null = null

  return (
    <div ref={conteneur} className="h-full overflow-auto bg-white">
      <div className="sticky top-0 z-10 border-b border-ink-200 bg-white px-6 py-2 text-[12px] text-ink-500">
        Transcription française · <span className="font-mono">{module.nom.replace('.lean', '.tex')}</span>
      </div>

      <div className="mx-auto max-w-2xl px-6 py-4 font-serif text-[15px] text-ink-800">
        {module.declarations.map((d) => {
          const nouvelleSection = d.section && d.section !== sectionCourante
          if (nouvelleSection) sectionCourante = d.section
          const active = courante === d
          return (
            <div key={`${d.nom}-${d.ligne}`}>
              {nouvelleSection && (
                <h2 className="mt-8 mb-3 border-b border-ink-200 pb-1 font-sans text-[13px] font-semibold tracking-wide text-ink-500 uppercase">
                  {d.section}
                </h2>
              )}

              {d.remarqueHtml && (
                <div
                  className="prose-cours my-3 text-ink-600"
                  dangerouslySetInnerHTML={{ __html: d.remarqueHtml }}
                />
              )}

              <section
                data-decl={d.ligne}
                onClick={() => onChoisir(d)}
                className={[
                  '-mx-3 my-2 cursor-pointer rounded-lg px-3 py-2 transition-colors',
                  active ? 'bg-brand-50 ring-1 ring-brand-200' : 'hover:bg-ink-50',
                ].join(' ')}
              >
                <div className="flex items-baseline gap-2">
                  <span className="font-sans text-[12px] font-semibold tracking-wide text-brand-700 uppercase">
                    {ETIQUETTE[d.sorte] ?? d.sorte}
                  </span>
                  <code className="font-mono text-[11.5px] text-ink-400">{d.nom}</code>
                  <span className="ml-auto font-mono text-[11px] text-ink-300">L{d.ligne}</span>
                </div>

                <div
                  className="prose-cours mt-1"
                  dangerouslySetInnerHTML={{ __html: d.enonceHtml || `<p>${d.doc}</p>` }}
                />

                {d.preuveHtml && (
                  <div className="mt-3 border-l-2 border-ink-200 pl-3">
                    <div className="font-sans text-[11px] font-semibold tracking-wide text-ink-400 uppercase">
                      Démonstration
                    </div>
                    <div
                      className="prose-cours text-[14.5px] text-ink-700"
                      dangerouslySetInnerHTML={{ __html: d.preuveHtml }}
                    />
                  </div>
                )}
              </section>
            </div>
          )
        })}
      </div>
    </div>
  )
}
