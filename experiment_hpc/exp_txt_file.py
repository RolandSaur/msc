import glob
import csv
counter = 0
list = [] 
for files in glob.glob("*.csv"):
	list.append(files)

with open("list_csv.txt",'w') as txtfile:
	schreiber = csv.writer(txtfile,delimiter=',')
	schreiber.writerow(list)
