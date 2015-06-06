'''
Created on Mar 8, 2015

@author: saur
'''
from pypower.api import  ppoption, runpf
from case_modul import casemodul
from numpy import *

def adapt_case(node,power, time):
    #input node is the node that the agent accesses, the power is in kW , the time is the timestep [0,96]
    time = time % 96 # if the time interval exceeds the number of elements in the load profile
    loadprofile = 0.001 * array([2.1632,1.9456,1.7568,1.5968,1.4784 ,1.3952,1.3408,1.3056,1.2832,1.2672,
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
    q = zeros(25) #set the reactive power to zero at each point
    p = loadprofile[time] * ones(25) # set the active power at each grid point to the value in the load profile given the time
    p[0] = 0 # set the load at the transformer to 0
    p[node] = p[node] + power * 0.001 # add the power to the node that the agent controlls
    
    # do the actual power flow simulation
    ppc = casemodul(p,q) 
    ppopt = ppoption(PF_ALG=2, VERBOSE= False,OUT_ALL=0)
    ppc_result,y = runpf(ppc, ppopt)  #run the powerflow simulation gibven the case and the options
    
    return ppc_result["bus"][node,7]
    
    