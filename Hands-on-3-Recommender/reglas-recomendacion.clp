(defrule recomendar-a-cliente-inactivo
    (declare (salience 10)) 
    ;; SI existe un cliente con un ID y nombre...
    (customer (customer-id ?cid) (name ?cname))
    ;; Y NO existe ninguna orden asociada a ese ID de cliente...
    (not (order (customer-id ?cid)))
  =>
    ;; ENTONCES, genera un hecho de recomendación para ese cliente.
    (assert (recomendacion (customer-id ?cid)
                           (product-name "Oferta de Bienvenida")
                           (reason (str-cat "Hola " ?cname ", tenemos un descuento especial en tu primera compra."))))
)

(defrule recomendar-producto-complementario
    (declare (salience 10))
    ;; SI un cliente (cliente 1) compró un producto (producto A)...
    (order (customer-id ?cid1) (part-number ?pnum1))
    (product (part-number ?pnum1) (name ?pname1))

    ;; Y existe OTRO cliente (cliente 2) que también compró el producto A...
    (order (customer-id ?cid2&~?cid1) (part-number ?pnum1))

    ;; Y ese OTRO cliente (cliente 2) también compró un producto diferente (producto B)...
    (order (customer-id ?cid2) (part-number ?pnum2&~?pnum1))
    (product (part-number ?pnum2) (name ?pname2))

    ;; Y el cliente original (cliente 1) AÚN NO ha comprado el producto B...
    (not (order (customer-id ?cid1) (part-number ?pnum2)))
  =>
    ;; ENTONCES, recomienda el producto B al cliente 1.
    (assert (recomendacion (customer-id ?cid1)
                           (product-name ?pname2)
                           (reason (str-cat "Quienes compraron " ?pname1 " también se interesaron por este producto."))))
)

(defrule mostrar-recomendaciones
    (declare (salience -10))
    ;; Busca un hecho de recomendación que aún no se haya mostrado
    ?rec <- (recomendacion (customer-id ?cid) (product-name ?pname) (reason ?razon))
  =>
    (printout t "-> Recomendación para Cliente " ?cid ": " ?pname crlf)
    (printout t "   Motivo: " ?razon crlf crlf)
    ;; Retract elimina el hecho para no volver a mostrarlo
    (retract ?rec)
)