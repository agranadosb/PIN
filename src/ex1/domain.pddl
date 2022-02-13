;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Ejercicio 1 de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain puerto)
  (:requirements :strips :typing)
  (:types cinta muelle grua pila altura contenedor - object)
  (:predicates 
		; Indica si un contenedor es verde
		(verde ?c - contenedor)

		; Indica si un contenedor es blanco (no verde)
		(no-verde ?x - (either pila contenedor))

		; Indica si una cinta o grua estan libres, es decir, sin contenedor
		(libre ?x - (either cinta grua))

		; Indica que contenedor1 esta sobre contenedor2, o en caso de no tener contenedor
		; abajo tiene la pila
		(encima ?c - contenedor ?x - (either pila contenedor))

		; Indica si una grua, pila o contenedor se encuentra en una cinta, muelle, grua o pila
		(ubicado-en ?x1 - (either grua pila contenedor) ?x2 - (either cinta muelle grua pila))

		; Indica cuando un contenedor puede ser cogido por la grua. Se permite el tipo pila
		; porque cuando se deja un contenedor en una pila hay que poner como no disponible
		; el contenedor que queda abajo, pero en caso de estar la pila vacia se necesita que
		; este predicado acepte el tipo pila
		(disponible ?x - (either pila contenedor))

		; Indica el contenedor que es el top de la pila, en caso de estar vacia la pila, la
		; pila es el top de la propia pila
		(top ?x - (either pila contenedor) ?pila2 - pila)

		; La cinta conecta muelle origen con muelle destino
		(conecta-a ?ct - cinta ?m_o - muelle ?m_d - muelle)

		; Este predica se utiliza para controlar la altura maxima de las pilas
		(next ?a1 - altura ?a2 - altura)

		; Indica la altura actual de la pila
		(altura ?p - pila ?t - altura)

  )

  (:action coger-pila
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor - contenedor
			?altura_pila - altura
			?objeto_base - (either pila contenedor)
			?altura_anterior - altura
		)
		:precondition (
			and
			(libre ?grua)
			(ubicado-en ?grua ?muelle)
			(ubicado-en ?pila ?muelle)
			(ubicado-en ?contenedor ?pila)
			(ubicado-en ?objeto_base ?pila)
			(top ?contenedor ?pila)
			(encima ?contenedor ?objeto_base)
			(disponible ?contenedor)
			(altura ?pila ?altura_pila)
			(next ?altura_anterior ?altura_pila)
		)
		:effect(
			and
			(not (libre ?grua))
			(ubicado-en ?contenedor ?grua)
			(not (ubicado-en ?contenedor ?pila))
			(not (top ?contenedor ?pila))
			(not (encima ?contenedor ?objeto_base))
			(not (disponible ?contenedor))
			(disponible ?objeto_base)
			(top ?objeto_base ?pila)
			(not (altura ?pila ?altura_pila))
			(altura ?pila ?altura_anterior)
		)
  )

  (:action dejar-blanco-pila
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor - contenedor
			?altura_pila - altura
			?objeto_base - (either pila contenedor)
			?altura_posterior - altura
		)
		:precondition(
			and
			(ubicado-en ?grua ?muelle)
			(ubicado-en ?pila ?muelle)
			(ubicado-en ?contenedor ?grua)
			(ubicado-en ?objeto_base ?pila)
			(top ?objeto_base ?pila)
			(no-verde ?objeto_base)
			(altura ?pila ?altura_pila)
			(next ?altura_pila ?altura_posterior)
		)
		:effect(
			and
			(libre ?grua)
			(ubicado-en ?contenedor ?pila)
			(not (ubicado-en ?contenedor ?grua))
			(encima ?contenedor ?objeto_base)
			(top ?contenedor ?pila)
			(not (top ?objeto_base ?pila))
			(altura ?pila ?altura_posterior)
			(not (altura ?pila ?altura_pila))
			(disponible ?contenedor)
			(not (disponible ?objeto_base))
		)
  )

  (:action dejar-verde-verde
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor_grua - contenedor
			?altura_pila - altura
			?contenedor_pila - contenedor
			?altura_posterior - altura
		)
		:precondition(
			and
			(ubicado-en ?grua ?muelle)
			(ubicado-en ?pila ?muelle)
			(ubicado-en ?contenedor_grua ?grua)
			(ubicado-en ?contenedor_pila ?pila)
			(top ?contenedor_pila ?pila)
			(verde ?contenedor_grua)
			(verde ?contenedor_pila)
			(altura ?pila ?altura_pila)
			(next ?altura_pila ?altura_posterior)
		)
		:effect(
			and
			(libre ?grua)
			(ubicado-en ?contenedor_grua ?pila)
			(not (ubicado-en ?contenedor_grua ?grua))
			(encima ?contenedor_grua ?contenedor_pila)
			(top ?contenedor_grua ?pila)
			(not (top ?contenedor_pila ?pila))
			(altura ?pila ?altura_posterior)
			(not (altura ?pila ?altura_pila))
			(disponible ?contenedor_grua)
		)
  )

  (:action coger-cinta
	    :parameters (
	    	?cinta - cinta
	    	?muelle_origen - muelle
	    	?muelle_destino - muelle
	    	?grua - grua
	    	?contenedor - contenedor
	    )
		:precondition(
			and
			(libre ?grua)
			(ubicado-en ?grua ?muelle_destino)
			(conecta-a ?cinta ?muelle_origen ?muelle_destino)
			(ubicado-en ?contenedor ?cinta)
		)
		:effect(
			and
			(libre ?cinta)
			(ubicado-en ?contenedor ?grua)
			(not (ubicado-en ?contenedor ?cinta))
			(not (libre ?grua))
			(ubicado-en ?contenedor ?muelle_destino)
		)
  )

  (:action dejar-cinta
	    :parameters (
	    	?cinta - cinta
	    	?muelle_origen - muelle
	    	?muelle_destino - muelle
	    	?grua - grua
	    	?contenedor - contenedor
	    )
		:precondition(
			and
			(libre ?cinta)
			(conecta-a ?cinta ?muelle_origen ?muelle_destino)
			(ubicado-en ?grua ?muelle_origen)
			(ubicado-en ?contenedor ?grua)
			(ubicado-en ?contenedor ?muelle_origen)
		)
		:effect(
			and
			(libre ?grua)
			(not (ubicado-en ?contenedor ?grua))
			(ubicado-en ?contenedor ?cinta)
			(not (libre ?cinta))
			(not (ubicado-en ?contenedor ?muelle_origen))
		)
  )
)



 