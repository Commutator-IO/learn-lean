import { useCallback, useEffect, useState } from 'react'
import { Footer, Header } from './components/Frame.tsx'
import type { Chapitre, Index } from './lib/types.ts'

/**
 * Le livre, lu en ligne.
 *
 * C'est le même texte que le PDF : les ouvertures écrites pour le livre, puis
 * les énoncés et leurs démonstrations. Le fichier Lean n'y est pas — on est ici
 * pour lire un cours, pas pour vérifier une preuve, et c'est l'onglet « cours »
 * qui met les deux en regard.
 */

type Livre = {
  livre: string
  parties: Record<string, string>
  chapitres: Record<string, string>
}

const ETIQUETTE: Record<string, string> = {
  theorem: 'Théorème',
  lemma: 'Lemme',
  def: 'Définition',
  abbrev: 'Définition',
  instance: 'Instance',
  example: 'Exemple',
}

export function BookPage() {
  const [index, setIndex] = useState<Index | null>(null)
  const [livre, setLivre] = useState<Livre | null>(null)
  const [chapitre, setChapitre] = useState<Chapitre | null>(null)
  const [pdf, setPdf] = useState<number | null>(null)
  const [menu, setMenu] = useState(false)

  useEffect(() => {
    fetch('/index.json')
      .then((r) => r.json())
      .then(setIndex)
      .catch(() => setIndex({ themes: [] }))
    fetch('/book.json')
      .then((r) => r.json())
      .then(setLivre)
      .catch(() => setLivre(null))
    // Le PDF est compilé par le workflow : le bouton n'apparaît que s'il est là.
    fetch('/cours-complet.pdf', { method: 'HEAD' })
      .then((r) => r.ok && setPdf(Number(r.headers.get('content-length') ?? 0)))
      .catch(() => {})
  }, [])

  const charger = useCallback(async (id: string) => {
    const r = await fetch(`/chapters/${id.replace('/', '__')}.json`)
    setChapitre(await r.json())
    setMenu(false)
    location.hash = id
    scrollTo({ top: 0 })
  }, [])

  useEffect(() => {
    const id = location.hash.slice(1)
    if (id) void charger(id)
  }, [charger])

  // Le livre est numéroté d'un bout à l'autre : les chapitres se suivent d'un
  // thème au suivant, sans repartir de 1.
  const numero = (id: string) => {
    let n = 0
    for (const t of index?.themes ?? []) {
      for (const c of t.chapitres) {
        n++
        if (c.id === id) return n
      }
    }
    return null
  }

  let sectionCourante: string | null = null

  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/livre/" />

      <div className="flex flex-1 flex-col lg:flex-row">
        {/* Sommaire du livre, étroit : la lecture occupe le reste. */}
        <aside
          className={[
            'shrink-0 border-b border-ink-200 bg-ink-50/60 lg:w-56 lg:border-r lg:border-b-0',
            menu ? '' : 'hidden lg:block',
          ].join(' ')}
        >
          <div className="sticky top-12 max-h-[calc(100dvh-3rem)] overflow-auto p-2">
            <button
              onClick={() => {
                setChapitre(null)
                location.hash = ''
                setMenu(false)
              }}
              className={[
                'mb-2 flex w-full rounded px-1.5 py-1 text-left text-[12.5px]',
                chapitre ? 'text-ink-600 hover:bg-ink-100' : 'bg-brand-50 text-ink-900',
              ].join(' ')}
            >
              Avant-propos
            </button>
            {index?.themes.map((t) => (
              <div key={t.id} className="mb-3">
                <div
                  className="px-1.5 py-1 font-sans text-[11px] font-semibold tracking-wide text-ink-400 uppercase"
                  title={t.sousTitre}
                >
                  {t.titre}
                </div>
                {t.chapitres.map((c) => (
                  <button
                    key={c.id}
                    onClick={() => void charger(c.id)}
                    className={[
                      'flex w-full items-baseline gap-1.5 rounded px-1.5 py-1 text-left text-[12.5px]',
                      chapitre?.id === c.id
                        ? 'bg-brand-50 text-ink-900'
                        : 'text-ink-600 hover:bg-ink-100',
                    ].join(' ')}
                  >
                    <span className="font-mono text-[10.5px] text-ink-400">{numero(c.id)}</span>
                    <span className="min-w-0 flex-1 truncate" title={`${c.titre} — ${c.niveau}`}>
                      {c.titre}
                    </span>
                  </button>
                ))}
              </div>
            ))}
          </div>
        </aside>

        <main className="min-w-0 flex-1">
          <div className="flex items-center gap-3 border-b border-ink-200 px-5 py-2">
            <button
              onClick={() => setMenu((v) => !v)}
              className="rounded border border-ink-200 px-2 py-1 text-[12px] text-ink-600 lg:hidden"
            >
              Sommaire
            </button>
            <span className="min-w-0 truncate font-serif text-[15px] text-ink-900">
              Mathématiques du secondaire
            </span>
            {pdf !== null && (
              <a
                href="/cours-complet.pdf"
                className="ml-auto shrink-0 rounded-md border border-ink-300 px-2.5 py-1 text-[12.5px] text-ink-700 hover:bg-ink-50"
              >
                PDF{pdf > 0 ? ` · ${(pdf / 1e6).toFixed(1)} Mo` : ''}
              </a>
            )}
          </div>

          <article className="mx-auto max-w-2xl px-6 py-8 font-serif text-[16px] leading-relaxed text-ink-800">
            {!chapitre ? (
              <>
                <h1 className="font-serif text-3xl text-ink-900">Avant-propos</h1>
                <div
                  className="prose-cours mt-5"
                  dangerouslySetInnerHTML={{ __html: livre?.livre ?? '' }}
                />
                <div className="mt-10 border-t border-ink-200 pt-6">
                  <h2 className="font-serif text-xl text-ink-900">Table des matières</h2>
                  {index?.themes.map((t, i) => (
                    <div key={t.id} className="mt-5">
                      <div className="font-sans text-[12px] font-semibold tracking-wide text-ink-400 uppercase">
                        Partie {i + 1} — {t.titre}
                      </div>
                      <div className="font-sans text-[13px] text-ink-400">{t.sousTitre}</div>
                      <ol className="mt-2 space-y-1 font-sans text-[14px]">
                        {t.chapitres.map((c) => (
                          <li key={c.id} className="flex gap-3">
                            <span className="w-5 shrink-0 text-right font-mono text-ink-400">
                              {numero(c.id)}
                            </span>
                            <button
                              onClick={() => void charger(c.id)}
                              className="text-left text-ink-700 hover:underline"
                            >
                              {c.titre}
                            </button>
                            <span className="ml-auto shrink-0 text-[12px] text-ink-400">
                              {c.niveau}
                            </span>
                          </li>
                        ))}
                      </ol>
                    </div>
                  ))}
                </div>
              </>
            ) : (
              <>
                <div className="font-sans text-[12px] font-semibold tracking-wide text-ink-400 uppercase">
                  Chapitre {numero(chapitre.id)} · {chapitre.niveau}
                </div>
                <h1 className="mt-1 font-serif text-3xl text-ink-900">{chapitre.titre}</h1>

                {livre?.chapitres[chapitre.id] && (
                  <div
                    className="prose-cours mt-5 text-ink-700"
                    dangerouslySetInnerHTML={{ __html: livre.chapitres[chapitre.id] }}
                  />
                )}

                {chapitre.modules.map((m) => {
                  sectionCourante = null
                  return (
                    <div key={m.nom}>
                      {chapitre.modules.length > 1 && (
                        <h2 className="mt-10 font-serif text-2xl text-ink-900">
                          {m.declarations[0]?.section ?? m.nom}
                        </h2>
                      )}
                      {m.declarations.map((d) => {
                        const nouvelle = d.section && d.section !== sectionCourante
                        if (nouvelle) sectionCourante = d.section
                        return (
                          <div key={`${m.nom}-${d.ligne}`}>
                            {nouvelle && (
                              <h3 className="mt-8 mb-2 font-serif text-[19px] text-ink-900">
                                {d.section}
                              </h3>
                            )}
                            {d.remarqueHtml && (
                              <div
                                className="prose-cours my-3 text-ink-600"
                                dangerouslySetInnerHTML={{ __html: d.remarqueHtml }}
                              />
                            )}
                            <div className="my-4">
                              <span className="font-sans text-[12px] font-semibold tracking-wide text-brand-700 uppercase">
                                {ETIQUETTE[d.sorte] ?? d.sorte}
                              </span>
                              <div
                                className="prose-cours mt-1"
                                dangerouslySetInnerHTML={{ __html: d.enonceHtml || `<p>${d.doc}</p>` }}
                              />
                              {d.preuveHtml && (
                                <div className="mt-3 border-l-2 border-ink-200 pl-4">
                                  <div className="font-sans text-[11px] font-semibold tracking-wide text-ink-400 uppercase">
                                    Démonstration
                                  </div>
                                  <div
                                    className="prose-cours text-[15px] text-ink-700"
                                    dangerouslySetInnerHTML={{ __html: d.preuveHtml }}
                                  />
                                </div>
                              )}
                              <div className="mt-1 text-right">
                                <a
                                  href={`/cours/#${chapitre.id}/${m.nom}/L${d.ligne}`}
                                  className="font-mono text-[11px] text-ink-300 hover:text-brand-700"
                                >
                                  {m.nom}#L{d.ligne}
                                </a>
                              </div>
                            </div>
                          </div>
                        )
                      })}
                    </div>
                  )
                })}
              </>
            )}
          </article>
        </main>
      </div>

      <Footer />
    </div>
  )
}
