;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. Correo Eva de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem problema_simple) 
(:domain puerto)
(:objects 
    g1 - grua
    g2 - grua

    p1 - pila
    p2 - pila
    p3 - pila
    p4 - pila

    m1 - muelle
    m2 - muelle

    t1 - cinta
    t2 - cinta

    c1 - contenedor
    c2 - contenedor
    c3 - contenedor
    c4 - contenedor

    n0 - talla
    n1 - talla

)

(:init

    ; Muelle donde se encuentra cada contenedor
    (ubicado_en c1 m2)
    (ubicado_en c2 m2)
    (ubicado_en c3 m1)

    ; Contenedores en sus pilas
    (ubicado_en c1 p1)
    (ubicado_en c2 p2)
    (ubicado_en c3 p3)

    ; Pilas en sus muelles
    (ubicado_en p1 m2)
    (ubicado_en p2 m2)
    (ubicado_en p3 m1)
    (ubicado_en p4 m1)

    ; Orden de los contenedores en cada pila
    (encima c2 p2)
    (encima c1 p1)
    (encima c3 p3)

    ; Gruas en sus muelles
    (ubicado_en g1 m1)
    (ubicado_en g2 m2)

    ; Conexion carriles de cinta
    (conecta_a t1 m1 m2)
    (conecta_a t2 m2 m1)

    ; Tops de las pilas
    (top c1 p1)
    (top c2 p2)
    (top c3 p3)
    (top p4 p4)

    ; Control de tallas
    (next n0 n1)

    ; Gruas y carriles de cinta libres
    (libre g1)
    (libre g2)
    (libre t1)
    (libre t2)

    ; Altura actual de cada pila contando sus contenedores
    (altura p1 n1)
    (altura p2 n1)
    (altura p3 n1)
    (altura p4 n0)

    ; Contendores disponibles
    (disponible c1)
    (disponible c2)
    (disponible c3)

    ; Contenedores verdes
    (verde c1)
    (verde c2)

    ; Contenedores no verdes
    (no_verde c3)

    ; Hay que marcar que las pilas son no verdes
    (no_verde p1)
    (no_verde p2)
    (no_verde p3)
    (no_verde p4)

    ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
    (ubicado_en p1 p1)
    (ubicado_en p2 p2)
    (ubicado_en p3 p3)
    (ubicado_en p4 p4)

    ; Alt max de pila por muelle
    ; La alt max en m1 es 1
    (no_es_alt_max n0 m1)
    (no_es_alt_max n1 m1)

    ; La alt max en m2 es 1
    (no_es_alt_max n0 m2)
    (no_es_alt_max n1 m2)

)

(:goal (and

    (ubicado_en c1 m1)
    (ubicado_en c2 m1)

    (disponible c1)
    (disponible c2)
))

)