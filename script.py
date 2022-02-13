import os
import time
import shutil
from multiprocessing import Process
import logging

logging.basicConfig(
    format="%(asctime)s %(levelname)-8s %(message)s",
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
)

def execute(command: str) -> str:
    with open('executed-commands.txt', 'a') as logs:
        print(command, file=logs)
        logging.info(f"Executing command: {command}")
    stream = os.popen(command)
    output = stream.read()
    return output

def grouped(iterable, n):
    return zip(*[iter(iterable)]*n)

def launch_jobs(processes: list[Process]) -> None:
    for i in processes:
        i.start()
    for i in processes:
        init = time.time()
        while i.is_alive():
            logging.info(f'Waiting to {i.name} during {time.time() - init:10.2f} seconds')
            i.join(timeout=120)
        logging.info(f'Process {i.name} finished in {time.time() - init:10.2f} seconds')

if os.path.exists('results'):
    shutil.rmtree('results')
os.mkdir('results')

os.mkdir('results/ex1')
os.mkdir('results/ex2')
os.mkdir('results/ex3')

problems = ['1', '2', '3', '4', '5', 'eva']
planners = ['optic', 'lpg', 'lpg-t', 'ff']
processes = []
for planner in planners:
    for problem in problems:
        command = f'make {planner} PROBLEM={problem} EX=1 N=3 > results/ex1/results-{planner}-{problem}.txt'
        process = Process(target=execute, args=(command,), name=f'Problem {problem} with planner {planner}')
        processes.append(process)

planners = ['optic', 'lpg']

for planner in planners:
    for problem in problems:
        command = f'make {planner} PROBLEM={problem} EX=2 N=3 > results/ex2/results-{planner}-{problem}.txt'
        process = Process(target=execute, args=(command,), name=f'Problem {problem} with planner {planner}')
        processes.append(process)

problems += ['1-t', '2-t', '3-t', '4-t', '5-t', 'eva-t']
domains = ['domain-no-recarga', 'domain-recarga']

for planner in planners:
    for problem in problems:
        for domain in domains:
            command = f'make {planner} PROBLEM={problem} EX=3 N=3 DOMAIN={domain} > results/ex3/results-{planner}-{problem}-{domain}.txt'
            process = Process(target=execute, args=(command,), name=f'Problem {problem} with planner {planner}')
            processes.append(process)
launch_jobs(processes)
