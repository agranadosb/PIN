PROBLEM=1
DOMAIN=domain
TIMESTEPS=
N=1

.DEFAULT_GOAL := ff

chmod:
	chmod +x planners/ff/metric_ff
	chmod +x planners/lpg/lpg-td
	chmod +x planners/optic/optic-clp
ff:
	./planners/metric_ff -o domain/${DOMAIN}.pddl -f problems/problem${PROBLEM}.pddl
lpg:
	./planners/lpg-td -o domain/${DOMAIN}.pddl -f problems/problem${PROBLEM}.pddl -n ${N} -out results/result-problem${PROBLEM}.txt ${TIMESTEPS}
optic:
	./planners/optic-clp domain/${DOMAIN}.pddl problems/problem${PROBLEM}.pddl
