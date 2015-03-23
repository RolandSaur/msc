'''
Created on Mar 22, 2015

@author: saur
'''
from cases import cases

class agent(object):
    '''
    classdocs
    '''


    def __init__(self, SOC, node,time):
        '''
        Constructor
        '''
        self.SOC = SOC
        self.node = node
        self.Voltage = 1
        self.time = time
        
    def get_action(self):
        #returns the action the agent would like to perform based on time ,SOC and voltage
        return 0
    
    def set_voltage(self,voltage):
        #sets the voltage level that the agent sees 
        self.Voltage = voltage
        
    def power_uesd(self,power):
        self.SOC += power 
        
    def do_interaction(self,case_object):
        # increase the time and then interact with the case structure
        self.time += self.time
        case_object.add_power(self.node,self.get_action(self.time))
        
        
    def get_feedback(self, case_object):
        """might be better to run this once for all and then parse the result structure to each of them"""
        #gets feedback from the gird in the form of voltage and actual power consumption
        self.power_uesd(case_object.get_power_actual()) 
        self.set_voltage(case_object.get_voltage())