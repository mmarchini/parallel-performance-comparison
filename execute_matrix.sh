#!/bin/bash

set -e

PROCESSES=$1;

if [ -z "$PROCESSES" ]; then
    PROCESSES=4
fi

./generate_matrix.py -p $PROCESSES

# GO TEST CASES #
echo "Go testing"
GO_SRC=go-benchmark/src
mkdir -p results/go/sequential/matrix/
mkdir -p results/go/parallel/matrix/
# matrixMultiplication 
echo "Starting matrix multiplication profiling"
for test_casein $(ls tests/matrix/); do
    # Sequential matrixMultiplication 
    echo "Running sequential matrix multiplication $test_case"
    go run $GO_SRC/matrixMultiplication.go tests/matrix/$test_case/A tests/matrix/$test_case/B 100 results/go/sequential/matrix/$test_case

    # Parallel matrixMultiplication 
    echo "Running parallel matrix multiplication $test_case"
    go run $GO_SRC/matrixMultiplication.go tests/matrix/$test_case/A tests/matrix/$test_case/B $PROCESSES 100 results/go/parallel/matrix/$test_case
done
echo "Matrix multiplication profiling finished"

# ERLANG TEST CASES #
echo "Erlang testing"
ERL_SRC=erlang-benchmark/src
mkdir -p results/erlang/sequential/matrix/
mkdir -p results/erlang/parallel/matrix/
# matrixMultiplication 
echo "Starting matrix multiplication profiling"
erlc -o . $ERL_SRC/matrixMultiplication.erl
erlc -o . $ERL_SRC/parallelMatrixMultiplication.erl
for test_casein $(ls tests/matrix/); do
    # Sequential matrixMultiplication 
    echo "Running sequential matrix multiplication $test_case"
    erl -noshell -s matrixMultiplication test_loop tests/matrix/$test_case/A tests/matrix/$test_case/B 100 results/erlang/sequential/matrix/$test_case

    # Parallel matrixMultiplication 
    echo "Running parallel matrix multiplication $test_case"
    erl -noshell -s matrixMultiplication test_loop tests/matrix/$test_case/A tests/matrix/$test_case/B $PROCESSES 100 results/erlang/sequential/matrix/$test_case
done
rm matrixMultiplication.beam
rm parallelMatrixMultiplication.beam
echo "Matrix multiplication profiling finished"

