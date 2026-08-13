import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import { TravauxPage } from './TravauxPage.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <TravauxPage />
  </StrictMode>,
)
