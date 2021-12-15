;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. 4 pero con 2 gruas en muelle 1 de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem problema_simple) 
(:domain puerto)
(:objects 
    grua1 - grua
    grua2 - grua
    grua3 - grua
    grua4 - grua

    pila1 - pila
    pila2 - pila
    pila3 - pila
    pila4 - pila
    pila5 - pila
    pila6 - pila
    pila7 - pila
    pila8 - pila

    muelle1 - muelle
    muelle2 - muelle
    muelle3 - muelle

    cinta1 - cinta
    cinta2 - cinta
    cinta3 - cinta
    cinta4 - cinta

    contenedor1 - contenedor
    contenedor2 - contenedor
    contenedor3 - contenedor
    contenedor4 - contenedor
    contenedor5 - contenedor
    contenedor6 - contenedor
    contenedor7 - contenedor
    contenedor8 - contenedor
    contenedor9 - contenedor
    contenedor10 - contenedor
    contenedor11 - contenedor
    contenedor12 - contenedor
    contenedor13 - contenedor
    contenedor14 - contenedor

    altura_muelle1_0 - altura
    altura_muelle1_1 - altura
    altura_muelle1_2 - altura

    altura_muelle2_0 - altura
    altura_muelle2_1 - altura
    altura_muelle2_2 - altura
    altura_muelle2_3 - altura

    altura_muelle3_0 - altura
    altura_muelle3_1 - altura
    altura_muelle3_2 - altura
)

(:init

    ; Muelle donde se encuentra cada contenedor
    (ubicado-en contenedor1 muelle1)
    (ubicado-en contenedor3 muelle1)

    (ubicado-en contenedor2 muelle2)
    (ubicado-en contenedor4 muelle2)
    (ubicado-en contenedor5 muelle2)
    (ubicado-en contenedor6 muelle2)
    (ubicado-en contenedor7 muelle2)
    (ubicado-en contenedor8 muelle2)
    (ubicado-en contenedor10 muelle2)
    (ubicado-en contenedor9 muelle2)

    (ubicado-en contenedor11 muelle3)
    (ubicado-en contenedor12 muelle3)
    (ubicado-en contenedor13 muelle3)
    (ubicado-en contenedor14 muelle3)

    ; Contenedores en sus pilas
    (ubicado-en contenedor1 pila1)
    (ubicado-en contenedor3 pila3)

    (ubicado-en contenedor2 pila4)
    (ubicado-en contenedor4 pila4)
    (ubicado-en contenedor5 pila4)
    (ubicado-en contenedor7 pila5)
    (ubicado-en contenedor6 pila5)
    (ubicado-en contenedor10 pila6)
    (ubicado-en contenedor9 pila6)
    (ubicado-en contenedor8 pila6)

    (ubicado-en contenedor11 pila7)
    (ubicado-en contenedor12 pila7)
    (ubicado-en contenedor13 pila8)
    (ubicado-en contenedor14 pila8)

    ; Pilas en sus muelles
    (ubicado-en pila1 muelle1)
    (ubicado-en pila2 muelle1)
    (ubicado-en pila3 muelle1)

    (ubicado-en pila4 muelle2)
    (ubicado-en pila5 muelle2)
    (ubicado-en pila6 muelle2)

    (ubicado-en pila7 muelle3)
    (ubicado-en pila8 muelle3)

    ; Orden de los contenedores en cada pila
    (encima contenedor1 pila1)
    (encima contenedor3 pila3)

    (encima contenedor2 contenedor5)
    (encima contenedor5 contenedor4)
    (encima contenedor4 pila4)

    (encima contenedor7 contenedor6)
    (encima contenedor6 pila5)

    (encima contenedor10 contenedor9)
    (encima contenedor9 contenedor8)
    (encima contenedor8 pila6)

    (encima contenedor12 contenedor11)
    (encima contenedor11 pila7)

    (encima contenedor14 contenedor13)
    (encima contenedor13 pila8)

    ; Gruas en sus muelles
    (ubicado-en grua1 muelle1)
    (ubicado-en grua4 muelle1)
    (ubicado-en grua2 muelle2)
    (ubicado-en grua3 muelle3)

    ; Conexion carriles de cinta
    (conecta_a cinta1 muelle1 muelle2)
    (conecta_a cinta2 muelle2 muelle1)
    (conecta_a cinta3 muelle1 muelle3)
    (conecta_a cinta4 muelle3 muelle1)

    ; Tops de las pilas
    (top contenedor1 pila1)
    (top pila2 pila2)
    (top contenedor3 pila3)
    (top contenedor2 pila4)
    (top contenedor7 pila5)
    (top contenedor10 pila6)
    (top contenedor12 pila7)
    (top contenedor14 pila8)

    ; Control de alturas
    (next altura_muelle1_0 altura_muelle1_1)
    (next altura_muelle1_1 altura_muelle1_2)

    (next altura_muelle2_0 altura_muelle2_1)
    (next altura_muelle2_1 altura_muelle2_2)
    (next altura_muelle2_2 altura_muelle2_3)

    (next altura_muelle3_0 altura_muelle3_1)
    (next altura_muelle3_1 altura_muelle3_2)

    ; Gruas y carriles de cinta libres
    (libre grua1)
    (libre grua2)
    (libre grua3)
    (libre grua4)
    (libre cinta1)
    (libre cinta2)
    (libre cinta3)
    (libre cinta4)

    ; Altura actual de cada pila contando sus contenedores
    (altura pila1 altura_muelle1_1)
    (altura pila2 altura_muelle1_0)
    (altura pila3 altura_muelle1_1)
    (altura pila4 altura_muelle2_3)
    (altura pila5 altura_muelle2_2)
    (altura pila6 altura_muelle2_3)
    (altura pila7 altura_muelle3_2)
    (altura pila8 altura_muelle3_2)

    ; Contendores disponibles
    (disponible contenedor1)
    (disponible contenedor3)
    (disponible contenedor2)
    (disponible contenedor7)
    (disponible contenedor10)
    (disponible contenedor12)
    (disponible contenedor14)
    ; ya que es un verde sobre un verde
    (disponible contenedor4)
    

    ; Contenedores verdes
    
    (verde contenedor4)
    (verde contenedor5)
    (verde contenedor9)
    (verde contenedor13)

    ; Contenedores no verdes
    (no-verde contenedor1)
    (no-verde contenedor2)
    (no-verde contenedor3)
    (no-verde contenedor6)
    (no-verde contenedor7)
    (no-verde contenedor8)
    (no-verde contenedor10)
    (no-verde contenedor11)
    (no-verde contenedor12)
    (no-verde contenedor14)

    ; Hay que marcar que las pilas son no verdes
    (no-verde pila1)
    (no-verde pila2)
    (no-verde pila3)
    (no-verde pila4)
    (no-verde pila5)
    (no-verde pila6)
    (no-verde pila7)
    (no-verde pila8)

    ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
    (ubicado-en pila1 pila1)
    (ubicado-en pila2 pila2)
    (ubicado-en pila3 pila3)
    (ubicado-en pila5 pila5)
    (ubicado-en pila6 pila6)
    (ubicado-en pila4 pila4)
    (ubicado-en pila7 pila7)
    (ubicado-en pila8 pila8)
)

(:goal (and

    (ubicado-en contenedor9 muelle1)
    (disponible contenedor9)

    (ubicado-en contenedor5 muelle1)
    (disponible contenedor5)

    (ubicado-en contenedor4 muelle1)
    (disponible contenedor4)

    (ubicado-en contenedor13 muelle1)
    (disponible contenedor13)

))

)