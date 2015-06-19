library(ggplot2)


function_average <- function(df) {
        for (k in c(1:100)){
                
                if (k ==1){
                        averages <- mean(df[[k]]$agent6_soc)
                }else {
                        averages <- c(averages, mean(df[[k]]$agent6_soc))
                }
        }
        #hist(averages)
        return(averages)
}

function_hard_failure <- function(df){
        hard_fails <- c()
        for (k in c(1:100)){
                summe <- 0
                #print(k)
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                for (i in c(1:24)){
                        #print(i)
                        agent_name <- paste("agent",i,"_soc", sep="")
                        index <- which(colnames(untergruppe)==agent_name)
                        log_vector <- (untergruppe[index]==0)
                        #print(length(log_vector))
                        number_of_fails <- 0
                        for (z in c(1:length(log_vector))){
                                if (z !=1){
                                        #print(z)
                                        #print((as.numeric(log_vector[z]) - as.numeric(log_vector[z-1]))==0)
                                        if ((log_vector[z] - log_vector[z-1]) == 1) {
                                                number_of_fails <- number_of_fails +1
                                        }
                                }
                        }
                        summe <- summe + number_of_fails
                        #print(summe)
                }
                hard_fails <- c(hard_fails,summe)
        }
        #print(max(hard_fails))
        #print(min(hard_fails))
        #breaks <- c(0,200 * c(1:100))
        #breaks <- c(0:60)
        #hist(hard_fails,breaks)
        return(hard_fails)
}
function_hard_failure_no <- function(df){
        hard_fails <- c()
        for (k in c(1:100)){
                summe <- 0
                #print(k)
                untergruppe <- subset(df[[k]],df[[k]]$voting == "False")
                for (i in c(1:24)){
                        #print(i)
                        agent_name <- paste("agent",i,"_soc", sep="")
                        index <- which(colnames(untergruppe)==agent_name)
                        log_vector <- (untergruppe[index]==0)
                        #print(length(log_vector))
                        number_of_fails <- 0
                        for (z in c(1:length(log_vector))){
                                if (z !=1){
                                        #print(z)
                                        #print((as.numeric(log_vector[z]) - as.numeric(log_vector[z-1]))==0)
                                        if ((log_vector[z] - log_vector[z-1]) == 1) {
                                                number_of_fails <- number_of_fails +1
                                        }
                                }
                        }
                        summe <- summe + number_of_fails
                        #print(summe)
                }
                hard_fails <- c(hard_fails,summe)
        }
        #print(max(hard_fails))
        #print(min(hard_fails))
        #breaks <- c(0,200 * c(1:100))
        #breaks <- c(0:60)
        #hist(hard_fails)#,breaks)
        return(hard_fails)
}

function_weak_failure <- function(df){
        weak_fails <- c()
        for (k in c(1:100)){
                summe <- 0 
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                for (i in c(1:24)){
                        agent_name <- paste("agent",i,"_soc", sep="")
                        number_fails <- 0 
                        index <- which(colnames(untergruppe)==agent_name)
                        x <- untergruppe[[index]]
                        xx <- split(x, ceiling(seq_along(x)/96))
                        #print(x)
                        #print(xx)
                        #print(length(x))
                        #print(length(xx))
                        #print(xx[[1]]==0)
                        #print(length(xx))
                        #print(length(xx[1]))
                        #print(xx[1])
                        for (z in c(1:length(xx))){
                                #print(xx[z])
                                #print((xx[z][1]==40.0))
                                if (sum(xx[[z]]==40.0)==0){
                                        number_fails <- number_fails +1
                                }
                        }
                        summe <- summe + number_fails
                }
                weak_fails <- c(weak_fails,summe)
        }
        #breaks <- 5 * c(0:100)
        #hist(weak_fails,breaks)
        #xx
        return(weak_fails)
}
function_weak_failure_no <- function(df){
        weak_fails <- c()
        for (k in c(1:100)){
                summe <- 0 
                untergruppe <- subset(df[[k]],df[[k]]$voting == "False")
                for (i in c(1:24)){
                        agent_name <- paste("agent",i,"_soc", sep="")
                        number_fails <- 0 
                        index <- which(colnames(untergruppe)==agent_name)
                        x <- untergruppe[[index]]
                        xx <- split(x, ceiling(seq_along(x)/96))
                        #print(x)
                        #print(xx)
                        #print(length(x))
                        #print(length(xx))
                        #print(xx[[1]]==0)
                        #print(length(xx))
                        #print(length(xx[1]))
                        #print(xx[1])
                        for (z in c(1:length(xx))){
                                #print(xx[z])
                                #print((xx[z][1]==40.0))
                                if (sum(xx[[z]]==40.0)==0){
                                        number_fails <- number_fails +1
                                }
                        }
                        summe <- summe + number_fails
                }
                weak_fails <- c(weak_fails,summe)
        }
        #breaks <- 5 * c(0:100)
        #hist(weak_fails)#,breaks)
        #xx
        return(weak_fails)
}
main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1:10)
averages_majority <- c()
averages_borda <- c()
hard_majority <- c()
hard_borda <- c()
weak_majority <- c()
weak_borda <- c()
for (i in runs) {
        folder <- paste(main_folder,"/exp_b_",i,sep="")
        data_frames <- list()
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_b_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        #assign(paste("data_a_",i),function_average(data_frames))
        print((data_frames[[1]]$majority[1] =="False"))
        if (data_frames[[1]]$majority[1] =="False"){
                print(6)
                averages_borda <- c(averages_borda,function_average(data_frames))
                hard_borda <- c(hard_borda, function_hard_failure(data_frames))
                weak_borda <- c(weak_borda,function_weak_failure(data_frames))
        }else{
                print(7)
                averages_majority <- c(averages_majority,function_average(data_frames))
                hard_majority <- c(hard_majority,function_hard_failure(data_frames))
                weak_majority <- c(weak_majority,function_weak_failure(data_frames))
        }
        #averages <- function_average(data_frames) 
        #hard_failures <- function_hard_failure(data_frames)
        #weak_failures <- function_weak_failure(data_frames)

}
averages_majority_figure <- qplot(averages_majority,geom = "histogram",binwidth = 1) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure , file = paste("../latex/averages_majority_exp_b.jpg",sep=""))

averages_borda_figure <- qplot(averages_borda,geom = "histogram",binwidth = 1) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure , file = paste("../latex/averages_borda_exp_b_.jpg",sep=""))

weak_borda_figure <- qplot(weak_borda,geom = "histogram",binwidth = 10) + 
        ggtitle("Number of weak Failures") + xlab("Number of weak Failures")
ggsave(weak_figure , file = paste("../latex/weak_borda_exp_b.jpg",sep=""))

weak_majority_figure <- qplot(weak_majority,geom = "histogram",binwidth = 10) + 
        ggtitle("Number of weak Failures") + xlab("Number of weak Failures")
ggsave(weak_figure , file = paste("../latex/weak_majority_exp_b.jpg",sep=""))

hard_borda_figure <- qplot(hard_borda,geom = "histogram",binwidth = 1) + 
        ggtitle("Number of hard Failures") + xlab("Number of hard Failures")
ggsave(hard_figure , file = paste("../latex/hard_borda_exp_b.jpg",sep=""))

hard_majority_figure <- qplot(hard_majority,geom = "histogram",binwidth = 1) + 
        ggtitle("Number of hard Failures") + xlab("Number of hard Failures")
ggsave(hard_figure , file = paste("../latex/hard_majority_exp_b.jpg",sep=""))

