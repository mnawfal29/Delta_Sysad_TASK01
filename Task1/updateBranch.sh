#!/bin/bash

OLDIFS=$IFS
IFS="_"
read -a arr <<< $(whoami)
branch="${arr[1]}"
IFS=$OLDIFS

cd /home/bank/$branch
branch_curr_bal=0
touch Branch_Current_Balance.txt
touch Branch_Transaction_History.txt

for acc in $(ls)
do
if [ -d $acc ]
then
cd $acc
curr_bal=$(cat Current_Balance.txt)
branch_curr_bal=$(( branch_curr_bal + curr_bal ))
cat Transaction_History.txt >> ../Branch_Transaction_History.txt
cd ..
fi
done
echo $branch_curr_bal > Branch_Current_Balance.txt
