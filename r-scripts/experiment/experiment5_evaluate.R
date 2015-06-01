library(ggplot2)
library(reshape)

x <- data.frame(read.csv('../../../experiment5_output/output_csv_exp5.csv', sep="," ,header=TRUE))
number_of_id <- max(x$run_id)

for (i  in  1:number_of_id)
{
        assign(paste("run_",i,sep=""),subset(x, run_id ==i))
}