/**
 * La figure d'un énoncé.
 *
 * Le SVG vient du dépôt — il est écrit à la main dans `figures/<théorème>.svg`,
 * jamais reçu de l'extérieur — et il est inséré tel quel : c'est ainsi qu'il
 * suit la couleur du texte, donc le thème, ce qu'une image ne ferait pas.
 *
 * Le SVG ne porte qu'un `viewBox`, sans dimension : c'est la feuille de style
 * qui lui donne sa largeur, et la hauteur suit. Sans cela il se replierait à
 * zéro dans un conteneur flexible.
 *
 * Le livre en PDF a sa propre version, en TikZ, dessinée sur les mêmes
 * coordonnées.
 */
export function Figure({ svg }: { svg: string }) {
  return (
    <figure
      className="my-5 flex justify-center text-ink-700 [&_svg]:h-auto [&_svg]:w-full [&_svg]:max-w-[22rem]"
      dangerouslySetInnerHTML={{ __html: svg }}
    />
  );
}
