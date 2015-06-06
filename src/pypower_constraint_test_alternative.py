'''
Created on May 29, 2015

@author: saur
'''
from cases_alternative_model import cases
from numpy import zeros, ones , array , random , savetxt, transpose, reshape

number_of_runs  = 20
unconstraint_matrix = zeros((4, number_of_runs))
constraint_matrix = zeros((4,number_of_runs))
load_vector = zeros((28,1))
difference_vector = zeros((28,1))
actions = array([1,2,3,4,5])
time = 90

def test_pypower_constrained(load_difference):
    correct = True
    for k in range(0,4):
        for i in range(0,7):
            if (load_difference[k,i] > 0) & (load_difference[k,i] < 1):
                if i != 5:
                    for z in range(i+1,7):
                        if (load_difference[k,z] !=1):
                            correct =False
                            
    return correct
    
    

for i in range(0, number_of_runs):
    testcase = cases(time)
    for k in range(0,28):
        load_vector[k,0] = random.choice(actions)
    
    
    testcase.set_base(time)
    for k in range(2,30):
        testcase.set_power(k, load_vector[k-2,0])
    
    
    testcase.adapt_main_generator()
    output = testcase.get_output()
    
    constraint_matrix[0,i]=output["bus"][7,7]
    constraint_matrix[1,i]=output["bus"][14,7]
    constraint_matrix[2,i]=output["bus"][21,7]
    constraint_matrix[3,i]=output["bus"][28,7]
    difference_vector =  - (testcase.ppc["gen"][1:29,1] - testcase.dispatch_load[1:29]) / testcase.dispatch_load[1:29]
    difference_vector = difference_vector.reshape((4,7))
    print "constraining branches in the correct order"
    print test_pypower_constrained(difference_vector)

    

    testcase2 = cases(time)
    testcase2.set_base(time)
    for k in range(2,30):
        testcase2.set_power(k, load_vector[k-2,0])
    
    testcase2.ppc["bus"][:,12] = 0.60
    testcase2.adapt_main_generator()
    output2 = testcase2.get_output()
    unconstraint_matrix[0,i]=output2["bus"][7,7]
    unconstraint_matrix[1,i]=output2["bus"][14,7]
    unconstraint_matrix[2,i]=output2["bus"][21,7]
    unconstraint_matrix[3,i]=output2["bus"][28,7]
    
    correct_unconstrained = True
    for i in range(0,4):
        if (output2["bus"][i*7 + 7,7] > 0.96):
            difference_vector =  - (testcase.ppc["gen"][1:29,1] - testcase.dispatch_load[1:29]) / testcase.dispatch_load[1:29]
            for k in range(i *7 ,i *7+7):
                if (difference_vector[k] !=0):
                    correct_unconstrained = False
    print "Not constraining branches which need no constraining"
    print correct_unconstrained
    
unconstraint_matrix = unconstraint_matrix.transpose()
constraint_matrix = constraint_matrix.transpose()
savetxt('/home/saur/constraint_alternative_test.txt',constraint_matrix,fmt='%1.4f',delimiter=',')
savetxt('/home/saur/unconstraint_alternative_test.txt',unconstraint_matrix,fmt='%1.4f',delimiter=',')
