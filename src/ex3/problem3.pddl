;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. 3 de Daniel P. y Alejandro G.
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
        pila5 - pila
        pila6 - pila
        pila7 - pila

        muelle1 - muelle
        muelle2 - muelle

        cinta1 - cinta
        cinta2 - cinta

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

        altura_muelle1_0 - log_altura
        altura_muelle1_1 - log_altura
        altura_muelle1_2 - log_altura

        altura_muelle2_0 - log_altura
        altura_muelle2_1 - log_altura
        altura_muelle2_2 - log_altura
        altura_muelle2_3 - log_altura
    )

    (:init
        (= (peso contenedor1) 1)
        (= (peso contenedor2) 1)
        (= (peso contenedor3) 1)
        (= (peso contenedor4) 1)
        (= (peso contenedor5) 1)
        (= (peso contenedor6) 1)
        (= (peso contenedor7) 1)
        (= (peso contenedor8) 1)
        (= (peso contenedor9) 1)
        (= (peso contenedor10) 1)
        (= (peso contenedor11) 1)
        (= (peso contenedor12) 1)
        (= (peso contenedor13) 1)

        (= (longitud cinta1) 5)
        (= (velocidad cinta1) 1)
        (= (gasolina cinta1) 10)
        (= (longitud cinta2) 5)
        (= (velocidad cinta2) 1)
        (= (gasolina cinta2) 10)

        (= (total-gasoilina-gastada) 0)

        ; Muelle donde se encuentra cada contenedor
        (ubicado-en contenedor1 muelle1)
        (ubicado-en contenedor2 muelle1)
        (ubicado-en contenedor3 muelle1)
        (ubicado-en contenedor4 muelle1)

        (ubicado-en contenedor5 muelle2)
        (ubicado-en contenedor6 muelle2)
        (ubicado-en contenedor7 muelle2)
        (ubicado-en contenedor8 muelle2)
        (ubicado-en contenedor9 muelle2)
        (ubicado-en contenedor10 muelle2)
        (ubicado-en contenedor11 muelle2)
        (ubicado-en contenedor12 muelle2)
        (ubicado-en contenedor13 muelle2)

        ; Contenedores en sus pilas
        (ubicado-en contenedor1 pila1)
        (ubicado-en contenedor2 pila1)
        (ubicado-en contenedor4 pila2)
        (ubicado-en contenedor3 pila3)

        (ubicado-en contenedor5 pila4)
        (ubicado-en contenedor6 pila5)
        (ubicado-en contenedor7 pila5)

        (ubicado-en contenedor8 pila6)
        (ubicado-en contenedor9 pila6)
        (ubicado-en contenedor10 pila6)

        (ubicado-en contenedor11 pila7)
        (ubicado-en contenedor12 pila7)
        (ubicado-en contenedor13 pila7)

        ; Pilas en sus muelles
        (ubicado-en pila1 muelle1)
        (ubicado-en pila2 muelle1)
        (ubicado-en pila3 muelle1)

        (ubicado-en pila4 muelle2)
        (ubicado-en pila5 muelle2)
        (ubicado-en pila6 muelle2)
        (ubicado-en pila7 muelle2)

        ; Orden de los contenedores en cada pila
        (encima contenedor2 contenedor1)
        (encima contenedor1 pila1)

        (encima contenedor4 pila2)

        (encima contenedor3 pila3)

        (encima contenedor5 pila4)

        (encima contenedor7 contenedor6)
        (encima contenedor6 pila5)

        (encima contenedor10 contenedor9)
        (encima contenedor9 contenedor8)
        (encima contenedor8 pila6)

        (encima contenedor13 contenedor12)
        (encima contenedor12 contenedor11)
        (encima contenedor11 pila7)

        ; Gruas en sus muelles
        (ubicado-en grua1 muelle1)
        (ubicado-en grua2 muelle2)

        ; Conexion carriles de cinta
        (conecta-a cinta1 muelle1 muelle2)
        (conecta-a cinta2 muelle2 muelle1)

        ; Tops de las pilas
        (top contenedor2 pila1)
        (top contenedor4 pila2)
        (top contenedor3 pila3)
        (top contenedor5 pila4)
        (top contenedor7 pila5)
        (top contenedor10 pila6)
        (top contenedor13 pila7)

        (= (altura grua1) 5)
        (= (altura grua2) 5)
        (= (altura cinta1) 1)
        (= (altura cinta2) 1)

        ; Control de alturas
        (next altura_muelle1_0 altura_muelle1_1)
        (next altura_muelle1_1 altura_muelle1_2)

        (next altura_muelle2_0 altura_muelle2_1)
        (next altura_muelle2_1 altura_muelle2_2)
        (next altura_muelle2_2 altura_muelle2_3)

        ; Gruas y carriles de cinta libres
        (libre grua1)
        (libre grua2)
        (libre cinta1)
        (libre cinta2)

        ; Altura actual de cada pila contando sus contenedores
        (= (altura pila1) 2)
        (= (altura pila2) 1)
        (= (altura pila3) 1)
        (= (altura pila4) 1)
        (= (altura pila5) 2)
        (= (altura pila6) 3)
        (= (altura pila7) 3)

        (logica-altura pila1 altura_muelle1_2)
        (logica-altura pila2 altura_muelle1_1)
        (logica-altura pila3 altura_muelle1_1)
        (logica-altura pila4 altura_muelle2_1)
        (logica-altura pila5 altura_muelle2_2)
        (logica-altura pila6 altura_muelle2_3)
        (logica-altura pila7 altura_muelle2_3)

        ; Contendores disponibles
        (disponible contenedor2)
        (disponible contenedor4)
        (disponible contenedor3)
        (disponible contenedor5)
        (disponible contenedor7)
        (disponible contenedor10)
        (disponible contenedor13)

        ; Contenedores verdes
        (verde contenedor1)
        (verde contenedor6)
        (verde contenedor11)
        (verde contenedor9)

        ; Contenedores no verdes
        (no-verde contenedor2)
        (no-verde contenedor3)
        (no-verde contenedor4)
        (no-verde contenedor5)
        (no-verde contenedor7)
        (no-verde contenedor10)
        (no-verde contenedor8)
        (no-verde contenedor12)
        (verde contenedor13)

        ; Hay que marcar que las pilas son no verdes
        (no-verde pila1)
        (no-verde pila2)
        (no-verde pila3)
        (no-verde pila4)
        (no-verde pila5)
        (no-verde pila6)
        (no-verde pila7)

        ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
        (ubicado-en pila1 pila1)
        (ubicado-en pila2 pila2)
        (ubicado-en pila3 pila3)
        (ubicado-en pila4 pila4)
        (ubicado-en pila5 pila5)
        (ubicado-en pila6 pila6)
        (ubicado-en pila7 pila7)
    )

    (:goal
        (and

            (ubicado-en contenedor1 muelle1)
            (disponible contenedor1)

            (ubicado-en contenedor6 muelle1)
            (disponible contenedor6)

            (ubicado-en contenedor11 muelle1)
            (disponible contenedor11)

            (ubicado-en contenedor9 muelle1)
            (disponible contenedor9)

        )
    )
    (:metric minimize (total-gasoilina-gastada))
)