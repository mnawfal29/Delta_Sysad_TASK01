#!/bin/bash

#Assuming Branch Manager is logged in
OLDIFS=$IFS
IFS="_"
read -a arr <<< $(whoami)
branch="${arr[1]}"
IFS=$OLDIFS

cd /home/bank/$branch
read -p "Enter Account No : " acc
read -p "Enter Transaction Amount : " amt

if [ -d $acc ]
then
cd $acc
read bal < Current_Balance.txt
echo $bal
echo $amt
rem=$(($bal-$amt))

if [ $rem -gt 0 ]
then
echo $rem > Current_Balance.txt
x=$(date '+%Y-%m-%d %H:%M:%S')
echo "-$amt $x" >> Transaction_History.txt
else
echo "Amount greater than or equal to Current_Balance"
fi

else
echo "Account not present"
fi
