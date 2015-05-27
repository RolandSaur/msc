'''
Created on May 27, 2015

@author: saur
'''

import setup
from numpy import array

#setup.read_parameters_from_file(str)
setup.do_experiment("../experiment4/input_parameter.csv","../../experiment4_output/output_csv_exp4.csv",
                    array([1,1,20,5,5,0]))