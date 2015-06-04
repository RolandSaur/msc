import csv


counter = 1 
name_base = "exp_c_"
for x in range(1,10,2):
	for y in range(0,10-x):
		z = 10 - x - y
		next_line = [x/10.0,y/10.0,z/10.0, '"vertical"' , 0.8, 0,1,counter]
		name = name_base + str(counter) + ".csv"
		with open(name,'w') as csv_file:
			schreiber = csv.writer(csv_file, delimiter=',',quotechar='\'')
			first_line = ['"random_change"', '"copy_best_change"' , '"learn_change"' , '"copy_al"' , '"inst_success"', '"majority_vote"' , '"repetitions"','"run_id"']
			schreiber.writerow(first_line)
		with open(name,'a') as csv_file:
			schreiber = csv.writer(csv_file, delimiter=',',quotechar='\'')
			schreiber.writerow(next_line)
		counter += 1
