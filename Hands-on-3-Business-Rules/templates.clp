;; --- Plantillas para el Motor de Reglas de Negocio ---

(deftemplate customer
  (slot customer-id (type INTEGER))
  (slot name (type STRING))
  (slot tipo (type SYMBOL)) ; menudista o mayorista
)

(deftemplate smartphone
  (slot part-number (type INTEGER))
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot precio (type INTEGER))
)

(deftemplate compu
  (slot part-number (type INTEGER))
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot precio (type INTEGER))
)

(deftemplate accesorio
  (slot part-number (type INTEGER))
  (slot nombre (type STRING))
  (slot tipo (type SYMBOL)) ; funda, mica, etc.
  (slot precio (type INTEGER))
)

(deftemplate tarjeta
  (slot tarjeta-id (type INTEGER))
  (slot banco (type SYMBOL))
  (slot grupo (type SYMBOL)) ; oro, visa, etc.
  (slot exp-date (type STRING))
)

(deftemplate orden
  (slot orden-id (type INTEGER))
  (slot customer-id (type INTEGER))
  (slot part-number (type INTEGER))
  (slot tarjeta-id (type INTEGER))
  (slot qty (type INTEGER))
  (slot pago (type SYMBOL)) ; contado o credito
)

;; --- Plantillas para los Resultados ---

(deftemplate vales
  (slot vale-id (type SYMBOL))
  (slot customer-id (type INTEGER))
  (slot monto (type INTEGER))
)

(deftemplate oferta
  (slot descripcion (type STRING))
)

(deftemplate descuento
  (slot descripcion (type STRING))
)

(deftemplate recomendacion
  (slot customer-id (type INTEGER))
  (slot product-name (type STRING))
  (slot reason (type STRING))
)