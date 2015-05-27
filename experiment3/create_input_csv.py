import csv
with open("input_parameter.csv",'w') as csv_file:
	schreiber = csv.writer(csv_file, delimiter=',',quotechar='\'')
	first_line = ['"random_change"', '"copy_best_change"' , '"learn_change"' , '"copy_al"' , '"inst_success"', '"majority_vote"' , '"repetitions"']
	schreiber.writerow(first_line)
for x in range(1,10,2):
	for y in range(0,10-x):
		z = 10 - x - y
		next_line = [x,y,z, '"vertical"' , 0.8, 0,100]
		with open("input_parameter.csv",'a') as csv_file:
			schreiber = csv.writer(csv_file, delimiter=',',quotechar='\'')
			schreiber.writerow(next_line)
