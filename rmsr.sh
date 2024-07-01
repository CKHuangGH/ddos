i=$1
manage=$2

scp -r ./ddos root@$i:/root/

echo "run precluster.sh (write ip address to config, and known host)"
scp /home/chuang/.ssh/id_rsa root@$i:/root/.ssh
ssh root@$i . /root/mck8s_lsv/remote_script/precluster.sh $manage
echo "----------------$i OK----------------"