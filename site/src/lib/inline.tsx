import type { ReactNode } from "react";

/**
 * Rend le code en ligne d'un texte écrit en markdown.
 *
 * Les titres de section viennent des en-têtes `/-! ## … -/` des fichiers Lean,
 * les énoncés des index de chapitre : ce sont des textes markdown, où le code
 * est entre accents graves. Affichés tels quels, ces accents se voient — et se
 * lisent comme une coquille. Le reste du markdown n'est pas traité : ces textes
 * n'en contiennent pas.
 */
export function avecCode(
  texte: string,
  classe = "font-mono text-[0.9em]",
): ReactNode[] {
  return texte.split("`").map((part, i) =>
    i % 2 ? (
      <code key={i} className={classe}>
        {part}
      </code>
    ) : (
      <span key={i}>{part}</span>
    ),
  );
}
