#!/bin/bash


INPUT_1=results.csv

if [[ -e "$INPUT_1" ]]; then

# unset arrays
unset men
unset women

#FIRST=0 # flag, to skip the header when is 0

#sed -i 1d results.csv

echo "<!DOCTYPE html><html><head>Informe de resultats</head><body>"
echo "<style>table, th, td {border:1px solid black;}td {padding-left: 60px;}</style>"

while IFS=, read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12
	do	 
			# Data men into array
			if [[ $col1 == "M" ]]; then				
				men[${#men[@]}]=$col2
				men[${#men[@]}]=$col3	
				men[${#men[@]}]=$col4	
				men[${#men[@]}]=$col5	
				men[${#men[@]}]=$col6	
				men[${#men[@]}]=$col7	
				men[${#men[@]}]=$col8	
				men[${#men[@]}]=$col9
				men[${#men[@]}]=$col10	
				men[${#men[@]}]=$col11	
				men[${#men[@]}]=$col12	
				
			# Data women into array
			elif [[ $col1 == "W" ]]; then				
				women[${#women[@]}]=$col2
				women[${#women[@]}]=$col3	
				women[${#women[@]}]=$col4	
				women[${#women[@]}]=$col5	
				women[${#women[@]}]=$col6	
				women[${#women[@]}]=$col7	
				women[${#women[@]}]=$col8	
				women[${#women[@]}]=$col9
				women[${#women[@]}]=$col10	
				women[${#women[@]}]=$col11	
				women[${#women[@]}]=$col12	
			fi
			
	done < "$INPUT_1"

# Create a h3 headline
function h3(){
	echo "<h3>$1</h3>"
}
# Create a html table
function create_table(){
	echo "<table style='width:100%'>"
}
# Insert headers into first row table
function header(){
	echo "<tr><th>Avg.Age</th><th>MaxAge</th><th>MinAge</th><th>Avg.AgeASY</th><th>Avg.AgeTA</th><th>Avg.MaxHR</th><th>Avg.Cholesterol</th>" \
		 "<th>Avg.RestingBP</th><th>TotalPatients</th><th>TotalPatients_1</th><th>%Patients_1</th></tr>"
}
# Close a html row and table
function end_table(){
	echo "</tr></table>"
}

# Show men data
h3 "Homes:"
create_table
header
echo "<tr>"
for i in "${men[@]}";
	do
		echo "<td>"
		echo $i
		echo "</td>"
	done
end_table

# Show women data
h3 "Dones:"
create_table
header
echo "<tr>"
for w in "${women[@]}";
	do
		echo "<td>"
		echo  $w | bc -l 
		echo "</td>"	
	done
end_table

echo "<br><br><br><br>"

# Calculate results between men and women
h3 "Diferència resultats Homes-Dones:"
create_table
header
echo "<tr>"
for i in "${!men[@]}"; do
	for w in "${!women[@]}"; do
		if (($i == $w)); then
			a=`echo ${men[$i]}-${women[$i]} | bc -l`
			#if (($a == 0)); then
				#echo "<td bgcolor="red">"
			#else 
				#echo "<td bgcolor="green">"
			#fi
			echo "<td>"
				echo $a
			echo "</td>"
		fi
	done
done
end_table

# show the info features legend
echo "<br><br>"
h3 "Llegenda"
echo "<b>Avg.Age:</b>Edat mitja del pacient afectat<br>"
echo "<b>MaxAge:</b>Edat màxima del pacient afectat<br>"
echo "<b>MinAge:</b>Edat mínima del pacient afectat<br>"
echo "<b>Avg.AgeASY:</b>Edat mitja del pacient que pateix una angina de pit de tipus asimptomàtica<br>"
echo "<b>Avg.AgeTA:</b>Edat mitja del pacient que pateix una angina de pit de tipus típica<br>"
echo "<b>Avg.MaxHR:</b>Valor mitjà del màxim de pulsacions enregistrades[Valor numéric entre 60 i 202]<br>"
echo "<b>Avg.Cholesterol:</b>Valor mitjà de colesterol a la sang[mm/dl]<br>"
echo "<b>Avg.RestingBP:</b>Valor mitjà de la pressió arterial en repós[mm Hg]<br>"
echo "<b>TotalPatients:</b>Total de la mostra de persones en el dataset<br>"
echo "<b>TotalPatients_1:</b>Total de la mostra de pacients afectats per una enfernetat cardiovascular en el dataset<br>"
echo "<b>%Patients_1:</b>Percentatge de pacients afectats en relació al total de la mostra (TotalPatients)<br>"

echo "</body></html>"

else 
	echo "File $1 Not Found"
fi

rm heart_men.csv
rm heart_women.csv
rm results.csv
