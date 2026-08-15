import { Footer, Header } from "./components/Frame.tsx";
import { colorier } from "./lib/lean.ts";

/**
 * La méthode : comment ces preuves ont été écrites, avec quoi, et dans quel
 * ordre.
 *
 * La page part de l'outillage plutôt que de la théorie, parce que c'est
 * l'outillage qui a décidé de ce qui était faisable : sans réponse en deux
 * secondes du serveur de langage, on n'écrit pas deux cent cinquante preuves,
 * on en devine vingt.
 */

function Code({ children }: { children: string }) {
  return (
    <pre className="my-4 overflow-x-auto rounded-lg border border-ink-200 bg-ink-50 px-4 py-3 font-mono text-[12.5px] leading-[1.6]">
      {colorier(children.trim()).map((jetons, i) => (
        <div key={i}>
          {jetons.map((j, k) => (
            <span
              key={k}
              className={j.classe === "texte" ? undefined : `jeton-${j.classe}`}
            >
              {j.texte}
            </span>
          ))}
          {jetons.length === 0 ? " " : null}
        </div>
      ))}
    </pre>
  );
}

function Titre({ children, id }: { children: string; id: string }) {
  return (
    <h2
      id={id}
      className="mt-12 mb-4 scroll-mt-16 font-serif text-2xl text-ink-900"
    >
      {children}
    </h2>
  );
}

/**
 * La chaîne de production, d'un fichier Lean au livre imprimé.
 *
 * Un dessin plutôt qu'une liste : ce qui compte est l'ordre — rien n'est écrit à
 * la main en aval d'un générateur — et l'outil qui fait chaque pas. La colonne
 * du milieu porte ce qui s'écrit, les côtés ce qui s'en déduit. Le SVG suit la
 * couleur du texte, donc le thème.
 */
function Chaine() {
  const boite = (
    x: number,
    y: number,
    l: number,
    titre: string,
    sous: string,
    mono = true,
  ) => (
    <g key={titre}>
      <rect
        x={x}
        y={y}
        width={l}
        height={44}
        rx={6}
        className="fill-white stroke-ink-300"
      />
      <text
        x={x + l / 2}
        y={y + 19}
        textAnchor="middle"
        className={
          mono
            ? "fill-ink-900 font-mono text-[11px]"
            : "fill-ink-900 text-[12px]"
        }
      >
        {titre}
      </text>
      <text
        x={x + l / 2}
        y={y + 34}
        textAnchor="middle"
        className="fill-ink-500 text-[10px]"
      >
        {sous}
      </text>
    </g>
  );

  /** Flèche verticale, l'outil écrit à sa droite. */
  const bas = (x: number, y1: number, y2: number, outil: string) => (
    <g key={`${x}-${y1}-bas`}>
      <line
        x1={x}
        y1={y1}
        x2={x}
        y2={y2}
        className="stroke-ink-400"
        markerEnd="url(#pointe)"
      />
      <text
        x={x + 10}
        y={(y1 + y2) / 2 + 4}
        className="fill-brand-700 font-mono text-[10px]"
      >
        {outil}
      </text>
    </g>
  );

  /** Flèche horizontale : l'outil est écrit dans la boîte d'arrivée. */
  const cote = (x1: number, x2: number, y: number) => (
    <line
      key={`${x1}-${y}-cote`}
      x1={x1}
      y1={y}
      x2={x2}
      y2={y}
      className="stroke-ink-400"
      markerEnd="url(#pointe)"
    />
  );

  return (
    <figure className="my-6 overflow-x-auto rounded-lg border border-ink-200 bg-ink-50/50 p-4">
      <svg viewBox="0 0 640 330" className="w-full min-w-[560px]" fill="none">
        <title>
          De la preuve Lean au livre : ordre de production et outils employés
        </title>
        <defs>
          <marker
            id="pointe"
            viewBox="0 0 10 10"
            refX="9"
            refY="5"
            markerWidth="6"
            markerHeight="6"
            orient="auto"
          >
            <path d="M0,0 L10,5 L0,10 z" className="fill-ink-400" />
          </marker>
        </defs>

        {/* Colonne du milieu : ce qui s'écrit. */}
        {boite(225, 15, 190, "courses/**/*.lean", "les preuves, à la main")}
        {bas(320, 59, 89, "generate-tex.py")}
        {boite(225, 93, 190, "courses/**/*.tex", "squelette + ancres #Lnn")}
        {bas(320, 137, 167, "à la main : la transcription")}
        {boite(225, 171, 190, "+ démonstrations", "en français, appariées")}
        {bas(320, 215, 245, "generate-book.py")}
        {boite(225, 249, 190, "book/cours-complet.tex", "+ book/textes")}

        {/* À droite : ce que Lean et LaTeX en font. */}
        {cote(415, 436, 37)}
        {boite(
          440,
          15,
          185,
          "vérifié par le noyau",
          "lake build + Mathlib",
          false,
        )}
        {cote(415, 436, 193)}
        {boite(440, 171, 185, "PDF du chapitre", "tectonic", false)}
        {cote(415, 436, 271)}
        {boite(440, 249, 185, "cours-complet.pdf", "tectonic", false)}

        {/* À gauche : ce que le site en fait. */}
        {cote(225, 204, 193)}
        {boite(15, 171, 185, "site/public/*.json", "manifest.mjs", false)}
        {bas(107, 215, 245, "vite build")}
        {boite(
          15,
          249,
          185,
          "lean.commutator.io",
          "site + livre en ligne",
          false,
        )}
      </svg>
      <figcaption className="mt-3 text-[13px] leading-relaxed text-ink-500">
        Deux choses seulement s'écrivent à la main : la preuve Lean, et sa
        transcription française. Tout le reste est engendré et se régénère —
        c'est ce qui permet de vérifier que les deux disent la même chose.
      </figcaption>
    </figure>
  );
}

