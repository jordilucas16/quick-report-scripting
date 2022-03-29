#!/bin/bash

INPUT_1=$1

if [[ -e "$INPUT_1" ]]; then

# unset arrays
unset age
unset asy
unset ta
unset maxhr
unset chol
unset restbp

# init variables
men=0
men_1=0

while IFS=, read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12
	do		
			# Get only gender = Male > heart_men.csv file
			if [[ $col2 == "Male" ]]; then	
				# Total records
				let men=men+1
				# Set columns
				echo "Gender,Avg.Age,MaxAge,MinAge,Avg.AgeASY,Avg.AgeTA,Avg.MaxHR,Avg.Cholesterol,Avg.RestingBP,TotalPatients,TotalPatients_1,%Patients_1" > results.csv 
				# Get only HeartDisease=1 records to analyze
				if [[ $col12 == 1 ]]; then		
					if [[ $col3 == "Asymptomatic" ]]; then			
						asy[${#asymp[@]}]=$col1	
					fi	
					if [[ $col3 == "Typical Angina" ]]; then			
						ta[${#ta[@]}]=$col1	
					fi	
					# Get Age data
					age[${#age[@]}]=$col1
					# Get MaxHR data
					maxhr[${#maxhr[@]}]=$col8
					# Get Cholesterol data
					chol[${#chol[@]}]=$col5
					# Get RetsingBP data
					restbp[${#restbp[@]}]=$col4
					# Total records on HeartDisease=1
					let men_1=men_1+1
				fi	
			else
				echo "First parameter has to be heart_men.csv file"; exit 99;
			fi	
	done < "$INPUT_1"
	

# Function to calculate average from array
function calculate_avg(){
	arr=("$@")
	tot=0

		for i in "${arr[@]}"; do
			let tot+=$i
		done

	size=${#arr[@]}
	
	echo "scale=2; $tot/$size" | bc

}

# Get the max and min age values
max_age=$(printf "%d\n" "${age[@]}" | sort -n | tail -1)
min_age=$(printf "%d\n" "${age[@]}" | sort -n -r | tail -1)

# Columns Gender,Avg.Age,MaxAge,MinAge,Avg.AgeASY,Avg.AgeTA,Avg.MaxHR,Avg.Cholesterol,Avg.RestingBP,TotalMen,TotalMen_1,%Men_1
echo M,$(calculate_avg "${age[@]}"),$max_age,$min_age,$(calculate_avg "${asy[@]}"),$(calculate_avg "${ta[@]}"), 	\
	 $(calculate_avg "${maxhr[@]}"),$(calculate_avg "${chol[@]}"),$(calculate_avg "${restbp[@]}"),$men,$men_1,$(( $men_1*100/$men | bc -l )) > results.csv 

else 
	echo "File $1 Not Found"
fi