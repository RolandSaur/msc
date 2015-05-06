'''
Created on Mar 16, 2015

@author: saur
'''
from cases_second import cases
from agent import agent

time_init = 80
testcase = cases(time_init)

#create the agents
SOC_initial = 5
agents = dict()
for k in range(2,26):
    agents[k]= agent(SOC_initial,k,time_init)

"""here is what has to be repeated over and over again. """
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
    


