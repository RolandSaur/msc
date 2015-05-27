'''
Created on Apr 29, 2015

@author: saur
'''
import global_variables as g
from numpy import zeros , array, argmax, ones, shape, argmin
from scipy.cluster.vq import vq, kmeans, whiten
import csv
from global_variables import agents

def go(str2_out):
    time_experiment = 96 * 30 * 6 # this is just one day
    #print time_experiment
    #print g.copy_al
    #g.majority_vote = True
    
    voting = False
    while g.time < time_experiment:
        g.time += 1
        g.testcase.set_base(g.time)
        for i in g.agents:
            if g.agents[i].at_home:
                g.agents[i].do_interaction(g.testcase)
            else: 
                if g.time % 96 == g.agents[i].arrival_time:
                    g.agents[i].arrive_at_home()
                    
        g.testcase.adapt_main_generator()
        output = g.testcase.get_output()
        
        for i in g.agents:
            if g.agents[i].at_home:
                g.agents[i].get_feedback(output)
                if g.time % 96 == g.agents[i].leaving_time:
                    g.agents[i].at_home = False
                    
        for i in g.agents:
            g.agents[i].update_situation()
            
        if g.time % 672 == 0:
            if (voting == True):
                voting = True 
                if all(g.institutional_rule != zeros(6)):
                    count_memory = 0
                    for i in g.agents:
                        memory = g.agents[i].get_memory()
                        in_memory = False
                        for k in range(0,5):
                            if all(memory[k,0:6] == g.institutional_rule):
                                in_memory = True
                        if in_memory == True:
                            count_memory += 1
                    if count_memory < 24 * g.institutional_success_rate: # 12 because i have 24 agents
                        voting = False
                vote_rules()
                #for i in agents:
                #    print agents[i].get_active_rule()
            else:
                for i in g.agents:
                    g.agents[i].reset_values()
                for i in g.agents:
                    g.agents[i].change_rule()
                memory_full = True
                for i in g.agents:
                    if ((g.agents[i].memory[4,0]!= 1) &  (g.agents[i].memory[4,0]!= 2)):
                        memory_full = False
                if (memory_full == True):
                    voting = True
                    
        with open(str2_out,'a') as csvfile:
            schreiber = csv.writer(csvfile,delimiter=',',quotechar='"')
            output_values_to_csv = [g.random_change,g.copy_best_change,g.learn_change,g.copy_al,
                               g.institutional_success_rate,g.majority_vote, g.time,
                               g.institutional_rule[0],g.institutional_rule[1],g.institutional_rule[2],
                               g.institutional_rule[3],g.institutional_rule[4],g.institutional_rule[5],
                               voting,g.run_id]
            for i in g.agents:
                output_values_to_csv.append(float(g.agents[i].SOC))
            schreiber.writerow(output_values_to_csv)
        
        
        #print g.institutional_rule
        #print g.time / 96
                
                
    
                                
                   
                    

def vote_rules(): 
    if (g.majority_vote == False):
        election_matrix = zeros((240,7))
        n = 5
        index = 0 
        for i in g.agents:
            g.agents[i].reset_values()
        for i in g.agents:
            #print agents[i].node
            for k in range(0,5):
                multiple = 0
                while multiple < n - k-1:
                    election_matrix[index,:] = g.agents[i].get_memory()[k,:]
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
            
        g.institutional_rule = new_rule
        for i in g.agents:
            g.agents[i].active_rule = new_rule
    
    else:
        print "this is majority voting"
        election_matrix = zeros((24,7))
        index = 0 
        for i in g.agents:
            g.agents[i].reset_values()
            
        for i in g.agents:
            election_matrix[index,:] = g.agents[i].get_memory()[0,:]
            index += 1
            
        count_voltage = 0
        count_time = 0
        for k in range(0,24):
            if election_matrix[k,0] == 1:
                count_voltage += 1
            elif election_matrix[k,0] == 2:
                count_time += 1
                
        if count_voltage> count_time:
            new_rule = cluster_voltage_rule(election_matrix,count_voltage)
        else:
            new_rule = cluster_time_rule(election_matrix,count_time)
            
        g.institutional_rule = new_rule
        for i in g.agents:
            g.agents[i].active_rule = new_rule
            
            
        
        
        
    
        
        
def cluster_voltage_rule(election_matrix,number):
    sub_matrix = zeros((number,6))
    if (g.majority_vote == False):
        matrix_size = 240
    else:
        matrix_size = 24
    index =0 
    for k in range(0,matrix_size):
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
    soc_dif = abs(soc * ones(shape(g.soc_threshold_options)) - g.soc_threshold_options)
    index_soc  = argmin(soc_dif)
    soc = g.soc_threshold_options[index_soc]
    return array([1,volt,soc, action1, action2 , 0 ])

def cluster_time_rule(election_matrix,number):
    sub_matrix = zeros((number,6))
    index =0 
    if (g.majority_vote == False):
        matrix_size = 240
    else:
        matrix_size = 24
    for k in range(0,matrix_size):
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
    soc_dif = abs(soc * ones(shape(g.soc_threshold_options)) - g.soc_threshold_options)
    index_soc  = argmin(soc_dif)
    soc = g.soc_threshold_options[index_soc]
    return array([2,t_begin, t_end, soc, action1, action2])
    