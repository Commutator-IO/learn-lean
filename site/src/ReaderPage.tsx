import { useCallback, useEffect, useRef, useState } from 'react'
import { Footer, Header } from './components/Frame.tsx'
import { LeanPane } from './components/LeanPane.tsx'
import { TexPane } from './components/TexPane.tsx'
import type { Declare } from './lib/lean.ts'
import type { Cible, Pilote } from './lib/sync.ts'
import type { Chapitre, Declaration, Index } from './lib/types.ts'

/**
 * Le cours : à gauche le Lean, à droite le français.
 *
 * Les deux volets défilent séparément mais partagent une sélection : cliquer
 * une déclaration d'un côté amène l'autre en face. C'est tout l'objet de la
 * page — vérifier d'un coup d'œil que la démonstration formelle et sa
 * rédaction disent la même chose.
 *
 * La sélection vit dans le fragment d'adresse, `#02-lycee/06-integration/Integration.lean/L34`,
 * pour qu'un lien pointe sur un théorème et pas seulement sur un chapitre.
 */

/** Ce que désigne l'adresse : un chapitre, un module, une ligne. */
type Adresse = { chapitre: string; module: string; ligne: number } | null

function lireHash(): Adresse {
  const m = /^#([\w-]+\/[\w-]+)\/([\w.]+)\/L(\d+)$/.exec(location.hash)
  return m ? { chapitre: m[1], module: m[2], ligne: Number(m[3]) } : null
}

