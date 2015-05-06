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
from power_env2 import *
import matplotlib.pyplot as plt




#set the environment 
environment = power_env2(80,5,3)

# create the lerner 
controller = ActionValueTable(63, 3)
controller.initialize(1.0)
learner = Q(0.5,1) # discount set to 0 because it is a infinitely long game
agent = LearningAgent(controller, learner)

# set the task 
task = charge_opt(environment, 0.8, 0.01)

#do experiment
number_of_runs = 20


#change the reward and run the whole experiment 
task.change_reward(1, 0.0)

# create the experiment
experiment = Experiment(task, agent)

k=0
while k < number_of_runs:
    experiment.doInteractions(96)
    agent.learn()
    agent.reset()
    #log some data of the first and last run.
    if k == 0:  # if it is the first run
        first_run_time2 = environment.log_time
        first_run_soc2 = environment.log_soc
        first_run_volt2 = environment.log_volt
    #if k == number_of_runs - 1: # if it it the last run
    #    last_run_time2 = environment.log_time
    #    last_run_soc2 = environment.log_soc
    #    last_run_volt2 = environment.log_volt 
    environment.reset()
    k += 1

agent.learning = False #to keep it from exploring
experiment = Experiment(task, agent) 
experiment.doInteractions(96)
last_run_time2 = environment.log_time
last_run_soc2 = environment.log_soc
last_run_volt2 = environment.log_volt


plt.plot(first_run_time2,first_run_soc2,'r--',last_run_time2,last_run_soc2,'g--')

plt.show()
