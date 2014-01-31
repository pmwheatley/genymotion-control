#script genymotion-save.sh
VM=$1

echo "VM is \"$VM\""
VBoxManage snapshot $VM take snap1 