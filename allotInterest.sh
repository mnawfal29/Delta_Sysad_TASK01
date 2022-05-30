#!/bin/bash

if [ $(crontab -l | wc -c) -eq 0 ]
then
(crontab -l 2>/dev/null; echo "00 00 * * * /root/allotInterest.sh ") | crontab -

else
cd /home/bank
for branch in $(ls)
do
if [ "$branch" != MGR ]
then
cd $branch
while read -r category rate
do
eval $category=${rate::-1} #Create varaible with identifier as cateogory and value as interest
done < Daily_Interest_Rates.txt #Assuming the file is already created by the Manager

for acc in $(ls)
do

if [ -d $acc ] #Required to distinguish directories from .txt files in Branch file
then
read -a arr <<< "$(groups $acc)"
arr=("${arr[@]:3}")
read bal < ./$acc/Current_Balance.txt
touch ./$acc/Interest.txt

net_rate=0
for category in "${arr[@]}"
do
if [[ ! $category == *"Branch"* ]] #Required because Branch? is also a subgroup for the user
then
rate=${!category}
net_rate=$(echo "print($net_rate+$rate)" | python3) 
fi
done

interest=$(echo "print($net_rate*$bal)" | python3)
echo $interest >  ./$acc/Interest.txt
fi
done

cd ..
fi
done

fi
