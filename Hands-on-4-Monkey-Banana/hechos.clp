;; --- Hechos iniciales para el Problema del Mono y la Banana ---

(deffacts estado-inicial
  (estado (mono-en ventana)
          (caja-en centro)
          (tiene-caja no)
          (tiene-bananas no)
          (alcance-bananas no))
  (objetivo (logrado no))
)