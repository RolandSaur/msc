'''
Created on May 6, 2015

@author: saur
'''
import unittest
from agent import agent
from numpy import array,zeros, ones
from global_variables import agents
from cases_second import cases

class TestStringMethods(unittest.TestCase):
    
    
    def test_simple(self):
        agent1 = agent(20,1,32)
        self.assertEqual(agent1.get_soc(), 20,"simple soc set test")
        self.assertEqual(agent1.node, 1,"simple node set test")
    
    def test_reset_values(self):
        agent1 = agent(20,1,32)
        agent1.update_situation()
        agent1.SOC = 10 
        agent1.update_situation()
        agent1.SOC = 40
        agent1.update_situation()
        agent1.SOC = 10
        agent1.update_situation()
        agent1.reset_values()
        self.assertEqual(agent1.count_steps, 0, "reset values 1")
        self.assertEqual(agent1.count_soc, 0, "reset values 2")
        self.assertEqual(agent1.preference, 0, "reset values 3")
        

    def test_update_situation(self):
        agent1 = agent(20,1,32)
        agent1.update_situation()
        agent1.SOC = 10 
        agent1.update_situation()
        agent1.SOC = 40
        agent1.update_situation()
        agent1.SOC = 10
        agent1.update_situation()
        self.assertEqual(agent1.preference, 20, "update_situation")
        
    def test_power_used1(self):
        agent1 = agent(20,1,32)
        agent1.power_used(4)
        self.assertEqual(agent1.SOC, 21,"power used")
        agent1.power_used(1)
        self.assertEqual(agent1.SOC, 21.25,"power used")
        agent1.power_used(2)
        self.assertEqual(agent1.SOC, 21.75,"power used")
        
    def test_power_used2(self):
        agent1 = agent(39,1,32)
        agent1.power_used(4)
        self.assertEqual(agent1.SOC,40, "power used 2")
        agent1.power_used(4)
        self.assertEqual(agent1.SOC,40,"power used 2")
        
    def test_get_action_volt(self):
        agent1 = agent(20,1,32)
        agent1.set_voltage(0.97)
        self.assertEqual(agent1.Voltage,0.97) 
        
        rule =array([1, 0.96, 30, 5, 2, 0])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(), 2,"get action voltage rule 1")
        
        rule = array([1, 0.98, 10, 5, 2, 0])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(),5 , "get action voltage rule 2")
        
        rule = array([1, 0.98, 30, 5, 2, 0])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(),2 , "get action voltage rule 3")
        
        rule = array([1, 0.96, 10, 5, 2, 0])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(),2 , "get action voltage rule 4") 
        
        agent1.SOC = 40 
        self.assertEqual(agent1.get_action(), 0, "get action voltage rule 5")  
        
    def test_get_action_time(self):
        agent1 = agent(20,1,32)
        agent1.set_voltage(0.97)
        self.assertEqual(agent1.Voltage,0.97) 
        
        rule =array([2, 16, 35, 10, 5, 2])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(), 5, "get action time rule 1")
        
        rule =array([2, 16, 35, 30, 5, 2])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(), 2, "get action time rule 2")
        
        rule =array([2, 86, 35, 10, 5, 2])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(), 5, "get action time rule 3")
            
        rule =array([2, 26, 30, 10, 5, 2])
        agent1.set_rule(rule)
        self.assertEqual(agent1.get_action(), 2, "get action time rule 4")
        
    def test_update_memory(self):
        agent1 = agent(20,1,32)
        #new rule is good enough to make it into the memomry and is new
        memory = zeros((5,7))
        memory[0,:] = array([2, 26, 30, 10, 5, 2, 3])
        memory[1,:] = array([2, 26, 36, 10, 5, 2, 2.5])
        memory[2,:] = array([2, 23, 40, 10, 5, 2, 2])
        memory[3,:] = array([2, 25, 45, 10, 5, 2, 1.5])
        memory[4,:] = array([2, 22, 30, 10, 5, 2, 1])
        agent1.memory = memory
        rule = array([1, 0.98, 30, 5, 2, 0])
        memory_after = zeros((5,7))
        memory_after[0,:] = array([2, 26, 30, 10, 5, 2, 3])
        memory_after[1,:] = array([2, 26, 36, 10, 5, 2, 2.5])
        memory_after[2,:] = array([1, 0.98, 30, 5, 2, 0,2.2])
        memory_after[3,:] = array([2, 23, 40, 10, 5, 2, 2])
        memory_after[4,:] = array([2, 25, 45, 10, 5, 2, 1.5])
        
        agent1.set_rule(rule)
        agent1.preference = 2.2
        agent1.update_memory()
        for i in range(0,6):
            for k in range(0,4):
                self.assertEqual(agent1.get_memory()[k,i], memory_after[k,i], "update memory 1")
                
                
        # new rule is not good enough and the memory stays the same
        memory = zeros((5,7))
        memory[0,:] = array([2, 26, 30, 10, 5, 2, 3])
        memory[1,:] = array([2, 26, 36, 10, 5, 2, 2.5])
        memory[2,:] = array([2, 23, 40, 10, 5, 2, 2])
        memory[3,:] = array([2, 25, 45, 10, 5, 2, 1.5])
        memory[4,:] = array([2, 22, 30, 10, 5, 2, 1])
        agent1.memory = memory
        agent1.set_rule(rule)
        agent1.preference = 0.5
        memory_after = memory
        agent1.update_memory()
        for i in range(0,6):
            for k in range(0,4):
                self.assertEqual(agent1.get_memory()[k,i], memory_after[k,i], "update memory 2")
                
        
        #new rule is already in the memory
        memory = zeros((5,7))
        memory[0,:] = array([2, 26, 30, 10, 5, 2, 3])
        memory[1,:] = array([2, 26, 36, 10, 5, 2, 2.5])
        memory[2,:] = array([2, 23, 40, 10, 5, 2, 2])
        memory[3,:] = array([2, 25, 45, 10, 5, 2, 1.5])
        memory[4,:] = array([2, 22, 30, 10, 5, 2, 1])
        
        rule = array([2, 26, 30, 10, 5, 2])
        agent1.memory = memory
        agent1.set_rule(rule)
        agent1.preference = 0.25
        memory_after = zeros((5,7))
        memory_after[0,:] = array([2, 26, 36, 10, 5, 2, 2.5])
        memory_after[1,:] = array([2, 23, 40, 10, 5, 2, 2])
        memory_after[2,:] = array([2, 26, 30, 10, 5, 2,1.625])
        memory_after[3,:] = array([2, 25, 45, 10, 5, 2, 1.5])
        memory_after[4,:] = array([2, 25, 45, 10, 5, 2, 1.5])
        agent1.update_memory()
        for i in range(0,6):
            for k in range(0,4):
                self.assertEqual(agent1.get_memory()[k,i], memory_after[k,i], "update memory 3")
        
    def test_weighted_time_rules(self):
        agent1 = agent(20,1,32)
        
        #only time based rules in the memory
        memory = zeros((5,7))
        memory[0,:] = array([2, 20, 30, 10, 5, 2, 5])
        memory[1,:] = array([2, 20, 40, 5, 5, 2, 4])
        memory[2,:] = array([2, 30, 40, 5, 3, 3, 3])
        memory[3,:] = array([2, 30, 50, 10, 3, 3, 2])
        memory[4,:] = array([2, 10, 50, 10, 3, 3, 1])
        agent1.memory = memory
        new_rule = agent1.weighted_time_rule()
        self.assertEqual(new_rule[1], 23, "weighted time rules 1")
        self.assertEqual(new_rule[2], 39,"weighted time rules 1")
        self.assertEqual(new_rule[3], 10,"weighted time rules 1")
        self.assertEqual(new_rule[4], 4,"weighted time rules 1")
        self.assertEqual(new_rule[5], 2,"weighted time rules 1")
        
        #time and voltage rules are in the memory 
        memory = zeros((5,7))
        memory[0,:] = array([2, 20, 30, 10, 5, 2, 5])
        memory[1,:] = array([2, 20, 40, 5, 5, 2, 4])
        memory[2,:] = array([1, 0.98, 30, 5, 2, 0,2.2])
        memory[3,:] = array([2, 30, 50, 10, 3, 3, 2])
        memory[4,:] = array([1, 0.98, 20, 5, 2, 0,0.2])
        agent1.memory = memory
        new_rule = agent1.weighted_time_rule()
        self.assertEqual(new_rule[0], 2, "weighted time rules 1")
        self.assertEqual(new_rule[1], 22, "weighted time rules 1")
        self.assertEqual(new_rule[2], 37,"weighted time rules 1")
        self.assertEqual(new_rule[3], 10,"weighted time rules 1")
        self.assertEqual(new_rule[4], 5,"weighted time rules 1")
        self.assertEqual(new_rule[5], 2,"weighted time rules 1")
        
    def test_weighted_volt_rules(self):
        agent1 = agent(20,1,32)
        
        #only volt based rules in the memory
        memory = zeros((5,7))
        memory[0,:] = array([1, 0.97, 30, 5, 2, 0,5])
        memory[1,:] = array([1, 0.97, 20, 5, 2, 0,4])
        memory[2,:] = array([1, 0.96, 20, 3, 2, 0,3])
        memory[3,:] = array([1, 0.98, 40, 3, 5, 0,2])
        memory[4,:] = array([1, 0.98, 40, 3, 5, 0,1])
        agent1.memory = memory
        new_rule = agent1.weighted_volt_rule()
        self.assertEqual(new_rule[0], 1, "weighted time rules 1")
        self.assertEqual(new_rule[1], 0.97, "weighted time rules 1")
        self.assertEqual(new_rule[2], 25,"weighted time rules 1")
        self.assertEqual(new_rule[3], 4,"weighted time rules 1")
        self.assertEqual(new_rule[4], 3,"weighted time rules 1")
        self.assertEqual(new_rule[5], 0,"weighted time rules 1")
        
        #time and voltage rules are in the memory
        memory = zeros((5,7))
        memory[0,:] = array([1, 0.97, 30, 5, 2, 0,5])
        memory[1,:] = array([2, 20, 40, 5, 5, 2, 4])
        memory[2,:] = array([1, 0.96, 20, 3, 2, 0,3])
        memory[3,:] = array([2, 30, 50, 10, 3, 3, 2])
        memory[4,:] = array([1, 0.98, 40, 3, 5, 0,1])
        agent1.memory = memory
        new_rule = agent1.weighted_volt_rule()
        self.assertEqual(new_rule[0], 1, "weighted time rules 1")
        self.assertEqual(new_rule[1], 0.97, "weighted time rules 1")
        self.assertEqual(new_rule[2], 30,"weighted time rules 1")
        self.assertEqual(new_rule[3], 4,"weighted time rules 1")
        self.assertEqual(new_rule[4], 2,"weighted time rules 1")
        self.assertEqual(new_rule[5], 0,"weighted time rules 1")
        
    def test_copy_best(self):
        time =32
        for k in range(2,26):
            agents[k]= agent(30,k,time)
            
        bad_memory = zeros((5,7))
        bad_memory[0,:] = array([1, 0.97, 30, 5, 2, 0,4.5])
        bad_memory[1,:] = array([2, 20, 40, 5, 5, 2, 4])
        bad_memory[2,:] = array([1, 0.96, 20, 3, 2, 0,3])
        bad_memory[3,:] = array([2, 30, 50, 10, 3, 3, 2])
        bad_memory[4,:] = array([1, 0.98, 40, 3, 5, 0,1])
        
        for i  in agents:
            agents[i].memory = bad_memory
        
        good_memory = zeros((5,7))
        good_memory[0,:] = array([1, 0.99, 20, 5, 5, 0,5])
        good_memory[1,:] = array([2, 20, 40, 5, 5, 2, 4])
        good_memory[2,:] = array([1, 0.96, 20, 3, 2, 0,3])
        good_memory[3,:] = array([2, 30, 50, 10, 3, 3, 2])
        good_memory[4,:] = array([1, 0.98, 40, 3, 5, 0,1])   
        
        i = 2
        agents[i].memory = good_memory 
        best_rule =array([1, 0.99, 20, 5, 5, 0])
        agents[3].copy_best()
        copied_rule =    agents[3].active_rule
        for k in range(0,6):
            self.assertEqual(best_rule[k],copied_rule[k],"copy best rule test")
        
    def test_do_interaction(self):
        time =32
        testcase = cases(time)
        testcase.set_base(time)
        
        for k in range(2,26):
            agents[k] = agent(30,k,time)
            agents[k].Voltage = 0.98
            agents[k].set_rule(array([1, 0.97, 20, 5, 2, 0]))
            
            
        for i in agents:
            agents[i].do_interaction(testcase)
            
        for i in agents:
            self.assertEqual(agents[i].time,33, "do interaction time test")
            
        load_vector = array([0, -0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002,-0.002])

        for i in range(0,25):
            self.assertEqual(testcase.dispatch_load[i], load_vector[i], "do interaction dispatchabel load test")
            
            
    def test_get_feedback(self):
        time =32
        testcase = cases(time)
        testcase.ppc["bus"][:,12] = 0.90 #basically drop the voltage restriction 
        testcase.set_base(time)
        
        for k in range(2,26):
            agents[k] = agent(30,k,time)
            agents[k].Voltage = 0.98
            agents[k].set_rule(array([1, 0.99, 20, 4, 2, 0]))
            
            
        for i in agents:
            agents[i].do_interaction(testcase)
            
        testcase.adapt_main_generator()
        output = testcase.get_output()
        for i in agents:
            agents[i].get_feedback(output)
            
        for i in agents:
            self.assertEqual(agents[i].SOC, 31, "test get feedback check SOC")
            
            
    def test_arrive_at_home(self):
        agent1= agent(20,1,23)
        agent1.at_home = False
        agent1.arrive_at_home()
        self.assertEqual(agent1.at_home,True, "test arrive at home, at home true")
        
        agent1.SOC = -2 
        agent1.at_home = False
        agent1.arrive_at_home()
        self.assertEqual(agent1.SOC, 0, "test arrive at home soc equal 0")
        
    def test_vote_rule(self):
        memory = zeros((5,7))
        time = 32
        memory[0,:] = array([2, 20, 30, 10, 5, 2, 5])
        memory[1,:] = array([2, 20, 40, 5, 5, 2, 4])
        memory[2,:] = array([1, 0.98, 30, 5, 2, 0,2.2])
        memory[3,:] = array([2, 30, 50, 10, 3, 3, 2])
        memory[4,:] = array([1, 0.98, 20, 5, 2, 0,0.2])
        n = 5
        agents = dict()
        for i in range(2,26):
            agents[i] = agent(30,i,time)
            agents[i].memory = memory
            
            
        global institutional_rule
        election_matrix = zeros((240,7))

        index = 0 
        for i in agents:
            agents[i].reset_values()
        for i in agents:
            #print agents[i].node
            for k in range(0,5):
                multiple = 0
                while multiple < n - k-1:
                    election_matrix[index,:] = agents[i].get_memory()[k,:]
                    index += 1
                    multiple += 1
        count_voltage = 0
        count_time = 0
        for k in range(0,240):
            if election_matrix[k,0] == 1:
                count_voltage += 1
            elif election_matrix[k,0] == 2:
                    count_time += 1
                                    
        index_counts = array([96,72,48,24,0])
        for i in range(0,5):
            counter = 0 
            rule_test = memory[i,0:6]
            for k in range(0,240):
                if all(election_matrix[k,0:6] == rule_test):
                    counter += 1
            self.assertEqual(counter, index_counts[i], "test number of rules in election matrix")
            
        self.assertEqual(count_time, 192, "test number of time rules in election matrix")
        self.assertEqual(count_voltage, 48, "test number of voltage rules in election matrix")
    
        
        
if __name__ == '__main__':
    unittest.main()
