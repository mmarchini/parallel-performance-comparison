#!/usr/bin/env python

import os
import random
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--processes", help="Number of processes", default=4, type=int)
parser.add_argument("-s", "--seed", help="Random generator seed", default=64, type=int)
args = parser.parse_args()

PROCESSES = args.processes
SEED      = args.seed

print "PROCESSES:", PROCESSES
print "SEED:", SEED

random.seed(SEED)

print "Matrix"
os.makedirs("tests/matrix")
for multiplier in [25, 50, 75, 100, 125, 150]:#, 5000, 10000]:
    rows = multiplier*PROCESSES
    print rows
    os.makedirs("tests/matrix/%d"%rows)
    with open("tests/matrix/%d/A"%rows, "w") as A, open("tests/matrix/%d/B"%rows, "w") as B:
        for r in range(rows):
            Arow = ",".join(["%d"%random.randrange(0, rows) for m in range(rows)])+"\n"
            A.write(Arow)

            Brow = ",".join(["%d"%random.randrange(0, rows) for m in range(rows)])+"\n"
            B.write(Brow)

