library(ggplot2)
function_average_t <- function(df) {
        for (k in c(1:100)){
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                #print(untergruppe)
                if (k ==1){
                        averages <- mean(untergruppe$agent6_soc)
                }else {
                        averages <- c(averages, mean(untergruppe$agent6_soc))
                }
        }
        return(averages)
}


function_average_t_all <- function(df) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                summe <- 0
                counter <- 0
                #print(untergruppe)
                for (i in c(1:24)){
                        agent_name <- paste("agent",i,"_soc", sep="")
                        index <- which(colnames(untergruppe)==agent_name)
                        summe <- summe + sum(untergruppe[[index]])
                        counter <- counter + length(untergruppe[[index]])
                }
                #print(summe)
                #print(counter)
                averages <- c(averages, summe/counter)
        }
        return(averages)
}


function_average_f <- function(df) {
        for (k in c(1:100)){
                untergruppe <- subset(df[[k]],df[[k]]$voting == "False")
                if (k ==1){
                        averages <- mean(untergruppe$agent6_soc)
                }else {
                        averages <- c(averages, mean(untergruppe$agent6_soc))
                }
        }
        return(averages)
}

function_average_f_all <- function(df) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <- subset(df[[k]],df[[k]]$voting == "False")
                summe <- 0
                counter <- 0
                #print(untergruppe)
                for (i in c(1:24)){
                        agent_name <- paste("agent",i,"_soc", sep="")
                        index <- which(colnames(untergruppe)==agent_name)
                        summe <- summe + sum(untergruppe[[index]])
                        counter <- counter + length(untergruppe[[index]])
                }
                averages <- c(averages, summe/counter)
        }
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
        print(max(hard_fails))
        print(min(hard_fails))
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
        print(max(hard_fails))
        print(min(hard_fails))
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
runs <- c(1,2,3)
hard_failures <- c()
weak_failures <- c()
averages <- c()

hard_failures_no <- c()
weak_failures_no <- c()
averages_no <- c()
averages_all <- c()
averages_all_no <- c()
for (i in runs) {
        folder <- paste(main_folder,"/exp_a_",i,sep="")
        data_frames <- list()
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        #assign(paste("data_a_",i),function_average(data_frames))
        hard_failures <- c(hard_failures,function_hard_failure(data_frames))
        weak_failures <- c(weak_failures,function_weak_failure(data_frames))
        averages <- c(averages,function_average_t(data_frames))
        averages_all <- c(averages_all, function_average_t_all(data_frames))
        
        hard_failures_no <- c(hard_failures_no,function_hard_failure_no(data_frames))
        weak_failures_no <- c(weak_failures_no,function_weak_failure_no(data_frames))
        averages_no <- c(averages_no,function_average_f(data_frames))
        averages_all_no <- c(averages_all_no, function_average_f_all(data_frames))

}


averages_figure <- qplot(averages,geom = "histogram",binwidth = 1) + 
        ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")
averages_no_figure <- qplot(averages_no,geom = "histogram",binwidth = 1) +
        ggtitle("Average SOC without Institutional Rule") + xlab("Average SOC")

ggsave(averages_figure , file = "../latex/averages_first_2.jpg")
ggsave(averages_no_figure , file = "../latex/averages_no_first_2.jpg") 
        

averages_all_figure <- qplot(averages_all,geom = "histogram",binwidth = 1) +
        ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")

averages_all_no_figure <- qplot(averages_all_no,geom = "histogram",binwidth = 1) +
        ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")
ggsave(averages_all_figure , file = "../latex/average_all_first_2.jpg")
ggsave(averages_all_no_figure , file = "../latex/average_all_no_first_2.jpg")

weak_figure <- qplot(weak_failures,geom = "histogram",binwidth = 10) + 
        ggtitle("Number of weak failures with Institutional Rule") + xlab("Number of weak Failures")
weak_no_figure <- qplot(weak_failures_no,geom = "histogram",binwidth = 10) +
        ggtitle("Number of weak failures without Institutional Rule") + xlab("Number of weak Failures")
ggsave(weak_figure , file = "../latex/weak_first_2.jpg")
ggsave(weak_no_figure , file = "../latex/weak_no_first_2.jpg")

hard_figure <- qplot(hard_failures,geom = "histogram",binwidth = 1) + 
        ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
hard_no_figure <- qplot(hard_failures_no,geom = "histogram",binwidth = 1) + 
        ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
ggsave(hard_figure , file = "../latex/hard_first_2.jpg")
ggsave(hard_no_figure , file = "../latex/hard_no_first_2.jpg")

#----------------------------------t_test---------------------------------------
t.test(averages, averages_no, "less", conf.level= 0.95)
t.test(averages_all,averages_all_no, "less", conf.level= 0.95 )