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

print "Queens"
os.makedirs("tests/queens")
for multiplier in [1, 2, 3]:
    size = multiplier*PROCESSES
    print size
    open("tests/queens/%d"%size, "w").close()

