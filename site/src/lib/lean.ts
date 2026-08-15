/**
 * Coloration syntaxique de Lean 4, réduite à ce qui aide à lire.
 *
 * Une coloration complète demanderait l'analyseur de Lean lui-même : la syntaxe
 * est extensible, les tactiques sont des macros, et rien ne distingue
 * lexicalement un identifiant d'un mot-clé introduit par une bibliothèque. Ce
 * qui suit ne prétend donc pas être exact — il sépare les commentaires, les
 * mots-clés du langage et les tactiques les plus fréquentes, ce qui suffit à
 * suivre une démonstration de l'œil.
 */

const MOTS = new Set([
  'theorem', 'lemma', 'def', 'abbrev', 'instance', 'example', 'structure', 'class',
  'namespace', 'end', 'section', 'variable', 'open', 'import', 'noncomputable',
  'private', 'protected', 'partial', 'unsafe', 'attribute', 'deriving', 'where',
  'fun', 'let', 'have', 'show', 'from', 'match', 'with', 'do', 'if', 'then', 'else',
  'by', 'calc', 'this', 'omit', 'in',
])

const TACTIQUES = new Set([
  'intro', 'intros', 'exact', 'apply', 'refine', 'rintro', 'rcases', 'obtain', 'cases',
  'induction', 'simp', 'simpa', 'rw', 'rwa', 'ring', 'ring_nf', 'linarith', 'nlinarith',
  'omega', 'decide', 'norm_num', 'field_simp', 'positivity', 'constructor', 'use',
  'push_cast', 'push_neg', 'linear_combination', 'unfold', 'change', 'convert', 'congr',
  'ext', 'funext', 'abel', 'module', 'gcongr', 'interval_cases', 'fin_cases', 'trivial',
  'rfl', 'sorry', 'nth_rewrite', 'by_contra', 'by_cases', 'subst', 'specialize',
])

export type Jeton = {
  texte: string
  classe: string
  /** Adresse de la déclaration nommée par ce jeton, quand on sait la trouver. */
  lien?: string
  /** Vrai si le lien reste dans le site : une déclaration de ce chapitre. */
  interne?: boolean
}

/** Une déclaration du chapitre courant : où la trouver dans le site. */
export type Declare = { module: string; ligne: number }

const MATHLIB = 'https://leanprover-community.github.io/mathlib4_docs/find/?pattern='

/**
 * Où mène un identifiant.
 *
 * Deux cas, et une part d'à-peu-près assumée. Un nom déclaré dans le chapitre
 * mène à sa propre page — c'est exact, le manifeste le sait. Un nom de la
 * bibliothèque mène à la recherche de la documentation de Mathlib, qui résout
 * elle-même le nom vers sa page : on n'a donc pas à connaître le module où il
 * vit, ce qui serait invérifiable ici.
 *
 * Reste à décider qui est un nom de bibliothèque. Sans le serveur de langage —
 * qui demanderait de compiler Mathlib à chaque construction du site — on s'en
 * tient à deux formes que les fichiers du dépôt n'emploient pas pour leurs
 * variables locales : un nom qualifié (`Nat.dvd_add`) et un nom en
 * `serpent_case` d'au moins deux mots (`mul_eq_zero`). Un lien qui tombe à côté
 * arrive sur une page « non trouvé » de la documentation, ce qui se voit ; c'est
 * le prix, jugé acceptable, de rendre le code cliquable.
 */
function lien(mot: string, declares: Map<string, Declare>): Pick<Jeton, 'lien' | 'interne'> {
  const local = declares.get(mot)
  if (local) return { lien: `${local.module}/L${local.ligne}`, interne: true }

  const qualifie = /^[A-Z][A-Za-z0-9]*(\.[A-Za-z_][A-Za-z0-9_']*)+$/.test(mot)
  const serpent = /^[a-z][a-z0-9]*(_[a-z0-9']+){1,}$/.test(mot)
  if (qualifie || serpent) return { lien: `${MATHLIB}${encodeURIComponent(mot)}#doc` }
  return {}
}

/** Découpe une ligne de Lean en jetons colorés. */
export function jetons(ligne: string, declares: Map<string, Declare> = new Map()): Jeton[] {
  const out: Jeton[] = []
  let i = 0
  const pousser = (texte: string, classe: string, extra?: Pick<Jeton, 'lien' | 'interne'>) => {
    if (!texte) return
    const dernier = out[out.length - 1]
    // Deux jetons ne se recollent que s'ils sont de même nature *et* sans lien :
    // un identifiant cliquable doit rester un élément à lui seul.
    if (dernier && dernier.classe === classe && !dernier.lien && !extra?.lien) {
      dernier.texte += texte
    } else {
      out.push({ texte, classe, ...extra })
    }
  }

  while (i < ligne.length) {
    const reste = ligne.slice(i)

    // Commentaires : `--` jusqu'au bout, `/-` … `-/` sur la ligne.
    if (reste.startsWith('--')) {
      pousser(reste, 'commentaire')
      break
    }
    if (reste.startsWith('/-')) {
      const fin = reste.indexOf('-/')
      const bloc = fin === -1 ? reste : reste.slice(0, fin + 2)
      pousser(bloc, 'commentaire')
      i += bloc.length
      continue
    }
    if (reste.startsWith('-/')) {
      pousser('-/', 'commentaire')
      i += 2
      continue
    }

    // Chaînes de caractères.
    const chaine = /^"(?:[^"\\]|\\.)*"/.exec(reste)
    if (chaine) {
      pousser(chaine[0], 'chaine')
      i += chaine[0].length
      continue
    }

    // Identifiants, avec les caractères que Lean autorise.
    const mot = /^[A-Za-z_ℕℤℚℝℂ][A-Za-z0-9_'!?ₙₐₖ.ℕℤℚℝℂ]*/.exec(reste)
    if (mot) {
      const m = mot[0]
      const nu = m.split('.').pop() ?? m
      if (MOTS.has(m)) pousser(m, 'motcle')
      else if (TACTIQUES.has(nu)) pousser(m, 'tactique')
      else pousser(m, 'texte', lien(m, declares))
      i += m.length
      continue
    }

    const nombre = /^\d+/.exec(reste)
    if (nombre) {
      pousser(nombre[0], 'nombre')
      i += nombre[0].length
      continue
    }

    pousser(ligne[i], 'texte')
    i++
  }
  return out
}

/**
 * Les commentaires de bloc traversent les lignes ; on colorie donc le fichier
 * d'un seul tenant, en gardant l'état d'un `/- … -/` ouvert d'une ligne à
 * l'autre.
 */
export function colorier(source: string, declares: Map<string, Declare> = new Map()): Jeton[][] {
  const lignes = source.split('\n')
  const out: Jeton[][] = []
  let dansCommentaire = false

  for (const ligne of lignes) {
    if (dansCommentaire) {
      const fin = ligne.indexOf('-/')
      if (fin === -1) {
        out.push([{ texte: ligne, classe: 'commentaire' }])
        continue
      }
      dansCommentaire = false
      const debut = ligne.slice(0, fin + 2)
      out.push([
          { texte: debut, classe: 'commentaire' },
          ...jetons(ligne.slice(fin + 2), declares),
        ])
      continue
    }

    const ouvre = ligne.lastIndexOf('/-')
    if (ouvre !== -1 && !ligne.slice(ouvre).includes('-/')) {
      dansCommentaire = true
      out.push([
        ...jetons(ligne.slice(0, ouvre), declares),
        { texte: ligne.slice(ouvre), classe: 'commentaire' },
      ])
      continue
    }
    out.push(jetons(ligne, declares))
  }
  return out
}
