#!/bin/bash

# script to capture a series of photos 

DATE=$(date +"%m%d%y")
NUMBER_OF_PICS=-1
WAIT=-1

# check for setup information passed on command line
OPTIND=1
while getopts "c:d:h?" opt; do 
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    c)  NUMBER_OF_PICS=$OPTARG
        ;;
    d)  WAIT=$OPTARG
        ;;
    esac
done


# if nothing on command line prompt for setup information

if [ "$NUMBER_OF_PICS" -eq -1 ]; then
    read -e -p "How many pictures in the series? " -i "75" NUMBER_OF_PICS
fi

if [ "$WAIT" -eq -1 ]; then
    read -e -p "How many seconds to wait between pictures? " -i "3600" WAIT
fi


for (( i=1; i<=$NUMBER_OF_PICS; i++))
do 
    printf "taking picture\n"
    sudo /usr/bin/raspistill -t 1 -rot 180 -o capt0000.jpg
    sudo mv capt0000.jpg /home/tomc/pictures/r-$DATE-$i.jpg

    if [ "$i" -lt "$NUMBER_OF_PICS" ]; then
        printf "sleeping $WAIT seconds\n\n"
        sleep $WAIT
    fi
done
