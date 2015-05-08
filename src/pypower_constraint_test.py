'''
Created on May 6, 2015

@author: saur
'''

from cases_second import cases
from numpy import zeros, ones , array , random , savetxt, transpose, reshape

number_of_runs  = 20
unconstraint_matrix = zeros((4, number_of_runs))
constraint_matrix = zeros((4,number_of_runs))
load_vector = zeros((24,1))
difference_vector = zeros((24,1))
actions = array([1,2,3,4,5])
time = 90

def test_pypower_constrained(load_difference):
    correct = True
    for k in range(0,4):
        for i in range(0,6):
            if (load_difference[k,i] > 0) & (load_difference[k,i] < 1):
                if i != 5:
                    for z in range(i+1,6):
                        if (load_difference[k,z] !=1):
                            correct =False
                            
    return correct
    
    

for i in range(0, number_of_runs):
    testcase = cases(time)
    for k in range(0,24):
        load_vector[k,0] = random.choice(actions)
    
    
    testcase.set_base(time)
    for k in range(2,26):
        testcase.set_power(k, load_vector[k-2,0])
        
    testcase.adapt_main_generator()
    output = testcase.get_output()
    constraint_matrix[0,i]=output["bus"][6,7]
    constraint_matrix[1,i]=output["bus"][12,7]
    constraint_matrix[2,i]=output["bus"][18,7]
    constraint_matrix[3,i]=output["bus"][24,7]
    difference_vector =  - (testcase.ppc["gen"][1:25,1] - testcase.dispatch_load[1:25]) / testcase.dispatch_load[1:25]
    difference_vector = difference_vector.reshape((4,6))
    print "constraining branches in the correct order"
    print test_pypower_constrained(difference_vector)

    

    testcase2 = cases(time)
    testcase2.set_base(time)
    for k in range(2,26):
        testcase2.set_power(k, load_vector[k-2,0])
    
    testcase2.ppc["bus"][:,12] = 0.80
    testcase2.adapt_main_generator()
    output2 = testcase2.get_output()
    unconstraint_matrix[0,i]=output2["bus"][6,7]
    unconstraint_matrix[1,i]=output2["bus"][12,7]
    unconstraint_matrix[2,i]=output2["bus"][18,7]
    unconstraint_matrix[3,i]=output2["bus"][24,7]
    
    correct_unconstrained = True
    for i in range(0,4):
        if (output2["bus"][i*6 + 6,7] > 0.96):
            difference_vector =  - (testcase.ppc["gen"][1:25,1] - testcase.dispatch_load[1:25]) / testcase.dispatch_load[1:25]
            for k in range(i *6 ,i *6+6):
                if (difference_vector[k] !=0):
                    correct_unconstrained = False
    print "Not constraining branches which need no constraining"
    print correct_unconstrained
    
unconstraint_matrix = unconstraint_matrix.transpose()
constraint_matrix = constraint_matrix.transpose()
savetxt('/home/saur/constraint_test.txt',constraint_matrix,fmt='%1.4f',delimiter=',')
savetxt('/home/saur/unconstraint_test.txt',unconstraint_matrix,fmt='%1.4f',delimiter=',')