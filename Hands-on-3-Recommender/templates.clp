;; --- Plantillas para Clientes, Productos y Órdenes ---
(deftemplate customer
  (slot customer-id (type INTEGER))
  (slot name (type STRING))
)

(deftemplate product
  (slot part-number (type INTEGER))
  (slot name (type STRING))
  (slot category (type SYMBOL))
)

(deftemplate order
  (slot customer-id (type INTEGER))
  (slot part-number (type INTEGER))
)

;; --- Plantilla para generar recomendaciones ---
(deftemplate recomendacion
    (slot customer-id (type INTEGER))
    (slot product-name (type STRING))
    (slot reason (type STRING))
)