;; --- Reglas de Acciones para el Problema del Mono y la Banana ---

;; Contador para los pasos del plan
(defglobal
  ?*paso-actual* = 0
)

;; Regla 1: Mover el mono a una nueva posición
(defrule mover-mono
  (declare (salience 10))
  ?e <- (estado (mono-en ?pos1)
                 (caja-en ?caja-pos)
                 (tiene-caja no)
                 (alcance-bananas no)
                 (tiene-bananas no))
  (test (neq ?pos1 debajo-banana)) ; No se mueve si ya está debajo de la banana para otra acción
  =>
  (bind ?*paso-actual* (+ ?*paso-actual* 1))
  (printout t "Paso " ?*paso-actual* ": Mono se mueve de " ?pos1 " a " debajo-banana crlf)
  (assert (plan-accion (paso ?*paso-actual*) (accion (str-cat "Mover mono de " ?pos1 " a debajo-banana"))))
  (modify ?e (mono-en debajo-banana)))

;; Regla 2: Empujar la caja
(defrule empujar-caja-debajo-banana
  (declare (salience 20))
  ?e <- (estado (mono-en ?mono-pos)
                 (caja-en ?caja-pos)
                 (tiene-caja no)
                 (alcance-bananas no)
                 (tiene-bananas no))
  (test (neq ?caja-pos debajo-banana)) ; La caja no está debajo de las bananas
  (test (eq ?mono-pos debajo-banana))   ; El mono está en la posición correcta para empujar
  =>
  (bind ?*paso-actual* (+ ?*paso-actual* 1))
  (printout t "Paso " ?*paso-actual* ": Mono empuja la caja de " ?caja-pos " a " debajo-banana crlf)
  (assert (plan-accion (paso ?*paso-actual*) (accion (str-cat "Empujar caja de " ?caja-pos " a debajo-banana"))))
  (modify ?e (caja-en debajo-banana)))


;; Regla 3: Subirse a la caja
(defrule subirse-a-caja
  (declare (salience 30))
  ?e <- (estado (mono-en ?mono-pos)
                 (caja-en debajo-banana) ; La caja está debajo de las bananas
                 (tiene-caja no)          ; El mono no está en la caja
                 (alcance-bananas no)
                 (tiene-bananas no))
  (test (eq ?mono-pos debajo-banana)) ; El mono está en el suelo debajo de las bananas
  =>
  (bind ?*paso-actual* (+ ?*paso-actual* 1))
  (printout t "Paso " ?*paso-actual* ": Mono se sube a la caja" crlf)
  (assert (plan-accion (paso ?*paso-actual*) (accion "Subirse a la caja"))))


;; Regla 4: Alcanzar las bananas (estando en la caja)
(defrule alcanzar-bananas
  (declare (salience 40))
  ?e <- (estado (mono-en ?mono-pos)
                 (caja-en debajo-banana)
                 (tiene-caja no) ; Mono no está en la caja
                 (alcance-bananas no)
                 (tiene-bananas no))
  (test (eq ?mono-pos debajo-banana)) ; El mono debe estar en la posición para subirse a la caja
  =>
  (bind ?*paso-actual* (+ ?*paso-actual* 1))
  (printout t "Paso " ?*paso-actual* ": Mono puede alcanzar las bananas (subiéndose a la caja)" crlf)
  (assert (plan-accion (paso ?*paso-actual*) (accion "Mono se sube a la caja y alcanza las bananas")))
  (modify ?e (tiene-caja si) (alcance-bananas si))) ; Cambia el estado para que ahora pueda agarrarlas

;; Regla 5: Agarrar las bananas
(defrule agarrar-bananas
  (declare (salience 50))
  ?e <- (estado (alcance-bananas si)
                 (tiene-bananas no))
  ?o <- (objetivo (logrado no))
  =>
  (bind ?*paso-actual* (+ ?*paso-actual* 1))
  (printout t "Paso " ?*paso-actual* ": Mono agarra las bananas!" crlf)
  (assert (plan-accion (paso ?*paso-actual*) (accion "Agarrar las bananas")))
  (modify ?e (tiene-bananas si))
  (modify ?o (logrado si)))

;; Regla para mostrar el plan final 
(defrule mostrar-plan-final
  (declare (salience -10))
  (objetivo (logrado si))
  =>
  (printout t crlf "¡Objetivo logrado! Plan de acciones:" crlf)
  (do-for-all-facts ((?p plan-accion)) TRUE
    (printout t ?p:paso ". " ?p:accion crlf)))