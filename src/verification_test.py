'''
Created on May 6, 2015

@author: saur
'''
import unittest
from agent import agent


class TestStringMethods(unittest.TestCase):
    
    
  def test_simple(self):
      agent1 = agent(20,1,32)
      self.assertEqual(agent1.get_soc(), 20)
      
      
if __name__ == '__main__':
    unittest.main()
