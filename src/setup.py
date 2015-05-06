'''
Created on Apr 28, 2015

@author: saur
'''
from cases_second import cases
from global_variables import *
from agent import agent
from numpy import random
from go import go
import time as zeiter


def setup(): 
    init_agents()
    
    
def init_agents():
    
    for k in range(2,26):
        soc = random.normal(average_soc, sd_average_soc, 1)
        agents[k]= agent(soc,k,time)


start = zeiter.time()
setup()

go()
for i in agents:
    z = agents[i].memory
    print z
print zeiter.time() - start
