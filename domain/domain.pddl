;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Ejercicio 1 de Daniel P. y Alejandro G.
;;;; COPIA DE SEGURIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain puerto)
  (:requirements :strips :typing)
  (:types cinta muelle grua pila talla contenedor -object)
  (:predicates 
  			   (verde ?c - contenedor); Indica si un contenedor es verde
			   (no_verde ?x - (either pila contenedor)); Indica si un contenedor es blanco (no verde)
			   (libre ?x - (either cinta grua)); Indica si una cinta o grua estan libres, es decir, sin contenedor
			   (encima ?c - contenedor ?x - (either pila contenedor)); Indica que contenedor1 esta sobre contenedor2, o en caso de no tener contenedor abajo tiene la pila
			   (ubicado_en ?x1 - (either grua pila contenedor) ?x2 - (either cinta muelle grua pila)); Indica si una grua, pila o contenedor se encuentra en una cinta, muelle, grua o pila
               (disponible ?x - (either pila contenedor)); Indica cuando un contenedor puede ser cogido por la grua. Se permite el tipo pila porque cuando se deja un contenedor en una pila hay que poner como no disponible el contenedor que queda abajo, pero en caso de estar la pila vacia se necesita que este predicado acepte el tipo pila
			   (top ?x - (either pila contenedor) ?p2 - pila); Indica el contenedor que es el top de la pila, en caso de estar vacia la pila, la pila es el top de la propia pila
			   (conecta_a ?ct - cinta ?m_o - muelle ?m_d - muelle); La cinta conecta muelle origen con muelle destino
			   (next ?t1 - talla ?t2 - talla); Este predica se utiliza para controlar la altura maxima de las pilas
			   (altura ?p - pila ?t - talla); Indica la altura actual de la pila
			   (no_es_alt_max ?t - talla ?m - muelle); Indica que tallas no son la alt. maxima de las pilas por muelle.
  )

  (:action grua-coger
		:parameters (?muelle - muelle ?grua - grua ?pila - pila ?contenedor1 - contenedor ?contenedor2 - (either pila contenedor) ?talla_o - talla ?talla_d - talla)
		:precondition (
			and
			(libre ?grua)
			(ubicado_en ?grua ?muelle)
			(ubicado_en ?pila ?muelle)
			(ubicado_en ?contenedor1 ?muelle)
			(ubicado_en ?contenedor2 ?muelle)	
			(ubicado_en ?contenedor1 ?pila)
			(ubicado_en ?contenedor2 ?pila)
			(top ?contenedor1 ?pila)
			(encima ?contenedor1 ?contenedor2)
			(disponible ?contenedor1)
			(altura ?pila ?talla_o)
			(next ?talla_d ?talla_o)
		)
		:effect(
			and
			(not (libre ?grua))
			(ubicado_en ?contenedor1 ?grua)
			(not (ubicado_en ?contenedor1 ?pila))
			(not (top ?contenedor1 ?pila))
			(not (encima ?contenedor1 ?contenedor2))
			(not (disponible ?contenedor1))
			(disponible ?contenedor2)
			(top ?contenedor2 ?pila)
			(not (altura ?pila ?talla_o))
			(altura ?pila ?talla_d)
		)
  )

  (:action dejar-cualquiera-sobre-blanco-o-pila-vacia
		:parameters (?muelle - muelle ?grua - grua ?pila - pila ?contenedor1 - contenedor ?contenedor2 - (either pila contenedor) ?talla_o - talla ?talla_d - talla)
		:precondition(
			and
			(ubicado_en ?grua ?muelle)
			(ubicado_en ?pila ?muelle)
			(ubicado_en ?contenedor1 ?muelle)
			(ubicado_en ?contenedor2 ?muelle)
			(ubicado_en ?contenedor1 ?grua)
			(ubicado_en ?contenedor2 ?pila)
			(top ?contenedor2 ?pila)
			(no_verde ?contenedor2)
			(altura ?pila ?talla_o)
			(next ?talla_o ?talla_d)
			(no_es_alt_max ?talla_d ?muelle)
		)
		:effect(
			and
			(libre ?grua)
			(ubicado_en ?contenedor1 ?pila)
			(not (ubicado_en ?contenedor1 ?grua))
			(encima ?contenedor1 ?contenedor2)
			(top ?contenedor1 ?pila)
			(not (top ?contenedor2 ?pila))
			(altura ?pila ?talla_d)
			(not (altura ?pila ?talla_o))
			(disponible ?contenedor1)
			(not (disponible ?contenedor2))
		)
  )

  (:action dejar-verde-sobre-verde
		:parameters (?muelle - muelle ?grua - grua ?pila - pila ?contenedor1 - contenedor ?contenedor2 - contenedor ?talla_o - talla ?talla_d - talla)
		:precondition(
			and
			(ubicado_en ?grua ?muelle)
			(ubicado_en ?pila ?muelle)
			(ubicado_en ?contenedor1 ?muelle)
			(ubicado_en ?contenedor2 ?muelle)
			(ubicado_en ?contenedor1 ?grua)
			(ubicado_en ?contenedor2 ?pila)
			(top ?contenedor2 ?pila)
			(verde ?contenedor1)
			(verde ?contenedor2)
			(altura ?pila ?talla_o)
			(next ?talla_o ?talla_d)
			(no_es_alt_max ?talla_d ?muelle)
		)
		:effect(
			and
			(libre ?grua)
			(ubicado_en ?contenedor1 ?pila)
			(not (ubicado_en ?contenedor1 ?grua))
			(encima ?contenedor1 ?contenedor2)
			(top ?contenedor1 ?pila)
			(not (top ?contenedor2 ?pila))
			(altura ?pila ?talla_d)
			(not (altura ?pila ?talla_o))
			(disponible ?contenedor1)
		)
  )

  (:action dejar-contenedor-en-cinta
	    :parameters (?cinta - cinta ?muelle_o - muelle ?muelle_d - muelle ?grua - grua ?contenedor - contenedor)
		:precondition(
			and
			(libre ?cinta)
			(conecta_a ?cinta ?muelle_o ?muelle_d)
			(ubicado_en ?grua ?muelle_o)
			(ubicado_en ?contenedor ?grua)

			(ubicado_en ?contenedor ?muelle_o)
		)
		:effect(
			and
			(libre ?grua)
			(not (ubicado_en ?contenedor ?grua))
			(ubicado_en ?contenedor ?cinta)
			(not (libre ?cinta))

			(not (ubicado_en ?contenedor ?muelle_o))
		)
  )

  (:action coger-contenedor-de-cinta
	    :parameters (?cinta - cinta ?muelle_o - muelle ?muelle_d - muelle ?grua - grua ?contenedor - contenedor)
		:precondition(
			and
			(libre ?grua)
			(ubicado_en ?grua ?muelle_d)
			(conecta_a ?cinta ?muelle_o ?muelle_d)
			(ubicado_en ?contenedor ?cinta)
		)
		:effect(
			and
			(libre ?cinta)
			(ubicado_en ?contenedor ?grua)
			(not (ubicado_en ?contenedor ?cinta))
			(not (libre ?grua))

			(ubicado_en ?contenedor ?muelle_d)
		)
  )

)



 