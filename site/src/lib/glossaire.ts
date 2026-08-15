/**
 * Ce que fait chaque mot du langage, en une phrase.
 *
 * Le volet de gauche s'adresse à quelqu'un qui apprend Lean : `rfl`, `simpa`,
 * `linarith` n'y disent rien tant qu'on ne les a pas rencontrés ailleurs. Cette
 * table donne, au survol, ce que le mot fait — en français, parce que toute la
 * documentation existante est en anglais et que c'est précisément la marche à
 * franchir.
 *
 * Les explications sont volontairement courtes et un peu simplifiées : elles
 * doivent tenir dans une infobulle et suffire à comprendre la ligne qu'on est
 * en train de lire. Le lien mène au texte exact, qui, lui, ne simplifie rien.
 *
 * Les liens ont été vérifiés un à un : pour les tactiques, l'ancre existe bien
 * dans la page visée. Ceux de la référence du langage pointent, pour les mots
 * du langage eux-mêmes, sur le chapitre qui les traite et non sur un
 * paragraphe : le manuel ne leur donne pas d'ancre propre.
 */

const TAC =
  "https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference/#";
const REF = "https://lean-lang.org/doc/reference/latest/";
const ML =
  "https://leanprover-community.github.io/mathlib4_docs/Mathlib/Tactic/";

export type Aide = {
  /** Ce que le mot fait, en une phrase. */
  quoi: string;
  /** Où lire le texte de référence. */
  doc?: string;
};

