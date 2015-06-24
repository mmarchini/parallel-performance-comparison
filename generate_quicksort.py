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
for multiplier in [250, 500, 750, 1000, 1250, 1500]:
    length = multiplier*PROCESSES
    print length
    with open("tests/qsort/%d"%length, "w") as f:
        f.writelines(["%d\n"%random.randrange(0, length) for m in range(length)])

