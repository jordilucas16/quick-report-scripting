BEGIN {
        FS=",";
        totWomen = 0;
        totWomen_1 = 0;
		totWomenAge=0;
		
		sumAgeAsy=0;
		sumAgeTa=0;
		
		womenAsy=0
		womenTa=0;
		
		maxhrSum=0;
		maxhrTotal=0;
		
		cholSum=0;
		cholTotal=0;
		
		restbpSum=0;
		restbpTotal=0;	
		
		max_age=50;
		min_age=50;
		
		#fileName="heart_women.csv";
}
{
	if($2 ~ /Female/){
		totWomen += 1;
		
		if ($12 ~ /1/) {
			totWomenAge += $1;
			totWomen_1 += 1;
			#ageWomenArray[NR-1]=$1
			if($3 ~ /Asymptomatic/){
				sumAgeAsy +=$1;
				womenAsy +=1;
			}
			else if($3 ~ /Typical Angina/){
				sumAgeTa +=$1;
				womenTa +=1;
			}
			maxhrSum +=$8;
			maxhrTotal +=1;
			cholSum +=$5;
			cholTotal +=1;
			restbpSum +=$4;
			restbpTotal +=1;

		}
		# Calculate max and min age 
		if ( $1 > max_age ) { max_age = $1 }
		if ( $1 < min_age ) { min_age = $1 }
	}
}
END {
	#printf("Gender,Avg.Age,MaxAge,MinAge,Avg.AgeASY,Avg.AgeTA,Avg.MaxHR,Avg.Cholesterol,Avg.RestingBP,TotalWomen,TotalWomen_1,%Women_1")
	printf "W,";
	printf("%.2f", (totWomenAge / totWomen_1  ));
	printf ",";
	printf(max_age);
	printf ",";
	printf(min_age);
	printf ",";
	printf("%.2f", (sumAgeAsy / womenAsy  ));
	printf ",";
	printf("%.2f", (sumAgeTa / womenTa  ));
	printf ",";
	printf("%.2f", (maxhrSum / maxhrTotal  ));
	printf ",";
	printf("%.2f", (cholSum / cholTotal  ));
	printf ",";
	printf("%.2f", (restbpSum / restbpTotal  ));
	printf ",";
	printf(totWomen  );
	printf ",";
	printf(totWomen_1  );
	printf ",";
	printf("%.2f", (totWomen_1 * 100 / totWomen  ));
	print("");
}