export const GLOSSAIRE: Record<string, Aide> = {
  // ---- Mots du langage -----------------------------------------------------
  theorem: {
    quoi: "Énonce un théorème et ouvre sa démonstration : à gauche du `:` le nom, à droite l'énoncé.",
    doc: `${REF}Definitions/`,
  },
  lemma: {
    quoi: "Comme `theorem`. Le mot vient de Mathlib et sert aux résultats intermédiaires.",
    doc: `${REF}Definitions/`,
  },
  def: {
    quoi: "Définit un objet — une fonction, un nombre, une structure — par sa valeur.",
    doc: `${REF}Definitions/`,
  },
  abbrev: {
    quoi: "Une définition que Lean déplie automatiquement : un simple raccourci de notation.",
    doc: `${REF}Definitions/`,
  },
  instance: {
    quoi: "Déclare qu'un type possède une structure (groupe, ordre, mesure) ; Lean la retrouvera seul.",
    doc: `${REF}Type-Classes/`,
  },
  example: {
    quoi: "Un théorème sans nom : Lean le vérifie, mais rien ne pourra s'y référer ensuite.",
    doc: `${REF}Definitions/`,
  },
  structure: {
    quoi: "Définit un objet fait de plusieurs champs, comme un couple nommé.",
    doc: `${REF}Type-Classes/`,
  },
  class: {
    quoi: "Définit une structure que Lean saura retrouver tout seul à partir du type.",
    doc: `${REF}Type-Classes/`,
  },
  namespace: {
    quoi: "Ouvre un espace de noms : tout ce qui suit reçoit ce préfixe.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  section: {
    quoi: "Délimite une portion de fichier, le temps d'y poser des variables communes.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  end: {
    quoi: "Ferme la section ou l’espace de noms ouvert plus haut.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  variable: {
    quoi: "Pose une variable partagée : les énoncés qui l'emploient la reçoivent en argument.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  omit: {
    quoi: "Retire d'un énoncé une hypothèse posée par `variable` dont il n'a pas besoin.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  open: {
    quoi: "Permet d’écrire les noms d’un espace sans son préfixe.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  import: {
    quoi: "Charge un autre fichier ; ici, ceux de Mathlib. Se met en tête, avant tout le reste.",
    doc: `${REF}Source-Files-and-Modules/`,
  },
  noncomputable: {
    quoi: "Signale une définition dont Lean ne sait pas calculer les valeurs — courant en analyse.",
    doc: `${REF}Definitions/`,
  },
  private: {
    quoi: "Réserve la déclaration au fichier courant.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  protected: {
    quoi: "Oblige à écrire le nom complet, même après un `open`.",
    doc: `${REF}Namespaces-and-Sections/`,
  },
  partial: {
    quoi: "Autorise une fonction dont Lean ne sait pas prouver qu'elle termine ; on ne démontre alors rien sur elle.",
    doc: `${REF}Definitions/`,
  },
  unsafe: {
    quoi: "Lève les garde-fous du noyau. N'apparaît pas dans ce dépôt.",
    doc: `${REF}Definitions/`,
  },
  attribute: {
    quoi: "Attache une étiquette à une déclaration — par exemple `@[simp]`, pour que `simp` s'en serve.",
    doc: `${REF}Attributes/`,
  },
  deriving: {
    quoi: "Demande à Lean d’engendrer seul les fonctions usuelles (égalité décidable, affichage).",
    doc: `${REF}Type-Classes/`,
  },
  where: {
    quoi: "Introduit les champs d’une structure, ou les cas d’une définition par récurrence.",
    doc: `${REF}Definitions/`,
  },
  fun: {
    quoi: "Une fonction anonyme : `fun x => x + 1` est « la fonction qui à x associe x + 1 ».",
    doc: `${REF}Terms/`,
  },
  let: {
    quoi: "Nomme une valeur intermédiaire pour la suite du terme.",
    doc: `${REF}Terms/`,
  },
  have: {
    quoi: "Démontre un résultat intermédiaire et le nomme : c'est le « posons » des démonstrations écrites.",
    doc: `${REF}Terms/`,
  },
  show: {
    quoi: "Réécrit le but sous une forme équivalente, pour dire ce qu'on démontre.",
    doc: `${TAC}show`,
  },
  from: {
    quoi: "Donne directement le terme qui démontre le but annoncé par `show`.",
    doc: `${REF}Terms/`,
  },
  match: {
    quoi: "Distingue les cas selon la forme de la valeur : zéro ou successeur, liste vide ou non.",
    doc: `${REF}Terms/`,
  },
  with: {
    quoi: "Introduit les cas d’un `match`, ou les noms que produit une tactique.",
    doc: `${REF}Terms/`,
  },
  do: {
    quoi: "Enchaîne des instructions dans une monade — de la programmation, pas de la démonstration.",
    doc: `${REF}Functors___-Monads-and--do--Notation/`,
  },
  if: { quoi: "Choix selon une condition décidable.", doc: `${REF}Terms/` },
  // Cette table est indexée par les mots de Lean, et l'un d'eux s'appelle
  // `then` : elle n'en devient pas une promesse pour autant.
  // oxlint-disable-next-line unicorn/no-thenable
  then: { quoi: "La branche vraie du `if`.", doc: `${REF}Terms/` },
  else: { quoi: "La branche fausse du `if`.", doc: `${REF}Terms/` },
  by: {
    quoi: "Ouvre le mode tactique : ce qui suit n'est plus un terme, mais une suite d'ordres qui construisent la preuve.",
    doc: `${REF}Tactic-Proofs/`,
  },
  calc: {
    quoi: "Une chaîne d'égalités ou d'inégalités, écrite comme au tableau, chaque pas étant justifié.",
    doc: `${TAC}calc`,
  },
  this: {
    quoi: "Le nom que porte le dernier résultat introduit sans nom.",
    doc: `${REF}Terms/`,
  },
  in: { quoi: "Sépare un `let` de la suite du terme.", doc: `${REF}Terms/` },

  // ---- Tactiques -----------------------------------------------------------
  intro: {
    quoi: "Fait entrer une hypothèse ou une variable dans le contexte : « soit x » et « supposons ».",
    doc: `${TAC}intro`,
  },
  intros: {
    quoi: "Comme `intro`, pour plusieurs d’un coup.",
    doc: `${TAC}intros`,
  },
  exact: {
    quoi: "Fournit le terme qui démontre exactement le but.",
    doc: `${TAC}exact`,
  },
  apply: {
    quoi: "Applique un théorème au but, en laissant ses hypothèses à démontrer.",
    doc: `${TAC}apply`,
  },
  refine: {
    quoi: "Comme `exact`, mais avec des trous `?_` qui deviennent autant de buts.",
    doc: `${TAC}refine`,
  },
  rintro: {
    quoi: "Un `intro` qui découpe au passage ce qu’il introduit.",
    doc: `${TAC}rintro`,
  },
  rcases: {
    quoi: "Découpe une hypothèse en ses cas ou ses morceaux (un « et », un « ou », un « il existe »).",
    doc: `${TAC}rcases`,
  },
  obtain: {
    quoi: "Nomme les morceaux d’une hypothèse en la découpant.",
    doc: `${TAC}obtain`,
  },
  cases: {
    quoi: "Sépare la démonstration selon les cas possibles.",
    doc: `${TAC}cases`,
  },
  induction: {
    quoi: "Raisonnement par récurrence : le cas de base, puis l’hérédité.",
    doc: `${TAC}induction`,
  },
  simp: {
    quoi: "Simplifie le but avec les milliers de lemmes marqués `@[simp]` dans Mathlib.",
    doc: `${TAC}simp`,
  },
  simpa: {
    quoi: "Simplifie le but *et* le terme fourni, puis vérifie qu’ils coïncident.",
    doc: `${TAC}simpa`,
  },
  rw: {
    quoi: "Réécrit le but en remplaçant un membre d'une égalité par l'autre.",
    doc: `${TAC}rw`,
  },
  rwa: {
    quoi: "Réécrit, puis conclut avec une hypothèse du contexte.",
    doc: `${TAC}rwa`,
  },
  ring: {
    quoi: "Démontre toute identité vraie dans un anneau commutatif : développer, réduire, comparer.",
    doc: `${ML}Ring/RingNF.html#Mathlib.Tactic.RingNF.ring`,
  },
  ring_nf: {
    quoi: "Met les expressions polynomiales sous forme normale, sans forcément conclure.",
    doc: `${ML}Ring/RingNF.html#Mathlib.Tactic.RingNF.ringNF`,
  },
  linarith: {
    quoi: "Conclut une inégalité qui découle linéairement des hypothèses.",
    doc: `${ML}Linarith/Frontend.html#Mathlib.Tactic.linarith`,
  },
  nlinarith: {
    quoi: "Comme `linarith`, en ajoutant quelques produits — de quoi traiter les carrés.",
    doc: `${ML}Linarith/Frontend.html#Mathlib.Tactic.nlinarith`,
  },
  omega: {
    quoi: "Décide les énoncés d'arithmétique linéaire sur les entiers, divisions euclidiennes comprises.",
    doc: `${TAC}omega`,
  },
  decide: {
    quoi: "Fait calculer la réponse à Lean, quand l'énoncé porte sur un nombre fini de cas.",
    doc: `${TAC}decide`,
  },
  norm_num: {
    quoi: "Calcule sur les nombres : additions, comparaisons, primalité de petits entiers.",
    doc: `${ML}NormNum/Core.html#Mathlib.Tactic.normNum`,
  },
  field_simp: {
    quoi: "Chasse les dénominateurs, sachant qu'ils sont non nuls.",
    doc: `${ML}FieldSimp.html#Mathlib.Tactic.FieldSimp.fieldSimp`,
  },
  positivity: {
    quoi: "Démontre qu'une expression est positive, ou non nulle, en la parcourant.",
    doc: `${ML}Positivity/Core.html#Mathlib.Tactic.Positivity.positivity`,
  },
  constructor: {
    quoi: "Coupe un but en ses parties : démontrer « A et B », c'est démontrer A puis B.",
    doc: `${TAC}constructor`,
  },
  use: {
    quoi: "Fournit le témoin d'un « il existe » : reste à vérifier qu'il convient.",
    doc: `${ML}Use.html#Mathlib.Tactic.useSyntax`,
  },
  push_cast: {
    quoi: "Fait descendre les conversions de type (`ℕ → ℝ`) vers les feuilles de l’expression.",
    doc: `${TAC}push_cast`,
  },
  push_neg: {
    quoi: "Fait entrer les négations : « non pour tout » devient « il existe … non ».",
    doc: `${ML}Push.html#Mathlib.Tactic.Push.push_neg`,
  },
  linear_combination: {
    quoi: "Démontre une égalité comme combinaison linéaire d'égalités déjà connues.",
    doc: `${ML}LinearCombination.html#Mathlib.Tactic.LinearCombination.linearCombination`,
  },
  unfold: { quoi: "Remplace un nom par sa définition.", doc: `${TAC}unfold` },
  change: {
    quoi: "Remplace le but par un but qui lui est identique par définition.",
    doc: `${TAC}change`,
  },
  convert: {
    quoi: "Rapproche le but d'un résultat connu, et laisse les différences à démontrer.",
    doc: `${ML}Convert.html#Mathlib.Tactic.convert`,
  },
  congr: {
    quoi: "Ramène l'égalité de deux expressions de même forme à celle de leurs morceaux.",
    doc: `${TAC}congr`,
  },
  ext: {
    quoi: "Deux objets sont égaux s'ils le sont point par point : c'est l'extensionnalité.",
    doc: `${TAC}ext`,
  },
  funext: {
    quoi: "Deux fonctions égales en tout point sont égales. La tactique porte le nom du théorème qu'elle applique.",
    doc: "https://leanprover-community.github.io/mathlib4_docs/Init/Core.html#funext",
  },
  abel: {
    quoi: "Comme `ring`, dans un groupe commutatif : additions et opposés seulement.",
    doc: `${ML}Abel.html#Mathlib.Tactic.Abel.abel`,
  },
  module: {
    quoi: "Comme `ring`, dans un module : combinaisons linéaires de vecteurs.",
    doc: `${ML}Module.html#Mathlib.Tactic.Module.tacticModule`,
  },
  gcongr: {
    quoi: "Compare deux expressions de même forme en comparant leurs morceaux.",
    doc: `${ML}GCongr/Core.html#Mathlib.Tactic.GCongr.gcongr`,
  },
  interval_cases: {
    quoi: "Épuise les valeurs d'un entier borné, un cas par valeur.",
    doc: `${ML}IntervalCases.html#Mathlib.Tactic.intervalCases`,
  },
  fin_cases: {
    quoi: "Épuise les éléments d’un type fini, un cas par élément.",
    doc: `${ML}FinCases.html#Lean.Elab.Tactic.finCases`,
  },
  trivial: {
    quoi: "Ferme un but qui ne demande aucun travail.",
    doc: `${TAC}trivial`,
  },
  rfl: {
    quoi: "Les deux membres sont le même objet une fois les calculs faits : l'égalité est vraie par définition.",
    doc: `${TAC}rfl`,
  },
  sorry: {
    quoi: "Admet le but sans le démontrer. Aucune preuve de ce dépôt n'en contient.",
    doc: `${TAC}sorry`,
  },
  nth_rewrite: {
    quoi: "Réécrit une occurrence précise, quand `rw` en changerait plusieurs.",
    doc: `${ML}NthRewrite.html#Mathlib.Tactic.tacticNth_rewrite_____`,
  },
  by_contra: {
    quoi: "Raisonnement par l'absurde : on suppose le contraire et on cherche une contradiction.",
    doc: `${ML}ByContra.html#Mathlib.Tactic.ByContra.byContra!`,
  },
  by_cases: {
    quoi: "Sépare selon qu’une proposition est vraie ou fausse.",
    doc: `${TAC}by_cases`,
  },
  subst: {
    quoi: "Élimine une variable en la remplaçant partout par sa valeur.",
    doc: `${TAC}subst`,
  },
  specialize: {
    quoi: "Applique une hypothèse universelle à une valeur particulière.",
    doc: `${TAC}specialize`,
  },
};
