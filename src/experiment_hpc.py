'''
Created on Jun 3, 2015

@author: saur
'''

import setup
import sys
import ntpath

#print sys.argv[1]
#path = sys.argv[3]
#
#head, tail = ntpath.split(path)
#setup.read_parameters_from_file(str)

path = sys.argv[1]
output = path[0:len(path)-4]
setup.do_experiment_hpc(path, output +"_"+sys.argv[2] + "_output.csv",sys.argv[2])