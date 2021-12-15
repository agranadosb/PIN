;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Prob. 2 de Daniel P. y Alejandro G.
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

    altura0 - talla
    altura1 - talla
    altura2 - talla
    altura3 - talla
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

    ; Pilas en sus muelles
    (ubicado-en pila1 muelle1)
    (ubicado-en pila2 muelle1)
    (ubicado-en pila3 muelle1)

    (ubicado-en pila4 muelle2)
    (ubicado-en pila5 muelle2)
    (ubicado-en pila6 muelle2)

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

    ; Gruas en sus muelles
    (ubicado-en grua1 muelle1)
    (ubicado-en grua2 muelle2)

    ; Conexion carriles de cinta
    (conecta_a cinta1 muelle1 muelle2)
    (conecta_a cinta2 muelle2 muelle1)

    ; Tops de las pilas
    (top contenedor1 pila1)
    (top pila2 pila2)
    (top contenedor3 pila3)
    (top contenedor2 pila4)
    (top contenedor7 pila5)
    (top contenedor10 pila6)

    ; Control de tallas
    (next altura0 altura1)
    (next altura1 altura2)
    (next altura2 altura3)

    ; Gruas y carriles de cinta libres
    (libre grua1)
    (libre grua2)
    (libre cinta1)
    (libre cinta2)

    ; Altura actual de cada pila contando sus contenedores
    (altura pila1 altura1)
    (altura pila2 altura0)
    (altura pila3 altura1)
    (altura pila4 altura3)
    (altura pila5 altura2)
    (altura pila6 altura3)

    ; Contendores disponibles
    (disponible contenedor1)
    (disponible contenedor3)
    (disponible contenedor2)
    (disponible contenedor7)
    (disponible contenedor10)
    ; ya que es un verde sobre un verde
    (disponible contenedor4)
    (disponible contenedor8)

    ; Contenedores verdes
    
    (verde contenedor4)
    (verde contenedor5)
    (verde contenedor9)
    (verde contenedor8)

    ; Contenedores no verdes
    (no-verde contenedor1)
    (no-verde contenedor2)
    (no-verde contenedor3)
    (no-verde contenedor6)
    (no-verde contenedor7)

    ; Hay que marcar que las pilas son no verdes
    (no-verde pila1)
    (no-verde pila2)
    (no-verde pila3)
    (no-verde pila4)
    (no-verde pila5)
    (no-verde pila6)

    ; Hay que ubicar una pila en si misma para poder dejar contenedores en pilas vacias
    (ubicado-en pila1 pila1)
    (ubicado-en pila2 pila2)
    (ubicado-en pila3 pila3)
    (ubicado-en pila5 pila5)
    (ubicado-en pila6 pila6)
    (ubicado-en pila4 pila4)

    ; Alt max de pila por muelle
    ; La alt max en muelle1 es 1
    (no-altura-max altura0 muelle1)
    (no-altura-max altura1 muelle1)
    ;(no-altura-max altura2 muelle1)
    ;(no-altura-max altura3 muelle1)

    ; La alt max en muelle2 es 3
    (no-altura-max altura0 muelle2)
    (no-altura-max altura1 muelle2)
    (no-altura-max altura2 muelle2)
    (no-altura-max altura3 muelle2)

)

(:goal (and

    (ubicado-en contenedor9 muelle1)
    (disponible contenedor9)

    (ubicado-en contenedor5 muelle1)
    (disponible contenedor5)

    (ubicado-en contenedor4 muelle1)
    (disponible contenedor4)

))

)