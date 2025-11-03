(clear)

;; 1. Cargar todas las definiciones
(printout t "Cargando templates..." crlf)
(load "templates.clp")
(printout t "Cargando base de conocimiento (hechos)..." crlf)
(load "hechos.clp")
(printout t "Cargando reglas de negocio..." crlf)
(load "reglas.clp")

;; 2. Cargar hechos base a la memoria
(reset)
(printout t "Hechos base cargados." crlf crlf)

;; 3. Simular el escenario
(printout t "--- Simulando escenario de prueba ---" crlf)

;;    Simulación 1: Sofía (101) compra un Pixel 9 (p# 1) con BancoNorte (t# 201)
(printout t "Simulando compra de Sofía..." crlf)
(assert (orden (orden-id 1001) (customer-id 101) (part-number 1) (tarjeta-id 201) (qty 1) (pago credito)))

;;    Simulación 2: David (102) compra un Galaxy S25 (p# 2) con TiendaSur (t# 202)
(printout t "Simulando compra de David (Samsung)..." crlf)
(assert (orden (orden-id 1002) (customer-id 102) (part-number 2) (tarjeta-id 202) (qty 1) (pago credito)))

;;    Simulación 3: Miguel (103) compra una Dell XPS (p# 4) con BancoEste (t# 203)
(printout t "Simulando compra de Miguel (Dell)..." crlf)
(assert (orden (orden-id 1003) (customer-id 103) (part-number 4) (tarjeta-id 203) (qty 1) (pago credito)))

;;    Simulación 4: David (102, mayorista) compra 20 Audifonos (p# 5)
;;    (Esto probará la regla de descuento por volumen para mayoristas)
(printout t "Simulando compra de David (Volumen)..." crlf)
(assert (orden (orden-id 1004) (customer-id 102) (part-number 5) (tarjeta-id 202) (qty 20) (pago contado)))

;;    Simulación 5: Sofía (101) vuelve a comprar, esta vez el combo de accesorios (p# 5 y p# 6)
;;    (Esto probará la regla de descuento por combo)
(printout t "Simulando compra de Sofía (Combo)..." crlf)
(assert (orden (orden-id 1005) (customer-id 101) (part-number 5) (tarjeta-id 201) (qty 1) (pago contado)))
(assert (orden (orden-id 1006) (customer-id 101) (part-number 6) (tarjeta-id 201) (qty 1) (pago contado)))

;;    Simulación 6: Sofía (101) compra solo el Cargador GaN (p# 6)
;;    (Esto probará la nueva Regla 21)
;; (printout t "Simulando compra de Sofía (Cargador)..." crlf)
;; (assert (orden (orden-id 1005) (customer-id 101) (part-number 6) (tarjeta-id 201) (qty 1) (pago contado)))

;; 4. Correr el motor de reglas
(printout t crlf "--- Ejecutando Motor de Reglas de Negocio ---" crlf crlf)
(run)
(printout t crlf "--- Fin de la ejecución ---" crlf)