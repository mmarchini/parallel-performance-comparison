#!/bin/bash

set -e

PROCESSES=$1;

if [ -z "$PROCESSES" ]; then
    PROCESSES=4
fi

./generate_quicksort.py -p $PROCESSES

# GO TEST CASES #
GO_SRC=go-benchmark/src
mkdir -p results/go/sequential
mkdir -p results/go/parallel

# QuickSort
echo "Starting quick sort profiling"
for test_case in $(ls tests/qsort/); do
    # Sequential quickSort
    echo "Running sequential quick sort $test_case"
    go run $GO_SRC/quickSort.go tests/qsort/$test_case 100 results/go/sequential/quickSort_$test_case

    # Parallel quickSort
    echo "Running parallel quick sort $test_case"
    go run $GO_SRC/parallelQuickSort.go tests/qsort/$test_case 100 results/go/parallel/quickSort_$test_case
done
echo "Quick sort profiling finished"

# ERLANG TEST CASES #
echo "Erlang testing"
ERL_SRC=erlang-benchmark/src
mkdir -p results/erlang/sequential/qsort/
mkdir -p results/erlang/parallel/qsort/
# quickSort 
echo "Starting quick sort profiling"
erlc -o . $ERL_SRC/quickSort.erl
erlc -o . $ERL_SRC/parallelQuickSort.erl
for test_case in $(ls tests/qsort/); do
    # Sequential quick sort 
    echo "Running sequential quickSort $test_case"
    erl -noshell -s quickSort test_loop tests/qsort/$test_case 100 results/erlang/sequential/qsort/$test_case

    # Parallel quick sort 
    echo "Running parallel quick sort $test_case"
    erl -noshell -s parallelQuickSort test_loop tests/qsort/$test_case 100 results/erlang/sequential/qsort/$test_case
done
rm quickSort.beam 
rm parallelQuickSort.beam 
echo "quick sort profiling finished"

