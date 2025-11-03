(clear)

;; 1. Cargar todas las definiciones
(printout t "Cargando templates..." crlf)
(load "templates.clp")
(printout t "Cargando hechos iniciales..." crlf)
(load "hechos.clp")
(printout t "Cargando reglas de acciones..." crlf)
(load "reglas.clp")

;; 2. Cargar hechos base a la memoria y restablecer contador de pasos
(reset)
(bind ?*paso-actual* 0) ; Reinicia el contador de pasos al inicio de cada ejecución
(printout t "Estado inicial cargado." crlf crlf)

;; 3. Correr el motor de reglas
(printout t "--- Buscando plan de acciones para el mono ---" crlf crlf)
(run)
(printout t crlf "--- Fin de la búsqueda del plan ---" crlf)