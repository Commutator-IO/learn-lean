import { useRef, useState } from 'react'
import { GLOSSAIRE } from '../lib/glossaire.ts'
import { colorier, type Declare } from '../lib/lean.ts'
import { useSyncScroll, type Cible, type Pilote } from '../lib/sync.ts'
import type { Declaration, Module } from '../lib/types.ts'

/** Le mot survolé et l'endroit où poser son infobulle. */
type Bulle = { mot: string; x: number; y: number }

/**
 * L'infobulle d'un mot du langage.
 *
 * Elle est posée en `fixed` : le volet défile et rogne ce qui le déborde, or
 * l'explication d'un mot de la dernière ligne visible doit rester lisible. Elle
 * reste ouverte tant que la souris est dessus, pour qu'on puisse aller cliquer
 * le lien.
 */
function Infobulle({
  bulle,
  onGarder,
  onFermer,
}: {
  bulle: Bulle
  onGarder: () => void
  onFermer: () => void
}) {
  const aide = GLOSSAIRE[bulle.mot]
  if (!aide) return null
  return (
    <div
      onMouseEnter={onGarder}
      onMouseLeave={onFermer}
      style={{
        left: Math.max(8, Math.min(bulle.x, window.innerWidth - 340)),
        top: Math.min(bulle.y + 6, window.innerHeight - 160),
      }}
      className="fixed z-50 w-80 rounded-lg border border-ink-200 bg-white p-3 shadow-lg"
    >
      <div className="font-mono text-[12px] font-semibold text-ink-900">{bulle.mot}</div>
      <p className="mt-1 font-sans text-[12.5px] leading-relaxed text-ink-600">
        {/* Les explications citent du code entre accents graves, comme partout
            ailleurs dans le dépôt. */}
        {aide.quoi.split('`').map((part, i) =>
          i % 2 ? (
            <code key={i} className="rounded bg-ink-100 px-1 font-mono text-[11.5px]">
              {part}
            </code>
          ) : (
            part
          ),
        )}
      </p>
      {aide.doc && (
        <a
          href={aide.doc}
          target="_blank"
          rel="noreferrer"
          onClick={(e) => e.stopPropagation()}
          className="mt-2 inline-block font-sans text-[12px] text-brand-700 underline underline-offset-2"
        >
          documentation ↗
        </a>
      )}
    </div>
  )
}

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

  // L'infobulle survit à un bref passage de la souris entre le mot et elle :
  // sans ce délai, on ne pourrait jamais atteindre son lien.
  const [bulle, setBulle] = useState<Bulle | null>(null)
  const minuterie = useRef<number | null>(null)
  const garder = () => {
    if (minuterie.current !== null) clearTimeout(minuterie.current)
  }
  const fermer = () => {
    garder()
    minuterie.current = window.setTimeout(() => setBulle(null), 120)
  }
  const montrer = (mot: string, el: HTMLElement) => {
    garder()
    const r = el.getBoundingClientRect()
    setBulle({ mot, x: r.left, y: r.bottom })
  }

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
                  // Un mot du langage s'explique au survol : le glossaire est en
                  // français, la documentation qu'il cite ne l'est pas.
                  if (j.aide) {
                    return (
                      <span
                        key={k}
                        className={`${classe} jeton-aide`}
                        onMouseEnter={(e) => montrer(j.aide!, e.currentTarget)}
                        onMouseLeave={fermer}
                      >
                        {j.texte}
                      </span>
                    )
                  }
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

      {bulle && <Infobulle bulle={bulle} onGarder={garder} onFermer={fermer} />}
    </div>
  )
}
