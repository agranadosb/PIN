import time
import os
import re
import logging

logging.basicConfig(
    format="%(asctime)s %(levelname)-8s %(message)s",
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
)

problems = ['1', '3', 'eva']
planners = {
    'ff': (lambda y: len(re.findall('\d+:', y)), 1),
    'lpg': (lambda y: len(re.findall('\d+\.\d+:', y)), 7),
    'lpg-t': (lambda y: len(re.findall('\d+\.\d+:', y)), 7),
    'optic': (lambda y: len(re.findall('\d+\.\d+:', y)), 3),
}

res_file = open('res.txt', 'w')
for problem in problems:
    for planner, (function, repeat) in planners.items():
        for i in range(repeat):
            init = time.time()
            stream = os.popen(f'make {planner} PROBLEM={problem}')
            output = stream.read()
            fin = time.time() - init

            with open(f'results/{planner}-{problem}-{i}.txt', 'w') as fr:
                fr.write(output)

            values = function(output)
            logging.info(f'{planner}-{problem}-{i}: Seconds={fin} MaxFacts={values}')
            res_file.write(f'{planner}-{problem}-{i}: Seconds={fin} MaxFacts={values}\n')
res_file.close()