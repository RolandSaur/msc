'''
Created on Mar 10, 2015

@author: saur
'''
from scipy import *
import sys, time

from pybrain.rl.experiments import Experiment
from pybrain.rl.environments import Task
from pybrain.rl.learners.valuebased import ActionValueTable
from pybrain.rl.agents import LearningAgent
from pybrain.rl.learners import Q, SARSA
from charge_opt import *
from power_env import *

#from matplotlib.pyplot import plot


#set the environment 
environment = power_env(80,5,3)

# create the lerner 
controller = ActionValueTable(3321, 9)
controller.initialize(1.)
learner = Q()
agent = LearningAgent(controller, learner)

# set the task 
task = charge_opt(environment)

# create experiment 
experiment = Experiment(task, agent)

#do experiment
number_of_runs = 1000
k = 0 
while k < number_of_runs:
    experiment.doInteractions(32)
    agent.learn()
    agent.reset()
    k += 1
    
    
print "this test github"