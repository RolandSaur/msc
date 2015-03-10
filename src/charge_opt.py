'''
Created on Mar 9, 2015

@author: saur
'''
from pybrain.rl.environments import Task
from scipy import array
from scipy import *

class charge_opt(Task):
    '''
    classdocs
    '''
    def reward_soc(self,soc):
        #print soc / 20.0 - 0.5
        return soc / 20.0 - 0.5 # to have the best value be at one 
    
    def reward_voltage(self,voltage):
        #print  1 - power(((1-voltage)/0.01),2)
        return 1 - power(((1-voltage)/0.01),2) # have the reward be 1 for voltage 1 and 0 for voltage 0.98 or 1.02
    
    def getReward(self):
        soc_weight = 0.8
        voltage_weight = 0.01
        return soc_weight * self.reward_soc(self.env.SOC) + voltage_weight * self.reward_voltage(self.env.Voltage)
    
    
    def performAction(self, action):
        """ The action vector is stripped and the only element is cast to integer and given 
            to the super class. 
        """
        Task.performAction(self, int(action[0]))
        
    def getObservation(self):
        #set the possible values and the actual value for soc and voltage
        pos_voltage =linspace(0.98,1.02,41)
        pos_soc = linspace(0,20,81)
        soc = self.env.SOC   
        voltage = self.env.Voltage
        
        # get the index of the nearest discrete voltage value
        dif_voltages = abs(ones(shape(pos_voltage))* voltage - pos_voltage)
        index_voltage = dif_voltages.argmin()
        
        # get the index of the nearest discrete soc value
        dif_soc = abs(ones(shape(pos_soc)) * soc - pos_soc)
        index_soc = dif_soc.argmin()
        
        #combine the indices to get the index in an array and not a matrix
        obs = array([index_soc * 41 + index_voltage])
        return obs