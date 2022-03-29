#!/bin/bash
./info.sh -v
./pre-proccess-data.sh
./analyze-men-data.sh heart_men.csv
gawk -f analyze-women-data.awk heart_women.csv >> results.csv
./d.sh > results.html