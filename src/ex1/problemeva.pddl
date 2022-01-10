;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. Correo Eva de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem problema_simple) 
(:domain puerto)
(:objects 
    grua1 - grua
    grua2 - grua

    pila1 - pila
    pila2 - pila
    pila3 - pila
    pila4 - pila

    muelle1 - muelle
    muelle2 - muelle

    cinta1 - cinta
    cinta2 - cinta

    contenedor1 - contenedor
    contenedor2 - contenedor
    contenedor3 - contenedor
    contenedor4 - contenedor

    altura_muelle1_0 - altura
    altura_muelle1_1 - altura

    altura_muelle2_0 - altura
    altura_muelle2_1 - altura
)

(:init
    ; Muelle donde se encuentra cada contenedor
    (ubicado-en contenedor1 muelle2)
    (ubicado-en contenedor2 muelle2)
    (ubicado-en contenedor3 muelle1)

    ; Contenedores en sus pilas
    (ubicado-en contenedor1 pila1)
    (ubicado-en contenedor2 pila2)
    (ubicado-en contenedor3 pila3)

    ; Pilas en sus muelles
    (ubicado-en pila1 muelle2)
    (ubicado-en pila2 muelle2)
    (ubicado-en pila3 muelle1)
    (ubicado-en pila4 muelle1)

    ; Orden de los contenedores en cada pila
    (encima contenedor2 pila2)
    (encima contenedor1 pila1)
    (encima contenedor3 pila3)

    ; Gruas en sus muelles
    (ubicado-en grua1 muelle1)
    (ubicado-en grua2 muelle2)

    ; Conexion carriles de cinta
    (conecta_a cinta1 muelle1 muelle2)
    (conecta_a cinta2 muelle2 muelle1)

    ; Tops de las pilas
    (top contenedor1 pila1)
    (top contenedor2 pila2)
    (top contenedor3 pila3)
    (top pila4 pila4)

    ; Control de alturas
    ; Muelle 1
    (next altura_muelle1_0 altura_muelle1_1)

    ; Muelle 2
    (next altura_muelle2_0 altura_muelle2_1)

    ; Gruas y carriles de cinta libres
    (libre grua1)
    (libre grua2)
    (libre cinta1)
    (libre cinta2)

    ; Altura actual de cada pila contando sus contenedores
    (altura pila1 altura_muelle2_1)
    (altura pila2 altura_muelle2_1)
    (altura pila3 altura_muelle1_1)
    (altura pila4 altura_muelle1_0)

    ; Contendores disponibles
    (disponible contenedor1)
    (disponible contenedor2)
    (disponible contenedor3)

    ; Contenedores verdes
    (verde contenedor1)
    (verde contenedor2)

    ; Contenedores no verdes
    (no-verde contenedor3)

    ; Hay que marcar que las pilas son no verdes
    (no-verde pila1)
    (no-verde pila2)
    (no-verde pila3)
    (no-verde pila4)

    ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
    (ubicado-en pila1 pila1)
    (ubicado-en pila2 pila2)
    (ubicado-en pila3 pila3)
    (ubicado-en pila4 pila4)
)

(:goal (and

    (ubicado-en contenedor1 muelle1)
    (ubicado-en contenedor2 muelle1)

    (disponible contenedor1)
    (disponible contenedor2)
))

)