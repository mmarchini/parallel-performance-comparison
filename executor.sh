#!/bin/bash

PROCESSES=$1;

if [ -z "$PROCESSES" ]; then
    PROCESSES=4
fi

if [ -d "results" ]; then
    mv results results.bkp 
fi
if [ -d "tests" ]; then
    mv tests tests.bkp
fi

# ./generate_tests.py -p $PROCESSES

# GO TEST CASES #
GO_SRC=go-benchmark/src
mkdir -p results/go/sequential
mkdir -p results/go/parallel

# QuickSort
echo "Starting quick sort profiling"
for test_casein $(ls tests/qsort/); do
    # Sequential quickSort
    echo "Running sequential quick sort $test_case"
    go run $GO_SRC/quickSort.go tests/qsort/$test_case 100 results/go/sequential/quickSort_$test_case

    # Parallel quickSort
    echo "Running parallel quick sort $test_case"
    go run $GO_SRC/parallelQuickSort.go tests/qsort/$test_case 100 results/go/parallel/quickSort_$test_case
done
echo "Quick sort profiling finished"

# matrixMultiplication 
echo "Starting matrix multiplication profiling"
for test_casein $(ls tests/matrix/); do
    # Sequential matrixMultiplication 
    echo "Running sequential matrix multiplication $test_case"
    go run $GO_SRC/matrixMultiplication.go tests/matrix/$test_case/A tests/matrix/$test_case/B 100 results/go/sequential/matrix_$test_case

    # Parallel matrixMultiplication 
    echo "Running parallel matrix multiplication $test_case"
    go run $GO_SRC/matrixMultiplication.go tests/matrix/$test_case/A tests/matrix/$test_case/B $PROCESSES 100 results/go/parallel/matrix_$test_case
done
echo "Matrix multiplication profiling finished"

# queensProblem 
echo "Starting queens problem profiling"
for test_casein $(ls tests/queens/); do
    # Sequential queens Problem 
    echo "Running sequential queens problem $test_case"
    go run $GO_SRC/queensProblem.go tests/queens/$test_case 100 results/go/sequential/queens_$test_case

    # Parallel queensProblem 
    echo "Running parallel queens problem $test_case"
    go run $GO_SRC/parallelQueensProblem.go tests/queens/$test_case $PROCESSES 100 results/go/parallel/queens_$test_case
done
echo "Queens problem profiling finished"

