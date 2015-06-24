#!/bin/bash

set -e

PROCESSES_MATRIX=$1;
PROCESSES_QUEENS=$2;
PROCESSES_QUICKS=$3;

if [ -z "$PROCESSES_MATRIX" ]; then
    PROCESSES_MATRIX=4
fi
if [ -z "$PROCESSES_QUEENS" ]; then
    PROCESSES_QUEENS=4
fi
if [ -z "$PROCESSES_QUICKS" ]; then
    PROCESSES_QUICKS=4
fi

if [ -d "results" ]; then
    mv results results.bkp 
fi
if [ -d "tests" ]; then
    mv tests tests.bkp
fi

./execute_matrix.sh $PROCESSES_MATRIX
./execute_queens.sh $PROCESSES_QUEENS
./execute_quicksort.sh $PROCESSES_QUICKS

