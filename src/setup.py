'''
Created on Apr 28, 2015

@author: saur
'''
from cases_second import cases
import global_variables as g 
from agent import agent
from numpy import random, array, zeros
from go import go
import time as zeiter
import csv

parameter_matrix = []

def read_parameters_from_file(str):
    with open(str) as csvfile:
        leser = csv.reader(csvfile,delimiter = ",",quotechar='"' )
        k = 0 
        parameter_matrix = []
        for row in leser:
            if k !=0:
               parameter_matrix.append(row)
            k+=1
    return parameter_matrix
    


def setup(): 
    init_agents()
    #g.init_experiment("../experiment1/input_parameter.csv")
        
    
    
def init_agents():
    
    for k in range(2,26):
        soc = random.normal(g.average_soc, g.sd_average_soc, 1)
        g.agents[k]= agent(soc,k,g.time)
        g.agents[k].copy_all = g.copy_al
        
def set_global_rule(inst_rule):
    for k in g.agents:
        g.agents[k].active_rule = inst_rule
        
        
def init_global_vraibles(parameter_row_from_matrix):
    #"string is the path to the file in which the experiment is defined"
    g.random_change = parameter_row_from_matrix[0]
    g.copy_best_change = parameter_row_from_matrix[1]
    g.learn_change = parameter_row_from_matrix[2]
    g.copy_al = parameter_row_from_matrix[3]
    g.institutional_success_rate = parameter_row_from_matrix[4]
    if parameter_row_from_matrix[5] == 0:
        g.majority_vote = False
    if parameter_row_from_matrix[5] == 1:
        g.majority_vote = True
        
    #reset some of the values to the original
    g.institutional_rule = zeros(6)
    g.agents = dict()
    g.time = 0
    g.testcase = cases(g.time)
    g.average_arrival_time = 72
    g.average_laeving_time = 32
    g.sd_average = 1
    g.average_battery_drain = 10
    g.sd_average_battery_drain = 2
    g.average_soc = 20
    g.sd_average_soc = 2
    g.soc_max_gloabl = 40
    
def do_experiment_hpc(str,str2_out,run):
    parameter_matrix =read_parameters_from_file(str)[0]
    if not (isinstance(parameter_matrix[0],list)):
	print "one"
	number_experiments=1
    else:
	number_experiments =  len(parameter_matrix)
    #print len(parameter_matrix[0])
    g.run_id = run
    parameter_matrix = parameter_matrix[0:len(parameter_matrix)-1]
    
    with open(str2_out,'w') as csvfile:
        schreiber = csv.writer(csvfile,delimiter=',')
        schreiber.writerow(("random_change","copy_best","learn_change","copy_all","inst_success",
                            "majority", "time" ,"inst_rule1","inst_rule2","inst_rule3","inst_rule4",
                            "inst_rule5","inst_rule6", "voting","run_id","agent1_soc","agent2_soc","agent3_soc",
                            "agent4_soc","agent5_soc","agent6_soc","agent7_soc","agent8_soc","agent9_soc",
                            "agent10_soc","agent11_soc","agent12_soc","agent13_soc","agent14_soc",
                            "agent15_soc","agent16_soc","agent17_soc","agent18_soc","agent19_soc",
                            "agent20_soc","agent21_soc","agent22_soc","agent23_soc","agent24_soc"))
    for i in range(0,number_experiments):
        repetition_counter = 0 
        number_repetitions = parameter_matrix[6]
        #print number_repetitions
        while (repetition_counter < int(number_repetitions)):
            init_global_vraibles(parameter_matrix[0:6])
            
            #print g.run_id
            setup() 
                    
            go(str2_out)
            repetition_counter += 1 

def do_experiment(str,str2_out,*args):
    g.run_id = 0 
    parameter_matrix =read_parameters_from_file(str)
    number_experiments = len(parameter_matrix)
    
    with open(str2_out,'w') as csvfile:
        schreiber = csv.writer(csvfile,delimiter=',')
        schreiber.writerow(("random_change","copy_best","learn_change","copy_all","inst_success",
                            "majority", "time" ,"inst_rule1","inst_rule2","inst_rule3","inst_rule4",
                            "inst_rule5","inst_rule6", "voting","run_id","agent1_soc","agent2_soc","agent3_soc",
                            "agent4_soc","agent5_soc","agent6_soc","agent7_soc","agent8_soc","agent9_soc",
                            "agent10_soc","agent11_soc","agent12_soc","agent13_soc","agent14_soc",
                            "agent15_soc","agent16_soc","agent17_soc","agent18_soc","agent19_soc",
                            "agent20_soc","agent21_soc","agent22_soc","agent23_soc","agent24_soc"))
    for i in range(0,number_experiments):
        repetition_counter = 0 
        number_repetitions = parameter_matrix[i][6]
        print number_repetitions
        while (repetition_counter < int(number_repetitions)):
            init_global_vraibles(parameter_matrix[i][0:6])
            g.run_id += 1
            #print g.run_id
            setup() 
            
            if args: #if there is a default initial rule to be set set it for each agent. 
                for k in g.agents:
                    #print args[0]
                    g.agents[k].active_rule = args[0]
                    
            go(str2_out)
            repetition_counter += 1
            
def do_noise_experiment(str,str2_out,noise_levels):
    g.run_id = 0 
    parameter_matrix =read_parameters_from_file(str)
    number_experiments = len(noise_levels)
    print number_experiments
    print noise_levels
    
    with open(str2_out,'w') as csvfile:
        schreiber = csv.writer(csvfile,delimiter=',')
        schreiber.writerow(("random_change","copy_best","learn_change","copy_all","inst_success",
                            "majority", "time" ,"inst_rule1","inst_rule2","inst_rule3","inst_rule4",
                            "inst_rule5","inst_rule6", "voting","run_id","agent1_soc","agent2_soc","agent3_soc",
                            "agent4_soc","agent5_soc","agent6_soc","agent7_soc","agent8_soc","agent9_soc",
                            "agent10_soc","agent11_soc","agent12_soc","agent13_soc","agent14_soc",
                            "agent15_soc","agent16_soc","agent17_soc","agent18_soc","agent19_soc",
                            "agent20_soc","agent21_soc","agent22_soc","agent23_soc","agent24_soc","noise_level"))
    for i in range(0,number_experiments):
        #print parameter_matrix
        init_global_vraibles(parameter_matrix[i][0:6])
        repetition_counter = 0 
        number_repetitions = parameter_matrix[i][6]
        while repetition_counter < number_repetitions:
            g.run_id += 1
            
            setup() 
            #print noise_levels[i] 
            go(str2_out,noise_levels[i])
            
            repetition_counter += 1
    


