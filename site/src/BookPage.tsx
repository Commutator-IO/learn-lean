import { useEffect, useState } from 'react'
import { Footer, Header } from './components/Frame.tsx'
import type { Index } from './lib/types.ts'

/**
 * Le livre : le cours complet, de la sixième à la terminale, en un seul PDF.
 *
 * Le PDF n'est pas versionné — il est compilé par le workflow et publié avec le
 * site. Le bouton de téléchargement ne s'affiche donc que si le fichier est
 * réellement là : une tuile qui promet un document absent apprend au lecteur à
 * se méfier de tous les autres liens de la page.
 */
export function BookPage() {
  const [index, setIndex] = useState<Index | null>(null)
  const [pdf, setPdf] = useState<{ octets: number } | null>(null)

  useEffect(() => {
    fetch('/index.json')
      .then((r) => r.json())
      .then(setIndex)
      .catch(() => setIndex({ programmes: [] }))

    fetch('/cours-complet.pdf', { method: 'HEAD' })
      .then((r) => {
        if (!r.ok) return
        setPdf({ octets: Number(r.headers.get('content-length') ?? 0) })
      })
      .catch(() => {})
  }, [])

  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/livre/" />

      <main className="flex-1">
        <section className="mx-auto max-w-3xl px-5 pt-14 pb-8">
          <h1 className="font-serif text-3xl leading-tight text-ink-900">
            Un cours complet, de la sixième à la terminale
          </h1>
          <p className="mt-5 text-[16px] leading-relaxed text-ink-600">
            Les dix-sept chapitres réunis en un seul document : les définitions, les énoncés et
            leurs démonstrations, dans l'ordre des programmes. Le texte de liaison — ce qui
            introduit un chapitre, ce qui explique pourquoi la notion suivante arrive là — est
            rédigé pour le livre ; les démonstrations, elles, sont celles du dépôt, sans
            retouche.
          </p>

          <div className="mt-7">
            {pdf ? (
              <a
                href="/cours-complet.pdf"
                className="inline-flex items-center gap-2 rounded-lg bg-brand-700 px-4 py-2.5 text-[14px] font-medium text-white hover:bg-brand-800"
              >
                Télécharger le PDF
                {pdf.octets > 0 && (
                  <span className="font-mono text-[12px] opacity-80">
                    {(pdf.octets / 1e6).toFixed(1)} Mo
                  </span>
                )}
              </a>
            ) : (
              <p className="rounded-lg border border-ink-200 bg-ink-50 px-4 py-3 text-[13.5px] text-ink-500">
                Le PDF est compilé par le workflow de publication ; il n'est pas encore présent sur
                cette version du site. La source LaTeX, elle, est dans le dépôt sous{' '}
                <code className="font-mono">book/</code>.
              </p>
            )}
          </div>
        </section>

        <section className="border-t border-ink-200 bg-ink-50">
          <div className="mx-auto max-w-3xl px-5 py-10">
            <h2 className="font-serif text-xl text-ink-900">Table des matières</h2>
            <div className="mt-5 space-y-6">
              {index?.programmes.map((p, i) => (
                <div key={p.id}>
                  <div className="font-sans text-[12px] font-semibold tracking-wide text-ink-400 uppercase">
                    Partie {i + 1} — {p.titre}
                  </div>
                  <ol className="mt-2 space-y-1">
                    {p.chapitres.map((c, j) => (
                      <li key={c.id} className="flex gap-3 text-[14px] text-ink-700">
                        <span className="w-6 shrink-0 text-right font-mono text-ink-400">
                          {j + 1}.
                        </span>
                        <a href={`/cours/#${c.id}`} className="hover:underline">
                          {c.titre}
                        </a>
                        <span className="ml-auto font-mono text-[12px] text-ink-400">
                          {c.statuts.demontres}/{c.statuts.total}
                        </span>
                      </li>
                    ))}
                  </ol>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="mx-auto max-w-3xl px-5 py-12">
          <h2 className="font-serif text-xl text-ink-900">Ce que le livre ajoute, et ce qu'il ne
            touche pas</h2>
          <div className="mt-4 space-y-4 text-[15px] leading-relaxed text-ink-600">
            <p>
              Un chapitre du dépôt est une suite d'énoncés : il n'a ni introduction, ni fil. Le
              livre ajoute ce fil — une entrée en matière par partie et par chapitre, une phrase de
              passage entre deux sections, le rappel de ce qui sert plus loin.
            </p>
            <p>
              <strong className="text-ink-800">Les démonstrations, elles, sont reprises telles
              quelles.</strong> Elles transcrivent le script Lean étape par étape ; les réécrire
              pour les rendre plus élégantes romprait le lien entre le livre et la preuve
              vérifiée, qui est tout l'objet de l'exercice. Une démonstration qui paraît
              laborieuse dans le livre l'est aussi dans le fichier.
            </p>
            <p>
              Les énoncés que le dépôt ne démontre pas figurent au même endroit que dans les
              programmes, avec la raison : c'est une information sur l'outil, pas un trou à
              masquer.
            </p>
          </div>
        </section>
      </main>

      <Footer />
    </div>
  )
}
