import { Footer, Header } from './components/Frame.tsx'
import { colorier } from './lib/lean.ts'

/**
 * La méthode : comment on passe d'un énoncé de programme à un théorème vérifié.
 *
 * Cette page n'est pas un tutoriel Lean — il en existe de meilleurs. Elle décrit
 * ce que ce dépôt a réellement fait, dans l'ordre où il l'a fait, avec les
 * outils qu'il a employés et les erreurs qui ont coûté du temps.
 */

function Code({ children }: { children: string }) {
  return (
    <pre className="my-4 overflow-x-auto rounded-lg border border-ink-200 bg-ink-50 px-4 py-3 font-mono text-[12.5px] leading-[1.6]">
      {colorier(children.trim()).map((jetons, i) => (
        <div key={i}>
          {jetons.map((j, k) => (
            <span key={k} className={j.classe === 'texte' ? undefined : `jeton-${j.classe}`}>
              {j.texte}
            </span>
          ))}
          {jetons.length === 0 ? ' ' : null}
        </div>
      ))}
    </pre>
  )
}

function Titre({ children, id }: { children: string; id: string }) {
  return (
    <h2 id={id} className="mt-12 mb-4 scroll-mt-16 font-serif text-2xl text-ink-900">
      {children}
    </h2>
  )
}

