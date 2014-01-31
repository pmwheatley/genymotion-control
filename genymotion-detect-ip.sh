#script genymotion-detect-ip.sh
VM=`cat currVM.txt`

#find mac of vm
#http://stackoverflow.com/questions/10991771/sed-to-insert-colon-in-a-mac-address
# Update arp table
#echo "Updating ARP table..."
#for i in {101..254}; do ping -c 1 192.168.56.$i 2>&1 >/dev/null; done
fping -q -g 192.168.56.101 192.168.56.254

MAC=`VBoxManage showvminfo "$VM" | grep MAC | grep 'NIC 1' | awk -F ":" '{print $3}' | cut -c 2-13`
#echo "MAC is $MAC"

MAC=`echo $MAC | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1:/g' -e 's/\(.*\):$/\1/' | tr '[:upper:]' '[:lower:]'`
#echo "MAC is $MAC"

# Find IP: substitute vname-mac-addr with your vm's mac address in ':' notation
IP=`arp -a | sed "s/ \(.\):/ 0\1:/" | sed "s/:\(.\):/:0\1:/g"|sed "s/:\(.\):/:0\1:/g"|sed "s/:\(.\)$/:0\1/"|grep $MAC`
#echo "IP is $IP"

IP=`echo $IP | cut -d "(" -f2 | cut -d ")" -f1`
#IP=`ifconfig -a | grep 192.168.56.255 | egrep -o '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1`
#echo "IP is $IP"
#echo 192.168.56.101
echo $IP