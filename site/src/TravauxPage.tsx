import { useEffect, useMemo, useState } from 'react'
import { Footer, Header } from './components/Frame.tsx'

/**
 * En travaux : les annales, en consultation seulement.
 *
 * Cette page annonce un chantier ouvert et n'affiche que ce qui existe : des
 * liens vers les sujets, hébergés par l'APMEP. Aucun n'est résolu en Lean pour
 * l'instant, et la page le dit — une case « à faire » qui laisserait croire à
 * un travail commencé apprendrait à se méfier de tous les autres chiffres du
 * site.
 */

type Session = { annee: number; session: string; sujet: string; corrige: string | null }
type Examen = { id: string; titre: string; fichier: string; sessions: Session[] }

export function TravauxPage() {
  const [examens, setExamens] = useState<Examen[] | null>(null)
  const [choisi, setChoisi] = useState('brevet')
  const [annee, setAnnee] = useState<number | 'toutes'>('toutes')

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
      <Header path="/travaux/" />

      <main className="mx-auto w-full max-w-4xl flex-1 px-5 pb-16">
        <div className="mt-14 flex items-center gap-3">
          <h1 className="font-serif text-4xl leading-tight text-ink-900">En travaux</h1>
          <span className="rounded-full bg-encours-50 px-2.5 py-1 font-sans text-[11px] font-semibold tracking-wide text-encours-600 uppercase">
            chantier ouvert
          </span>
        </div>

        <p className="mt-5 text-[17px] leading-relaxed text-ink-600">
          Le cours est démontré ; les épreuves ne le sont pas encore. Cette page rassemble les
          sujets de brevet et de baccalauréat de France métropolitaine — <strong>en consultation
          seulement</strong>. Aucun exercice n'est aujourd'hui formalisé. Les corrigés de l'APMEP
          ne sont pas repris ici : l'objet du chantier est de démontrer les énoncés, pas de les
          comparer à une correction rédigée.
        </p>

        <div className="mt-6 rounded-lg border border-ink-200 bg-ink-50 px-5 py-4 text-[15px] leading-relaxed text-ink-600">
          <p>
            <strong className="text-ink-800">Ce qui est prévu.</strong> Reprendre ces exercices un
            à un : écrire l'énoncé en Lean, le démontrer, puis transcrire la démonstration en
            français comme pour les chapitres du cours. Un exercice d'examen est un banc d'essai
            plus exigeant qu'un théorème de manuel — il est concret, il mélange les chapitres, et
            son énoncé est écrit pour un élève, pas pour une machine.
          </p>
          <p className="mt-3">
            <strong className="text-ink-800">Pourquoi ce n'est pas commencé.</strong> Un sujet
            d'examen pose d'abord un problème de modélisation : une figure à traduire, une
            situation à formaliser, des questions qui s'enchaînent. Ce travail-là est d'une autre
            nature que celui du cours, et il valait mieux finir les dix-sept chapitres avant de
            l'ouvrir.
          </p>
        </div>

        <div className="mt-8 flex flex-wrap items-center gap-3">
          <div className="flex rounded-lg border border-ink-200 p-0.5">
            {examens?.map((e) => (
              <button
                key={e.id}
                onClick={() => {
                  setChoisi(e.id)
                  setAnnee('toutes')
                }}
                className={[
                  'rounded-md px-3 py-1.5 text-[13px]',
                  choisi === e.id ? 'bg-brand-700 text-white' : 'text-ink-600 hover:bg-ink-100',
                ].join(' ')}
              >
                {e.titre}
                <span className="ml-1.5 font-mono text-[11px] opacity-70">
                  {e.sessions.length}
                </span>
              </button>
            ))}
          </div>

          <select
            value={annee}
            onChange={(e) => setAnnee(e.target.value === 'toutes' ? 'toutes' : Number(e.target.value))}
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

        <table className="mt-5 w-full border-collapse text-[14px]">
          <thead>
            <tr className="border-b border-ink-200 text-left text-[12px] tracking-wide text-ink-400 uppercase">
              <th className="py-2 pr-3 font-semibold">Session</th>
              <th className="py-2 pr-3 font-semibold">Sujet</th>
              <th className="py-2 font-semibold">Formalisé</th>
            </tr>
          </thead>
          <tbody>
            {sessions.map((s, i) => (
              <tr key={`${s.annee}-${i}`} className="border-b border-ink-100">
                <td className="py-2 pr-3 text-ink-700">{s.session}</td>
                <td className="py-2 pr-3">
                  <a
                    href={s.sujet}
                    className="text-brand-700 underline underline-offset-2 hover:text-brand-800"
                  >
                    PDF
                  </a>
                </td>
                <td className="py-2 font-mono text-[12px] text-ink-300">☐</td>
              </tr>
            ))}
          </tbody>
        </table>

        <p className="mt-8 text-[13.5px] leading-relaxed text-ink-500">
          Les sujets et corrigés sont la propriété de leurs auteurs et sont diffusés par
          l'
          <a className="underline underline-offset-2" href="https://www.apmep.fr/">
            APMEP
          </a>
          , qui archive les annales depuis 1941. Ce dépôt n'en héberge aucune copie : les liens
          ci-dessus mènent aux fichiers de l'association. Les listes complètes, avec leurs notes de
          lecture, sont dans{' '}
          <a
            className="underline underline-offset-2"
            href={`https://github.com/Commutator-IO/learn-lean/blob/main/exams/${examen?.fichier ?? ''}`}
          >
            {examen?.fichier}
          </a>
          .
        </p>
      </main>

      <Footer />
    </div>
  )
}
