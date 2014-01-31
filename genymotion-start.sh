#!/bin/bash
# script genymotion-start.sh
if [[ -z $1 ]]
  then
    VM=`genymotion-random.sh`
  else
    VM=$1
fi

echo "$VM" > currVM.txt
echo "VM is $VM"
VBoxManage snapshot "$VM" restore clean
#VBoxHeadless -s $VM &
VBoxManage startvm "$VM" &

IP=""
sleep 10

while [[ -z "$IP" ]]; do
	echo "Waiting for IP... $IP"
    IP=`genymotion-detect-ip.sh`
done
echo "IP is $IP"

adb root
adb connect $IP:5555

OUT=`adb shell getprop init.svc.bootanim`
while [[ ${OUT:0:7}  != 'stopped' ]]; do
    OUT=`adb shell getprop init.svc.bootanim`
    echo 'Waiting for emulator to fully boot...'
done
echo "Emulator booted!"

#restart adb as root to allow powering it off
#root mode is generally what we want from a headless emulator (to download emma files for instance)
#adb root
#adb connect $IP:5555
