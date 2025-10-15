;; --- Hechos iniciales del sistema  ---

(deffacts clientes-y-productos
    ;; Clientes
    (customer (customer-id 101) (name "Ana"))
    (customer (customer-id 102) (name "Beto"))
    (customer (customer-id 103) (name "Carlos"))
    (customer (customer-id 104) (name "Diana"))     ;; Cliente inactivo
    (customer (customer-id 105) (name "Elena"))     ;; Cliente inactivo
    (customer (customer-id 106) (name "Fernando"))

    ;; Productos
    (product (part-number 1) (name "Laptop Gamer") (category electronica))
    (product (part-number 2) (name "Mouse Vertical") (category electronica))
    (product (part-number 3) (name "Libro de IA") (category lectura))
    (product (part-number 4) (name "Teclado Mecanico") (category electronica)) 
    (product (part-number 5) (name "Monitor 4K") (category electronica)) 
)

(deffacts historial-de-compras-extendido
    ;; --- Compras existentes ---
    ; Ana compró una Laptop
    (order (customer-id 101) (part-number 1))
    ; Beto compró una Laptop y un Mouse
    (order (customer-id 102) (part-number 1))
    (order (customer-id 102) (part-number 2))
    ; Carlos compró un Libro
    (order (customer-id 103) (part-number 3))
    ; Carlos también compró un Teclado
    (order (customer-id 103) (part-number 4))
    ; Fernando compró Laptop, Teclado y Monitor
    (order (customer-id 106) (part-number 1))
    (order (customer-id 106) (part-number 4))
    (order (customer-id 106) (part-number 5))
)