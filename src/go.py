'''
Created on Apr 29, 2015

@author: saur
'''
from global_variables import *
from numpy import zeros , array, argmax, ones, shape, argmin
from scipy.cluster.vq import vq, kmeans, whiten

def go():
    time_experiment = 96 * 44 # this is just one day
    global time
    global institutional_rule
    while time < time_experiment:
        time += 1
        voting = False
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
            agents[i].update_situation()
            
        if time % 672 == 0:
            if (voting == True):
                voting = True 
                if all(institutional_rule != zeros(6)):
                    count_memory = 0
                    for i in agents:
                        memory = agents[i].get_memory()
                        in_memory = False
                        for k in range(0,5):
                            if memory[k,0:6] == institutional_rule:
                                in_memory = True
                        if in_memory == True:
                            count_memory += 1
                    if count_memory < 24 * institutional_success_rate: # 12 because i have 24 agents
                        voting = False
                vote_rules()
                #for i in agents:
                #    print agents[i].get_active_rule()
            else:
                for i in agents:
                    agents[i].reset_values()
                for i in agents:
                    agents[i].change_rule()
                memory_full = True
                for i in agents:
                    if (agents[i].memory[4,0]==0):
                        memory_full = False
                if (memory_full == True):
                    voting = True
                
                                
                   
                    

def vote_rules():
    global institutional_rule
    election_matrix = zeros((240,7))
    n = 5
    index = 0 
    for i in agents:
        agents[i].reset_values()
    for i in agents:
        #print agents[i].node
        for k in range(0,5):
            multiple = 0
            while multiple < n - k-1:
                election_matrix[index,:] = agents[i].get_memory()[k,:]
                index += 1
                multiple += 1
    count_voltage = 0
    count_time = 0
    for k in range(0,240):
        if election_matrix[k,0] == 1:
            count_voltage += 1
        elif election_matrix[k,0] == 2:
            count_time += 1
            
    if count_voltage> count_time:
        new_rule = cluster_voltage_rule(election_matrix,count_voltage)
    else:
        new_rule = cluster_time_rule(election_matrix,count_time)
        
    institutional_rule = new_rule
    for i in agents:
        agents[i].active_rule = new_rule
        
        
def cluster_voltage_rule(election_matrix,number):
    sub_matrix = zeros((number,6))
    index =0 
    for k in range(0,240):
        if election_matrix[k,0] == 1:
            #print election_matrix[k,0:6]
            sub_matrix[index,:] = election_matrix[k,0:6]
            index += 1
    #sub_matrix = whiten(sub_matrix)
    new_rules , distortion= kmeans(sub_matrix, 3)
    counters , distortion = vq(sub_matrix, new_rules)
    count_rule1 = 0
    count_rule2 = 0
    count_rule3 = 0
    for k in counters:
        if k == 0:
            count_rule1 += 1
        elif k == 1:
            count_rule2 += 1
        elif k == 2:
            count_rule3 += 1
    rule_index_options = array([count_rule1, count_rule2, count_rule3])
    rule_index = argmax(rule_index_options)
    new_rule = new_rules[rule_index,:]
    volt = round(new_rule[1],2)
    action1 = round(new_rule[3],0)
    action2 = round(new_rule[4],0)
    soc = new_rule[2]
    soc_dif = abs(soc * ones(shape(soc_threshold_options)) - soc_threshold_options)
    index_soc  = argmin(soc_dif)
    soc = soc_threshold_options[index_soc]
    return array([1,volt,soc, action1, action2 , 0 ])

def cluster_time_rule(election_matrix,number):
    sub_matrix = zeros((number,6))
    index =0 
    for k in range(0,240):
        if election_matrix[k,0] == 2:
            sub_matrix[index,:] = election_matrix[k,0:6]
            index += 1
    #sub_matrix = whiten(sub_matrix)
    new_rules , distortion= kmeans(sub_matrix, 3)
    counters , distortion = vq(sub_matrix, new_rules)
    count_rule1 = 0
    count_rule2 = 0
    count_rule3 = 0
    for k in counters:
        if k == 0:
            count_rule1 += 1
        elif k == 1:
            count_rule2 += 1
        elif k == 2:
            count_rule3 += 1
    rule_index_options = array([count_rule1, count_rule2, count_rule3])
    rule_index = argmax(rule_index_options)
    new_rule = new_rules[rule_index,:]
    t_begin = round(new_rule[1],0)
    t_end = round(new_rule[2],0)
    action1 = round(new_rule[4],0)
    action2 = round(new_rule[5],0)
    soc = new_rule[3]
    soc_dif = abs(soc * ones(shape(soc_threshold_options)) - soc_threshold_options)
    index_soc  = argmin(soc_dif)
    soc = soc_threshold_options[index_soc]
    return array([2,t_begin, t_end, soc, action1, action2])
    