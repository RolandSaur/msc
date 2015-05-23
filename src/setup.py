'''
Created on Apr 28, 2015

@author: saur
'''
from cases_second import cases
import global_variables as g 
from agent import agent
from numpy import random
from go import go
import time as zeiter


def setup(): 
    init_agents()
    
    
def init_agents():
    
    for k in range(2,26):
        soc = random.normal(g.average_soc, g.sd_average_soc, 1)
        g.agents[k]= agent(soc,k,g.time)


start = zeiter.time()
setup()

go()
for i in g.agents:
    z = g.agents[i].memory
    print z
print zeiter.time() - start
