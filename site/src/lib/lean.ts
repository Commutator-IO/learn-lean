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

export type Jeton = { texte: string; classe: string }

/** Découpe une ligne de Lean en jetons colorés. */
export function jetons(ligne: string): Jeton[] {
  const out: Jeton[] = []
  let i = 0
  const pousser = (texte: string, classe: string) => {
    if (!texte) return
    const dernier = out[out.length - 1]
    if (dernier && dernier.classe === classe) dernier.texte += texte
    else out.push({ texte, classe })
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
      pousser(m, MOTS.has(m) ? 'motcle' : TACTIQUES.has(nu) ? 'tactique' : 'texte')
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
export function colorier(source: string): Jeton[][] {
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
      out.push([{ texte: debut, classe: 'commentaire' }, ...jetons(ligne.slice(fin + 2))])
      continue
    }

    const ouvre = ligne.lastIndexOf('/-')
    if (ouvre !== -1 && !ligne.slice(ouvre).includes('-/')) {
      dansCommentaire = true
      out.push([...jetons(ligne.slice(0, ouvre)), { texte: ligne.slice(ouvre), classe: 'commentaire' }])
      continue
    }
    out.push(jetons(ligne))
  }
  return out
}
