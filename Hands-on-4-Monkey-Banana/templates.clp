;; --- Plantillas para el Problema del Mono y la Banana ---

(deftemplate estado
  (slot mono-en (type SYMBOL))   ; Posición del mono (ej: ventana, centro, caja)
  (slot caja-en (type SYMBOL))   ; Posición de la caja (ej: ventana, centro, debajo-banana)
  (slot tiene-caja (type SYMBOL) (allowed-symbols si no)) ; El mono está sobre la caja o no
  (slot tiene-bananas (type SYMBOL) (allowed-symbols si no)) ; El mono tiene las bananas o no
  (slot alcance-bananas (type SYMBOL) (allowed-symbols si no)) ; El mono puede alcanzar las bananas (está en la caja debajo)
)

(deftemplate objetivo
  (slot logrado (type SYMBOL) (allowed-symbols si no)) ; El objetivo final ha sido alcanzado
)

(deftemplate plan-accion
  (slot paso (type INTEGER))
  (slot accion (type STRING))
)