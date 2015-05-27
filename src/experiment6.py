'''
Created on May 27, 2015

@author: saur
'''

import setup
from numpy import array

#setup.read_parameters_from_file(str)
setup.do_noise_experiment("../experiment6/input_parameter.csv","../../experiment6_output/output_csv_exp6.csv",
                    array([0.1,0.3,0.5,0.8]))