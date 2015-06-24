#!/usr/bin/env python

import os

os.path

languages = ['erlang', 'go']
modes = ['sequential', 'parallel']
problems = ['qsort', 'matrix', 'queens']

for language in languages:
    for mode in modes:
        for problem in problems:
            path = os.path.join('results', language, mode, problem)

            results = sorted(os.listdir(path), key=int)
            result_files = map(open, [os.path.join(path, r) for r in results])

            with open(os.path.join('results', '%s_%s_%s.csv'%(language, mode, problem)), 'w') as compiled_results:
                compiled_results.write(" ".join(results) + "\n")

                line_results = []
                for rfile in result_files:
                    line_results.append([r.strip() for r in rfile.readlines()])

                rows = [" ".join(l) for l in zip(*line_results)]
                compiled_results.write("\n".join(rows)+"\n")