export function MethodePage() {
  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/methode/" />

      <main className="mx-auto w-full max-w-3xl flex-1 px-5 pb-16">
        <h1 className="mt-14 font-serif text-4xl leading-tight text-ink-900">Méthode</h1>
        <p className="mt-5 text-[17px] leading-relaxed text-ink-600">
          Comment on passe d'une ligne de programme scolaire à un théorème que la machine
          accepte, puis à une page de livre qu'un élève peut lire. Ce qui suit décrit le
          travail réellement fait dans ce dépôt, avec ses outils et ses impasses.
        </p>

        <nav className="mt-8 rounded-lg border border-ink-200 bg-ink-50 px-5 py-4 text-[14px]">
          <ol className="space-y-1 text-ink-600">
            <li>
              <a className="hover:underline" href="#enonce">
                1. Le plus dur est l'énoncé, pas la preuve
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#chercher">
                2. Chercher dans Mathlib avant d'écrire
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#preuve">
                3. Écrire la preuve : la boucle
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#outils">
                4. Les outils
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#skills">
                5. Les deux skills du dépôt
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#lecons">
                6. Ce que la formalisation apprend
              </a>
            </li>
          </ol>
        </nav>

        <div className="text-[15.5px] leading-relaxed text-ink-700">
          <Titre id="enonce">1. Le plus dur est l'énoncé, pas la preuve</Titre>
          <p>
            Un énoncé de programme est écrit pour un lecteur qui complète tout seul ce qui manque.
            « Dans un parallélogramme, les diagonales se coupent en leur milieu » suppose que le
            quadrilatère n'est pas croisé ; « le quotient <code>a/b</code> » suppose{' '}
            <code>b ≠ 0</code> ; « la racine de <code>a</code> » suppose <code>a ≥ 0</code>. Un
            assistant de preuve ne complète rien : chaque hypothèse tue doit être écrite, ou
            l'énoncé devient faux.
          </p>
          <p className="mt-3">
            La première question est donc toujours la même : <strong>de quoi cet énoncé parle-t-il
            exactement ?</strong> Trois pièges reviennent.
          </p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            Les définitions déguisées en théorèmes
          </h3>
          <p>
            « L'aire du disque vaut <code>πr²</code> » n'est pas un théorème au collège : c'est une
            formule donnée. En mathématiques, c'est un résultat de théorie de la mesure. Formaliser
            demande donc de choisir : ou bien on pose la formule comme définition — et l'on ne
            démontre rien — ou bien on la démontre, avec un appareillage sans rapport avec le
            niveau. Le dépôt choisit la seconde voie quand elle est raisonnable et le dit quand
            elle ne l'est pas.
          </p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            Les valeurs de remplissage
          </h3>
          <p>
            Lean exige que toute fonction soit totale. Mathlib complète donc celles qui ne le sont
            pas : <code>x / 0 = 0</code>, la soustraction des entiers naturels est tronquée,{' '}
            <code>√x = 0</code> pour <code>x &lt; 0</code>. Ces valeurs rendent des théorèmes vrais
            dans des cas où l'énoncé mathématique n'a aucun sens — et il ne faut jamais les
            présenter comme des mathématiques. Un énoncé du dépôt garde donc ses hypothèses même
            quand Lean pourrait s'en passer.
          </p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            Les tâches qui ne sont pas des propositions
          </h3>
          <p>
            « Construire la médiatrice à la règle et au compas », « étudier la fonction f »,
            « dresser le tableau de variation » : ce sont des tâches. Ce qui se démontre, c'est la
            caractérisation de la médiatrice, ou le lien entre le signe de la dérivée et le sens de
            variation. Le dépôt formalise la proposition et laisse la tâche au tableau.
          </p>

          <Titre id="chercher">2. Chercher dans Mathlib avant d'écrire</Titre>
          <p>
            Une bonne moitié du programme du lycée existe déjà dans Mathlib, souvent sous un autre
            nom et dans une généralité plus grande. Écrire une preuve sans avoir cherché, c'est
            refaire — mal — ce qui est déjà fait. Trois façons de chercher, dans l'ordre où elles
            paient :
          </p>
          <ul className="mt-3 list-disc space-y-2 pl-5">
            <li>
              <strong>Par la forme de l'énoncé</strong> — <em>loogle</em> prend un motif de type :{' '}
              <code>|- Real.sqrt _ = _ * _</code> trouve tout ce qui conclut sur une racine de
              produit. C'est l'outil le plus précis quand on sait à quoi ressemble le résultat.
            </li>
            <li>
              <strong>Par le sens</strong> — <em>leansearch</em> accepte une phrase : « second
              derivative nonnegative implies convex ». Utile quand on ne connaît pas le vocabulaire
              de la bibliothèque.
            </li>
            <li>
              <strong>Par le but courant</strong> — <code>exact?</code> et <code>apply?</code>{' '}
              cherchent un lemme qui ferme le but où l'on est. Lent, mais imbattable en fin de
              preuve.
            </li>
          </ul>
          <p className="mt-3">
            Quand le résultat existe, le travail change de nature : il ne s'agit plus de démontrer
            mais de <strong>vérifier que l'énoncé de la bibliothèque dit bien la même chose que
            celui du programme</strong>. Ce n'est pas toujours plus facile. L'argument d'un produit
            en est le meilleur exemple : Mathlib le donne dans le groupe des angles, parce que
            l'égalité entre réels est fausse — ce que la notation scolaire « [2π] » cache.
          </p>

          <Titre id="preuve">3. Écrire la preuve : la boucle</Titre>
          <p>
            La méthode tient en trois pas, répétés jusqu'à ce que le fichier soit vert.
          </p>
          <p className="mt-3">
            <strong>Poser l'énoncé, admettre la preuve.</strong> On écrit le théorème avec{' '}
            <code>sorry</code> et on vérifie qu'il compile : c'est le seul moment où l'on regarde
            l'énoncé seul, sans être distrait par la démonstration.
          </p>
          <Code>{`theorem somme_de_deux_impairs_est_paire {m n : ℕ}
    (hm : Impair m) (hn : Impair n) : Pair (m + n) := by
  sorry`}</Code>
          <p>
            <strong>Descendre d'un cran.</strong> On remplace <code>sorry</code> par la première
            étape — défaire une hypothèse, distinguer des cas, réécrire — et l'on regarde le but
            qui reste. C'est là que le serveur de langage compte : il donne l'état du but à
            n'importe quelle ligne, sans recompiler.
          </p>
          <Code>{`  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l + 1, by omega⟩`}</Code>
          <p>
            <strong>Laisser l'automatisation finir.</strong> Le dépôt s'appuie sur une petite
            famille de tactiques, et chacune a son domaine :
          </p>
          <ul className="mt-3 list-disc space-y-1.5 pl-5">
            <li>
              <code>omega</code> — arithmétique linéaire sur ℕ et ℤ, divisibilité par des
              constantes. Elle démontre <em>directement une équivalence</em>, ce qui évite de
              séparer les deux sens à la main.
            </li>
            <li>
              <code>linarith</code>, <code>nlinarith</code> — inégalités linéaires, et non
              linéaires avec des indications.
            </li>
            <li>
              <code>ring</code>, <code>field_simp</code>, <code>linear_combination</code> — les
              identités algébriques. La dernière est précieuse : elle démontre une égalité comme
              combinaison d'hypothèses, ce qui remplace des pages de réécritures.
            </li>
            <li>
              <code>simp</code>, <code>simpa</code> — la simplification par la base de règles. À
              manier avec méfiance : ce qu'elle prouve dépend de la bibliothèque, et une preuve qui
              n'est qu'un <code>simp</code> n'apprend rien.
            </li>
            <li>
              <code>positivity</code>, <code>decide</code>, <code>norm_num</code> — la positivité,
              le calcul fini, le calcul numérique.
            </li>
          </ul>
          <p className="mt-3">
            Une règle de conduite, apprise à ses dépens : <strong>ne jamais laisser une preuve
            reposer sur un nom de lemme qu'on n'a pas vérifié</strong>. Un nom inventé qui
            ressemble à un vrai coûte une reconstruction complète — cinq minutes ici — alors que le
            vérifier en coûte deux secondes.
          </p>

          <Titre id="outils">4. Les outils</Titre>
          <p>
            Deux outils changent l'échelle du travail, et le reste est de l'outillage classique.
          </p>
          <p className="mt-3">
            <strong>
              <a
                className="text-brand-700 underline underline-offset-2"
                href="https://github.com/oOo0oOo/lean-lsp-mcp"
              >
                lean-lsp-mcp
              </a>
            </strong>{' '}
            — un serveur MCP qui expose le serveur de langage de Lean. Il rend{' '}
            <em>toutes</em> les erreurs d'un fichier en une fois, donne l'état du but à n'importe
            quelle ligne, teste plusieurs tactiques sans modifier le fichier, et interroge loogle
            et leansearch. Sans lui, chaque nom erroné coûte un <code>lake build</code> complet ;
            avec lui, la boucle se compte en secondes. C'est la différence entre écrire une preuve
            et deviner une preuve.
          </p>
          <p className="mt-3">
            <strong>
              <a
                className="text-brand-700 underline underline-offset-2"
                href="https://github.com/cameronfreer/lean4-skills"
              >
                lean4-skills
              </a>
            </strong>{' '}
            — des skills et workflows Lean 4 pour agents de code, sur la recherche de preuve :
            réparation guidée par le compilateur, remplissage de <code>sorry</code>, réduction
            d'une preuve qui compile.
          </p>
          <p className="mt-3">
            Le reste : <code>elan</code> et <code>lake</code> pour la chaîne Lean, avec un{' '}
            <code>lake build --wfail</code> qui fait échouer la construction sur un simple
            avertissement — une variable inutilisée est une erreur ; <code>tectonic</code> pour
            composer les documents, parce qu'il ne télécharge que les paquets utilisés ; et une
            bibliothèque Lean par chapitre, pour ne reconstruire qu'un chapitre à la fois.
          </p>

          <Titre id="skills">5. Les deux skills du dépôt</Titre>
          <p>
            Une skill est un mode d'emploi que l'agent de code charge quand la tâche s'y prête. Le
            dépôt en porte deux, qui encadrent les deux moments où l'on écrit du français.
          </p>

          <div className="mt-5 rounded-lg border border-ink-200 p-5">
            <h3 className="font-mono text-[13px] font-semibold text-brand-700">
              transcribe-lean-proof
            </h3>
            <p className="mt-2 text-[15px]">
              Transcrire une preuve Lean en français, dans le document jumeau du fichier. Sa règle
              première : <strong>transcrire, pas réécrire</strong>. La démonstration française suit
              les étapes du script, dans leur ordre, avec leurs cas ; on ne substitue pas une preuve
              plus élégante. Si la preuve Lean est laide, la transcription est laide.
            </p>
            <ul className="mt-3 list-disc space-y-1.5 pl-5 text-[14.5px] text-ink-600">
              <li>
                Une table de correspondance tactique → français, avec une consigne ferme :{' '}
                <em>ne jamais nommer une tactique</em>, mais dire ce qu'elle fait. « relève de
                l'arithmétique linéaire », pas « <code>omega</code> conclut ».
              </li>
              <li>
                Un nom de lemme n'est pas une démonstration : <code>Nat.le_of_dvd</code> se traduit
                par ce qu'il affirme, pas par son identifiant.
              </li>
              <li>
                Les énoncés et les définitions <em>portent leur formule</em> : « une homothétie
                multiplie les distances » ne dit pas de combien.
              </li>
              <li>
                Les calculs restent des calculs : un <code>field_simp</code> se transcrit par la
                suite d'égalités, pas par « on simplifie ».
              </li>
              <li>
                La rédaction se règle sur le niveau de la classe, et quand la preuve formelle
                dépasse ce niveau, on le dit en une phrase.
              </li>
              <li>
                <strong>Les conventions de Lean ne sont pas des mathématiques</strong> : une valeur
                de remplissage doit être signalée comme telle, jamais présentée comme un résultat.
              </li>
              <li>
                Ce qui n'est pas démontré est écrit noir sur blanc, avec la raison.
              </li>
            </ul>
          </div>

          <div className="mt-5 rounded-lg border border-ink-200 p-5">
            <h3 className="font-mono text-[13px] font-semibold text-brand-700">
              write-course-book
            </h3>
            <p className="mt-2 text-[15px]">
              Rédiger les textes de liaison du livre : avant-propos, ouverture des parties,
              introduction des chapitres. Sa règle première est le pendant de l'autre :{' '}
              <strong>les énoncés et les démonstrations ne sont pas réécrits</strong>. Les rendre
              plus élégants romprait le lien avec la preuve vérifiée, qui est tout l'objet du dépôt.
            </p>
            <ul className="mt-3 list-disc space-y-1.5 pl-5 text-[14.5px] text-ink-600">
              <li>
                Ce qu'un texte d'ouverture doit faire : dire ce que le chapitre établit, ce dont il
                a besoin et qui vient d'ailleurs, ce qu'il faut regarder de près, et ce qu'il ne
                démontre pas.
              </li>
              <li>
                Ce qu'il ne fait jamais : introduire un énoncé nouveau, inventer un exemple,
                promettre un résultat qui n'arrive pas, ou juger de la difficulté.
              </li>
            </ul>
          </div>

          <Titre id="lecons">6. Ce que la formalisation apprend</Titre>
          <p>
            Le résultat le plus intéressant n'est pas la liste des théorèmes démontrés : c'est le
            déplacement de la frontière entre ce qui est admis et ce qui est établi.
          </p>
          <p className="mt-3">
            Le programme du lycée admet beaucoup — théorème des valeurs intermédiaires, existence
            des primitives, aire sous la courbe, espérance d'une loi binomiale, théorème du toit. Un
            assistant de preuve ne connaît pas cette convention. La frontière bouge donc, et dans
            les deux sens : <strong>l'espérance d'une loi binomiale, admise en première, est
            démontrée ici</strong> — et Mathlib ne la contenait pas — tandis que{' '}
            <strong>le théorème du toit, admis lui aussi, ne l'est pas</strong>, parce que sa
            démonstration repose sur un calcul de dimensions invisible dans l'énoncé scolaire.
          </p>
          <p className="mt-3">
            De même, l'intégrale : au lycée elle <em>est</em> l'aire sous la courbe, par définition
            ; ici l'aire est une mesure et l'égalité est un théorème, qui ouvre le chapitre. Le
            renversement est complet, et c'est lui qu'il fallait écrire.
          </p>
          <p className="mt-3">
            Enfin, la formalisation mesure ce que coûtent les évidences. L'unicité de la
            décomposition en facteurs premiers, admise au collège, demande le lemme d'Euclide, qui
            demande le théorème de Gauss. Une démonstration complète n'est pas plus difficile qu'un
            « on montre de même » : elle est simplement écrite.
          </p>
        </div>
      </main>

      <Footer />
    </div>
  )
}
