
function_average <- function(df) {
        for (k in c(1:100)){
                if (k ==1){
                        df2 <- subset(df,df$run_id == k)
                        averages <- mean(df2$agent6_soc)
                }else {
                        df2 <- subset(df,df$run_id == k)
                        averages <- c(averages, mean(df2$agent6_soc))
                }
        }
        hist(averages)
}

main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1,2,3)
for (i in runs) {
        folder <- paste(main_folder,"/exp_a_",i,sep="")
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
                print(filename)
                if (k==1){
                        data_frame<-read.csv(filename, header = TRUE, sep = ",")
                }else{
                        data_frame <- merge(data_frame,read.csv(filename, header = TRUE, sep = ","),all=TRUE,sort=FALSE)
                }
        }
        assign(paste("data_a_",i),function_average(data_frame))
}



