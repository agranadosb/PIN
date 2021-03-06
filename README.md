PIN project
===========

This is the repository for PIN project. In src folder are the 3 exercises of the project:

 - ex1 = First exercise
 - ex2 = Second exercise
 - ex3 = Third exercise

Exercises 4 and 5 are in the files `graphplan_v3.xlsx` and `Pop.pdf` respectively.

In this project are 6 problems in exercises 1, 2 and 3:

 - 1
 - 2
 - 3
 - 4
 - 5
 - eva

In exercise three are 2 domains:

 - domain-no-recarga.pddl
 - domain-recarga.pddl

And other 6 problems more:

 - 1-t
 - 2-t
 - 3-t
 - 4-t
 - 5-t
 - eva-t

The problems without -t in ex3 have as metric the resource defined and with -t the total time.

The plan results of LPG for each domain for each exercise is stored in `sr/ex_/results` folder.

The execution results of each domain for each exercise is stored in `results/ex_`. The naming of these files is `results-planner-problem.txt`.

Usage
-----

The excutions are made using Makefile, so to execute one planner:

```sh
make [planner] [PROBLEM] [options] [domain] [exercise]
```
The planner can be:

 - ff
 - lpg
 - optic

The problem is specified with the option PROBLEM=problem, being 'problem' the number of the problem.

For the lpg planner, two options can be setted:

 - `N=x` for n option of the lpg planner
 - `TIMESTEPS=[-timesteps]` for timesteps option

For example, if we want to execute lpg planner with n=1, with timesteps on the problem 3 in exercise 1 with the domain "domain":

```sh
make lpg PROBLEM=3 N=1 TIMESTEPS=-timesteps EX=1 DOMAIN=domain
```

To give execution permissions, use:

```sh
make chmod
```

INSTRUCCIONES PARA EJECUTAR LOS PLANIFICADORES
----------------------------------------------


### FF � METRIC-FF (para dominios STRIPS)

Probar fichero ejecutable o bien compilar el c�digo fuente de Metric-FF (basta con hacer $make).


> ./metric_ff -o <domain.pddl> -f <problem.pddl>

http://fai.cs.uni-saarland.de/hoffmann/metric-ff.html


En el caso de que no funcione en la versi�n de Linux utilizada, se muestran otras opciones:

(1) Descargar Metric-FF-v2.1.tgz y compilar igualmente con $make. En este caso, el fichero ejectuable se llama ff y hay que ejecturalo as�:

> ./ff -o <domain.pddl> -f <problem.pddl> -s 0

donde -s 0 significa que el planificador se ejecutar� con la opci�n de b�squeda (search) por defecto (hill climbing + BFS).


(2) Descargar FF-v2.3.tgz y compilar igualmente con $make. En este caso, el fichero ejecutable es ff y hay que ejecutarlo as�:

> ./ff -o <domain.pddl> -f <problem.pddl>


FF se puede ejecutar con las opciones -E -h 0 (la primera desactiva el hill climbing, la segunda pone la heur�stica a 0, de forma que FF se ejecuta en modo �ptimo con estas dos opciones).


### LPG-td

Probar primero la versi�n lpg-td (ejecutable LPG-td 1.4)


> ./lpg-td-1.0 -o <domain.pddl> 
               -f <problem.pddl> 
               -n <number>    specifies the desired number of solutions
               -out <fich_solution>   ;; fichero para la soluci�n



Si se quiere minimizar el n�mero de timesteps hay que usar adem�s la etiqueta -timesteps en detrimento del n�mero de acciones.


NOTA (1):

- Cuando se usan fluents en LPG es necesario poner una funci�n a minimizar; en caso contrario el problema no funciona.
- En el caso de utilizar solo fluents y no durative-actions, se puede igualmente utilizar  (:metric minimize (total-time)))
- LPG no admite (o bien genera problemas) la utilizaci�n de condiciones sobre fluents donde se utilice el operador de comparaci�n  <= . De este modo, hay que utilizar siempre los operadores comparativos >= o > .


NOTA (2):

- lpg_MAX_PLAN_LENGTH es una versi�n de LPG compilada con tama�os m�s grandes de arrays. Se recomienda usar esta versi�n, especialmente para temporal y num�rico. La contrase�a del archivo zip es 1234.


http://zeus.ing.unibs.it/lpg/


### OPTIC planner


https://sourceforge.net/projects/tsgp/   


El c�digo se puede bajar de la p�gina indicada (tambi�n en Poliformat)

