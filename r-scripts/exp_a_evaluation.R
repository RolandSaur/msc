
function_average <- function(df) {
        for (k in c(1:100)){
          
                if (k ==1){
                        averages <- mean(df[[k]]$agent6_soc)
                }else {
                        averages <- c(averages, mean(df[[k]]$agent6_soc))
                }
        }
        hist(averages)
}

main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1,2,3)
for (i in runs) {
        folder <- paste(main_folder,"/exp_a_",i,sep="")
        data_frames <- list()
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        assign(paste("data_a_",i),function_average(data_frames))
}



