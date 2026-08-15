import { useEffect, useMemo, useState } from 'react'
import { Footer, Header } from './components/Frame.tsx'

/**
 * Les sujets d'examens : les annales, en consultation seulement.
 *
 * Cette page annonce un chantier ouvert et n'affiche que ce qui existe : des
 * sujets, hébergés par l'APMEP. Aucun n'est résolu en Lean pour l'instant, et la
 * page le dit — une case « à faire » qui laisserait croire à un travail commencé
 * apprendrait à se méfier de tous les autres chiffres du site.
 *
 * Le sujet choisi s'ouvre dans un volet d'aperçu, à droite. Le fichier vient de
 * l'APMEP et y reste : rien n'est copié ici. L'affichage dans un cadre est
 * possible parce que le serveur ne l'interdit pas — pas d'en-tête
 * `X-Frame-Options`, pas de `frame-ancestors` — ce qui n'est pas garanti pour
 * toujours ; d'où le lien qui ouvre le fichier chez l'association, à côté de
 * l'aperçu.
 */

type Session = { annee: number; session: string; sujet: string; corrige: string | null }
type Examen = { id: string; titre: string; fichier: string; sessions: Session[] }

export function SujetsPage() {
  const [examens, setExamens] = useState<Examen[] | null>(null)
  const [choisi, setChoisi] = useState('brevet')
  const [annee, setAnnee] = useState<number | 'toutes'>('toutes')
  const [ouvert, setOuvert] = useState<Session | null>(null)

  useEffect(() => {
    fetch('/exams.json')
      .then((r) => r.json())
      .then((d) => setExamens(d.examens))
      .catch(() => setExamens([]))
  }, [])

  const examen = examens?.find((e) => e.id === choisi) ?? null
  const annees = useMemo(
    () => [...new Set(examen?.sessions.map((s) => s.annee) ?? [])].sort((a, b) => b - a),
    [examen],
  )
  const sessions = useMemo(
    () => examen?.sessions.filter((s) => annee === 'toutes' || s.annee === annee) ?? [],
    [examen, annee],
  )

  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/sujets/" />

      <div className="mx-auto w-full max-w-7xl flex-1 px-5">
        <div className="flex items-center gap-3 pt-10">
          <h1 className="font-serif text-3xl leading-tight text-ink-900">Sujets d'examens</h1>
          <span className="rounded-full bg-encours-50 px-2.5 py-1 font-sans text-[11px] font-semibold tracking-wide text-encours-600 uppercase">
            chantier ouvert
          </span>
        </div>

        <p className="mt-4 max-w-3xl text-[15.5px] leading-relaxed text-ink-600">
          Le cours est démontré ; les épreuves ne le sont pas encore. Les sujets de brevet et de
          baccalauréat de France métropolitaine sont ici <strong>en consultation seulement</strong>
          . L'objectif est de les reprendre un à un : écrire l'énoncé en Lean, le démontrer, puis
          transcrire la démonstration en français, comme pour les chapitres du cours. Un exercice
          d'examen est un banc d'essai plus exigeant qu'un théorème de manuel — il est concret, il
          mêle les chapitres, et son énoncé s'adresse à un élève, pas à une machine.
        </p>

        <div className="mt-6 flex flex-wrap items-center gap-3">
          <div className="flex rounded-lg border border-ink-200 p-0.5">
            {examens?.map((e) => (
              <button
                key={e.id}
                onClick={() => {
                  setChoisi(e.id)
                  setAnnee('toutes')
                  setOuvert(null)
                }}
                className={[
                  'rounded-md px-3 py-1.5 text-[13px]',
                  choisi === e.id ? 'bg-brand-700 text-white' : 'text-ink-600 hover:bg-ink-100',
                ].join(' ')}
              >
                {e.titre}
                <span className="ml-1.5 font-mono text-[11px] opacity-70">{e.sessions.length}</span>
              </button>
            ))}
          </div>

          <select
            value={annee}
            onChange={(e) =>
              setAnnee(e.target.value === 'toutes' ? 'toutes' : Number(e.target.value))
            }
            className="rounded-lg border border-ink-200 px-3 py-1.5 text-[13px] text-ink-600"
          >
            <option value="toutes">Toutes les années</option>
            {annees.map((a) => (
              <option key={a} value={a}>
                {a}
              </option>
            ))}
          </select>

          <span className="text-[13px] text-ink-400">
            {sessions.length} session{sessions.length > 1 ? 's' : ''}
          </span>
        </div>

        <div className="mt-5 grid gap-5 pb-12 lg:grid-cols-[22rem_1fr]">
          {/* La liste : cliquer ouvre l'aperçu, sans quitter la page. */}
          <div className="max-h-[70dvh] overflow-auto rounded-lg border border-ink-200">
            <table className="w-full border-collapse text-[13.5px]">
              <thead className="sticky top-0 bg-white">
                <tr className="border-b border-ink-200 text-left text-[11px] tracking-wide text-ink-400 uppercase">
                  <th className="px-3 py-2 font-semibold">Session</th>
                  <th className="px-2 py-2 font-semibold">Formalisé</th>
                </tr>
              </thead>
              <tbody>
                {sessions.map((s, i) => (
                  <tr
                    key={`${s.annee}-${i}`}
                    onClick={() => setOuvert(s)}
                    className={[
                      'cursor-pointer border-b border-ink-100',
                      ouvert?.sujet === s.sujet ? 'bg-brand-50' : 'hover:bg-ink-50',
                    ].join(' ')}
                  >
                    <td className="px-3 py-2 text-ink-700">{s.session}</td>
                    <td className="px-2 py-2 font-mono text-[12px] text-ink-300">☐</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* L'aperçu : le fichier de l'APMEP, affiché tel quel. */}
          <div className="flex h-[70dvh] flex-col overflow-hidden rounded-lg border border-ink-200">
            {ouvert ? (
              <>
                <div className="flex items-center gap-3 border-b border-ink-200 px-4 py-2">
                  <span className="min-w-0 truncate text-[13.5px] text-ink-700">
                    {ouvert.session}
                  </span>
                  <a
                    href={ouvert.sujet}
                    target="_blank"
                    rel="noreferrer"
                    className="ml-auto shrink-0 rounded border border-ink-300 px-2 py-1 text-[12px] text-ink-600 hover:bg-ink-50"
                  >
                    ouvrir chez l'APMEP
                  </a>
                </div>
                <iframe
                  key={ouvert.sujet}
                  src={ouvert.sujet}
                  title={`Sujet — ${ouvert.session}`}
                  className="min-h-0 flex-1 bg-ink-100"
                />
              </>
            ) : (
              <div className="grid flex-1 place-items-center px-6 text-center text-[13.5px] text-ink-400">
                Choisissez une session dans la liste pour l'afficher ici.
              </div>
            )}
          </div>
        </div>

        <p className="pb-12 text-[13px] leading-relaxed text-ink-500">
          Les sujets et corrigés appartiennent à leurs auteurs et sont diffusés par l'
          <a className="underline underline-offset-2" href="https://www.apmep.fr/">
            APMEP
          </a>
          , qui archive les annales depuis 1941. Ce dépôt n'en héberge aucune copie : l'aperçu
          ci-dessus affiche le fichier de l'association. Les listes complètes, avec leurs notes de
          lecture, sont dans{' '}
          <a
            className="underline underline-offset-2"
            href={`https://github.com/Commutator-IO/learn-lean/blob/main/exams/${examen?.fichier ?? ''}`}
          >
            {examen?.fichier}
          </a>
          .
        </p>
      </div>

      <Footer />
    </div>
  )
}
