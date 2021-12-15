;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. 4 de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem problema_simple) 
(:domain puerto)
(:objects 
    g1 - grua
    g2 - grua
    g3 - grua

    p1 - pila
    p2 - pila
    p3 - pila
    p4 - pila
    p5 - pila
    p6 - pila
    p7 - pila
    p8 - pila


    m1 - muelle
    m2 - muelle
    m3 - muelle

    t1 - cinta
    t2 - cinta
    t3 - cinta
    t4 - cinta

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
    c14 - contenedor

    n0 - talla
    n1 - talla
    n2 - talla
    n3 - talla
)

(:init

    ; Muelle donde se encuentra cada contenedor
    (ubicado_en c1 m1)
    (ubicado_en c3 m1)

    (ubicado_en c2 m2)
    (ubicado_en c4 m2)
    (ubicado_en c5 m2)
    (ubicado_en c6 m2)
    (ubicado_en c7 m2)
    (ubicado_en c8 m2)
    (ubicado_en c10 m2)
    (ubicado_en c9 m2)

    (ubicado_en c11 m3)
    (ubicado_en c12 m3)
    (ubicado_en c13 m3)
    (ubicado_en c14 m3)

    ; Contenedores en sus pilas
    (ubicado_en c1 p1)
    (ubicado_en c3 p3)

    (ubicado_en c2 p4)
    (ubicado_en c4 p4)
    (ubicado_en c5 p4)
    (ubicado_en c7 p5)
    (ubicado_en c6 p5)
    (ubicado_en c10 p6)
    (ubicado_en c9 p6)
    (ubicado_en c8 p6)

    (ubicado_en c11 p7)
    (ubicado_en c12 p7)
    (ubicado_en c13 p8)
    (ubicado_en c14 p8)

    ; Pilas en sus muelles
    (ubicado_en p1 m1)
    (ubicado_en p2 m1)
    (ubicado_en p3 m1)

    (ubicado_en p4 m2)
    (ubicado_en p5 m2)
    (ubicado_en p6 m2)

    (ubicado_en p7 m3)
    (ubicado_en p8 m3)

    ; Orden de los contenedores en cada pila
    (encima c1 p1)
    (encima c3 p3)

    (encima c2 c5)
    (encima c5 c4)
    (encima c4 p4)

    (encima c7 c6)
    (encima c6 p5)

    (encima c10 c9)
    (encima c9 c8)
    (encima c8 p6)

    (encima c12 c11)
    (encima c11 p7)

    (encima c14 c13)
    (encima c13 p8)

    ; Gruas en sus muelles
    (ubicado_en g1 m1)
    (ubicado_en g2 m2)
    (ubicado_en g3 m3)

    ; Conexion carriles de cinta
    (conecta_a t1 m1 m2)
    (conecta_a t2 m2 m1)
    (conecta_a t3 m1 m3)
    (conecta_a t4 m3 m1)

    ; Tops de las pilas
    (top c1 p1)
    (top p2 p2)
    (top c3 p3)
    (top c2 p4)
    (top c7 p5)
    (top c10 p6)
    (top c12 p7)
    (top c14 p8)

    ; Control de tallas
    (next n0 n1)
    (next n1 n2)
    (next n2 n3)

    ; Gruas y carriles de cinta libres
    (libre g1)
    (libre g2)
    (libre g3)
    (libre t1)
    (libre t2)
    (libre t3)
    (libre t4)

    ; Altura actual de cada pila contando sus contenedores
    (altura p1 n1)
    (altura p2 n0)
    (altura p3 n1)
    (altura p4 n3)
    (altura p5 n2)
    (altura p6 n3)
    (altura p7 n2)
    (altura p8 n2)

    ; Contendores disponibles
    (disponible c1)
    (disponible c3)
    (disponible c2)
    (disponible c7)
    (disponible c10)
    (disponible c12)
    (disponible c14)
    ; ya que es un verde sobre un verde
    (disponible c4)
    

    ; Contenedores verdes
    
    (verde c4)
    (verde c5)
    (verde c9)
    (verde c13)

    ; Contenedores no verdes
    (no_verde c1)
    (no_verde c2)
    (no_verde c3)
    (no_verde c6)
    (no_verde c7)
    (no_verde c8)
    (no_verde c10)
    (no_verde c11)
    (no_verde c12)
    (no_verde c14)

    ; Hay que marcar que las pilas son no verdes
    (no_verde p1)
    (no_verde p2)
    (no_verde p3)
    (no_verde p4)
    (no_verde p5)
    (no_verde p6)
    (no_verde p7)
    (no_verde p8)

    ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
    (ubicado_en p1 p1)
    (ubicado_en p2 p2)
    (ubicado_en p3 p3)
    (ubicado_en p5 p5)
    (ubicado_en p6 p6)
    (ubicado_en p4 p4)
    (ubicado_en p7 p7)
    (ubicado_en p8 p8)

    ; Alt max de pila por muelle
    ; La alt max en m1 es 1
    (no_es_alt_max n0 m1)
    (no_es_alt_max n1 m1)
    (no_es_alt_max n2 m1)

    ; La alt max en m2 es 3
    (no_es_alt_max n0 m2)
    (no_es_alt_max n1 m2)
    (no_es_alt_max n2 m2)
    (no_es_alt_max n3 m2)

    ; La alt max en m3 es 3
    (no_es_alt_max n0 m3)
    (no_es_alt_max n1 m3)
    (no_es_alt_max n2 m3)

)

(:goal (and
    (ubicado_en c9 m1)
    (disponible c9)

    (ubicado_en c5 m1)
    (disponible c5)

    (ubicado_en c4 m1)
    (disponible c4)

    (ubicado_en c13 m1)
    (disponible c13)

))
)