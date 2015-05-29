'''
Created on May 29, 2015

@author: saur
'''
from scipy import array,ones , zeros
from pypower.api import  ppoption, runopf, runpf
from numpy import random

class cases(object):
    '''
    classdocs
    '''

    def __init__(self, Time):
        '''
        Constructs a pypower case and inits a load profile
        '''
        #data for the power flow 
        self.Time = Time ## might be a useless variable since the laod profile has been moved to the agent
        ##options
        self.ppopt = ppoption(PF_ALG=2, VERBOSE= 0,OUT_ALL=0)
        self.ppc = {"version": '2'}
        
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
        
        ## system MVA base
        self.ppc["baseMVA"] = 0.144
        #self.ppc["baseMVA"] = 7
        
        ## bus data
        # bus_i type Pd Qd Gs Bs area Vm Va baseKV zone Vmax Vmin
        self.ppc["bus"] = array([
        [1,3,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [2,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [3,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [4,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [5,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [6,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [7,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [8,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [9,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [10,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [11,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [12,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [13,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [14,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [15,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [16,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [17,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [18,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [19,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [20,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [21,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [22,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [23,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [24,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [25,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [26,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [27,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [28,1,0,0,0,0,0,1,1,0,1,1.1,0.94],
        [29,1,0,0,0,0,0,1,1,0,1,1.1,0.94]
    ])
        self.ppc["bus"][:,12] = 0.96
        #self.ppc["bus"][:,12]=0.90 # relaxes the lower voltage constraint.
        ## generator data
        # bus, Pg, Qg, Qmax, Qmin, Vg, mBase, status, Pmax, Pmin, Pc1, Pc2,
        # Qc1min, Qc1max, Qc2min, Qc2max, ramp_agc, ramp_10, ramp_30, ramp_q, apf
        
        
        self.ppc["branch"] = array([
        [2,1,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [3,2,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [4,3,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [5,4,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [6,5,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [7,6,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [8,7,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [9,1,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [10,9,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [11,10,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [12,11,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [13,12,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [14,13,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [15,14,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [16,1,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [17,16,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [18,17,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [19,18,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [20,19,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [21,20,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [22,21,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [23,1,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [24,23,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [25,24,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [26,25,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [27,26,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [28,27,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360],
        [29,28,0.001590, 0.000814,0,0,0,0,0,0,1,-360,360]
        ])
        self.ppc["branch"][:,2]= (0.494 * 0.097 / 1.5) * ones(28)
        self.ppc["branch"][:,3]= (0.0883 * 0.097 / 1.5) * ones(28)
        
        ## generator data
        # bus, Pg, Qg, Qmax, Qmin, Vg, mBase, status, Pmax, Pmin, Pc1, Pc2,
        # Qc1min, Qc1max, Qc2min, Qc2max, ramp_agc, ramp_10, ramp_30, ramp_q, apf
        self.ppc["gen"] = array([
        [1, 1, 0, 0,   -1, 1.0,  100, 1, 5,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [2, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [3, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [4, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [5, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [6, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [7, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [8, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [9, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [10, 0, 0,0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [11, 0, 0,0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [12, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [13, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [14, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [15, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [16, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [17, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [18, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [19, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [20, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [21, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [22, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [23, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [24, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [25, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [26, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [27, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [28, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [29, 0, 0, 0,   -1, 1.0,  100, 1,0, -20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ])
        self.ppc["gen"][:,9] = -1
        self.ppc["gen"][:,4]=1
        self.power_slopes = array([-0.00022311,
                                   -0.00044879,
                                   -0.00067714,
                                   -0.00090823,
                                   -0.00114216,
                                   -0.00137904,
                                   -0.00161895]
)
        self.dispatch_load = zeros(29)
        
    
    def add_noise(self,noise):
        for i in range(1,25):
            addition = random.normal(0,noise * self.ppc["bus"][i,2],1)
            
            self.ppc["bus"][i,2] += addition
            
            if self.ppc["bus"][i,2] < 0: # constrain so it does ont drop below 0 
                self.ppc["bus"][i,2] = 0
            if self.ppc["bus"][i,2] > max(self.loadprofile) /1000.0: # constrain so it does not exceed the maximum load
                self.ppc["bus"][i,2] = max(self.loadprofile) / 1000.0
        
        
    def get_output(self,*args):
        #returns the output of the load flow calculation
        for k in range(1,29):
            self.ppc["gen"][k,1] = self.dispatch_load[k]
            
        ppc_result, y = runpf(self.ppc, self.ppopt)
        
        if args:
            self.add_noise(args[0])
        
        #print ppc_result["bus"][1,12]
        #print ppc_result["bus"][6,7]
        #print ppc_result["bus"][12,7]
        #print ppc_result["bus"][18,7]
        #print ppc_result["bus"][24,7]
        
        
        branch_constraints  = array([(ppc_result["bus"][7,7] < (ppc_result["bus"][1,12])) ,
                                    ppc_result["bus"][14,7] < (ppc_result["bus"][1,12]) ,
                                    ppc_result["bus"][21,7] < (ppc_result["bus"][1,12]),
                                    ppc_result["bus"][28,7] < (ppc_result["bus"][1,12])])
        
        #print self.ppc["gen"][:,1]
        if any(branch_constraints == True):
            while(any(branch_constraints == True)):
                for k in range(0,4):
                    if branch_constraints[k] == True:
                        self.adapt_branch_power(ppc_result,k)
                        self.adapt_main_generator()
                        
                ppc_result, y = runpf(self.ppc, self.ppopt)
                #print self.ppc["gen"][:,1]
                for k in range(0,4):
                    if branch_constraints[k] == True:
                        branch_constraints[k] = (abs(ppc_result["bus"][k * 7+ 7,7] - ppc_result["bus"][1,12]) > 0.001)
                
                #print ppc_result["bus"][6,7]
                #print ppc_result["bus"][12,7]
                #print ppc_result["bus"][18,7]
                #print ppc_result["bus"][24,7]
                #print branch_constraints
                
        return ppc_result
    

    
    def adapt_branch_power(self,ppc_result, k):
        difference_voltage = ppc_result["bus"][1,12] - ppc_result["bus"][k * 7 + 7,7]
        if difference_voltage > 0:
            counter = k * 7 + 7
            #print self.ppc["gen"][counter,1]
            while (difference_voltage > 0) & (counter > k * 7 ):
                level = ((counter-1) % 7 )
                enough_power = ppc_result["gen"][counter,1] * 1000 * self.power_slopes[level] > difference_voltage
                if enough_power:
                    power = ppc_result["gen"][counter,1]
                    #print self.ppc["gen"][counter,1]
                    self.ppc["gen"][counter,1] -= difference_voltage / (self.power_slopes[level] * 1000)
                    #print self.ppc["gen"][counter,1]
                    difference_voltage -= power * 1000 * self.power_slopes[level]
                else:
                    power = ppc_result["gen"][counter,1]
                    self.ppc["gen"][counter,1] = 0
                    difference_voltage -= power * 1000 * self.power_slopes[level]
                counter -=1
        else:
            counter = k * 7 + 1
            
            while (difference_voltage < -0.001) & (counter < k * 7 + 8):
                level = ((counter-1) % 7 )
                #print self.dispatch_load[counter]
                #print self.ppc["gen"][counter,1]
                
                possible_power_difference = -(ppc_result["gen"][counter,1] - self.dispatch_load[counter]) # this should be negative because both are negative
                #print self.power_slopes[level]
                #print possible_power_difference
                enough_power =possible_power_difference * 1000 * self.power_slopes[level] >= abs(difference_voltage)
                if enough_power:
                    power_difference = -difference_voltage / (self.power_slopes[level])
                    difference_voltage += power_difference * self.power_slopes[level]
                    self.ppc["gen"][counter,1] += (power_difference / 1000)
                    
                else:
                    power_difference = possible_power_difference
                    #print power_difference * self.power_slopes[level] * 1000
                    difference_voltage += power_difference * self.power_slopes[level] * 1000
                    self.ppc["gen"][counter,1] = self.dispatch_load[counter]
                counter += 1
                
        
    
   
    def set_power(self,node, power):
        # sets the power at a specific node
        #print  power / 1000.0
        #self.ppc["bus"][node,2] +=  power / 1000.0 #divide by 1000 to transform it to MW , the node -1 because indexing starts with 0 
        #print power
        self.dispatch_load[node-1] = - power / 1000.0
        
        
    def adapt_main_generator(self):
        self.ppc["gen"][0,1] = - sum(self.ppc["gen"][1:25,1])
        #print self.ppc["gen"][0,1]
        
        
        
    def set_base(self,Time):
        #sets the model to the base load profiles at a certain point in time
        Time = Time % 96
        p = self.loadprofile[Time] * ones(29) / 1000
        p[0] = 0 # set the power at slack to 0
        for k in range(0,self.ppc["bus"].shape[0]):
            self.ppc["bus"][k,2]= p[k] #reset the p value
        