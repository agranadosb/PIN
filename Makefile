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
	./planners/metric_ff -o src/${DOMAIN}.pddl -f src/problem${PROBLEM}.pddl
lpg:
	./planners/lpg-td -o src/${DOMAIN}.pddl -f src/problem${PROBLEM}.pddl -n ${N} -out results/result-problem${PROBLEM}.txt ${TIMESTEPS}
optic:
	./planners/optic-clp src/${DOMAIN}.pddl src/problem${PROBLEM}.pddl
