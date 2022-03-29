#!/bin/bash

# Mostrem la info per defecte si executem ./a.sh
default_info(){
	echo ---------
	echo Numero de linies:
	wc -l heart.csv
	echo Numero de columnes:
	head -1 heart.csv | sed 's/[^,]//g' | wc -c
	echo Nom de les Columnes:
	head -1 heart.csv
	echo ---------
}

# Descomprimim el dataset, si ja existeix l' actualitza.
echo Descomprimint ...
unzip -u archive.zip

# Mostrem la info detallada si executem ./a.sh -v
while getopts "v" option; do
	case "${option}" in
		v) 
			echo URL Descarrega:
			pwd
			echo Format:
			file -i heart.csv
	esac
done

default_info