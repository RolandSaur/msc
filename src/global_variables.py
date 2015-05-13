'''
Created on Apr 28, 2015

@author: saur
'''
from numpy import linspace , zeros
from cases_second import cases

global institutional_rule 
global time
global action_options
global voltage_options
global soc_threshold_options
global average_soc
global sd_average_soc
global t_end_options
global t_begin_options
global testcase
global average_arrival_time
global average_laeving_time
global sd_average
global average_battery_drain
global sd_average_battery_drain
global soc_max_gloabl
global random_change
global copy_best_change
global learn_change
global agents
global institutional_success_rate
global majority_vote 
global copy_all


majority_vote = False
copy_all = True
institutional_success_rate = 0.5 

institutional_rule = zeros(6)
agents = dict()
time = 0
testcase = cases(time)
average_arrival_time = 72
average_laeving_time = 32
sd_average = 1
average_battery_drain = 10
sd_average_battery_drain = 2
average_soc = 20
sd_average_soc = 2
soc_max_gloabl = 40
random_change = 0.5
copy_best_change = 0.3
learn_change = 0.2
#steps_threshhold = 96
action_options = [0,1,2,3,4,5]
t_end_options = linspace(1,96,96)
t_begin_options = t_end_options 
soc_threshold_options = linspace(0, soc_max_gloabl, 9)
voltage_options = linspace(0.96,1,5)