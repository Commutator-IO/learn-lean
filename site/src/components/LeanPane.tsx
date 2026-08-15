import { useRef } from 'react'
import { colorier, type Declare } from '../lib/lean.ts'
import { useSyncScroll, type Cible, type Pilote } from '../lib/sync.ts'
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
  cible,
  lie,
  pilote,
  declares,
  onChoisir,
  onDefile,
  onSuivre,
}: {
  module: Module
  chapitre: string
  courante: Declaration | null
  cible: Cible
  lie: boolean
  pilote: React.RefObject<Pilote>
  /** Les déclarations du chapitre, pour rendre leurs noms cliquables. */
  declares: Map<string, Declare>
  onChoisir: (d: Declaration) => void
  onDefile: (p: NonNullable<Cible>) => void
  onSuivre: (module: string, ligne: number) => void
}) {
  const lignes = colorier(module.source, declares)
  const conteneur = useRef<HTMLDivElement>(null)

  useSyncScroll({ conteneur, moi: 'lean', cible, lie, pilote, onDefile })

  // Quelle déclaration couvre quelle ligne. Le bloc commence à sa docstring et
  // non au mot-clé : c'est elle qui porte l'énoncé, et c'est donc elle qui doit
  // arriver en haut de l'écran quand on suit un renvoi.
  const parLigne = new Map<number, Declaration>()
  for (const d of module.declarations) {
    for (let l = d.ligneDoc; l <= d.finLigne; l++) parLigne.set(l, d)
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
              data-decl={d?.ligneDoc === numero ? d.ligne : undefined}
              data-decl-bas={d?.finLigne === numero ? d.ligne : undefined}
              onClick={d ? () => onChoisir(d) : undefined}
              className={[
                'flex gap-3 px-4',
                d ? 'cursor-pointer' : '',
                active ? 'bg-brand-50' : d ? 'hover:bg-ink-100/70' : '',
              ].join(' ')}
            >
              <span className="w-8 shrink-0 select-none text-right text-ink-300">{numero}</span>
              <span className="whitespace-pre-wrap break-words">
                {jetons.map((j, k) => {
                  const classe = j.classe === 'texte' ? undefined : `jeton-${j.classe}`
                  if (!j.lien) {
                    return (
                      <span key={k} className={classe}>
                        {j.texte}
                      </span>
                    )
                  }
                  // Un nom du chapitre mène à sa propre déclaration, dans les
                  // deux volets ; un nom de Mathlib, à sa documentation, dans un
                  // autre onglet — on ne quitte pas sa lecture pour un détour.
                  return j.interne ? (
                    <button
                      key={k}
                      onClick={(e) => {
                        e.stopPropagation()
                        const [mod, l] = j.lien!.split('/L')
                        onSuivre(mod, Number(l))
                      }}
                      className="jeton-lien-interne"
                      title="déclaration de ce chapitre"
                    >
                      {j.texte}
                    </button>
                  ) : (
                    <a
                      key={k}
                      href={j.lien}
                      target="_blank"
                      rel="noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="jeton-lien"
                      title="documentation de Mathlib"
                    >
                      {j.texte}
                    </a>
                  )
                })}
              </span>
            </div>
          )
        })}
      </pre>
    </div>
  )
}
