/**
 * Ce que produit `scripts/manifest.mjs`, et rien d'autre.
 *
 * Ces types décrivent des fichiers engendrés : les élargir « au cas où » les
 * ferait mentir. S'il manque un champ, c'est le script qui doit le produire.
 */

/** Une déclaration Lean documentée, appariée à sa transcription française. */
export type Declaration = {
  /** `theorem`, `lemma`, `def`… */
  sorte: string;
  nom: string;
  /** La docstring Lean, telle quelle. */
  doc: string;
  /** Le titre de la section `/-! ## … -/` qui la précède, s'il y en a une. */
  section: string | null;
  /** La ligne où s'ouvre la docstring : le vrai haut du bloc à l'écran. */
  ligneDoc: number;
  /** Première et dernière ligne de la déclaration elle-même, à partir de 1. */
  ligne: number;
  finLigne: number;
  code: string;
  /** L'énoncé rédigé en français, déjà rendu en HTML. */
  enonceHtml: string;
  /** Sa démonstration, vide pour une définition. */
  preuveHtml: string;
  /** Les remarques du fichier Lean qui précèdent l'énoncé dans le document. */
  remarqueHtml: string;
  /** Vrai si la preuve est un `sorry` : l'énoncé est écrit, pas démontré. */
  admis?: boolean;
  /**
   * La figure de l'énoncé, en SVG, telle qu'elle est écrite dans le dépôt.
   * Elle porte le nom de la déclaration : voir la skill `illustrate-theorem`.
   */
  figure?: string;
  /**
   * Les résultats que la démonstration emprunte, avec l'adresse de leur source.
   * Une preuve d'une ligne ne montre rien ; le lien mène à celle qui montre.
   */
  appuis?: { nom: string; url: string; paquet: string }[];
};

export type Module = {
  nom: string;
  source: string;
  declarations: Declaration[];
};

export type Statuts = { total: number; demontres: number; encours: number };

/** Une ligne de l'index d'un chapitre : l'énoncé tel que le programme le pose. */
export type Enonce = { enonce: string; niveau: string; statut: string };

export type Chapitre = {
  id: string;
  dossier: string;
  programme: string;
  /** `collège` ou `lycée` : la classe dont relève le chapitre. */
  niveau: string;
  titre: string;
  statuts: Statuts;
  modules: Module[];
  /**
   * La liste des énoncés à démontrer, portée par les seuls chapitres qui n'ont
   * pas encore de fichier Lean : c'est tout ce qu'il y a à montrer d'eux.
   */
  enonces?: Enonce[];
};

/**
 * L'index est rangé par thème, pas par cycle.
 *
 * Un lecteur ne suit pas un cycle mais une notion : la divisibilité de sixième
 * et l'arithmétique de terminale sont le même sujet. Le niveau reste porté par
 * chaque chapitre, pour qu'on sache toujours de quelle classe il relève.
 */
export type Index = {
  themes: {
    id: string;
    titre: string;
    sousTitre: string;
    chapitres: {
      id: string;
      titre: string;
      niveau: string;
      statuts: Statuts;
      modules: { nom: string; declarations: number }[];
    }[];
  }[];
};

/**
 * Une question d'un sujet d'examen, telle que l'index de la session la découpe.
 *
 * Un sujet se découpe en *problèmes* — « Exercice 1 », « Première partie » — et
 * chaque problème en *questions*. C'est le vocabulaire des sujets eux-mêmes.
 *
 * `theoremes` est vide quand la question n'est pas une proposition mathématique
 * — une lecture graphique, une interprétation. C'est le renseignement que la
 * page cherche à rendre visible, autant que les énoncés démontrés.
 */
export type Question = {
  id: string;
  /** L'ordre dans le sujet, pour trier comme on lit. */
  rang: number;
  annee: number;
  epreuve: string;
  session: string;
  sujet: string | null;
  /** Le fichier Lean de la session, relatif à la racine du dépôt. */
  source: string | null;
  /** Le problème dont cette question relève. */
  probleme: string;
  points: number | null;
  numero: string;
  intitule: string;
  notions: string[];
  theme: string;
  theoremes: string[];
  /** La ligne de chaque théorème dans le fichier source, quand on la connaît. */
  lignes: (number | null)[];
  statut: string;
};
