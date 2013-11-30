#!/bin/bash

# script to capture a series of photos 

DATE=$(date +"%m%d%y")

# prompt for setup information

read -e -p "Mount sd card and save pictures to it? (y/n) " -i "y" MOUNT
read -e -p "How many pictures in the series? " -i "75" NUMBER_OF_PICS
read -e -p "How many seconds to leave the shutter open? " -i "30s" SHUTTER_OPEN_SECS
read -e -p "How many seconds to wait between pictures? " -i "35" WAIT

# adjust wait time to allow some delay for transfering picture off camera.  ~6 seconds in testing
WAIT=$((WAIT-6))

echo ""
sudo gphoto2 --get-config /main/capturesettings/aperture
read -e -p "Aperture setting? " -i "0" APERTURE

echo ""
sudo gphoto2 --get-config /main/imgsettings/iso
read -e -p "ISO setting? " -i "4" ISO

sudo gphoto2 --set-config shutterspeed=bulb
sudo gphoto2 --set-config-index /main/capturesettings/aperture=$APERTURE
sudo gphoto2 --set-config-index /main/imgsettings/iso=$ISO

if [ "$MOUNT" == y ]; then 
    sudo mount /dev/mmcblk1p1 /home/tomc/pictures
    sudo rm /home/tomc/pictures/*.jpg
fi 

for (( i=1; i<=$NUMBER_OF_PICS; i++))
do 
    printf "taking picture number $i\n"
    sudo gphoto2 --set-config bulb=1 --wait-event=$SHUTTER_OPEN_SECS --set-config bulb=0 --wait-event-and-download=5s
    if [ "$i" == 1 ]; then
        sudo cp capt0000.jpg /var/www/images
    fi 
    sudo mv capt0000.jpg /home/tomc/pictures/$DATE-$i.jpg

    if [ "$i" -lt "$NUMBER_OF_PICS" ]; then
        printf "sleeping $WAIT more seconds\n\n"
        sleep $WAIT
    fi
done

if [ "$MOUNT" == y ]; then 
    sudo umount /home/tomc/pictures
fi
