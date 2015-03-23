# msc
master thesis file

Hi in here I will note which of the files are currently in use, because there is a lot of things that are not in use at the moment. 

Files:
cases.py:
	- basic MATPOWER case and some basic functions to interact with it
		- get_output() runs the case_model and return the output strucute
		- set_power(node,power) sets the dispatchabel load ot power at node 
		- change_restrictions(rateA) is supposed to change the current restriction

agent.py:
	- the agent class 
		- get_action() returns the action the agent wants to take
		- set_voltage(voltage) sets the voltage
		- power_used(power) charges the battery and thus updates the SOC
		- do_interaction(case_object) updates time and interacts with case-object
		- get_feedback(output) reads the power and voltage from the output

others.py:
	- currently runs the model to see how to enforce current restrictions


Currently: Try to get a handle on how to restrict the current in the branches so that the power the agents can use is lowered to what the grid allows.

