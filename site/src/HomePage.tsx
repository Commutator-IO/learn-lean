import { useEffect, useState } from "react";
import { Footer, Header } from "./components/Frame.tsx";
import { donnees } from "./lib/donnees.ts";
import type { Index } from "./lib/types.ts";

/**
 * L'accueil : ce que contient le dépôt, et ce qu'on peut en faire.
 *
 * Les chiffres sont lus dans `index.json`, donc dans les fichiers eux-mêmes.
 * Un compte écrit à la main serait faux au premier chapitre suivant.
 */
export function HomePage() {
  const [index, setIndex] = useState<Index | null>(null);
  useEffect(() => {
    donnees<Index>("/index.json")
      .then(setIndex)
      .catch(() => setIndex({ themes: [] }));
  }, []);

  const compte = (t: Index["themes"][number]) =>
    t.chapitres.reduce(
      (a, c) => ({
        total: a.total + c.statuts.total,
        demontres: a.demontres + c.statuts.demontres,
      }),
      { total: 0, demontres: 0 },
    );

  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/" />

      <main className="flex-1">
        <section className="mx-auto max-w-3xl px-5 pt-16 pb-10">
          <h1 className="font-serif text-4xl leading-tight text-ink-900">
            Les mathématiques du secondaire français, démontrées en Lean
          </h1>
          <p className="mt-5 text-[17px] leading-relaxed text-ink-600">
            De la sixième à la terminale, chaque théorème du programme est écrit
            et vérifié en{" "}
            <a
              className="text-brand-700 underline underline-offset-2"
              href="https://lean-lang.org/"
            >
              Lean 4
            </a>
            , puis transcrit en français. Le site montre les deux textes côte à
            côte : à gauche la preuve que la machine accepte, à droite celle
            qu'un élève peut lire. Les chapitres se suivent par notion et non
            par cycle : la divisibilité de sixième et l'arithmétique de
            terminale sont le même sujet, et se lisent à la suite.
          </p>
          <p className="mt-4 text-[15px] leading-relaxed text-ink-500">
            Le corpus est pris tel quel, sans écarter ce qui résiste. Les
            énoncés qu'on ne sait pas formaliser honnêtement — l'aire du disque,
            le théorème du toit, Moivre–Laplace — restent dans la liste, avec la
            raison. C'est là que se lisent les limites de l'outil, et c'est une
            des choses que ce travail cherche à mesurer.
          </p>

          <div className="mt-8 flex flex-wrap gap-3">
            <a
              href="/cours/"
              className="rounded-lg bg-brand-700 px-4 py-2.5 text-[14px] font-medium text-white hover:bg-brand-800"
            >
              Apprendre Lean
            </a>
            <a
              href="/livre/"
              className="rounded-lg border border-ink-300 px-4 py-2.5 text-[14px] font-medium text-ink-700 hover:bg-ink-50"
            >
              Lire le livre
            </a>
          </div>
        </section>

        <section className="border-y border-ink-200 bg-ink-50">
          <div className="mx-auto max-w-3xl px-5 py-10">
            <h2 className="font-serif text-2xl text-ink-900">
              Les cinq thèmes
            </h2>
            <p className="mt-2 text-[14.5px] text-ink-500">
              Chacun va du collège à la terminale, sans interruption.
            </p>
            <div className="mt-6 grid gap-5 sm:grid-cols-2">
              {index?.themes.map((t) => {
                const c = compte(t);
                return (
                  <a
                    key={t.id}
                    href={`/cours/#${t.chapitres[0]?.id ?? ""}`}
                    className="group"
                  >
                    <div className="flex items-baseline gap-2">
                      <span className="font-serif text-[17px] text-ink-900 group-hover:underline">
                        {t.titre}
                      </span>
                      <span className="ml-auto font-mono text-[12.5px] text-ink-400">
                        {c.demontres}/{c.total}
                      </span>
                    </div>
                    <div className="text-[13.5px] text-ink-500">
                      {t.sousTitre}
                    </div>
                    <div className="mt-2 h-1.5 overflow-hidden rounded-full bg-ink-200">
                      <div
                        className="h-full rounded-full bg-prouve-500"
                        style={{
                          width: `${c.total ? (100 * c.demontres) / c.total : 0}%`,
                        }}
                      />
                    </div>
                    <div className="mt-1.5 text-[12px] text-ink-400">
                      {t.chapitres.length} chapitre
                      {t.chapitres.length > 1 ? "s" : ""} ·{" "}
                      {[...new Set(t.chapitres.map((x) => x.niveau))].join(
                        " et ",
                      )}
                    </div>
                  </a>
                );
              })}
            </div>
          </div>
        </section>

        <section className="mx-auto max-w-3xl px-5 py-12">
          <h2 className="font-serif text-2xl text-ink-900">
            Comment c'est fait
          </h2>
          <div className="mt-5 space-y-5 text-[15px] leading-relaxed text-ink-600">
            <p>
              <strong className="text-ink-800">Le programme d'abord.</strong>{" "}
              Deux listes, une par cycle, recensent les théorèmes et propriétés
              au programme — sans filtrer ceux qui se formalisent mal. Chaque
              ligne porte son statut : démontré, en cours, ou non formalisable
              en l'état.
            </p>
            <p>
              <strong className="text-ink-800">La preuve ensuite.</strong> Un
              fichier Lean par section de chapitre, vérifié par{" "}
              <code className="font-mono text-[13.5px]">
                lake build --wfail
              </code>{" "}
              à chaque changement : un simple avertissement fait échouer la
              construction.
            </p>
            <p>
              <strong className="text-ink-800">La rédaction enfin.</strong> Le
              squelette du document français est engendré depuis le fichier Lean
              — sections, énoncés, renvois aux lignes exactes — et les
              démonstrations sont transcrites à la main, en suivant les étapes
              du script formel plutôt qu'en le paraphrasant. Ce sont ces
              documents que le site affiche et que le livre compile.
            </p>
          </div>
        </section>
      </main>

      <Footer />
    </div>
  );
}
