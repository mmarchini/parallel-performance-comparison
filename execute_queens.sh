#!/bin/bash

set -e

PROCESSES=$1;

if [ -z "$PROCESSES" ]; then
    PROCESSES=4
fi

./generate_queens.py -p $PROCESSES

# GO TEST CASES #
echo "Go testing"
GO_SRC=go-benchmark/src
mkdir -p results/go/sequential
mkdir -p results/go/parallel
# queensProblem 
echo "Starting queens problem profiling"
for test_case in $(ls tests/queens/); do
    # Sequential queens Problem 
    echo "Running sequential queens problem $test_case"
    go run $GO_SRC/queensProblem.go $test_case 100 results/go/sequential/queens_$test_case

    # Parallel queensProblem 
    echo "Running parallel queens problem $test_case"
    go run $GO_SRC/parallelQueensProblem.go $test_case $PROCESSES 100 results/go/parallel/queens_$test_case
done
echo "Queens problem profiling finished"

# ERLANG TEST CASES #
echo "Erlang testing"
ERL_SRC=erlang-benchmark/src
mkdir -p results/erlang/sequential/queens/
mkdir -p results/erlang/parallel/queens/
# queensProblem 
echo "Starting queens problem profiling"
erlc -o . $ERL_SRC/queensProblem.erl
erlc -o . $ERL_SRC/parallelQueensProblem.erl
for test_case in $(ls tests/queens/); do
    # Sequential queensProblem 
    echo "Running sequential queens problem $test_case"
    erl -noshell -s queensProblem test_loop $test_case 100 results/erlang/sequential/queens/$test_case -s init stop

    # Parallel queens 
    echo "Running parallel queens problem $test_case"
    erl -noshell -s parallelQueensProblem test_loop $test_case $PROCESSES 100 results/erlang/sequential/queens/$test_case -s init stop
done
rm queensProblem.beam 
rm parallelQueensProblem.beam 
echo "Queens problem profiling finished"

