#!/usr/bin/python

import urllib2
import time
from datetime import datetime

def getvars():
  delay = input("how seconds between pictures? ")
  number = input("how many pictures in the sequence? ")
  return delay, number

def takepic():
  dtn=datetime.now()
  imagename='/var/www/images/dlink' + dtn.strftime("%m%d%Y-%H%M%S") + '.jpg'
  f = open(imagename, 'wb')
  f.write(urllib2.urlopen("http://10.9.5.105/image/jpeg.cgi").read())
  f.close()

def run():
  delay, number = getvars()
  
  for i in range(0, number):
    print "taking picture number " + str(i+1)
    takepic()
    time.sleep(delay)

run()
