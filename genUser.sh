#!/bin/bash

mkdir /home/bank
read -p "Enter filename / e - Enter by hand / x - Exit: " option
while [ "$option" != x ]
do

if [ "$option" = e ]
then
read -p "Enter Account No : " acc
read -p "Enter Branch No : " branch
read -p "Enter category : " cat
read -p "Enter sub-category 1 (if any) : " sub1
read -p "Enter sub-category 2 (if any) : " sub2

#To create branch and user
groupadd -f $branch
groupadd -f $cat
useradd -m -d /home/bank/$acc -g $branch -G $cat $acc
[ ! -z "$sub1" ] && groupadd -f $sub1 && usermod -a -G $sub1 $acc
[ ! -z "$sub2" ] && groupadd -f $sub2 && usermod -a -G $sub2 $acc

#To create Transaction_History.txt and Current_Balance.txt

cd /home/bank/$acc
touch Transaction_History.txt
echo 500 > Current_Balance.txt 
cd ..

#To create branch manager
manager="MGR_""$branch"
if [ -z $(getent passwd $manager) ]
then useradd -m -d /home/bank/$manager -g $branch $manager
fi

else
while read -r acc branch cat sub1 sub2
do

#To create branch and user
groupadd -f $branch
groupadd -f $cat
useradd -m -d /home/bank/$acc -g $branch -G $cat $acc
[ "$sub1" != "-" ] && groupadd -f $sub1 && usermod -a -G $sub1 $acc
[ "$sub2" != "-" ] && groupadd -f $sub2 && usermod -a -G $sub2 $acc

#To create Transaction_History.txt and Current_Balance.txt
cd /home/bank/$acc
touch Transaction_History.txt
echo 500 > Current_Balance.txt 
cd ..

#To create branch manager
manager="MGR_""$branch"
if [ -z $(getent passwd $manager) ]
then useradd -m -d /home/bank/$manager -g $branch $manager
fi
done < $option
fi

read -p "Enter filename / e - Enter by hand / x - Exit: " option
done
