PROBLEM=1
DOMAIN=domain

.DEFAULT_GOAL := ff

ff:
	./planners/ff/metric_ff -o domain/${DOMAIN}.pddl -f problems/problem${PROBLEM}.pddl
lpg:
	./planners/ff/metric_ff -o domain/${DOMAIN}.pddl -f problems/problem${PROBLEM}.pddl