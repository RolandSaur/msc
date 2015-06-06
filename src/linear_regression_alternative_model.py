'''
Created on May 29, 2015

@author: saur
'''


from cases_alternative_model import cases
from pypower.api import  ppoption, runopf, runpf
from numpy import linspace
from scipy import array,ones , zeros
import matplotlib.pyplot as plt
from scipy.stats import linregress

time = 72

test_object = cases(time)
#test_object.set_base(time)
result , y = runpf(test_object.ppc,test_object.ppopt)
power = linspace(0,25,num=25)

slopes = zeros(7)
power_data_matrix  = zeros((25,7))
voltage_data_matrix  = zeros((25,7))
for index in range(2,9):
    count = 0
    voltages = zeros(25)
    powers = zeros(25)
    for p in power:
        test_object = cases(time)
        test_object.ppc["gen"][index-1,1] = - p /1000.0
        result , y = runpf(test_object.ppc,test_object.ppopt)
        power_data_matrix[count, index - 2] = p
        voltage_data_matrix[count, index - 2] = result["bus"][index-1,7]
        voltages[count] = result["bus"][index-1,7]
        powers[count] = p
        #print result["bus"][index,7]
        count += 1
    linereg =  linregress(powers, voltages)
    slopes[index - 2] = linereg[0]
 
 
 

#plot the linear regression in dashed lines and the actual output
for k in range(0,7):
    x = linspace(0,25,num =25)
    y = slopes[k] * x +1 
    plt.plot(power_data_matrix[:,k],voltage_data_matrix[:,k], x , y ,'g--')
    plt.hold(True)
plt.show()

print slopes
