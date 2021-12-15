;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. 3 de Daniel P. y Alejandro G.
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
    p5 - pila
    p6 - pila
    p7 - pila

    m1 - muelle
    m2 - muelle

    t1 - cinta
    t2 - cinta

    c1 - contenedor
    c2 - contenedor
    c3 - contenedor
    c4 - contenedor
    c5 - contenedor
    c6 - contenedor
    c7 - contenedor
    c8 - contenedor
    c9 - contenedor
    c10 - contenedor
    c11 - contenedor
    c12 - contenedor
    c13 - contenedor

    n0 - talla
    n1 - talla
    n2 - talla
    n3 - talla
)

(:init

    ; Muelle donde se encuentra cada contenedor
    (ubicado_en c1 m1)
    (ubicado_en c2 m1)
    (ubicado_en c3 m1)
    (ubicado_en c4 m1)

    (ubicado_en c5 m2)
    (ubicado_en c6 m2)
    (ubicado_en c7 m2)
    (ubicado_en c8 m2)
    (ubicado_en c9 m2)
    (ubicado_en c10 m2)
    (ubicado_en c11 m2)
    (ubicado_en c12 m2)
    (ubicado_en c13 m2)

    ; Contenedores en sus pilas
    (ubicado_en c1 p1)
    (ubicado_en c2 p1)
    (ubicado_en c4 p2)
    (ubicado_en c3 p3)

    (ubicado_en c5 p4)
    (ubicado_en c6 p5)
    (ubicado_en c7 p5)

    (ubicado_en c8 p6)
    (ubicado_en c9 p6)
    (ubicado_en c10 p6)

    (ubicado_en c11 p7)
    (ubicado_en c12 p7)
    (ubicado_en c13 p7)

    ; Pilas en sus muelles
    (ubicado_en p1 m1)
    (ubicado_en p2 m1)
    (ubicado_en p3 m1)

    (ubicado_en p4 m2)
    (ubicado_en p5 m2)
    (ubicado_en p6 m2)
    (ubicado_en p7 m2)

    ; Orden de los contenedores en cada pila
    (encima c2 c1)
    (encima c1 p1)

    (encima c4 p2)

    (encima c3 p3)

    (encima c5 p4)

    (encima c7 c6)
    (encima c6 p5)

    (encima c10 c9)
    (encima c9 c8)
    (encima c8 p6)

    (encima c13 c12)
    (encima c12 c11)
    (encima c11 p7)

    ; Gruas en sus muelles
    (ubicado_en g1 m1)
    (ubicado_en g2 m2)

    ; Conexion carriles de cinta
    (conecta_a t1 m1 m2)
    (conecta_a t2 m2 m1)

    ; Tops de las pilas
    (top c2 p1)
    (top c4 p2)
    (top c3 p3)
    (top c5 p4)
    (top c7 p5)
    (top c10 p6)
    (top c13 p7)

    ; Control de tallas
    (next n0 n1)
    (next n1 n2)
    (next n2 n3)

    ; Gruas y carriles de cinta libres
    (libre g1)
    (libre g2)
    (libre t1)
    (libre t2)

    ; Altura actual de cada pila contando sus contenedores
    (altura p1 n2)
    (altura p2 n1)
    (altura p3 n1)
    (altura p4 n1)
    (altura p5 n2)
    (altura p6 n3)
    (altura p7 n3)

    ; Contendores disponibles
    (disponible c2)
    (disponible c4)
    (disponible c3)
    (disponible c5)
    (disponible c7)
    (disponible c10)
    (disponible c13)

    ; Contenedores verdes
    (verde c1)
    (verde c6)
    (verde c11)
    (verde c9)

    ; Contenedores no verdes
    (no_verde c2)
    (no_verde c3)
    (no_verde c4)
    (no_verde c5)
    (no_verde c7)
    (no_verde c10)
    (no_verde c8)
    (no_verde c12)
    (verde c13)

    ; Hay que marcar que las pilas son no verdes
    (no_verde p1)
    (no_verde p2)
    (no_verde p3)
    (no_verde p4)
    (no_verde p5)
    (no_verde p6)
    (no_verde p7)

    ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
    (ubicado_en p1 p1)
    (ubicado_en p2 p2)
    (ubicado_en p3 p3)
    (ubicado_en p4 p4)
    (ubicado_en p5 p5)
    (ubicado_en p6 p6)
    (ubicado_en p7 p7)

    ; Alt max de pila por muelle
    ; La alt max en m1 es 2
    (no_es_alt_max n0 m1)
    (no_es_alt_max n1 m1)
    (no_es_alt_max n2 m1)

    ; La alt max en m2 es 3
    (no_es_alt_max n0 m2)
    (no_es_alt_max n1 m2)
    (no_es_alt_max n2 m2)
    (no_es_alt_max n3 m2)

)

(:goal (and

    (ubicado_en c1 m1)
    (disponible c1)

    (ubicado_en c6 m1)
    (disponible c6)

    (ubicado_en c11 m1)
    (disponible c11)

    (ubicado_en c9 m1)
    (disponible c9)

))

)