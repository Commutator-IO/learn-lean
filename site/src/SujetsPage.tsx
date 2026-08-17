import { useEffect, useMemo, useState } from "react";
import { Footer, Header } from "./components/Frame.tsx";
import { Exercices } from "./components/Exercices.tsx";
import { donnees } from "./lib/donnees.ts";
import type { Exercice } from "./lib/types.ts";

/**
 * Les sujets d'examens : les annales, en consultation seulement.
 *
 * La page reprend la disposition de l'onglet « Apprendre Lean » : le choix à
 * gauche, dans une colonne étroite, et le reste de l'écran pour lire. Un sujet
 * se consulte page à page — lui laisser toute la hauteur importe plus qu'un
 * texte d'introduction qu'on ne lit qu'une fois, et qui se replie donc dès
 * qu'une session est ouverte.
 *
 * Le fichier vient de l'APMEP et y reste : rien n'est copié ici. L'affichage
 * dans un cadre est possible parce que le serveur ne l'interdit pas — pas
 * d'en-tête `X-Frame-Options`, pas de `frame-ancestors` — ce qui n'est pas
 * garanti pour toujours ; d'où le lien qui ouvre le fichier chez l'association,
 * à côté de l'aperçu.
 *
 * Deux façons de lire, et un bouton pour passer de l'une à l'autre. « Sessions »
 * montre les sujets tels qu'ils sont passés, un fichier à la fois.
 * « Exercices » les montre découpés question par question, avec la notion, le
 * thème, et l'énoncé Lean qui en dérive — ou l'absence d'énoncé, qui est le
 * renseignement le plus intéressant : une lecture graphique ne se formalise pas.
 */

type Session = {
  annee: number;
  session: string;
  sujet: string;
  corrige: string | null;
};
type Examen = {
  id: string;
  titre: string;
  fichier: string;
  sessions: Session[];
};

