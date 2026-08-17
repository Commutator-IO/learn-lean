import { useMemo, useState } from "react";
import type { Exercice } from "../lib/types.ts";

/**
 * Parcourir les exercices d'examen.
 *
 * Un sujet se lit page à page, mais on cherche rarement une page : on cherche
 * une notion, un thème, ou — c'est le propre de ce dépôt — ce qui se formalise
 * et ce qui ne se formalise pas. D'où une liste plate, filtrée par facettes,
 * plutôt qu'une arborescence de sessions.
 *
 * Les compteurs d'une facette se calculent sur les résultats filtrés par toutes
 * les *autres* facettes : on voit ainsi ce que cocher une case ajouterait, et
 * une valeur qui ne mènerait à rien affiche zéro au lieu de disparaître.
 */

const STATUTS: Record<string, { court: string; classe: string; aide: string }> =
  {
    démontré: {
      court: "démontré",
      classe: "bg-prouve-50 text-prouve-700",
      aide: "l'énoncé est écrit en Lean et démontré",
    },
    "en cours": {
      court: "en cours",
      classe: "bg-encours-50 text-encours-600",
      aide: "l'énoncé est écrit, sa démonstration reste à faire",
    },
    "non formalisable": {
      court: "sans énoncé",
      classe: "bg-ink-100 text-ink-500",
      aide: "la question n'est pas une proposition mathématique : lecture graphique, interprétation, configuration",
    },
  };

/** Sans accents ni casse : on cherche « mediane » comme « médiane ». */
function pliage(s: string) {
  return s.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase();
}

function Facette({
  titre,
  valeurs,
  choisies,
  libelle = (v) => v,
  onBasculer,
}: {
  titre: string;
  valeurs: { valeur: string; n: number }[];
  choisies: Set<string>;
  /** Le nom affiché, quand il diffère de la valeur filtrée. */
  libelle?: (v: string) => string;
  onBasculer: (v: string) => void;
}) {
  const [tout, setTout] = useState(false);
  if (valeurs.length < 2) return null;
  // Au-delà d'une dizaine, la colonne déborde l'écran : on n'affiche d'abord
  // que les valeurs les plus fournies, et celles qui sont cochées.
  const visibles =
    tout || valeurs.length <= 10
      ? valeurs
      : valeurs.filter((v, i) => i < 10 || choisies.has(v.valeur));
  return (
    <div className="mb-4">
      <div className="mb-1 px-1 font-sans text-[10.5px] font-semibold tracking-wide text-ink-400 uppercase">
        {titre}
      </div>
      <div className="flex flex-wrap gap-1">
        {visibles.map(({ valeur, n }) => {
          const active = choisies.has(valeur);
          return (
            <button
              key={valeur}
              onClick={() => onBasculer(valeur)}
              aria-pressed={active}
              className={[
                "flex items-baseline gap-1 rounded-md border px-1.5 py-0.5 text-left text-[11.5px]",
                active
                  ? "border-brand-300 bg-brand-50 text-brand-800"
                  : n === 0
                    ? "border-ink-100 text-ink-300"
                    : "border-ink-200 text-ink-600 hover:bg-ink-50",
              ].join(" ")}
            >
              <span>{libelle(valeur)}</span>
              <span className="font-mono text-[10px] opacity-60">{n}</span>
            </button>
          );
        })}
        {visibles.length < valeurs.length && (
          <button
            onClick={() => setTout(true)}
            className="rounded-md px-1.5 py-0.5 text-[11.5px] text-brand-700 underline underline-offset-2"
          >
            + {valeurs.length - visibles.length} autres
          </button>
        )}
      </div>
    </div>
  );
}

/** Les axes de tri proposés, et la comparaison correspondante. */
const TRIS: Record<string, (a: Exercice, b: Exercice) => number> = {
  "ordre du sujet": (a, b) => b.annee - a.annee || a.rang - b.rang,
  thème: (a, b) => a.theme.localeCompare(b.theme) || a.rang - b.rang,
  statut: (a, b) => a.statut.localeCompare(b.statut) || a.rang - b.rang,
};

