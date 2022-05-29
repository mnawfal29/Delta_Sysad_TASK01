#!/bin/bash

cd /home/bank
for branch in $(ls)
do

if [ "$branch" != MGR ]
then
cd $branch
branch_curr_bal=0
touch Branch_Current_Balance.txt
touch Branch_Transaction_History.txt

for acc in $(ls)
do

if [ -d $acc ]
then
read curr_bal < ./$acc/Current_Balance.txt
branch_curr_bal=$((branch_curr_bal+curr_bal))
cat ./$acc/Transaction_History.txt >> Branch_Transaction_History.txt
fi
done

echo "$branch_curr_bal" > Branch_Current_Balance.txt
cd ..
fi
done
