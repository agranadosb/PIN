;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PUERTO Ejercicio 1 de Daniel P. y Alejandro G.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain puerto)
	(:requirements :strips :typing :fluents :durative-actions)
	(:types cinta muelle grua pila altura contenedor - object)
	(:predicates 
		(verde ?c - contenedor)
		(no-verde ?x - (either pila contenedor))
		(libre ?x - (either cinta grua))
		(encima ?c - contenedor ?x - (either pila contenedor))
		(ubicado-en ?x1 - (either grua pila contenedor) ?x2 - (either cinta muelle grua pila))
		(disponible ?x - (either pila contenedor))
		(top ?x - (either pila contenedor) ?pila2 - pila)
		(conecta-a ?ct - cinta ?m_o - muelle ?m_d - muelle)
	)
	(:functions
		(altura ?p - (either pila cinta grua))
		(altura-maxima ?muelle - muelle)
		(peso ?contenedor - contenedor)
		(longitud ?cinta - cinta)
		(velocidad ?cinta - cinta)
	)

	(:durative-action coger-pila
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor - contenedor
			?objeto_base - (either pila contenedor)
		)
		:duration (= ?duration (* (peso ?contenedor) (- (altura ?grua) (altura ?pila))))
		:condition (
			and
			(at start (libre ?grua))
			(at start (disponible ?contenedor))
			(over all (ubicado-en ?grua ?muelle))
			(over all (ubicado-en ?pila ?muelle))
			(over all (ubicado-en ?contenedor ?pila))
			(over all (ubicado-en ?objeto_base ?pila))
			; Se considera que el contenedor será top de la pila hasta que esté subido en la grúa
			; porque ningnua grúa podrá poner ni quitar elementos de la pila (o cinta) mientras
			; una grúa esté intractuando con el objeto base
			(over all (top ?contenedor ?pila))
			(over all (encima ?contenedor ?objeto_base))
		)
		:effect(
			and
			(at start (not (libre ?grua)))
			(at end (ubicado-en ?contenedor ?grua))
			(at end (not (ubicado-en ?contenedor ?pila)))
			(at end (not (top ?contenedor ?pila)))
			(at end (not (encima ?contenedor ?objeto_base)))
			(at start (not (disponible ?contenedor)))
			(at end (disponible ?objeto_base))
			(at end (top ?objeto_base ?pila))
			(at end (decrease (altura ?pila) 1))
		)
	)

	(:durative-action dejar-blanco-pila
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor - contenedor
			?objeto_base - (either pila contenedor)
		)
		:duration (= ?duration (* (peso ?contenedor) (- (altura ?grua) (altura ?pila))))
		:condition(
			and
			(over all (ubicado-en ?grua ?muelle))
			(over all (ubicado-en ?pila ?muelle))
			(over all (ubicado-en ?contenedor ?grua))
			(over all (ubicado-en ?objeto_base ?pila))
			(over all (top ?objeto_base ?pila))
			(over all (no-verde ?objeto_base))
			(over all (< (altura ?pila) (altura-maxima ?muelle)))
		)
		:effect(
			and
			(at end (libre ?grua))
			(at end (not (ubicado-en ?contenedor ?grua)))
			(at end (ubicado-en ?contenedor ?pila))
			(at end (encima ?contenedor ?objeto_base))
			(at end (not (top ?objeto_base ?pila)))
			(at end (top ?contenedor ?pila))
			(at end (disponible ?contenedor))
			(at end (not (disponible ?objeto_base)))
			(at end (increase (altura ?pila) 1))
		)
	)

	(:durative-action dejar-verde-verde
		:parameters (
			?muelle - muelle
			?grua - grua
			?pila - pila
			?contenedor_grua - contenedor
			?contenedor_pila - contenedor
		)
		:duration (= ?duration (* (peso ?contenedor_grua) (- (altura ?grua) (altura ?pila))))
		:condition(
			and
			(over all (ubicado-en ?grua ?muelle))
			(over all (ubicado-en ?pila ?muelle))
			(over all (ubicado-en ?contenedor_grua ?grua))
			(over all (ubicado-en ?contenedor_pila ?pila))
			(over all (top ?contenedor_pila ?pila))
			(over all (verde ?contenedor_grua))
			(over all (verde ?contenedor_pila))
			(over all (< (altura ?pila) (altura-maxima ?muelle)))
		)
		:effect(
			and
			(at end (libre ?grua))
			(at end (ubicado-en ?contenedor_grua ?pila))
			(at end (not (ubicado-en ?contenedor_grua ?grua)))
			(at end (encima ?contenedor_grua ?contenedor_pila))
			(at end (top ?contenedor_grua ?pila))
			(at end (not (top ?contenedor_pila ?pila)))
			(at end (increase (altura ?pila) 1))
			(at end (disponible ?contenedor_grua))
		)
	)

	(:durative-action coger-cinta
		:parameters (
			?cinta - cinta
			?muelle_origen - muelle
			?muelle_destino - muelle
			?grua - grua
			?contenedor - contenedor
		)
		:duration (= ?duration (* (peso ?contenedor) (- (altura ?grua) (altura ?cinta))))
		:condition(
			and
			(at start (libre ?grua))
			(over all (ubicado-en ?grua ?muelle_destino))
			(over all (conecta-a ?cinta ?muelle_origen ?muelle_destino))
			(over all (ubicado-en ?contenedor ?muelle_destino))
			(over all (ubicado-en ?contenedor ?cinta))
		)
		:effect(
			and
			(at end (libre ?cinta))
			(at end (not (ubicado-en ?contenedor ?cinta)))
			(at end (ubicado-en ?contenedor ?grua))
			(at start (not (libre ?grua)))
		)
	)

	(:durative-action dejar-cinta
		:parameters (
			?cinta - cinta
			?muelle_origen - muelle
			?muelle_destino - muelle
			?grua - grua
			?contenedor - contenedor
		)
		:duration (= ?duration (* (peso ?contenedor) (- (altura ?grua) (altura ?cinta))))
		:condition(
			and
			(at start (libre ?cinta))
			(over all (conecta-a ?cinta ?muelle_origen ?muelle_destino))
			(over all (ubicado-en ?grua ?muelle_origen))
			(over all (ubicado-en ?contenedor ?grua))
			(over all (ubicado-en ?contenedor ?muelle_origen))
		)
		:effect(
			and
			(at end (libre ?grua))
			(at end (not (ubicado-en ?contenedor ?grua)))
			(at end (ubicado-en ?contenedor ?cinta))
			(at start (not (libre ?cinta)))
		)
	)

	(:durative-action mover-cinta
		:parameters (
			?cinta - cinta
			?muelle_origen - muelle
			?muelle_destino - muelle
			?contenedor - contenedor
		)
		:duration (= ?duration (/ (longitud ?cinta) (velocidad ?cinta)))
		:condition (
			and
			(over all (conecta-a ?cinta ?muelle_origen ?muelle_destino))
			(over all (ubicado-en ?contenedor ?muelle_origen))
			(over all (ubicado-en ?contenedor ?cinta))
		)
		:effect(
			and
			(at end (not (ubicado-en ?contenedor ?muelle_origen)))
			(at end (ubicado-en ?contenedor ?muelle_destino))
		)
	)
)
