;; =================================================================
;; ARCHIVO DE REGLAS DE NEGOCIO
;; =================================================================

;; --- REGLAS DE OFERTAS (MSI, PROMOCIONES) ---
;; (Todas las reglas de negocio tienen prioridad 10 para ejecutarse antes que las de impresión)

;; Regla 1: Pixel 9 (p# 1) + BancoNorte (t# 201) → 24 meses sin intereses
(defrule pixel9-banconorte-24msi
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number 1) (tarjeta-id 201))
  =>
  (assert (oferta (descripcion (str-cat "¡Oferta! Pixel 9 con BancoNorte Oro: 24 meses sin intereses para orden " ?oid)))))

;; Regla 2: Galaxy S25 (p# 2) + TiendaSur VISA (t# 202) → 12 meses sin intereses
(defrule galaxys25-tiendasur-12msi
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number 2) (tarjeta-id 202))
  =>
  (assert (oferta (descripcion (str-cat "¡Oferta! Samsung Galaxy S25 con TiendaSur VISA: 12 meses sin intereses para orden " ?oid)))))

;; Regla 3: Cualquier producto Samsung + BancoEste VISA (t# 203) → 18 meses sin intereses
(defrule samsung-bancoeste-18msi
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number ?pnum) (tarjeta-id 203))
  (smartphone (part-number ?pnum) (marca samsung))
  =>
  (assert (oferta (descripcion (str-cat "¡Oferta! Producto Samsung con BancoEste VISA: 18 meses sin intereses para orden " ?oid)))))

;; Regla 4: Cualquier Compu + Tarjeta TiendaSur (t# 202) → 18 meses sin intereses
(defrule compu-tiendasur-18msi
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number ?pnum) (tarjeta-id 202))
  (compu (part-number ?pnum))
  =>
  (assert (oferta (descripcion (str-cat "¡Oferta! Computadora con Tarjeta TiendaSur: 18 meses sin intereses para orden " ?oid)))))

;; Regla 5: Pago de Contado en Dell XPS 15 (p# 4) → Oferta de Envío Gratis
(defrule dellxps-contado-envio
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number 4) (pago contado))
  =>
  (assert (oferta (descripcion (str-cat "¡Oferta! Envío Express GRATIS para Dell XPS 15 (Orden " ?oid ") por pago de contado.")))))


;; --- REGLAS DE DESCUENTOS DIRECTOS ---

;; Regla 6: Cliente Mayorista + Compra Dell XPS 15 (p# 4) → 10% de Descuento
(defrule dellxps-mayorista-descuento
  (declare (salience 10))
  (orden (orden-id ?oid) (customer-id ?cid) (part-number 4))
  (customer (customer-id ?cid) (tipo mayorista))
  =>
  (assert (descuento (descripcion (str-cat "Descuento Mayorista: 10% en Dell XPS 15 para Cliente " ?cid)))))

;; Regla 7: Combo Audifonos (p# 5) + Cargador (p# 6) → 15% Descuento en accesorios
(defrule combo-audifonos-cargador
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number 5))
  (orden (customer-id ?cid) (part-number 6))
  =>
  (assert (descuento (descripcion (str-cat "Descuento Combo: 15% para Cliente " ?cid " por comprar Audifonos y Cargador.")))))

;; Regla 8: Cliente Mayorista + Cantidad > 10 → 15% Descuento Total
(defrule descuento-general-mayorista
  (declare (salience 10))
  (orden (orden-id ?oid) (customer-id ?cid) (qty ?q&:(> ?q 10)))
  (customer (customer-id ?cid) (tipo mayorista))
  =>
  (assert (descuento (descripcion (str-cat "Descuento Volumen: 15% en Orden " ?oid " para Cliente Mayorista " ?cid " (Qty: " ?q ")")))))

;; Regla 9: Pago de Contado en cualquier Compu → 5% Descuento
(defrule compu-contado-descuento
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number ?pnum) (pago contado))
  (compu (part-number ?pnum) (precio ?p))
  =>
  (assert (descuento (descripcion (str-cat "Descuento 5% (Total: $" (* ?p 0.05) ") en Orden " ?oid " por pago de contado.")))))

;; Regla 10: Compra cualquier Google (p# 1) + Tarjeta HeyBanco (t# 204) → 10% Descuento
(defrule google-heybanco-descuento
  (declare (salience 10))
  (orden (orden-id ?oid) (part-number 1) (tarjeta-id 204))
  =>
  (assert (descuento (descripcion (str-cat "Descuento 10% en Google Pixel (Orden " ?oid ") por pagar con HeyBanco.")))))


;; --- REGLAS DE GENERACIÓN DE VALES ---

;; Regla 11: Compra producto de más de 40,000 (Dell XPS) → Vale de $1000
(defrule compra-cara-generar-vale
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number ?pnum))
  (compu (part-number ?pnum) (precio ?p&:(> ?p 40000)))
  =>
  (assert (vales (vale-id (gensym)) (customer-id ?cid) (monto 1000))))

;; Regla 12: Cliente Menudista compra Pixel 9 (p# 1) → Vale de $500
(defrule menudista-pixel-vale
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number 1))
  (customer (customer-id ?cid) (tipo menudista))
  =>
  (assert (vales (vale-id (gensym)) (customer-id ?cid) (monto 500))))

