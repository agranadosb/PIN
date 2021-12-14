PROBLEM=1
DOMAIN=domain
TIMESTEPS=
N=1

.DEFAULT_GOAL := ff

ff:
	./planners/ff/metric_ff -o domain/${DOMAIN}.pddl -f problems/problem${PROBLEM}.pddl
lpg:
	./planners/lpg/lpg-td -o domain/${DOMAIN}.pddl -f problems/problem${PROBLEM}.pddl -n ${N} -out results/result-problem${PROBLEM}.txt ${TIMESTEPS}
optic:
	./planners/optic/optic-clp domain/${DOMAIN}.pddl problems/problem${PROBLEM}.pddl
