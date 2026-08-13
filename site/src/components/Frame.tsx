/**
 * En-tête et pied de page, communs aux trois onglets.
 *
 * L'hébergement est statique : chaque onglet est un vrai document, pas une
 * route côté client. Une adresse ouverte sur un chapitre fonctionne encore
 * dans six mois — ce qui compte quand on partage le lien d'un théorème.
 */

const PAGES = [
  { path: '/cours/', label: 'Le cours' },
  { path: '/livre/', label: 'Le livre' },
]

function courant(path: string, ici: string) {
  const h = ici.endsWith('/') ? ici : `${ici}/`
  return path === h
}

export function Header({ path }: { path: string }) {
  return (
    <header className="sticky top-0 z-40 border-b border-ink-200 bg-white/93 backdrop-blur-md">
      <div className="mx-auto flex max-w-7xl items-center gap-4 px-5 py-2.5">
        <a href="/" className="flex min-w-0 items-center gap-2.5">
          <span
            aria-hidden
            className="grid size-6 place-items-center rounded bg-brand-700 font-mono text-[11px] font-bold text-white"
          >
            ∀
          </span>
          <span className="truncate text-[13px] font-semibold tracking-tight text-ink-900">
            learn-lean
          </span>
        </a>

        <nav className="ml-auto flex items-center gap-1 text-[13px]">
          {PAGES.map((p) => (
            <a
              key={p.path}
              href={p.path}
              aria-current={courant(p.path, path) ? 'page' : undefined}
              className={
                courant(p.path, path)
                  ? 'rounded px-2.5 py-1 font-medium text-ink-900'
                  : 'rounded px-2.5 py-1 text-ink-500 hover:bg-ink-100 hover:text-ink-800'
              }
            >
              {p.label}
            </a>
          ))}
          <a
            href="https://github.com/Commutator-IO/learn-lean"
            className="ml-1 rounded px-2.5 py-1 text-ink-500 hover:bg-ink-100 hover:text-ink-800"
          >
            Dépôt
          </a>
        </nav>
      </div>
    </header>
  )
}

export function Footer() {
  return (
    <footer className="border-t border-ink-200 bg-ink-50">
      <div className="mx-auto max-w-7xl px-5 py-8 text-[13px] leading-relaxed text-ink-500">
        <p>
          Les démonstrations sont écrites en Lean 4 et vérifiées par son noyau ; leur version
          française est transcrite à la main, pas engendrée. Les deux vues de ce site sont donc
          bien les deux faces d'un même texte.
        </p>
        <p className="mt-2">
          <a className="underline underline-offset-2" href="https://lean-lang.org/">
            Lean
          </a>{' '}
          ·{' '}
          <a className="underline underline-offset-2" href="https://leanprover-community.github.io/">
            Mathlib
          </a>{' '}
          ·{' '}
          <a
            className="underline underline-offset-2"
            href="https://github.com/Commutator-IO/learn-lean"
          >
            code source
          </a>
        </p>
      </div>
    </footer>
  )
}
