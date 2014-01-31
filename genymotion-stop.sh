#script genymotion-stop.sh 
IP=`genymotion-detect-ip.sh`

adb root
adb connect $IP:5555
#adb shell reboot -p
adb shell stop
adb disconnect $IP
sleep 5
pkill VirtualBoxVM
