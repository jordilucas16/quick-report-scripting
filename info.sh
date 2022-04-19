#!/bin/bash

# Display default information: ./info.sh
default_info(){
	echo ---------
	echo Lines number/filename:
	wc -l heart.csv
	echo Columns number:
	head -1 heart.csv | sed 's/[^,]//g' | wc -c
	echo Columns name:
	head -1 heart.csv
	echo ---------
}

# Unzip dataset, update if exists.
echo Unziping ...
unzip -u archive.zip

# Display detail info (add -v argument): ./info.sh -v
while getopts "v" option; do
	case "${option}" in
		v) 
			echo Download URL:
			pwd
			echo Format:
			file -i heart.csv
	esac
done

# Call function
default_info