export function ReaderPage() {
  const [index, setIndex] = useState<Index | null>(null)
  const [chapitre, setChapitre] = useState<Chapitre | null>(null)
  const [module, setModule] = useState<string | null>(null)
  const [courante, setCourante] = useState<Declaration | null>(null)
  const [menu, setMenu] = useState(false)

  // Le défilement lié se retient d'une visite à l'autre : c'est une préférence
  // de lecture, pas un état de la page.
  const [lie, setLie] = useState(() => localStorage.getItem('defilement-lie') !== 'non')
  useEffect(() => {
    localStorage.setItem('defilement-lie', lie ? 'oui' : 'non')
  }, [lie])

  // Qui mène, et sur quelle déclaration s'aligner. Voir lib/sync.ts.
  const pilote = useRef<Pilote>(null)
  const [cible, setCible] = useState<Cible>(null)
  const defile = useCallback((p: NonNullable<Cible>) => setCible(p), [])

  useEffect(() => {
    fetch('/index.json')
      .then((r) => r.json())
      .then(setIndex)
      .catch(() => setIndex({ themes: [] }))
  }, [])

  const charger = useCallback(async (id: string, ligne?: number, nomModule?: string) => {
    const r = await fetch(`/chapters/${id.replace('/', '__')}.json`)
    const c: Chapitre = await r.json()
    setChapitre(c)
    const m = c.modules.find((x) => x.nom === nomModule) ?? c.modules[0]
    setModule(m.nom)
    const d = ligne ? (m.declarations.find((x) => x.ligne === ligne) ?? null) : null
    setCourante(d)
    setCible(d ? { ligne: d.ligne, suivante: null, f: 0, par: 'clic' } : null)
    setMenu(false)
  }, [])

  // Au chargement : ce que dit l'adresse, ou le premier chapitre.
  useEffect(() => {
    if (!index || chapitre) return
    const adresse = lireHash()
    const premier = index.themes[0]?.chapitres[0]?.id
    const id = adresse?.chapitre ?? premier
    if (id) void charger(id, adresse?.ligne, adresse?.module)
  }, [index, chapitre, charger])

  const choisir = useCallback(
    (d: Declaration) => {
      setCourante(d)
      // Un clic est un déplacement voulu : les deux volets s'y rendent, quel
      // que soit l'état du défilement lié.
      pilote.current = 'clic'
      setCible({ ligne: d.ligne, suivante: null, f: 0, par: 'clic' })
      if (chapitre && module) location.hash = `${chapitre.id}/${module}/L${d.ligne}`
    },
    [chapitre, module],
  )

  // Les noms déclarés dans le chapitre, tous modules confondus : un fichier
  // cite volontiers un théorème démontré dans le fichier d'à côté.
  const declares = new Map<string, Declare>()
  for (const mod of chapitre?.modules ?? []) {
    for (const d of mod.declarations) {
      if (d.nom) declares.set(d.nom, { module: mod.nom, ligne: d.ligne })
    }
  }

  const suivre = useCallback(
    (nomModule: string, ligne: number) => {
      const mod = chapitre?.modules.find((x) => x.nom === nomModule)
      const d = mod?.declarations.find((x) => x.ligne === ligne)
      if (!mod || !d) return
      setModule(mod.nom)
      setCourante(d)
      pilote.current = 'clic'
      setCible({ ligne: d.ligne, suivante: null, f: 0, par: 'clic' })
      if (chapitre) location.hash = `${chapitre.id}/${mod.nom}/L${d.ligne}`
    },
    [chapitre],
  )

  const m = chapitre?.modules.find((x) => x.nom === module) ?? null

  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/cours/" />

      <div className="flex flex-1 flex-col lg:flex-row">
        {/* Sommaire. Replié sur petit écran : la lecture à deux volets y est
            déjà à l'étroit. */}
        <aside
          className={[
            'shrink-0 border-b border-ink-200 bg-white lg:w-52 lg:border-r lg:border-b-0',
            menu ? '' : 'hidden lg:block',
          ].join(' ')}
        >
          <div className="max-h-[70vh] overflow-auto p-2 lg:max-h-[calc(100dvh-3rem)]">
            {index?.themes.map((t) => (
              <div key={t.id} className="mb-4">
                <div
                  className="px-1.5 py-1 font-sans text-[11px] font-semibold tracking-wide text-ink-400 uppercase"
                  title={t.sousTitre}
                >
                  {t.titre}
                </div>
                {t.chapitres.map((c) => {
                  const actif = chapitre?.id === c.id
                  const complet = c.statuts.demontres === c.statuts.total
                  return (
                    <button
                      key={c.id}
                      onClick={() => void charger(c.id)}
                      className={[
                        'flex w-full items-center gap-1.5 rounded px-1.5 py-1 text-left text-[12.5px]',
                        actif ? 'bg-brand-50 text-ink-900' : 'text-ink-600 hover:bg-ink-100',
                      ].join(' ')}
                    >
                      <span className="min-w-0 flex-1 truncate" title={`${c.titre} — ${c.niveau}`}>
                        <span
                          aria-hidden
                          className={
                            c.niveau === 'collège'
                              ? 'mr-1.5 inline-block size-1.5 rounded-full bg-ink-300 align-middle'
                              : 'mr-1.5 inline-block size-1.5 rounded-full bg-brand-400 align-middle'
                          }
                        />
                        {c.titre}
                      </span>
                      <span
                        className={[
                          'shrink-0 rounded px-1 py-0.5 font-mono text-[10px]',
                          complet
                            ? 'bg-prouve-50 text-prouve-700'
                            : 'bg-encours-50 text-encours-600',
                        ].join(' ')}
                      >
                        {c.statuts.demontres}/{c.statuts.total}
                      </span>
                    </button>
                  )
                })}
              </div>
            ))}
          </div>
        </aside>

        <main className="flex min-w-0 flex-1 flex-col">
          <div className="flex items-center gap-3 border-b border-ink-200 px-4 py-2">
            <button
              onClick={() => setMenu((v) => !v)}
              className="rounded border border-ink-200 px-2 py-1 text-[12px] text-ink-600 lg:hidden"
            >
              Chapitres
            </button>
            <h1 className="min-w-0 truncate font-serif text-[15px] text-ink-900">
              {chapitre?.titre ?? '…'}
            </h1>
            <label className="ml-auto flex shrink-0 items-center gap-1.5 text-[12px] text-ink-500">
              <input
                type="checkbox"
                checked={lie}
                onChange={(e) => setLie(e.target.checked)}
                className="size-3.5 accent-brand-700"
              />
              défilement lié
            </label>
            {chapitre && chapitre.modules.length > 1 && (
              <select
                value={module ?? ''}
                onChange={(e) => {
                  setModule(e.target.value)
                  setCourante(null)
                  setCible(null)
                }}
                className="rounded border border-ink-200 px-2 py-1 font-mono text-[12px] text-ink-600"
              >
                {chapitre.modules.map((x) => (
                  <option key={x.nom} value={x.nom}>
                    {x.nom}
                  </option>
                ))}
              </select>
            )}
          </div>

          {m && chapitre ? (
            <div className="grid flex-1 grid-cols-1 lg:grid-cols-2">
              <div className="h-[50dvh] border-b border-ink-200 lg:h-[calc(100dvh-6.5rem)] lg:border-r lg:border-b-0">
                <LeanPane
                  module={m}
                  chapitre={chapitre.id}
                  courante={courante}
                  cible={cible}
                  lie={lie}
                  pilote={pilote}
                  declares={declares}
                  onChoisir={choisir}
                  onDefile={defile}
                  onSuivre={suivre}
                />
              </div>
              <div className="h-[50dvh] lg:h-[calc(100dvh-6.5rem)]">
                <TexPane
                  module={m}
                  courante={courante}
                  cible={cible}
                  lie={lie}
                  pilote={pilote}
                  onChoisir={choisir}
                  onDefile={defile}
                />
              </div>
            </div>
          ) : (
            <div className="grid flex-1 place-items-center p-10 text-[13px] text-ink-400">
              Chargement du chapitre…
            </div>
          )}
        </main>
      </div>

      <Footer />
    </div>
  )
}
