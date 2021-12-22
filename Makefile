PROBLEM=1
DOMAIN=domain
TIMESTEPS=-timesteps
N=1

.DEFAULT_GOAL := ff

chmod:
	chmod +x planners/metric_ff
	chmod +x planners/lpg-td
	chmod +x planners/optic-clp
ff:
	./planners/metric_ff -o src/${DOMAIN}.pddl -f src/problem${PROBLEM}.pddl
lpg:
	./planners/lpg-td -o src/${DOMAIN}.pddl -f src/problem${PROBLEM}.pddl -n ${N} -out results/result-problem${PROBLEM}.txt
lpg-t:
	./planners/lpg-td -o src/${DOMAIN}.pddl -f src/problem${PROBLEM}.pddl -n ${N} -out results/result-problem${PROBLEM}.txt -timesteps
optic:
	./planners/optic-clp src/${DOMAIN}.pddl src/problem${PROBLEM}.pddl
