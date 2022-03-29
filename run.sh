#!/bin/bash
./a.sh -v
./b.sh
./c_bash.sh heart_men.csv
gawk -f c_awk.awk heart_women.csv >> results.csv
./d.sh > results.html