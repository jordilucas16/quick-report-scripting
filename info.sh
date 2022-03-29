#!/bin/bash

# Display default information: ./a.sh
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

# Unzip dataset, update if exists.
echo Descomprimint ...
unzip -u archive.zip

# Display detail info (add -v argument): ./a.sh -v
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