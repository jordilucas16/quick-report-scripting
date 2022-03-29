# Substituim les sigles pel seu significat per fer el fitxer llegible als humans.
sed -E '{
# Sex: sex of the patient [M: Male, F: Female]
s/,F,/,Female,/g
s/,M,/,Male,/g

# ChestPainType: chest pain type [TA: Typical Angina, ATA: Atypical Angina, NAP: Non-Anginal Pain, ASY: Asymptomatic]
s/,TA,/,Typical Angina,/g
s/,ATA,/,Atypical Angina,/g
s/,NAP,/,Non-Anginal Pain,/g
s/,ASY,/,Asymptomatic,/g

# ExerciseAngina: exercise-induced angina [Y: Yes, N: No]
s/,Y,/,Yes,/g
s/,N,/,No,/g

# ST_Slope: the slope of the peak exercise ST segment [Up: upsloping, Flat: flat, Down: downsloping]
s/,Up,/,upsloping,/g
s/,Flat,/,flat,/g
s/,Down,/,downsloping,/g

}' heart.csv > heart_temp.csv

# Separem en dos fitxers tamporals per sexe (Female i Male)
file_by_gender(){
grep -E '*,Female,*' $1 > heart_women.csv
grep -E '*,Male,*' $1 > heart_men.csv
}

# Invoquem a la funció passant per paràmetre el tmp file.
file_by_gender heart_temp.csv

# Una vegada realitzades les transformacions i separats els fitxers esborrem el temporal.
rm heart_temp.csv