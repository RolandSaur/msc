'''
Created on Mar 16, 2015

@author: saur
'''
from cases_alternative_model import cases
from agent import agent
from pypower.api import  ppoption, runopf, runpf

min_value_voltage = 0.99
for time in range(0,96):
	testcase = cases(time)
	testcase.set_base(time)
	result , y = runpf(testcase.ppc,testcase.ppopt)
	print min(result["bus"][:,7])
	if min(result["bus"][:,7]) < min_value_voltage:
		min_value_voltage = min(result["bus"][:,7])

print min_value_voltage
"""
#create the agents
SOC_initial = 5
agents = dict()
for k in range(2,26):
    agents[k]= agent(SOC_initial,k,time_init)

##here is what has to be repeated over and over again.
## each agent does something to the environment
testcase.set_base(time_init)
#for i in agents:
#    agents[i].do_interaction(testcase)

testcase.adapt_main_generator()
#print testcase.get_output()
## the environment calculates the next step
output = testcase.get_output()
print min(output["bus"][:,7])
#print output

## the agent gets feedback from the environment
for i in agents:
    agents[i].get_feedback(output) 
"""

