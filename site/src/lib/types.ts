/**
 * Ce que produit `scripts/manifest.mjs`, et rien d'autre.
 *
 * Ces types décrivent des fichiers engendrés : les élargir « au cas où » les
 * ferait mentir. S'il manque un champ, c'est le script qui doit le produire.
 */

/** Une déclaration Lean documentée, appariée à sa transcription française. */
export type Declaration = {
  /** `theorem`, `lemma`, `def`… */
  sorte: string
  nom: string
  /** La docstring Lean, telle quelle. */
  doc: string
  /** Le titre de la section `/-! ## … -/` qui la précède, s'il y en a une. */
  section: string | null
  /** Première et dernière ligne dans le fichier `.lean`, à partir de 1. */
  ligne: number
  finLigne: number
  code: string
  /** L'énoncé rédigé en français, déjà rendu en HTML. */
  enonceHtml: string
  /** Sa démonstration, vide pour une définition. */
  preuveHtml: string
  /** Les remarques du fichier Lean qui précèdent l'énoncé dans le document. */
  remarqueHtml: string
}

export type Module = {
  nom: string
  source: string
  declarations: Declaration[]
}

export type Statuts = { total: number; demontres: number; encours: number }

export type Chapitre = {
  id: string
  dossier: string
  programme: string
  titre: string
  statuts: Statuts
  modules: Module[]
}

export type Index = {
  programmes: {
    id: string
    titre: string
    source: string
    chapitres: {
      id: string
      titre: string
      statuts: Statuts
      modules: { nom: string; declarations: number }[]
    }[]
  }[]
}
