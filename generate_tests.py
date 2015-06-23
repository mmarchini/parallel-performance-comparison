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

print "Quick sort"
os.makedirs("tests/qsort")
for multiplier in [100, 500, 1000, 5000, 10000, 50000]:
    length = multiplier*PROCESSES
    print length
    with open("tests/qsort/%d"%length, "w") as f:
        f.writelines(["%d\n"%random.randrange(0, length) for m in range(length)])

print "Matrix"
os.makedirs("tests/matrix")
for multiplier in [10, 50, 100, 500, 1000, 2500, 5000, 1000]:
    rows = multiplier*PROCESSES
    print rows
    with open("tests/matrix/%d"%rows, "w") as f:
        for r in range(rows):
            wrow = ",".join(["%d"%random.randrange(0, rows) for m in range(rows)])+"\n"
            f.write(wrow)

print "Queens"
os.makedirs("tests/queens")
for multiplier in [1, 2, 3, 4]:
    size = multiplier*PROCESSES
    print size
    open("tests/queens/%d"%size, "w").close()