export function MethodePage() {
  return (
    <div className="flex min-h-dvh flex-col">
      <Header path="/methode/" />

      <main className="mx-auto w-full max-w-3xl flex-1 px-5 pb-16">
        <h1 className="mt-14 font-serif text-4xl leading-tight text-ink-900">
          Méthode
        </h1>
        <p className="mt-5 text-[17px] leading-relaxed text-ink-600">
          Ces deux cent treize démonstrations ont été écrites avec Claude Code,
          dans un va-et-vient constant avec le serveur de langage de Lean. Cette
          page raconte comment on s'y prend concrètement : l'atelier d'abord,
          puis le travail de formalisation lui-même.
        </p>

        <nav className="mt-8 rounded-lg border border-ink-200 bg-ink-50 px-5 py-4 text-[14px]">
          <ol className="space-y-1 text-ink-600">
            <li>
              <a className="hover:underline" href="#atelier">
                1. L'atelier : Claude, le serveur de langage et le reste
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#boucle">
                2. La boucle de travail, pas à pas
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#chaine">
                3. De la preuve au livre : la chaîne
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#enonce">
                4. Le plus dur reste d'écrire l'énoncé
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#chercher">
                5. Chercher avant d'écrire
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#skills">
                6. Les skills du dépôt
              </a>
            </li>
            <li>
              <a className="hover:underline" href="#lecons">
                7. Ce que la formalisation révèle
              </a>
            </li>
          </ol>
        </nav>

        <div className="text-[15.5px] leading-relaxed text-ink-700">
          <Titre id="atelier">
            1. L'atelier : Claude, le serveur de langage et le reste
          </Titre>
          <p>
            Écrire une preuve Lean à la main revient à jouer aux échecs par
            correspondance : on propose un coup, on attend, on découvre qu'il
            était illégal. Une construction complète du dépôt prend cinq minutes
            ; à ce rythme, une erreur de nom de lemme coûte plus cher qu'elle ne
            devrait, et l'on finit par écrire au jugé.
          </p>
          <p className="mt-3">
            Tout change avec un serveur MCP qui expose le serveur de langage de
            Lean.{" "}
            <a
              className="text-brand-700 underline underline-offset-2"
              href="https://github.com/oOo0oOo/lean-lsp-mcp"
            >
              lean-lsp-mcp
            </a>{" "}
            donne à Claude ce que l'éditeur donne à un humain, et parfois
            davantage :
          </p>
          <ul className="mt-3 list-disc space-y-2 pl-5">
            <li>
              <strong>toutes les erreurs d'un fichier d'un coup</strong>, et non
              la première seulement : on corrige quinze points en une passe au
              lieu de quinze allers-retours ;
            </li>
            <li>
              <strong>l'état du but</strong> à n'importe quelle ligne, au milieu
              d'une preuve inachevée — la question « où en suis-je exactement ?
              » a enfin une réponse ;
            </li>
            <li>
              <strong>l'essai de plusieurs tactiques</strong> sans toucher au
              fichier : on propose <code>ring</code>, <code>field_simp</code>,{" "}
              <code>linarith</code>, et l'on voit laquelle ferme le but ;
            </li>
            <li>
              <strong>la recherche dans Mathlib</strong> par motif de type ou en
              langue naturelle, sans quitter la preuve en cours.
            </li>
          </ul>
          <p className="mt-3">
            La différence n'est pas de confort mais de nature. Vérifier un nom
            de lemme prend deux secondes au lieu de cinq minutes, donc on le
            vérifie ; et une preuve dont chaque pas est vérifié au moment où on
            l'écrit se construit, alors qu'une preuve écrite en aveugle se
            devine.
          </p>
          <p className="mt-3">
            À côté de cela, l'outillage est ordinaire : <code>elan</code> et{" "}
            <code>lake</code> pour la chaîne Lean, avec un{" "}
            <code>lake build --wfail</code> qui refuse jusqu'aux simples
            avertissements — une variable inutilisée casse la construction ; une
            bibliothèque Lean par chapitre, pour ne recompiler qu'un chapitre à
            la fois ; et <code>tectonic</code> pour les documents, qui ne
            télécharge que les paquets dont ils se servent. S'y ajoutent les{" "}
            <a
              className="text-brand-700 underline underline-offset-2"
              href="https://github.com/cameronfreer/lean4-skills"
            >
              lean4-skills
            </a>
            , qui outillent la recherche de preuve elle-même : réparation guidée
            par le compilateur, remplissage des <code>sorry</code>,
            raccourcissement d'une preuve qui passe déjà.
          </p>

          <Titre id="boucle">2. La boucle de travail, pas à pas</Titre>
          <p>
            Un chapitre se traite toujours de la même façon, et l'ordre compte.
          </p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            On pose l'énoncé et on admet la preuve
          </h3>
          <p>
            Le théorème s'écrit avec <code>sorry</code>, et l'on vérifie qu'il
            compile. C'est le seul moment où l'on regarde l'énoncé pour
            lui-même, sans se laisser distraire par la démonstration — et c'est
            là qu'on décide des hypothèses.
          </p>
          <Code>{`theorem somme_de_deux_impairs_est_paire {m n : ℕ}
    (hm : Impair m) (hn : Impair n) : Pair (m + n) := by
  sorry`}</Code>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            On descend d'un cran, et on regarde le but
          </h3>
          <p>
            On remplace <code>sorry</code> par la première étape — défaire une
            hypothèse, distinguer des cas, réécrire — puis on demande l'état du
            but à cette ligne. Le reste suit : à chaque pas, ce qu'il reste à
            démontrer est sous les yeux.
          </p>
          <Code>{`  obtain ⟨k, hk⟩ := hm
  obtain ⟨l, hl⟩ := hn
  exact ⟨k + l + 1, by omega⟩`}</Code>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            On laisse l'automatisation finir
          </h3>
          <p>
            Le dépôt s'appuie sur une poignée de tactiques, chacune dans son
            domaine :
          </p>
          <ul className="mt-3 list-disc space-y-1.5 pl-5">
            <li>
              <code>omega</code> pour l'arithmétique linéaire sur ℕ et ℤ,
              divisibilité par des constantes comprise. Elle démontre une
              équivalence d'un seul tenant, ce qui évite d'en séparer les deux
              sens ;
            </li>
            <li>
              <code>linarith</code> et <code>nlinarith</code> pour les
              inégalités, la seconde acceptant des indications quand le produit
              de deux inconnues entre en jeu ;
            </li>
            <li>
              <code>ring</code>, <code>field_simp</code> et{" "}
              <code>linear_combination</code> pour l'algèbre. La dernière vaut
              d'être connue : elle démontre une égalité en la présentant comme
              combinaison des hypothèses, là où il faudrait des pages de
              réécritures ;
            </li>
            <li>
              <code>simp</code> et <code>simpa</code> pour la simplification, à
              manier avec méfiance : ce qu'elles prouvent dépend de l'état de la
              bibliothèque, et une preuve réduite à un <code>simp</code>{" "}
              n'apprend rien à personne ;
            </li>
            <li>
              <code>positivity</code>, <code>decide</code> et{" "}
              <code>norm_num</code> pour la positivité, le calcul fini et le
              calcul numérique.
            </li>
          </ul>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            On transcrit, puis on referme
          </h3>
          <p>
            Le chapitre compilé, on met à jour le statut de chaque énoncé dans
            la liste du programme, on régénère le squelette du document
            français, on transcrit les démonstrations, on compile le PDF. Une
            règle, apprise à ses dépens :{" "}
            <strong>
              ne jamais laisser une preuve reposer sur un nom de lemme qu'on n'a
              pas vérifié
            </strong>
            . Un nom inventé qui ressemble à un vrai passe inaperçu à la lecture
            et coûte une construction entière.
          </p>

          <Titre id="chaine">3. De la preuve au livre : la chaîne</Titre>
          <p>
            Rien de ce qui suit la preuve n'est écrit deux fois. Le document
            français est engendré à partir du fichier Lean — sections, énoncés,
            et surtout les renvois <code>#Lnn</code> qui relient chaque bloc à
            sa déclaration — puis complété à la main de ses démonstrations. Le
            reste en découle : les PDF de chapitre, le livre, les données du
            site.
          </p>
          <Chaine />
          <p>
            Deux conséquences pratiques. Un fichier Lean dont les lignes bougent
            désengage tous ses renvois en aval, et le site n'apparie plus rien :
            c'est arrivé, et une vérification d'intégration le rattrape
            désormais. Et le livre n'imprime que ce que les chapitres
            contiennent — il ne peut pas être en avance sur eux.
          </p>

          <Titre id="enonce">4. Le plus dur reste d'écrire l'énoncé</Titre>
          <p>
            Un énoncé de programme scolaire s'adresse à un lecteur qui comble
            les vides tout seul. « Dans un parallélogramme, les diagonales se
            coupent en leur milieu » suppose le quadrilatère non croisé ; « le
            quotient <code>a/b</code> » suppose <code>b</code> non nul ; « la
            racine de <code>a</code> » suppose <code>a</code> positif. Une
            machine ne comble rien : toute hypothèse tue doit être écrite, faute
            de quoi l'énoncé devient faux.
          </p>
          <p className="mt-3">Trois pièges reviennent sans cesse.</p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            Les définitions déguisées en théorèmes
          </h3>
          <p>
            « L'aire du disque vaut <code>πr²</code> » n'est pas un théorème au
            collège : c'est une formule qu'on donne. En mathématiques, c'est un
            résultat de théorie de la mesure. Il faut donc choisir : poser la
            formule comme définition et ne rien démontrer, ou la démontrer avec
            un appareillage sans rapport avec le niveau. Le dépôt prend la
            seconde voie quand elle est raisonnable, et l'écrit quand elle ne
            l'est pas.
          </p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            Les valeurs de remplissage
          </h3>
          <p>
            Lean veut que toute fonction soit définie partout. Mathlib complète
            donc celles qui ne le sont pas : <code>x/0</code> vaut zéro, la
            soustraction des entiers naturels est tronquée, la racine d'un
            négatif vaut zéro. Ces valeurs rendent vrais des énoncés dans des
            cas où ils n'ont aucun sens mathématique — et il ne faut jamais les
            faire passer pour des résultats. Les énoncés du dépôt gardent donc
            leurs hypothèses même lorsque Lean s'en passerait.
          </p>

          <h3 className="mt-6 mb-2 font-sans text-[15px] font-semibold text-ink-900">
            Les consignes qui ne sont pas des propositions
          </h3>
          <p>
            « Construire la médiatrice à la règle et au compas », « étudier la
            fonction », « dresser le tableau de variation » : ce sont des
            tâches. Ce qui se démontre, c'est la caractérisation de la
            médiatrice, ou le lien entre le signe de la dérivée et le sens de
            variation. Le dépôt formalise la proposition et laisse la consigne
            au tableau.
          </p>

          <Titre id="chercher">5. Chercher avant d'écrire</Titre>
          <p>
            Une bonne moitié du programme de lycée figure déjà dans Mathlib,
            sous un autre nom et dans une généralité plus grande. Se lancer sans
            avoir cherché revient à refaire, moins bien, un travail déjà fait.
            Trois manières de chercher, de la plus précise à la plus
            approximative :
          </p>
          <ul className="mt-3 list-disc space-y-2 pl-5">
            <li>
              <strong>par la forme de l'énoncé</strong> — <em>loogle</em> prend
              un motif de type : <code>|- Real.sqrt _ = _ * _</code> ramène tout
              ce qui conclut sur une racine de produit ;
            </li>
            <li>
              <strong>par le sens</strong> — <em>leansearch</em> accepte une
              phrase entière, utile quand on ignore le vocabulaire de la
              bibliothèque ;
            </li>
            <li>
              <strong>par le but courant</strong> — <code>exact?</code> cherche
              un lemme qui ferme le but où l'on se trouve. Lent, mais souverain
              en fin de preuve.
            </li>
          </ul>
          <p className="mt-3">
            Quand le résultat existe, le travail change de nature : il ne s'agit
            plus de démontrer mais de{" "}
            <strong>
              vérifier que l'énoncé de la bibliothèque dit bien ce que dit le
              programme
            </strong>
            . Ce n'est pas toujours plus simple. L'argument d'un produit en est
            le meilleur exemple : Mathlib l'énonce dans le groupe des angles,
            parce que l'égalité entre réels est fausse — ce que le « [2π] » du
            lycée escamote.
          </p>

          <Titre id="skills">6. Les skills du dépôt</Titre>
          <p>
            Une skill est un mode d'emploi que l'agent charge quand la tâche s'y
            prête. Le dépôt en compte trois : deux encadrent les moments où l'on
            écrit du français, la troisième les figures.
          </p>

          <div className="mt-5 rounded-lg border border-ink-200 p-5">
            <h3 className="font-mono text-[13px] font-semibold text-brand-700">
              transcribe-lean-proof
            </h3>
            <p className="mt-2 text-[15px]">
              Transcrire une preuve Lean en français, dans le document jumeau du
              fichier. Sa règle première :{" "}
              <strong>transcrire, et non réécrire</strong>. La démonstration
              française suit les étapes du script, dans leur ordre, avec leurs
              cas et leurs hypothèses. Si la preuve Lean est laide, la
              transcription l'est aussi.
            </p>
            <ul className="mt-3 list-disc space-y-1.5 pl-5 text-[14.5px] text-ink-600">
              <li>
                Une table de correspondance entre tactiques et français, avec
                une consigne ferme :<em> ne jamais nommer une tactique</em>,
                mais dire ce qu'elle fait. « Cela relève de l'arithmétique
                linéaire », et non « <code>omega</code> conclut ».
              </li>
              <li>
                Un nom de lemme ne vaut pas démonstration :{" "}
                <code>Nat.le_of_dvd</code> se traduit par ce qu'il affirme, pas
                par son identifiant.
              </li>
              <li>
                Les énoncés et les définitions <em>portent leur formule</em> :
                dire qu'une homothétie multiplie les distances sans dire par
                combien ne définit rien.
              </li>
              <li>
                Les calculs restent des calculs : un <code>field_simp</code> se
                transcrit par la suite d'égalités, non par « on simplifie ».
              </li>
              <li>
                Le registre suit le niveau de la classe ; et quand la preuve
                formelle dépasse ce niveau, on le signale en une phrase plutôt
                que de faire semblant.
              </li>
              <li>
                <strong>
                  Les conventions de Lean ne sont pas des mathématiques
                </strong>{" "}
                : une valeur de remplissage se signale comme telle.
              </li>
              <li>
                Ce qui n'est pas démontré est écrit noir sur blanc, avec sa
                raison.
              </li>
            </ul>
          </div>

          <div className="mt-5 rounded-lg border border-ink-200 p-5">
            <h3 className="font-mono text-[13px] font-semibold text-brand-700">
              write-course-book
            </h3>
            <p className="mt-2 text-[15px]">
              Rédiger les textes de liaison du livre : avant-propos, ouverture
              des thèmes, introduction des chapitres. Sa règle première répond à
              l'autre :{" "}
              <strong>
                on ne retouche ni les énoncés ni les démonstrations
              </strong>
              . Les rendre plus élégants romprait le lien avec la preuve
              vérifiée, qui fait tout l'intérêt de l'exercice.
            </p>
            <ul className="mt-3 list-disc space-y-1.5 pl-5 text-[14.5px] text-ink-600">
              <li>
                Ce qu'une ouverture doit faire : dire ce que le chapitre
                établit, ce qu'il emprunte aux précédents, ce qui mérite
                attention, et ce qu'il laisse de côté.
              </li>
              <li>
                Ce qu'elle ne fait jamais : avancer un énoncé nouveau, inventer
                un exemple, promettre un résultat qui ne vient pas, ou juger de
                la difficulté.
              </li>
            </ul>
          </div>

          <div className="mt-5 rounded-lg border border-ink-200 p-5">
            <h3 className="font-mono text-[13px] font-semibold text-brand-700">
              illustrate-theorem
            </h3>
            <p className="mt-2 text-[15px]">
              Dessiner la figure d'un énoncé, en deux versions : TikZ pour le
              livre, où les étiquettes se composent dans les polices du
              document, et SVG pour le site, où la figure suit le thème. Sa
              règle première tient en une phrase :{" "}
              <strong>une figure illustre, elle ne démontre pas</strong>. Un
              lecteur qui la couvre de la main doit pouvoir suivre la
              démonstration sans elle.
            </p>
            <ul className="mt-3 list-disc space-y-1.5 pl-5 text-[14.5px] text-ink-600">
              <li>
                Les coordonnées s'écrivent une fois, en tête du fichier TikZ, et
                se recopient dans le SVG : deux versions qui divergent sont un
                défaut au même titre qu'une preuve fausse.
              </li>
              <li>
                On n'illustre pas tout : un calcul algébrique ou une
                divisibilité n'ont pas de figure, et en dessiner une est du
                bruit.
              </li>
              <li>
                Ni un cas particulier présenté comme le cas général, ni un
                énoncé admis illustré comme s'il était acquis.
              </li>
            </ul>
          </div>

          <Titre id="lecons">7. Ce que la formalisation révèle</Titre>
          <p>
            Le résultat le plus intéressant n'est pas la liste des théorèmes
            démontrés, mais le déplacement de la frontière entre ce qu'on admet
            et ce qu'on établit.
          </p>
          <p className="mt-3">
            Le programme du lycée admet beaucoup : théorème des valeurs
            intermédiaires, existence des primitives, aire sous la courbe,
            espérance d'une loi binomiale, théorème du toit. Un assistant de
            preuve ignore cette convention, et la frontière bouge dans les deux
            sens.{" "}
            <strong>
              L'espérance d'une loi binomiale, admise en première, est démontrée
              ici
            </strong>{" "}
            — Mathlib elle-même ne la contenait pas.{" "}
            <strong>Le théorème du toit, admis lui aussi, ne l'est pas</strong>{" "}
            : sa démonstration repose sur un calcul de dimensions que l'énoncé
            scolaire ne laisse pas soupçonner.
          </p>
          <p className="mt-3">
            L'intégrale offre le renversement le plus net. Au lycée, elle{" "}
            <em>est</em> l'aire sous la courbe, par définition. Ici, l'aire est
            une mesure et l'égalité devient un théorème, qui ouvre le chapitre.
          </p>
          <p className="mt-3">
            Enfin, la formalisation chiffre le prix des évidences. L'unicité de
            la décomposition en facteurs premiers, admise au collège, demande le
            lemme d'Euclide, lequel demande le théorème de Gauss. Une
            démonstration complète n'est pas plus difficile qu'un « on montre de
            même » : elle est seulement écrite.
          </p>
        </div>
      </main>

      <Footer />
    </div>
  );
}
