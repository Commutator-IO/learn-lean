import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import "./index.css";
import { MethodePage } from "./MethodePage.tsx";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <MethodePage />
  </StrictMode>,
);
