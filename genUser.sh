#!/bin/bash

#Enter password below
password=
echo $password | sudo -S printf "\nHi\n"
cd ~
[ -d "~/bank" ] && mkdir ~/bank

read -p "Enter filename or e-Enter by hand : " option
if [ "$option" = e ]
then
read -p "Enter Account No : " acc
read -p "Enter Branch No : " branch
read -p "Enter cateogory : " cat
#To create branch and user
sudo groupadd -f $branch
sudo groupadd -f $cat
sudo useradd -m -d ~/bank/$acc -g $branch -G $cat $acc
#To create Transaction_History.txt and Current_Balance.txt
cd ~/bank/$acc
sudo touch Transaction_History.txt
echo 500 | sudo tee Current_Balance.txt > /dev/null
cd ~
#To create branch manager
manager="MGR_""$branch"
if [ -z $(getent passwd $manager) ]
then sudo useradd -m -d ~/bank/$manager -g $branch $manager
fi

else
while read -r acc branch cat sub ex
do
#To create branch and user
sudo groupadd -f $branch
sudo groupadd -f $cat
sudo useradd -m -d ~/bank/$acc -g $branch -G $cat $acc
#To create Transaction_History.txt and Current_Balance.txt
cd ~/bank/$acc
sudo touch Transaction_History.txt
echo 500 | sudo tee Current_Balance.txt > /dev/null
cd ~
#To create branch manager
manager="MGR_""$branch"
if [ -z $(getent passwd $manager) ]
then sudo useradd -m -d ~/bank/$manager -g $branch $manager
fi
done < $option

fi
