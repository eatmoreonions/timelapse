#!/usr/bin/python

import urllib2
import base64
import time
from getpass import getpass
from datetime import datetime

camera = '10.9.5.105'
gifurl = 'http://' + camera + '/image/jpeg.cgi'

def getvars():
  username = raw_input("username: ")
  passwd = getpass("password: ")
  delay = input("how seconds between pictures? ")
  number = input("how many pictures in the sequence? ")
  return username, passwd, delay, number

def takepic(username, passwd):
  dtn=datetime.now()
  imagename='/var/www/images/dlink' + dtn.strftime("%m%d%Y-%H%M%S") + '.jpg'
  f = open(imagename, 'wb')
  request = urllib2.Request(gifurl)
  base64string = base64.encodestring('%s:%s' % (username, passwd)).replace('\n','')
  request.add_header("Authorization", "Basic %s" % base64string)
  f.write(urllib2.urlopen(request).read())
  f.close()
  return()

def run():
  username, passwd, delay, number = getvars()
  
  for i in range(0, number):
    if i > 0:
      time.sleep(delay)
    print "taking picture number " + str(i+1)
    takepic(username, passwd)

  return()

run()
