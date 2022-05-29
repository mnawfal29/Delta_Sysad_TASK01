#!/bin/bash
cd /home/bank

for branch in $(ls)
do

if [ "$branch" != MGR ]
then
cd $branch

for acc in $(ls)
do
#Change permissions for Account Holder
chown -R $acc $acc
chmod -R 400 $acc
done

cd ..
#Change permissions for BranchManager
manager="MGR_"$branch
setfacl -m u:$manager:rwx -R $branch
fi
done

#Create CEO and add permissions
useradd -m -d /home/bank/MGR/CEO CEO
setfacl -m u:CEO:r -R /home/bank
