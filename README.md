dlinktimelapse.py and dlinktimelapseAuth.py are python scripts to interact 
with dlink dcs-5020l wireless cameras.  They prompt for number of pictures and
delay between pictures (and dlinktimelapseAuth.py authentication information) 
and store snapshots in /var/www/images directory.  

timelapse.sh is a bash script to create a time sequence of photos using 
gphoto2 and a Canon Rebel XS camera.  The camera is connected via usb to 
a Beaglebone Black running Ubuntu Saucy 13.10.  

raspitimelapse.sh is a script to automate taking a sequence of photos
using the raspberry pi camera.  I know raspistill can do this directly
but I needed the scripting practice...  :)
