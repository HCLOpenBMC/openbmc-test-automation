# importing panda library 
import pandas as pd 
import sys

argumentList = sys.argv[1]

# readinag given csv file 
# and creating dataframe 

dataframe1 = pd.read_csv(argumentList)

#dataframe1.columns = ['TESTCASES', 'RESULT']
  
# storing this dataframe in a csv file 
dataframe1.to_csv('file.csv',  
                  index = None) 

