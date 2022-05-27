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
sudo groupadd -f $branch
sudo groupadd -f $cat
sudo useradd -m -d ~/bank/$acc -g $branch -G $cat $acc
cd ~/bank/$acc
sudo touch Transaction_History.txt
echo 500 | sudo tee Current_Balance.txt > /dev/null
cd ~

else
while read -r acc branch cat sub ex
do
sudo groupadd -f $branch
sudo groupadd -f $cat
sudo useradd -m -d ~/bank/$acc -g $branch -G $cat $acc
cd ~/bank/$acc
sudo touch Transaction_History.txt
echo 500 | sudo tee Current_Balance.txt > /dev/null
cd ~
done < User_Accounts.txt

fi
