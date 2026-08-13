import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import { ReaderPage } from './ReaderPage.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <ReaderPage />
  </StrictMode>,
)
