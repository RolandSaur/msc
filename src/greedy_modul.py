'''
Created on May 5, 2015

@author: saur
'''
from cases_second import cases
from greed_agent import agent
from numpy import random, zeros, savetxt,concatenate , ones
import time as zeiter
import csv

def run_model(str2_out,run_id):
	time_experiment = 96 * 6 *30
	time = 0
	soc = 20
	testcase = cases(time)
	soc_data = zeros((time_experiment,24))
	time_data = zeros((time_experiment,1))
	run_ids = ones((time_experiment,1)) * run_id
	agents = dict()
	
	for k in range(2,26):
	    #soc = random.normal(average_soc, sd_average_soc, 1)
	    agents[k]= agent(soc,k,time)
	    
	for i in agents:
	    soc_data[0,agents[i].node -2]=agents[i].get_soc()
	
	while (time < time_experiment -1):
	    time_data[time,0]=time
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
		time_data[time,0]=time        
		
	output_values_to_csv = concatenate((soc_data,time_data,run_ids),axis=1)
	with open(str2_out,'a') as csvfile:
		schreiber = csv.writer(csvfile,delimiter=',',quotechar='"')
		for row in output_values_to_csv:
			schreiber.writerow(row)


pathname = "/home/saur/Documents/master/output_data/greedy_folder/greedy_runs.csv"
#savetxt('/home/saur/test.txt',concatenate((soc_data,time_data),axis=1),fmt='%1.2f',delimiter=',')
with open(pathname,'w') as csvfile:
	schreiber = csv.writer(csvfile,delimiter=',',quotechar='"')
	headerline = ["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15","a16","a17","a18","a19","a20","a21","a22","a23","a24","time","run_id"]
	schreiber.writerow(headerline)

for run_id in range(1,101):
	run_model(pathname, run_id)