;; Regla 13: Cliente compra combo Pixel 9 (p# 1) + Asus Zenbook (p# 3) → Vale de $2000
(defrule combo-pixel-zenbook-vale
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number 1))
  (orden (customer-id ?cid) (part-number 3))
  =>
  (assert (vales (vale-id (gensym)) (customer-id ?cid) (monto 2000))))

;; Regla 14: Cantidad > 5 en cualquier Smartphone → Vale de $300
(defrule orden-grande-smartphone-vale
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number ?pnum) (qty ?q&:(> ?q 5)))
  (smartphone (part-number ?pnum))
  =>
  (assert (vales (vale-id (gensym)) (customer-id ?cid) (monto 300))))

;; Regla 15: Cliente Mayorista compra Accesorio → Vale de $50
(defrule mayorista-accesorio-vale
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number ?pnum))
  (customer (customer-id ?cid) (tipo mayorista))
  (accesorio (part-number ?pnum))
  =>
  (assert (vales (vale-id (gensym)) (customer-id ?cid) (monto 50))))


;; --- REGLAS DE RECOMENDACIÓN ---

;; Regla 16: Compra Smartphone (cualquiera) Y NO compra Audifonos (p# 5) → Recomendar Audifonos
(defrule recomendar-audifonos-con-smartphone
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number ?pnum))
  (smartphone (part-number ?pnum))
  (not (orden (customer-id ?cid) (part-number 5)))
  =>
  (assert (recomendacion (customer-id ?cid) (product-name "Audifonos USB-C") (reason "Complementa tu nuevo smartphone."))))

;; Regla 17: Compra Samsung Galaxy S25 (p# 2) Y NO compra Cargador (p# 6) → Recomendar Cargador
(defrule recomendar-cargador-con-s25
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number 2))
  (not (orden (customer-id ?cid) (part-number 6)))
  =>
  (assert (recomendacion (customer-id ?cid) (product-name "Cargador GaN") (reason "Ideal para la carga rápida de tu Galaxy S25."))))

;; Regla 18: Compra Pixel 9 (p# 1) → Recomendar Asus Zenbook (p# 3)
(defrule recomendar-zenbook-a-cliente-pixel
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number 1))
  (not (orden (customer-id ?cid) (part-number 3)))
  =>
  (assert (recomendacion (customer-id ?cid) (product-name "Asus Zenbook") (reason "Una gran laptop para tu nuevo Pixel."))))

;; Regla 19: Compra Compu (cualquiera) Y NO compra Mouse (p# 7) → Recomendar Mouse
(defrule recomendar-mouse-con-compu
  (declare (salience 10))
  (orden (customer-id ?cid) (part-number ?pnum))
  (compu (part-number ?pnum))
  (not (orden (customer-id ?cid) (part-number 7)))
  =>
  (assert (recomendacion (customer-id ?cid) (product-name "Mouse Inalambrico") (reason "Maximiza tu productividad con tu nueva computadora."))))

;; Regla 20: Cliente no ha comprado nada → Recomendar Oferta de Bienvenida
(defrule recomendar-a-cliente-inactivo
  (declare (salience 10))
  (customer (customer-id ?cid))
  (not (orden (customer-id ?cid)))
  =>
  (assert (recomendacion (customer-id ?cid) (product-name "Cupón de Primera Compra") (reason "Vemos que aún no te animas. ¡Toma un 10% de descuento!"))))

;; Regla 21: Recomendar Audifonos con la compra de un Cargador
(defrule recomendar-audifonos-con-cargador
  (declare (salience 10))
  ;; SI: El cliente compra un Cargador (p# 6)
  (orden (customer-id ?cid) (part-number 6))
  ;; Y NO: Ha comprado ya los Audífonos (p# 5)
  (not (orden (customer-id ?cid) (part-number 5)))
  =>
  ;; ENTONCES: Genera la recomendación
  (assert (recomendacion (customer-id ?cid) (product-name "Audifonos USB-C") (reason "Un accesorio perfecto para tu nuevo cargador."))))

;; =================================================================
;; REGLAS DE IMPRESIÓN (PRIORIDAD BAJA)
;; =================================================================

(defrule mostrar-ofertas
    (declare (salience -10))
    ?f <- (oferta (descripcion ?desc))
    =>
    (printout t "OFERTA GENERADA: " ?desc crlf)
    (retract ?f))

(defrule mostrar-descuentos
    (declare (salience -10))
    ?f <- (descuento (descripcion ?desc))
    =>
    (printout t "DESCUENTO GENERADO: " ?desc crlf)
    (retract ?f))

(defrule mostrar-vales
    (declare (salience -10))
    ?f <- (vales (customer-id ?cid) (monto ?m))
    =>
    (printout t "VALE GENERADO: Para Cliente " ?cid " por $" ?m crlf)
    (retract ?f))

(defrule mostrar-recomendaciones
    (declare (salience -10))
    ?f <- (recomendacion (customer-id ?cid) (product-name ?pname) (reason ?razon))
    =>
    (printout t "RECOMENDACIÓN GENERADA: Para Cliente " ?cid " - " ?pname " (Motivo: " ?razon ")" crlf)
    (retract ?f))