Vamos a trabajar con optic-clp (almost-compiled binary of OPTIC for 32-bit Linux).

Bajar el fichero optic-clp.tar.bz2

El fichero est� compilado pero hay que 'linkarlo' con las librer�as de CLP. Asegurarse que vuestra versi�n de Linux contiene los paquetes indicados en la p�gina de OPTIC.


PAQUETES: CMAKE, PERL, BISON, FLEX

PARA COMPILAR (leer el fichero README): 
1) RUN-CMAKE-RELEASE 
2) BUILD-RELEASE (si da error, entrar en el directorio y ejecutar make)


Si est�is en una m�quina de 64 bits, tened en cuenta las instrucciones indicadas en la secci�n 'Users of 64-bit Machines'.  


Ejecuci�n OPTIC

> ./optic-clp <domain.pddl> <problem.pddl>


OPTIC es un planficador de orden parcial. Devuelve una primera soluci�n (determinista) y luego intenta mejorarla. Ejemplo:


; No metric specified - using makespan

; Plan found with metric 0.004
; States evaluated so far: 23
; States pruned based on pre-heuristic cost lower bound: 0
; Time 0.00
0.000: (lift hoist0 crate1 pallet0 depot0)  [0.001]
0.000: (drive truck0 distributor1 distributor0)  [0.001]
0.000: (lift hoist1 crate0 pallet1 distributor0)  [0.001]
0.001: (load hoist0 crate1 truck1 depot0)  [0.001]
0.001: (load hoist1 crate0 truck0 distributor0)  [0.001]
0.002: (drive truck1 depot0 distributor0)  [0.001]
0.002: (drive truck0 distributor0 distributor1)  [0.001]
0.003: (unload hoist2 crate0 truck0 distributor1)  [0.001]
0.003: (unload hoist1 crate1 truck1 distributor0)  [0.001]
0.004: (drop hoist2 crate0 pallet2 distributor1)  [0.001]
0.004: (drop hoist1 crate1 pallet1 distributor0)  [0.001]

 * All goal deadlines now no later than 0.004


PLAN DE 11 ACCIONES ENCONTRADO EN 4 TIME STEPS. NOTESE QUE OPTIC DEVUELVE LOS TIME STEPS COMO 0.000 0.001 PORQUE ES UN PLANIFICADOR TEMPORAL Y TIENE LA SALIDA PREPARADA PARA PLANES TEMPORALES. PARA FIJARSE EN EL NUMERO DE TIME STEPS, HAY QUE FIJARSE EN EL �LTIMO DIGITO DEL TIME.

A PARTIR DEL PRIMER PLAN, SE FIJA EN EL NUMERO DE TIME STEPS (4 EN ESTE CASO) E INTENTA ENCONTRAR OTRO PLAN EN MENOS DE 4 TIME STEPS.


Resorting to best-first search
Running WA* with W = 5.000, not restarting with goal states
b (9.000 | 0.000)b (8.000 | 0.001)b (7.000 | 0.002)b (5.000 | 0.002)b (4.000 | 0.002)b (3.000 | 0.003)b (2.000 | 0.003)b (1.000 | 0.004)
Problem Unsolvable
;;;; Solution Found
; States evaluated: 120430
; Cost: 0.004
; Time 53.85
0.000: (lift hoist0 crate1 pallet0 depot0)  [0.001]
0.000: (drive truck0 distributor1 distributor0)  [0.001]
0.000: (lift hoist1 crate0 pallet1 distributor0)  [0.001]
0.001: (load hoist0 crate1 truck1 depot0)  [0.001]
0.001: (load hoist1 crate0 truck0 distributor0)  [0.001]
0.002: (drive truck1 depot0 distributor0)  [0.001]
0.002: (drive truck0 distributor0 distributor1)  [0.001]
0.003: (unload hoist2 crate0 truck0 distributor1)  [0.001]
0.003: (unload hoist1 crate1 truck1 distributor0)  [0.001]
0.004: (drop hoist2 crate0 pallet2 distributor1)  [0.001]
0.004: (drop hoist1 crate1 pallet1 distributor0)  [0.001]


ACTIVA BEST-FIRST SEARCH. NO ENCUENTRA OTRA SOLUCI�N, POR ESO DICE PROBLEM UNSOLVABLE Y DEVUELVE LA MISMA SOLUCI�N.
-------------------------------------------------------------------------------------------------------------------

VAL (herramienta para validar planes cl�sicos)

> ./validate -v <domain.pddl> <problem.pddl> <plan_file>

https://github.com/KCL-Planning/VAL
