PROBLEM=1
EX=1
TIMESTEPS=-timesteps
N=1

BASE=src/ex${EX}/

.DEFAULT_GOAL := ff

chmod:
	chmod +x planners/metric_ff
	chmod +x planners/lpg-td
	chmod +x planners/optic-clp
ff:
	./planners/metric_ff -o ${BASE}domain.pddl -f ${BASE}problem${PROBLEM}.pddl
lpg:
	./planners/lpg-td -o ${BASE}domain.pddl -f ${BASE}problem${PROBLEM}.pddl -n ${N} -out ${BASE}results/result-problem${PROBLEM}.txt
lpg-t:
	./planners/lpg-td -o ${BASE}domain.pddl -f ${BASE}problem${PROBLEM}.pddl -n ${N} -out ${BASE}results/result-problem${PROBLEM}.txt -timesteps
optic:
	./planners/optic-clp ${BASE}domain.pddl ${BASE}problem${PROBLEM}.pddl
