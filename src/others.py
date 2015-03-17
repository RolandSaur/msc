'''
Created on Mar 16, 2015

@author: saur
'''

##here goes all kind of stuff, just to see some things.
import csv 
from scipy import *
pos_voltage =linspace(0.98,1.02,5)
print pos_voltage
print linspace(0,20,41)

ReadData=csv.reader(open('loadprofile.csv','rb'), delimiter=',')
load = zeros(96)
k=0
#print ReadData
for data in ReadData:
	if k==0:
		print "ups"
	else:
		load[k-1] = data[1]
	k += 1
	#print " ".join(data[1])


print load
