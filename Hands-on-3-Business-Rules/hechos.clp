;; --- Base de Conocimiento (Productos, Clientes, Tarjetas) ---

(deffacts base-de-conocimiento
  ;; Clientes
  (customer (customer-id 101) (name "Sofia") (tipo menudista))
  (customer (customer-id 102) (name "David") (tipo mayorista))
  (customer (customer-id 103) (name "Miguel") (tipo menudista))
  (customer (customer-id 104) (name "Laura") (tipo mayorista))
  (customer (customer-id 105) (name "Gabriela") (tipo menudista))

  ;; Productos
  (smartphone (part-number 1) (marca Google) (modelo "Pixel 9") (precio 20000))
  (smartphone (part-number 2) (marca Samsung) (modelo "Galaxy S25") (precio 23000))
  (compu (part-number 3) (marca Asus) (modelo "Zenbook") (precio 30000))
  (compu (part-number 4) (marca Dell) (modelo "XPS 15") (precio 45000))
  (accesorio (part-number 5) (nombre "Audifonos USB-C") (tipo audio) (precio 600))
  (accesorio (part-number 6) (nombre "Cargador GaN") (tipo cargador) (precio 800))
  (accesorio (part-number 7) (nombre "Mouse Inalambrico") (tipo mouse) (precio 750))
  
  ;; Tarjetas
  (tarjeta (tarjeta-id 201) (banco BancoNorte) (grupo oro) (exp-date "01-12-26"))
  (tarjeta (tarjeta-id 202) (banco TiendaSur) (grupo visa) (exp-date "01-10-25"))
  (tarjeta (tarjeta-id 203) (banco BancoEste) (grupo visa) (exp-date "01-12-27"))
  (tarjeta (tarjeta-id 204) (banco HeyBanco) (grupo mastercard) (exp-date "06-11-28"))
)