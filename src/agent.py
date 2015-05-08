'''
Created on Mar 22, 2015

@author: saur
'''
from cases import cases
from scipy import array
from numpy import linspace, matrix, zeros , random, shape, ones, argmin, lexsort
import global_variables
from global_variables import *

class agent(object):
    '''
    classdocs
    '''
    

    def __init__(self, SOC, node,time):
        '''
        Constructor
        '''
        self.actions = linspace(0,5,6)
        self.SOC = SOC
        self.node = node
        self.Voltage = 1
        self.time = time
        self.at_home = True
        self.memory = zeros((5,7))
        self.active_rule = zeros((1,7))
        self.soc_max = soc_max_gloabl
        self.count_steps = 0
        self.count_soc = 0 
        self.preference = 0
        self.mean_battery_drain = random.normal(average_battery_drain, sd_average_battery_drain, 1)
        self.sd_battery_drain = 2
        self.arrival_time = round(random.normal(average_arrival_time,sd_average,1))
        self.leaving_time = round(random.normal(average_laeving_time, sd_average,1))
        
        decide = random.uniform(0,1,1)
        if decide > 0.5:
            self.active_rule = self.create_random_voltage_rule()
            #print self.active_rule
        else:
            self.active_rule = self.create_random_time_rule()
            #print self.active_rule
        
    def change_rule(self):
        decide = random.uniform(0,1)
        if decide > 1 - random_change:
            decide_random = random.uniform(0,1)
            if decide_random > 0.5:
                self.active_rule = self.create_random_voltage_rule()
            else:
                self.active_rule = self.create_random_time_rule()
        elif (decide > 1- random_change - copy_best_change):
            self.copy_best()
        else:
            self.change_learn()
    
    def copy_best(self):
        best_value = -1
        best_rule = zeros(6)
        for i in agents:
            if (agents[i].node != self.node):
                if agents[i].memory[0,6] > best_value:
                    best_rule = agents[i].memory[0,0:6]
                    best_value = agents[i].memory[0,6]
        self.active_rule = best_rule
        
        
    def change_learn(self):
        count_time = 0 
        count_voltage = 0
        preference_time = 0 
        preference_voltage = 0
        k = 0 
        ended= False
        while (k< 5) & (ended==False):
            if self.memory[k,0] == 1:
                count_voltage +=1
                preference_voltage += self.memory[k,6]
            if self.memory[k,0] ==2:
                count_time +=1
                preference_time += self.memory[k,6]
            if self.memory[k,0] == 0:
                ended = True
            index = k
            k += 1
            
            
        if (index == 0):
            self.active_rule = self.memory[0,0:6]
        else:
            if (count_time ==0) | (count_voltage == 0):
                if count_voltage > count_time:
                    self.active_rule = self.weighted_volt_rule()
                else:
                    self.active_rule = self.weighted_time_rule()
            else:
                if ((preference_voltage/count_voltage) > (preference_time/count_time)):
                    self.active_rule = self.weighted_volt_rule()
                else: 
                    self.active_rule = self.weighted_time_rule()
                    
    def weighted_volt_rule(self):
        
        av_volt = 0 
        av_soc = 0 
        av_action1 = 0
        av_action2 =0
        counter = 0 
        for k in range(0,5):
            if self.memory[k,0] == 1:
                av_volt += self.memory[k,1] * self.memory[k,6]
                av_soc += self.memory[k,2] * self.memory[k,6]
                av_action1 += self.memory[k,3] * self.memory[k,6]
                av_action2 += self.memory[k,4] * self.memory[k,6]
                counter += self.memory[k,6]
        av_volt = av_volt / counter
        av_soc = av_soc / counter 
        av_action1 = av_action1 / counter
        av_action2 = av_action2 / counter
        #print "weighted voltage rule"
        #print array([1, av_volt, av_soc, av_action1, av_action2, 0])
        
        av_volt = round(av_volt,2)
        av_action1 = round(av_action1,0)
        av_action2 = round(av_action2,0)
        soc_dif = abs(av_soc * ones(shape(soc_threshold_options)) - soc_threshold_options)
        index_soc  = argmin(soc_dif)
        av_soc = soc_threshold_options[index_soc]
        return array([1, av_volt, av_soc, av_action1, av_action2, 0])
    
    def weighted_time_rule(self):
        av_time_begin =0 
        av_time_end = 0 
        av_soc = 0 
        av_action1 = 0
        av_action2 =0
        counter = 0 
        for k in range(0,5):
            if self.memory[k,0] == 2:
                av_time_begin += self.memory[k,1]*self.memory[k,6]
                av_time_end += self.memory[k,2]*self.memory[k,6]
                av_soc += self.memory[k,3]*self.memory[k,6]
                av_action1 += self.memory[k,4]*self.memory[k,6]
                av_action2 += self.memory[k,5]*self.memory[k,6]
                counter += self.memory[k,6]
        av_time_begin = av_time_begin / counter
        av_time_end = av_time_end / counter 
        av_soc = av_soc / counter 
        av_action1 = av_action1 / counter
        av_action2 = av_action2 / counter
        av_action1 = round(av_action1,0)
        av_action2 = round(av_action2,0)
        soc_dif = abs(av_soc * ones(shape(soc_threshold_options)) - soc_threshold_options)
        index_soc  = argmin(soc_dif)
        av_soc = soc_threshold_options[index_soc]
        av_time_begin = round(av_time_begin,0)
        av_time_end = round(av_time_end,0)
        #print "weighted time rule"
        #print array([2, av_time_begin, av_time_end, av_soc, av_action1, av_action2])
        return array([2, av_time_begin, av_time_end, av_soc, av_action1, av_action2])
                
        
    def reset_values(self):
        self.update_memory()
        self.count_steps = 0
        self.count_soc = 0 
        self.preference = 0 
        
    def update_memory(self):
        in_memory = False
        for k in range(0,5):
            if all(self.memory[k,0:6] == self.active_rule):
                in_memory = True
                memory_index = k 
        
        if in_memory:
            self.memory[memory_index,6] = (self.memory[memory_index,6] + self.preference) / 2
        else:
            memory_full = True
            k = 0
            while (k<5) & (memory_full == True):
                if (self.memory[k,0]==0):
                    memory_full = False
                    memory_index = k
                k += 1
            if (memory_full == False):
                self.memory[memory_index,0:6]= self.active_rule
                self.memory[memory_index,6] = self.preference
            else:
                if self.memory[4,6] < self.preference:
                    self.memory[4,0:6] = self.active_rule
                    self.memory[4,6] = self.preference
        self.memory = self.memory[lexsort((self.memory[:,6],))]
        self.memory = self.memory[::-1]
        
    def create_random_voltage_rule(self):
        voltage_threshold = random.choice(voltage_options)
        
        soc_threshold = random.choice(soc_threshold_options)
        action1 = random.choice(action_options)
        action2 = random.choice(action_options)
        #print "random_voltage_rule"
        #print array([1,voltage_threshold,soc_threshold,action1,action2,0])
        return array([1,voltage_threshold,soc_threshold,action1,action2,0])
    
    def create_random_time_rule(self):

        action1 = random.choice(action_options)
        action2 = random.choice(action_options)
        t_begin = random.choice(t_begin_options)
        t_end = random.choice(t_end_options)
        soc_threshold = random.choice(soc_threshold_options)
        #print "random_time_rule"
        #print array([2,t_begin,t_end,soc_threshold,action1,action2])
        return array([2,t_begin,t_end,soc_threshold,action1,action2])
    
    
    
    def get_action(self):
        #returns the action the agent would like to perform based on time ,SOC and voltage
        if self.SOC == self.soc_max:
            return 0
        else:
            if self.active_rule[0] ==1:  # voltage rule
                if (self.Voltage < self.active_rule[1]) & (self.SOC> self.active_rule[2]):
                    return self.active_rule[3]
                else:
                    return self.active_rule[4]
            else:
                if (self.active_rule[2] > self.active_rule[1]):
                    if ((self.active_rule[1] < self.time % 96) & (self.active_rule[2] > self.time % 96) & (self.SOC> self.active_rule[3]) ):
                        return self.active_rule[4]
                    else:
                        return self.active_rule[5]
                else:
                    if ((self.active_rule[1] < self.time % 96) | (self.active_rule[2] > self.time % 96) & (self.SOC> self.active_rule[3]) ):
                        return self.active_rule[4]
                    else:
                        return self.active_rule[5]
    

    
    def set_voltage(self,voltage):
        #sets the voltage level that the agent sees 
        self.Voltage = voltage
        
    def power_used(self,power):
        #calculate how much energy can be used to charge the battery and updates the state of charge (SOC) 
        self.SOC += (power)/4.0 #energy used in a 15 minute interval 
        if self.SOC > self.soc_max:
            self.SOC = self.soc_max
        
    def do_interaction(self,case_object):
        # increase the time and then interact with the case structure
        self.time += 1
        #print self.get_action()
        case_object.set_power(self.node,self.get_action())
        
        
    def get_feedback(self, output):
        #gets feedback from the gird in the form of voltage and actual power consumption
        #print - output["gen"][self.node-1,1] * 1000
        self.power_used(- 1000.0 * output['gen'][self.node-1,1])
        self.set_voltage(output["bus"][self.node-1,7])
        
    def get_active_rule(self):
        return self.active_rule
    def get_memory(self):
        return self.memory
        
    def arrive_at_home(self):
        self.at_home = True
        battery_drain = random.normal(self.mean_battery_drain,self.sd_battery_drain,1)
        self.SOC = self.SOC - battery_drain
        if self.SOC < 0:
            self.SOC = 0
            
    def update_situation(self):
        self.count_steps += 1
        self.count_soc += self.SOC
        self.preference = float(self.count_soc) / float(self.count_steps)
        
    def get_soc(self):
        return self.SOC
    
    def set_rule(self,rule):
        self.active_rule = rule 