'''
Created on Mar 16, 2015

@author: saur
'''
from cases import cases
from agent import agent
#testcases = cases(72)
#testcases.change_restrictions(0.0000000000001)
#testcases.set_base(72)
#testcases.add_power(2, 10)
#print testcases.get_power_actual(2)
#print testcases.get_power_actual(2)
#testcases.change_restrictions(0.0005)
#print testcases.get_power_actual(2)
#for k in range(0,100):
#    testcases.set_base(72)
#    testcases.add_power(2, k)
#    print testcases.get_power_actual(2)

time_init = 72
testcase = cases(time_init)
testcase.change_restrictions(5)
#create the agents
SOC_initial = 5
agents = dict()
for k in range(2,26):
    agents[k]= agent(SOC_initial,k,time_init)

"""here is what has to be repeated over and over again. """
## each agent does something to the environment
for i in agents:
    agents[i].do_interaction(testcase)

## the environment calculates the next step
output = testcase.get_output()

## the agent gets feedback from the environment
for i in agents:
    agents[i].get_feedback(output)
    


##here goes all kind of stuff, just to see some things.
#import csv 
#from scipy import *
#pos_voltage =linspace(0.98,1.02,5)
#print pos_voltage
#print linspace(0,20,41)

#ReadData=csv.reader(open('loadprofile.csv','rb'), delimiter=',')
#
#load = zeros(96)
#k=0
#print ReadData
#for data in ReadData:
#    if k==0:
#        print "ups"
#    else:
#        load[k-1] = data[1]
#    k += 1
    #print " ".join(data[1])
#print load


