###update mck8s_lsv and ready key, known host, and write ip to config
uniq $OAR_NODEFILE > node_list
manage=$(awk NR==1 node_list)

for i in $(cat node_list)
do
	sh ./rmsr.sh $i $manage &
done
echo "management node is $manage"