export function SujetsPage() {
  const [examens, setExamens] = useState<Examen[] | null>(null);
  const [exercices, setExercices] = useState<Exercice[]>([]);
  const [mode, setMode] = useState<"sessions" | "exercices">("sessions");
  const [choisi, setChoisi] = useState("brevet");
  const [annee, setAnnee] = useState<number | "toutes">("toutes");
  const [ouvert, setOuvert] = useState<Session | null>(null);
  const [menu, setMenu] = useState(false);

  useEffect(() => {
    donnees<{ examens: Examen[]; exercices?: Exercice[] }>("/exams.json")
      .then((d) => {
        setExamens(d.examens);
        setExercices(d.exercices ?? []);
      })
      .catch(() => setExamens([]));
  }, []);

  const examen = examens?.find((e) => e.id === choisi) ?? null;
  const annees = useMemo(
    () =>
      [...new Set(examen?.sessions.map((s) => s.annee) ?? [])].sort(
        (a, b) => b - a,
      ),
    [examen],
  );
  const sessions = useMemo(
    () =>
      examen?.sessions.filter((s) => annee === "toutes" || s.annee === annee) ??
      [],
    [examen, annee],
  );

  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/sujets/" />

      <div className="flex items-center gap-3 border-b border-ink-200 px-4 py-2">
        <div className="flex rounded-lg border border-ink-200 p-0.5">
          {(["sessions", "exercices"] as const).map((m) => (
            <button
              key={m}
              onClick={() => setMode(m)}
              className={[
                "rounded-md px-3 py-1 text-[12.5px] capitalize",
                mode === m
                  ? "bg-brand-700 text-white"
                  : "text-ink-600 hover:bg-ink-100",
              ].join(" ")}
            >
              {m}
              {m === "exercices" && exercices.length > 0 && (
                <span className="ml-1.5 font-mono text-[10.5px] opacity-70">
                  {exercices.length}
                </span>
              )}
            </button>
          ))}
        </div>
        <span className="min-w-0 truncate font-sans text-[12.5px] text-ink-500">
          {mode === "sessions"
            ? "les sujets tels qu'ils sont passés"
            : "les mêmes sujets, découpés question par question"}
        </span>
        <span className="ml-auto shrink-0 rounded-full bg-encours-50 px-2 py-0.5 font-sans text-[10.5px] font-semibold tracking-wide text-encours-600 uppercase">
          chantier ouvert
        </span>
      </div>

      {mode === "exercices" ? (
        <div className="flex flex-1 flex-col lg:flex-row">
          <Exercices exercices={exercices} />
        </div>
      ) : (
        <div className="flex flex-1 flex-col lg:flex-row">
          {/* Le choix du sujet : examen, année, session. */}
          <aside
            className={[
              "shrink-0 border-b border-ink-200 bg-white lg:w-60 lg:border-r lg:border-b-0",
              menu ? "" : "hidden lg:block",
            ].join(" ")}
          >
            <div className="max-h-[70vh] overflow-auto p-2 lg:max-h-[calc(100dvh-3rem)]">
              <div className="mb-2 flex rounded-lg border border-ink-200 p-0.5">
                {examens?.map((e) => (
                  <button
                    key={e.id}
                    onClick={() => {
                      setChoisi(e.id);
                      setAnnee("toutes");
                      setOuvert(null);
                    }}
                    className={[
                      "flex-1 rounded-md px-2 py-1 text-[12.5px]",
                      choisi === e.id
                        ? "bg-brand-700 text-white"
                        : "text-ink-600 hover:bg-ink-100",
                    ].join(" ")}
                  >
                    {e.titre}
                    <span className="ml-1 font-mono text-[10.5px] opacity-70">
                      {e.sessions.length}
                    </span>
                  </button>
                ))}
              </div>

              <select
                value={annee}
                onChange={(e) =>
                  setAnnee(
                    e.target.value === "toutes"
                      ? "toutes"
                      : Number(e.target.value),
                  )
                }
                className="mb-2 w-full rounded-lg border border-ink-200 px-2 py-1 text-[12.5px] text-ink-600"
              >
                <option value="toutes">
                  Toutes les années ({examen?.sessions.length ?? 0})
                </option>
                {annees.map((a) => (
                  <option key={a} value={a}>
                    {a}
                  </option>
                ))}
              </select>

              {sessions.map((s, i) => (
                <button
                  key={`${s.annee}-${i}`}
                  onClick={() => {
                    setOuvert(s);
                    setMenu(false);
                  }}
                  className={[
                    "flex w-full items-center gap-1.5 rounded px-1.5 py-1 text-left text-[12.5px]",
                    ouvert?.sujet === s.sujet
                      ? "bg-brand-50 text-ink-900"
                      : "text-ink-600 hover:bg-ink-100",
                  ].join(" ")}
                  title={s.session}
                >
                  <span className="min-w-0 flex-1 truncate">{s.session}</span>
                  <span
                    className="shrink-0 font-mono text-[10.5px] text-ink-300"
                    title="pas encore formalisé en Lean"
                  >
                    ☐
                  </span>
                </button>
              ))}
            </div>
          </aside>

          <main className="flex min-w-0 flex-1 flex-col">
            <div className="flex items-center gap-3 border-b border-ink-200 px-4 py-2">
              <button
                onClick={() => setMenu((v) => !v)}
                className="rounded border border-ink-200 px-2 py-1 text-[12px] text-ink-600 lg:hidden"
              >
                Sujets
              </button>
              <h1 className="min-w-0 truncate font-serif text-[15px] text-ink-900">
                {ouvert ? ouvert.session : "Sujets d'examens"}
              </h1>
              {ouvert && (
                <a
                  href={ouvert.sujet}
                  target="_blank"
                  rel="noreferrer"
                  className="ml-auto shrink-0 rounded border border-ink-300 px-2 py-1 text-[12px] text-ink-600 hover:bg-ink-50"
                >
                  ouvrir chez l'APMEP
                </a>
              )}
            </div>

            {ouvert ? (
              <iframe
                key={ouvert.sujet}
                src={ouvert.sujet}
                title={`Sujet — ${ouvert.session}`}
                className="h-[70dvh] w-full bg-ink-100 lg:h-[calc(100dvh-6.5rem)]"
              />
            ) : (
              <div className="mx-auto max-w-2xl px-6 py-10">
                <p className="text-[15.5px] leading-relaxed text-ink-600">
                  Le cours est démontré ; les épreuves ne le sont pas encore.
                  Les sujets de brevet et de baccalauréat de France
                  métropolitaine sont ici{" "}
                  <strong>en consultation seulement</strong>. L'objectif est de
                  les reprendre un à un : écrire l'énoncé en Lean, le démontrer,
                  puis transcrire la démonstration en français, comme pour les
                  chapitres du cours. Un exercice d'examen est un banc d'essai
                  plus exigeant qu'un théorème de manuel — il est concret, il
                  mêle les chapitres, et son énoncé s'adresse à un élève, pas à
                  une machine.
                </p>
                <p className="mt-4 text-[13px] leading-relaxed text-ink-500">
                  Choisissez une session à gauche pour l'afficher ici. Les
                  sujets appartiennent à leurs auteurs et sont diffusés par l'
                  <a
                    className="underline underline-offset-2"
                    href="https://www.apmep.fr/"
                  >
                    APMEP
                  </a>
                  , qui archive les annales depuis 1941 ; ce dépôt n'en héberge
                  aucune copie. Les listes complètes, avec leurs notes de
                  lecture, sont dans{" "}
                  <a
                    className="underline underline-offset-2"
                    href={`https://github.com/Commutator-IO/learn-lean/blob/main/exams/${examen?.fichier ?? ""}`}
                  >
                    {examen?.fichier}
                  </a>
                  .
                </p>
              </div>
            )}
          </main>
        </div>
      )}

      <Footer />
    </div>
  );
}
