'''
Created on Mar 22, 2015

@author: saur
'''
from cases import cases
from scipy import array
from numpy import linspace

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
        #set the base load profile in the back
        self.loadprofile = array([2.1632,1.9456,1.7568,1.5968,1.4784 ,1.3952,1.3408,1.3056,1.2832,1.2672,
1.2608,1.2512,1.2416,1.2352,1.2256,
1.2256,1.2288,1.2416,1.2576,1.28,
1.3088,1.3792,1.5264,1.7856,2.176,
2.6496,3.136,3.568,3.8912,4.112,
4.2464,4.3136,4.3328,4.3136,4.2592,
4.1824,4.0864,3.9872,3.888,3.808,
3.7536,3.7184,3.7024,3.7024,3.7152,
3.744,3.7984,3.888,4.0128,4.1472,
4.256,4.3136,4.2944,4.2144,4.096,
3.968,3.8464,3.7376,3.6384,3.5424,
3.4528,3.376,3.312,3.2768,3.2704,
3.3024,3.3792,3.5168,3.712,3.9584,
4.2432,4.5536,4.8768,5.1904,5.4784,
5.7248,5.9104,6.0224,6.0448,5.9648,
5.7824,5.5264,5.2448,4.9792,4.7648,
4.5888,4.4288,4.2624,4.0704,3.856,
3.6256,3.3824,3.136,2.8864,2.64,
2.3968])
        
        
    def get_restricted(self):
        return self.actions[5] ## right now just unrestricted values 
    
    
    def get_action(self):
        #returns the action the agent would like to perform based on time ,SOC and voltage
        #base_load = self.loadprofile[self.time % 96]
        base_load =0
        #charging_load = self.actions[5]
        #print base_load + charging_load
        charging_load = self.get_restricted()
        print base_load + charging_load

        return base_load + charging_load
    

    
    def set_voltage(self,voltage):
        #sets the voltage level that the agent sees 
        self.Voltage = voltage
        
    def power_used(self,power):
        #calculate how much energy can be used to charge the battery and updates the state of charge (SOC) 
        self.SOC += (power - self.loadprofile[self.time % 96])/4.0 #energy used in a 15 minute interval 
        #print self.SOC
        
    def do_interaction(self,case_object):
        # increase the time and then interact with the case structure
        self.time += self.time
        case_object.set_power(self.node,self.get_action())
        
        
    def get_feedback(self, output):
        #gets feedback from the gird in the form of voltage and actual power consumption
        print - output["gen"][self.node-1,1] * 1000
        self.power_used(- 1000.0 * output["gen"][self.node-1,1])
        self.set_voltage(output["bus"][self.node-1,7])
        
        
        #self.power_uesd(case_object.get_power_actual()) 
        #self.set_voltage(case_object.get_voltage())