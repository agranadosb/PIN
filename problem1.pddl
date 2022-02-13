; ./planners/optic-clp ./Ej2/dominio.pddl ./Ej2/problema.pddl

(define (problem problem1) (:domain puerto)
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
    contenedor11 - contenedor

    altura0 - altura
    altura1 - altura
    altura2 - altura
    altura3 - altura
)
;etiqueta verde (predicado)TODO 

(:init
 
    ; Muelle donde se encuentra cada contenedor
    (ubicado-en contenedor1 muelle1)
    (ubicado-en contenedor7 muelle1)
    (ubicado-en contenedor9 muelle1)
    (ubicado-en contenedor10 muelle1)
    (ubicado-en contenedor11 muelle1)

    (ubicado-en contenedor8 muelle2)
    (ubicado-en contenedor4 muelle2)
    (ubicado-en contenedor3 muelle2)
    (ubicado-en contenedor2 muelle2)
    (ubicado-en contenedor5 muelle2)
    (ubicado-en contenedor6 muelle2)

    ; Contenedores en sus pilas
    (ubicado-en contenedor1 pila1)
    (ubicado-en contenedor7 pila1)
    (ubicado-en contenedor9 pila2)
    (ubicado-en contenedor10 pila2)
    (ubicado-en contenedor11 pila3)

    (ubicado-en contenedor4 pila4)
    (ubicado-en contenedor8 pila4)
    (ubicado-en contenedor5 pila5)
    (ubicado-en contenedor3 pila5)
    (ubicado-en contenedor2 pila5)
    (ubicado-en contenedor6 pila6)

    ; Pilas en sus muelles
    (ubicado-en pila1 muelle1)
    (ubicado-en pila2 muelle1)
    (ubicado-en pila3 muelle1)

    (ubicado-en pila4 muelle2)
    (ubicado-en pila5 muelle2)
    (ubicado-en pila6 muelle2)

    ; Orden de los contenedores en cada pila
    (encima contenedor7 contenedor1)
    (encima contenedor1 pila1)

    (encima contenedor10 contenedor9)
    (encima contenedor9 pila2)

    (encima contenedor11 pila3)

    (encima contenedor8 contenedor4)
    (encima contenedor4 pila4)

    (encima contenedor2 contenedor3)
    (encima contenedor3 contenedor5)
    (encima contenedor5 pila5)

    (encima  contenedor6 pila6)

    ; Gruas en sus muelles
    (ubicado-en grua1 muelle1)
    (ubicado-en grua2 muelle2)

    ; Conexion carriles de cinta
    (conecta_a cinta1 muelle1 muelle2)
    (conecta_a cinta2 muelle2 muelle1)

    ; Tops de las pilas
    (top contenedor7 pila1)
    (top contenedor10 pila2)
    (top contenedor11 pila3)
    (top contenedor8 pila4)
    (top contenedor2 pila5 )
    (top contenedor6 pila6)

    ; Control de alturas
    (next altura0 altura1)
    (next altura1 altura2)
    (next altura2 altura3)

    ; Gruas y carriles de cinta libres
    (libre grua1)
    (libre grua2)
    (libre cinta1)
    (libre cinta2)

    ; Altura actual de cada pila contando sus contenedores
    (altura pila1 altura2)
    (altura pila2 altura2)
    (altura pila3 altura1)
    (altura pila4 altura2)
    (altura pila5 altura3)
    (altura pila6 altura1)

    ; Contendores disponibles
    (disponible contenedor7)
    (disponible contenedor10)
    (disponible contenedor11)
    (disponible contenedor8)
    (disponible contenedor2)
    (disponible contenedor6)

    ; Contenedores verdes
    (verde contenedor3)
    (verde contenedor4)
    (verde contenedor7)

    ; Contenedores no verdes
    (no-verde contenedor1)
    (no-verde contenedor2)
    (no-verde contenedor5)
    (no-verde contenedor6)
    (no-verde contenedor8)
    (no-verde contenedor9)
    (no-verde contenedor10)
    (no-verde contenedor11)

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

    ;pesos de contenedor
    (= (peso contenedor1) 5)
    (= (peso contenedor2) 2)
    (= (peso contenedor3) 3)
    (= (peso contenedor4) 6)
    (= (peso contenedor5) 5)
    (= (peso contenedor6) 5)
    (= (peso contenedor7) 5)
    (= (peso contenedor8) 5)
    (= (peso contenedor9) 10)
    (= (peso contenedor10) 8)
    (= (peso contenedor11) 5)

    ; pilas ubiscadas en si mismas
    (ubicado-en pila1 pila1)
    (ubicado-en pila2 pila2)
    (ubicado-en pila3 pila3)
    (ubicado-en pila4 pila4)
    (ubicado-en pila5 pila5)
    (ubicado-en pila6 pila6)

    ;alturas pilas
    (= (altura_pila_temporal altura0) 0)
    (= (altura_pila_temporal altura1) 1)
    (= (altura_pila_temporal altura2) 2)
    (= (altura_pila_temporal altura3) 3)

    ;tiempo de transportar un contenedor en la cinta
    (= (tiempo_transporte) 10)

)

(:goal (and
    (ubicado-en contenedor3 muelle1)
    (ubicado-en contenedor4 muelle1)
    (ubicado-en contenedor7 muelle1)

    (disponible contenedor3)
    (disponible contenedor4)
    (disponible contenedor7)
))

;metrica a minimizar
(:metric minimize (total-time))
)
