;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Ejercicio 1 de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain puerto)
  (:requirements :strips :typing)
  (:types cinta muelle grua pila talla contenedor -object)
  (:predicates 
		; Indica si un contenedor es verde
		(verde ?c - contenedor)

		; Indica si un contenedor es blanco (no verde)
		(no_verde ?x - (either pila contenedor))

		; Indica si una cinta o grua estan libres, es decir, sin contenedor
		(libre ?x - (either cinta grua))

		; Indica que contenedor1 esta sobre contenedor2, o en caso de no tener contenedor
		; abajo tiene la pila
		(encima ?c - contenedor ?x - (either pila contenedor))

		; Indica si una grua, pila o contenedor se encuentra en una cinta, muelle, grua o pila
		(ubicado_en ?x1 - (either grua pila contenedor) ?x2 - (either cinta muelle grua pila))

		; Indica cuando un contenedor puede ser cogido por la grua. Se permite el tipo pila
		; porque cuando se deja un contenedor en una pila hay que poner como no disponible
		; el contenedor que queda abajo, pero en caso de estar la pila vacia se necesita que
		; este predicado acepte el tipo pila
		(disponible ?x - (either pila contenedor))

		; Indica el contenedor que es el top de la pila, en caso de estar vacia la pila, la
		; pila es el top de la propia pila
		(top ?x - (either pila contenedor) ?p2 - pila)

		; La cinta conecta muelle origen con muelle destino
		(conecta_a ?ct - cinta ?m_o - muelle ?m_d - muelle)

		; Este predica se utiliza para controlar la altura maxima de las pilas
		(next ?t1 - talla ?t2 - talla)

		; Indica la altura actual de la pila
		(altura ?p - pila ?t - talla)

		; Indica que tallas no son la alt. maxima de las pilas por muelle.
		(no_es_alt_max ?t - talla ?m - muelle)
  )

  (:action grua-coger-pila
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor - contenedor
			?objeto_base - (either pila contenedor)
			?talla_pila - talla
			?talla_anterior - talla
		)
		:precondition (
			and
			(libre ?grua)
			(ubicado_en ?grua ?muelle)
			(ubicado_en ?pila ?muelle)
			(ubicado_en ?contenedor ?pila)
			(ubicado_en ?objeto_base ?pila)
			(top ?contenedor ?pila)
			(encima ?contenedor ?objeto_base)
			(disponible ?contenedor)
			(altura ?pila ?talla_pila)
			(next ?talla_anterior ?talla_pila)
		)
		:effect(
			and
			(not (libre ?grua))
			(ubicado_en ?contenedor ?grua)
			(not (ubicado_en ?contenedor ?pila))
			(not (top ?contenedor ?pila))
			(not (encima ?contenedor ?objeto_base))
			(not (disponible ?contenedor))
			(disponible ?objeto_base)
			(top ?objeto_base ?pila)
			(not (altura ?pila ?talla_pila))
			(altura ?pila ?talla_anterior)
		)
  )

  (:action grua-dejar-blanco-pila
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor - contenedor
			?objeto_base - (either pila contenedor)
			?talla_pila - talla
			?talla_anterior - talla
		)
		:precondition(
			and
			(ubicado_en ?grua ?muelle)
			(ubicado_en ?pila ?muelle)
			(ubicado_en ?contenedor ?grua)
			(ubicado_en ?objeto_base ?pila)
			(top ?objeto_base ?pila)
			(no_verde ?objeto_base)
			(altura ?pila ?talla_pila)
			(next ?talla_pila ?talla_anterior)
			(no_es_alt_max ?talla_anterior ?muelle)
		)
		:effect(
			and
			(libre ?grua)
			(ubicado_en ?contenedor ?pila)
			(not (ubicado_en ?contenedor ?grua))
			(encima ?contenedor ?objeto_base)
			(top ?contenedor ?pila)
			(not (top ?objeto_base ?pila))
			(altura ?pila ?talla_anterior)
			(not (altura ?pila ?talla_pila))
			(disponible ?contenedor)
			(not (disponible ?objeto_base))
		)
  )

  (:action grua-dejar-verde-verde
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor_grua - contenedor
			?contenedor_pila - contenedor
			?talla_pila - talla
			?talla_anterior - talla
		)
		:precondition(
			and
			(ubicado_en ?grua ?muelle)
			(ubicado_en ?pila ?muelle)
			(ubicado_en ?contenedor_grua ?grua)
			(ubicado_en ?contenedor_pila ?pila)
			(top ?contenedor_pila ?pila)
			(verde ?contenedor_grua)
			(verde ?contenedor_pila)
			(altura ?pila ?talla_pila)
			(next ?talla_pila ?talla_anterior)
			(no_es_alt_max ?talla_anterior ?muelle)
		)
		:effect(
			and
			(libre ?grua)
			(ubicado_en ?contenedor_grua ?pila)
			(not (ubicado_en ?contenedor_grua ?grua))
			(encima ?contenedor_grua ?contenedor_pila)
			(top ?contenedor_grua ?pila)
			(not (top ?contenedor_pila ?pila))
			(altura ?pila ?talla_anterior)
			(not (altura ?pila ?talla_pila))
			(disponible ?contenedor_grua)
		)
  )

  (:action grua-coger-cinta
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
			(ubicado_en ?grua ?muelle_destino)
			(conecta_a ?cinta ?muelle_origen ?muelle_destino)
			(ubicado_en ?contenedor ?cinta)
		)
		:effect(
			and
			(libre ?cinta)
			(ubicado_en ?contenedor ?grua)
			(not (ubicado_en ?contenedor ?cinta))
			(not (libre ?grua))
			(ubicado_en ?contenedor ?muelle_destino)
		)
  )

  (:action grua-dejar-cinta
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
			(conecta_a ?cinta ?muelle_origen ?muelle_destino)
			(ubicado_en ?grua ?muelle_origen)
			(ubicado_en ?contenedor ?grua)
			(ubicado_en ?contenedor ?muelle_origen)
		)
		:effect(
			and
			(libre ?grua)
			(not (ubicado_en ?contenedor ?grua))
			(ubicado_en ?contenedor ?cinta)
			(not (libre ?cinta))
			(not (ubicado_en ?contenedor ?muelle_origen))
		)
  )
)



 