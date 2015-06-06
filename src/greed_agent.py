
'''
Created on Mar 22, 2015

@author: saur
'''
from cases import cases
from scipy import array
from numpy import linspace, matrix, zeros , random, shape, ones, argmin, lexsort


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
        self.soc_max = 40
        self.count_steps = 0
        self.count_soc = 0 
        self.preference = 0
        self.mean_battery_drain = random.normal(30,5, 1)
        self.sd_battery_drain = 2
        self.arrival_time = round(random.normal(32,1,1),0)
        self.leaving_time = round(random.normal(72, 1,1))
        

        

  
    
    
    
    def get_action(self):
        #returns the action the agent would like to perform based on time ,SOC and voltage
        if self.SOC == self.soc_max:
            return 0
        else:
            return 5
    
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
        self.time += self.time
        #print self.get_action()
        case_object.set_power(self.node,self.get_action())
        
        
    def get_feedback(self, output):
        #gets feedback from the gird in the form of voltage and actual power consumption
        #print - output["gen"][self.node-1,1] * 1000
        self.power_used(- 1000.0 * output['gen'][self.node-1,1])
        self.set_voltage(output["bus"][self.node-1,7])
        

        
    def arrive_at_home(self):
        self.at_home = True
        battery_drain = random.normal(self.mean_battery_drain,self.sd_battery_drain,1)
        self.SOC = self.SOC - battery_drain
        if self.SOC < 0:
            self.SOC = 0
            
    def update_situation(self):
        self.count_steps += 1
        self.count_soc += self.SOC
        self.preference = self.SOC / self.count_steps
        
    def get_soc(self):
        return self.SOC