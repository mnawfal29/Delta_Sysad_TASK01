echo "alias genUser='./genUser.sh'
alias permit='./permit.sh'
alias updateBranch='./updateBranch.sh'
alias allotInterest='./allotInterest.sh'
alias makeTransaction='./makeTransaction.sh'" >> /home/user/.bashrc

for i in {1..4}
do
echo "alias updateBranch='./updateBranch.sh'
alias makeTransaction='./makeTransaction.sh'" >> /home/bank/MGR/MGR_Branch$i/.bashrc
done
