library(ggplot2)
library(reshape2)

function_average <- function(df) {
        for (k in c(1:100)){
                
                if (k ==1){
                        averages <- mean(df[[k]]$agent6_soc)
                }else {
                        averages <- c(averages, mean(df[[k]]$agent6_soc))
                }
        }
        #hist(averages)
        #print(averages)
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

stability <- function(df){
        changes <- c()
        for (k in c(1:100)){
                summe <- 0 
                untergruppe <- subset(df[[k]],df[[k]]$time > 11520)
                log_vector <- (untergruppe$voting =="True")
                #print(log_vector)
                
                for (z in c(1:length(log_vector))){
                        if (z !=1){
                                #print(z)
                                #print((as.numeric(log_vector[z]) - as.numeric(log_vector[z-1]))==0)
                                #print(log_vector[z] -  log_vector[z-1])
                                if ((log_vector[z] - log_vector[z-1]) == 1) {
                                        #print("well well")
                                        summe <- summe +1
                                }
                        }
                }
                #print(summe)
                changes <- c(changes,summe)
        }
        return(changes)
}

main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1:10)
stability_10 <- c()
stability_30 <- c()
stability_50 <- c()
stability_80 <- c()
stability_100 <- c()

averages_10 <- c()
averages_30 <- c()
averages_50 <- c()
averages_80 <- c()
averages_100 <- c()

hard_10 <- c()
hard_30 <- c()
hard_50 <- c()
hard_80 <- c()
hard_100 <- c()

weak_10 <- c()
weak_30 <- c()
weak_50 <- c()
weak_80 <- c()
weak_100 <- c()
for (i in runs) {
        folder <- paste(main_folder,"/exp_b_",i,sep="")
        data_frames <- list()
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_b_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        #assign(paste("data_a_",i),function_average(data_frames))
        #print((data_frames[[1]]$majority[1] =="False"))
        print(data_frames[[1]]$inst_success[1]==0.1)
        if (data_frames[[1]]$inst_success[1] ==0.1){
                stability_10 <- c(stability_10,stability(data_frames))
                averages_10 <- c(averages_10, function_average(data_frames))
                hard_10 <- c(hard_10,function_hard_failure(data_frames))
                weak_10 <- c(weak_10, function_weak_failure(data_frames))
        }else if (data_frames[[1]]$inst_success[1] ==0.3){
                stability_30 <- c(stability_30,stability(data_frames))
                averages_30 <- c(averages_30, function_average(data_frames))
                hard_30 <- c(hard_30,function_hard_failure(data_frames))
                weak_30 <- c(weak_30, function_weak_failure(data_frames))
        }else if (data_frames[[1]]$inst_success[1] ==0.5){
                stability_50 <- c(stability_50,stability(data_frames))
                averages_50 <- c(averages_50, function_average(data_frames))
                hard_50 <- c(hard_50,function_hard_failure(data_frames))
                weak_50 <- c(weak_50, function_weak_failure(data_frames))
        }else if (data_frames[[1]]$inst_success[1] ==0.8){
                stability_80 <- c(stability_80,stability(data_frames))
                averages_80 <- c(averages_80, function_average(data_frames))
                hard_80 <- c(hard_80,function_hard_failure(data_frames))
                weak_80 <- c(weak_80, function_weak_failure(data_frames))
        }else if(data_frames[[1]]$inst_success[1] ==1){
                stability_100 <- c(stability_100,stability(data_frames))
                averages_100 <- c(averages_100, function_average(data_frames))
                hard_100 <- c(hard_100,function_hard_failure(data_frames))
                weak_100 <- c(weak_100, function_weak_failure(data_frames))
        }
        #averages <- function_average(data_frames) 
        #hard_failures <- function_hard_failure(data_frames)
        #weak_failures <- function_weak_failure(data_frames)
        
}

df <- melt(data.frame(stability_10,stability_30,stability_50,stability_80,stability_100))
df_averages <- melt(data.frame(averages_10,averages_30,averages_50,averages_80,averages_100))
df_hard <- melt(data.frame(hard_10,hard_30,hard_50,hard_80,hard_100))
df_weak <- melt(data.frame(weak_10,weak_30,weak_50,weak_80,weak_100))
#colnames(df) <- c("stability_10","stability_30","stability_50","stability_80","stability_100")



