;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Ejercicio 2 de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain puerto)

(:requirements :strips :typing :fluents :durative-actions )

(:types 
    grua
    contenedorObjetivo
    contenedor
    pila
    cinta
    muelle
    altura
    -object
)


(:predicates 
    (verde ?c - contenedor)
    (no-verde ?x - (either pila contenedor))
    (libre ?x - (either cinta grua))
    (encima ?c - contenedor ?x - (either pila contenedor))
    (ubicado-en ?x1 - (either grua pila contenedor) ?x2 - (either cinta muelle grua pila))
    (disponible ?x - (either pila contenedor))
    (top ?x - (either pila contenedor) ?pila2 - pila)
    (conecta_a ?ct - cinta ?m_o - muelle ?m_d - muelle)
    (next ?a1 - altura ?a2 - altura)
    (altura ?p - pila ?t - altura)
    
    (inicio-cinta ?c - contenedor ?t - cinta) 
    (final-cinta ?c - contenedor ?t - cinta)  
    
)

(:functions 
    (peso ?c1 - contenedor)
    (altura_pila_temporal ?a1 - altura)
    (tiempo_transporte)
)

(:durative-action coger
    :parameters (?g - grua ?p - pila ?c1 - contenedor ?c2 -(either contenedor pila) ?m - muelle  ?altura_origen - altura ?altura_destino  - altura )
    :duration (= ?duration (/ (peso ?c1) (altura_pila_temporal ?altura_origen)))
    :condition (and
                     
        (at start (libre ?g))  
        (over all (ubicado-en ?g ?m )) 
        (over all (ubicado-en ?p ?m)) 
        (at start (ubicado-en ?c1 ?p)) 
        (at start (ubicado-en ?c2 ?p)) 
        (at start (top ?c1 ?p)) 
        (at start (encima ?c1 ?c2)) 
        (at start (disponible ?c1))
        (at start (altura ?p ?altura_origen)) 
        (at start (next ?altura_destino ?altura_origen)) 
                )
    :effect (and
        (at end (not (libre ?g))) 
        (at end (ubicado-en ?c1 ?g)) 
        (at end (not (ubicado-en ?c1 ?p))) 
        (at end (not (top ?c1 ?p))) 
        (at end (not (encima ?c1 ?c2))) 
        (at end (not (disponible ?c1))) 
        (at end (disponible ?c2)) 
        (at end (top ?c2 ?p))
        (at end (not (altura ?p ?altura_origen))) 
        (at end (altura ?p ?altura_destino)) 
     )
)

(:durative-action dejar-blanco-pila
    :parameters (?g - grua ?p - pila ?c1 -contenedor ?c2 - (either contenedor pila) ?m - muelle ?altura_origen -altura ?altura_destino  -altura)
    :duration (= ?duration (/ (peso ?c1) (altura_pila_temporal ?altura_destino)))
    :condition (and
        (over all (ubicado-en ?g ?m)) 
        (over all (ubicado-en ?p ?m))
        (at start (ubicado-en ?c1 ?g)) 
        (over all (ubicado-en ?c2 ?p))
        (at start (top ?c2 ?p))
        (over all (no-verde ?c2)) 
        (at start (altura ?p ?altura_origen)) 
        (over all (next ?altura_origen ?altura_destino)) 
     )
    :effect (and
        (at end (libre ?g)) 
        (at end (ubicado-en ?c1 ?p)) 
        (at end (not (ubicado-en ?c1 ?g))) 
        (at end (encima ?c1 ?c2)) 
        (at end (top ?c1 ?p)) 
        (at end (not (top ?c2 ?p))) 
        (at end (altura ?p ?altura_destino)) 
        (at end (not (altura ?p ?altura_origen))) 
        (at end (disponible ?c1)) 
        (at end (not (disponible ?c2))) 
     )
)


(:durative-action dejar-verde-verde
    :parameters (?g - grua ?p - pila ?c1 -contenedor ?c2 - contenedor ?m - muelle ?altura_origen -altura ?altura_destino  -altura)
    :duration (= ?duration (/ (peso ?c1) (altura_pila_temporal ?altura_destino)))
    :condition (and
        (over all (ubicado-en ?g ?m)) 
        (over all (ubicado-en ?p ?m))
        (at start (ubicado-en ?c1 ?g)) 
        (over all (ubicado-en ?c2 ?p))
        (at start (top ?c2 ?p))
        (over all (verde ?c1))
        (over all (verde ?c2)) 
        (at start (altura ?p ?altura_origen)) 
        (over all (next ?altura_origen ?altura_destino)) 
         
     )
    :effect (and
        (at end (libre ?g)) 
        (at end (ubicado-en ?c1 ?p)) 
        (at end (not (ubicado-en ?c1 ?g))) 
        (at end (encima ?c1 ?c2)) 
        (at end (top ?c1 ?p)) 
        (at end (not (top ?c2 ?p))) 
        (at end (altura ?p ?altura_destino))
        (at end (not (altura ?p ?altura_origen))) 
        (at end (disponible ?c1)) 
        
     )
)

(:durative-action coger-cinta
    :parameters (?c - contenedor ?g - grua ?muelle_origen - muelle ?muelle_destino - muelle ?t - cinta)
    :duration (= ?duration (peso ?c))
    :condition (and
        (at start (libre ?g))
        (over all (ubicado-en ?g ?muelle_destino))
        (over all (conecta_a ?t ?muelle_origen ?muelle_destino ))
        (at start (ubicado-en ?c ?t)) 
        (at start (final-cinta ?c ?t)) 
     )
    :effect (and 
        (at end (libre ?t))
        (at end (ubicado-en ?c ?g))
        (at end (not (ubicado-en ?c ?t))) 
        (at end (not (libre ?g))) 
        (at end (ubicado-en ?c ?muelle_destino)) 
        (at end (not (final-cinta ?c ?t)))
    )
)

(:durative-action dejar-cinta
    :parameters (?c -contenedor ?g - grua ?muelle_origen - muelle ?muelle_destino - muelle ?t - cinta)
    :duration (= ?duration (peso ?c))
    :condition (and
        (at end (libre ?t)) 
        (over all (conecta_a ?t ?muelle_origen ?muelle_destino))
        (over all (ubicado-en ?g ?muelle_origen)) 
        (at start (ubicado-en ?c ?g)) 
        (at start (ubicado-en ?c ?muelle_origen)) 
     )
    :effect (and 
        (at end (libre ?g)) 
        (at end (not (ubicado-en ?c ?g))) 
        (at end (ubicado-en ?c ?t)) 
        (at end (not (libre ?t))) 
        (at end (not (ubicado-en ?c ?muelle_origen)))
        (at end (inicio-cinta  ?c ?t)) 
    )
)

(:durative-action mover
    :parameters (?c - contenedor ?muelle_origen - muelle ?muelle_destino - muelle ?t - cinta)
    :duration (= ?duration (tiempo_transporte))
    :condition (and
        (at start (inicio-cinta  ?c ?t)) 
        (over all (ubicado-en ?c ?t)) 
        (over all (conecta_a ?t ?muelle_origen ?muelle_destino)) 
     )
    :effect (and 
        (at end (final-cinta ?c ?t)) 
        (at end (not (inicio-cinta  ?c ?t))) 
    )
)

)



