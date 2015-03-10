'''
Created on Mar 9, 2015

@author: saur
'''

from random import random, choice
from numpy import *

from pybrain.utilities import Named
from pybrain.rl.environments.environment import Environment

from change_case import adapt_case # load the adapt_case interface to interact with my own pypower case


class power_env(Environment, Named):
    '''
    Is the  environemt for pybrain
    '''
    SOC = None      #init the state of charge 
    SOC_init = None
    SOC_max = None
    SOC_min = 0
    Time = None     #init the time 
    Time_init = None
    Voltage = None  #init the voltage
    node = None     #init the node point in the grid
    all_actions = array([-4,-3,-2,-1,0,1,2,3,4])


    def __init__(self,Time, SOC, node):
        '''
        Constructor
        '''
        self.SOC = SOC
        self.SOC_init = SOC
        self.SOC_max = 20
        self.SOC_min = 0
        self.Time = Time
        self.Time_init = Time
        self.Voltage = adapt_case(node,0, Time)
        self.node = node 
        
    def reset(self):
        self.SOC = self.SOC_init
        self.Time = self.Time_init
        self.Voltage = adapt_case(self.node,0, self.Time)
        return 0 
        
    def charge_battery(self,real_action):
        """ The function that does the charging of the battery and checks if is full or empty"""
        tmp = self.SOC + real_action * 0.25
        if tmp < 0:
            tmp = self.SOC_min
        if tmp > self.SOC_max:
            tmp = self.SOC_max
        self.SOC = tmp 
        print self.SOC
    
    def performAction(self, action):
        """performsAction function charges battery updates the time and gets new voltage from the grid."""
        #print self.all_actions[action]
        #print self.SOC
        if (self.all_actions[action] < - 4 * self.SOC): #check if the power drawn exceeds the energy in the battery
            real_action = 4 * self.SOC #only limited power available
        else:
            real_action = self.all_actions[action] # full power can be drawn. 
            
        self.charge_battery(real_action)
        self.Time += 1  
        self.Voltage = adapt_case(self.node, real_action, self.Time)
        #print real_action
        return 0 
    

        
        