'''
Created on May 5, 2015

@author: saur
'''
from cases_second import cases
from greed_agent import agent
from numpy import random, zeros, savetxt
import time as zeiter

time_experiment = 96 * 7
time = 0
soc = 20
testcase = cases(time)
soc_data = zeros((time_experiment,24))
agents = dict()

for k in range(2,26):
    #soc = random.normal(average_soc, sd_average_soc, 1)
    agents[k]= agent(soc,k,time)
    
for i in agents:
    soc_data[0,agents[i].node -2]=agents[i].get_soc()

while (time < time_experiment -1):
    time += 1
    testcase.set_base(time)
    
    for i in agents:
        if agents[i].at_home:
            agents[i].do_interaction(testcase)
        else: 
            if time % 96 == agents[i].arrival_time:
                agents[i].arrive_at_home()
                
    testcase.adapt_main_generator()
    output = testcase.get_output()
    for i in agents:
        if agents[i].at_home:
            agents[i].get_feedback(output)
            if time % 96 == agents[i].leaving_time:
                agents[i].at_home = False
                          
    for i in agents:
        soc_data[time,agents[i].node -2]=agents[i].get_soc()
        
        
savetxt('/home/saur/test.txt',soc_data,fmt='%1.2f',delimiter=',')