export function Exercices({ exercices }: { exercices: Exercice[] }) {
  const [q, setQ] = useState("");
  const [tri, setTri] = useState<keyof typeof TRIS>("ordre du sujet");
  const [filtres, setFiltres] = useState<Record<string, Set<string>>>({});

  const axes = useMemo(
    () =>
      [
        { cle: "epreuve", titre: "Épreuve", de: (e: Exercice) => e.epreuve },
        {
          cle: "annee",
          titre: "Session",
          de: (e: Exercice) => String(e.annee),
        },
        {
          cle: "partie",
          titre: "Partie du sujet",
          de: (e: Exercice) => e.partie,
        },
        { cle: "theme", titre: "Thème", de: (e: Exercice) => e.theme },
        {
          cle: "statut",
          titre: "Formalisation",
          de: (e: Exercice) => e.statut,
        },
        { cle: "notion", titre: "Notion", de: null },
      ] as const,
    [],
  );

  const basculer = (cle: string, v: string) =>
    setFiltres((f) => {
      const s = new Set(f[cle] ?? []);
      if (s.has(v)) s.delete(v);
      else s.add(v);
      return { ...f, [cle]: s };
    });

  // Un exercice passe une facette s'il n'y a rien de coché, ou s'il porte l'une
  // des valeurs cochées : à l'intérieur d'une facette on cumule, entre facettes
  // on restreint.
  const passe = useMemo(() => {
    const mots = pliage(q).split(/\s+/).filter(Boolean);
    return (e: Exercice, sauf?: string) => {
      if (mots.length) {
        const texte = pliage(
          [
            e.intitule,
            e.notions.join(" "),
            e.theme,
            e.session,
            e.theoremes.join(" "),
          ].join(" "),
        );
        if (!mots.every((m) => texte.includes(m))) return false;
      }
      for (const a of axes) {
        if (a.cle === sauf) continue;
        const choisies = filtres[a.cle];
        if (!choisies?.size) continue;
        const valeurs = a.de ? [a.de(e)] : e.notions;
        if (!valeurs.some((v) => choisies.has(v))) return false;
      }
      return true;
    };
  }, [q, filtres, axes]);

  const resultats = useMemo(
    () => exercices.filter((e) => passe(e)).sort(TRIS[tri]),
    [exercices, passe, tri],
  );

  const compter = (cle: string, de: ((e: Exercice) => string) | null) => {
    const n = new Map<string, number>();
    for (const e of exercices) {
      const valeurs = de ? [de(e)] : e.notions;
      for (const v of valeurs) if (!n.has(v)) n.set(v, 0);
    }
    for (const e of exercices.filter((x) => passe(x, cle))) {
      for (const v of de ? [de(e)] : e.notions) n.set(v, (n.get(v) ?? 0) + 1);
    }
    return [...n]
      .map(([valeur, k]) => ({ valeur, n: k }))
      .sort((a, b) => b.n - a.n || a.valeur.localeCompare(b.valeur));
  };

  const actifs = Object.values(filtres).reduce((a, s) => a + s.size, 0);

  return (
    <div className="flex min-w-0 flex-1 flex-col lg:flex-row">
      {/* Les facettes. En colonne à gauche du résultat, comme un catalogue. */}
      <aside className="shrink-0 border-b border-ink-200 p-3 lg:w-64 lg:border-r lg:border-b-0">
        <div className="flex items-baseline justify-between">
          <span className="font-sans text-[12px] text-ink-500">
            {resultats.length} exercice{resultats.length > 1 ? "s" : ""}
          </span>
          {(actifs > 0 || q) && (
            <button
              onClick={() => {
                setFiltres({});
                setQ("");
              }}
              className="text-[11.5px] text-brand-700 underline underline-offset-2"
            >
              tout effacer
            </button>
          )}
        </div>
        <div className="mt-3">
          {axes.map((a) => (
            <Facette
              key={a.cle}
              titre={a.titre}
              valeurs={compter(a.cle, a.de)}
              choisies={filtres[a.cle] ?? new Set()}
              libelle={
                a.cle === "statut" ? (v) => STATUTS[v]?.court ?? v : undefined
              }
              onBasculer={(v) => basculer(a.cle, v)}
            />
          ))}
        </div>
      </aside>

      <div className="min-w-0 flex-1">
        <div className="flex flex-wrap items-center gap-2 border-b border-ink-200 px-4 py-2">
          <input
            value={q}
            onChange={(e) => setQ(e.target.value)}
            placeholder="Chercher une notion, un énoncé, un théorème…"
            className="min-w-0 flex-1 rounded-lg border border-ink-200 px-3 py-1.5 text-[13px] text-ink-800 placeholder:text-ink-300 focus:border-brand-300 focus:outline-none"
          />
          <label className="flex shrink-0 items-center gap-1.5 text-[12px] text-ink-500">
            trier par
            <select
              value={tri}
              onChange={(e) => setTri(e.target.value as keyof typeof TRIS)}
              className="rounded border border-ink-200 px-1.5 py-1 text-[12px] text-ink-600"
            >
              {Object.keys(TRIS).map((t) => (
                <option key={t} value={t}>
                  {t}
                </option>
              ))}
            </select>
          </label>
        </div>

        <div className="max-h-[70dvh] overflow-auto lg:max-h-[calc(100dvh-9.5rem)]">
          {resultats.length === 0 ? (
            <p className="px-6 py-10 text-[14px] text-ink-500">
              Aucun exercice ne répond à ces critères.
            </p>
          ) : (
            <ul className="divide-y divide-ink-100">
              {resultats.map((e) => {
                const st = STATUTS[e.statut];
                return (
                  <li key={e.id} className="px-4 py-3">
                    <div className="flex flex-wrap items-baseline gap-x-2 gap-y-1">
                      <span className="font-mono text-[11px] text-ink-400">
                        {e.annee} · {e.partie.replace(/ —.*$/, "")} · {e.numero}
                      </span>
                      <span
                        className={`rounded px-1.5 py-0.5 font-sans text-[10px] font-semibold tracking-wide uppercase ${st.classe}`}
                        title={st.aide}
                      >
                        {st.court}
                      </span>
                      <span className="ml-auto font-sans text-[11px] text-ink-400">
                        {e.theme}
                      </span>
                    </div>

                    <div className="mt-1 font-serif text-[15px] text-ink-900">
                      {e.intitule}
                    </div>

                    <div className="mt-1.5 flex flex-wrap items-center gap-1.5">
                      {e.notions.map((n) => (
                        <span
                          key={n}
                          className="rounded bg-ink-100 px-1.5 py-0.5 font-sans text-[10.5px] text-ink-600"
                        >
                          {n}
                        </span>
                      ))}
                      {e.theoremes.map((t, i) => (
                        <a
                          key={t}
                          href={
                            e.source
                              ? `https://github.com/Commutator-IO/learn-lean/blob/main/${e.source}${
                                  e.lignes[i] ? `#L${e.lignes[i]}` : ""
                                }`
                              : undefined
                          }
                          target="_blank"
                          rel="noreferrer"
                          className="font-mono text-[11px] text-brand-700 underline decoration-dotted underline-offset-2"
                          title="l'énoncé Lean dérivé de cette question"
                        >
                          {t}
                        </a>
                      ))}
                      {e.sujet && (
                        <a
                          href={e.sujet}
                          target="_blank"
                          rel="noreferrer"
                          className="ml-auto text-[11px] text-ink-400 underline underline-offset-2 hover:text-ink-700"
                        >
                          sujet ↗
                        </a>
                      )}
                    </div>
                  </li>
                );
              })}
            </ul>
          )}
        </div>
      </div>
    </div>
  );
}
