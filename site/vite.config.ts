import { defineConfig } from 'vite'
import { resolve } from 'node:path'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  // GitHub Pages sert un site de projet sous /<dépôt>/ ; ici le site est publié
  // sur le domaine lean.commutator.io, donc à la racine. Le workflow peut
  // toujours remplir BASE_PATH si l'on revient à une adresse de projet.
  base: process.env.BASE_PATH ?? '/',
  build: {
    rollupOptions: {
      // Une entrée HTML par onglet. L'hébergement est statique : /cours/ est
      // servi par son propre index.html, sans routeur côté client ni
      // redirection. Une adresse partagée aujourd'hui fonctionne encore dans
      // six mois — ce qui compte pour un lien vers un théorème précis.
      input: {
        main: resolve(import.meta.dirname, 'index.html'),
        cours: resolve(import.meta.dirname, 'cours/index.html'),
        livre: resolve(import.meta.dirname, 'livre/index.html'),
        methode: resolve(import.meta.dirname, 'methode/index.html'),
        travaux: resolve(import.meta.dirname, 'travaux/index.html'),
      },
    },
  },
  server: {
    port: process.env.PORT ? Number(process.env.PORT) : 5173,
  },
})
