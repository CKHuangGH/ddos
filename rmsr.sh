i=$1

scp -r ./ddos root@$i:/root/

echo "run init (write ip address to config, and known host)"
scp /home/chuang/.ssh/id_rsa root@$i:/root/.ssh
ssh root@$i . /root/ddos/env/init.sh
echo "----------------$i OK----------------"