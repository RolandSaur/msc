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


function_get_number_timerules <- function(df)
{
        time_rules <- c()
        for (k in c(1:100))
        {
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                time_rules <- c(time_rules,sum(as.numeric(untergruppe$inst_rule1==2)))
        }
        return(time_rules)
}
function_get_number_voltagerules <- function(df)
{
        voltage_rules <- c()
        for (k in c(1:100))
        {
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                voltage_rules <- c(voltage_rules,sum(as.numeric(untergruppe$inst_rule1==1)))
        }
        return(voltage_rules)
}


#-------------------------------------------main code-------------------------------------------

main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1:10)
averages_majority <- c()
averages_borda <- c()
hard_majority <- c()
hard_borda <- c()
weak_majority <- c()
weak_borda <- c()


number_voltage_rules_borda <- c()
number_time_rules_borda <- c()

number_voltage_rules_majority <- c()
number_time_rules_majority <- c()
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
                number_voltage_rules_borda <- c(number_voltage_rules_borda,function_get_number_voltagerules(data_frames))
                number_time_rules_borda <- c(number_time_rules_borda,function_get_number_timerules(data_frames))
        }else{
                print(7)
                averages_majority <- c(averages_majority,function_average(data_frames))
                hard_majority <- c(hard_majority,function_hard_failure(data_frames))
                weak_majority <- c(weak_majority,function_weak_failure(data_frames))
                number_voltage_rules_majority <- c(number_voltage_rules_majority,function_get_number_voltagerules(data_frames))
                number_time_rules_majority <- c(number_time_rules_majority,function_get_number_timerules(data_frames))
        }
        #averages <- function_average(data_frames) 
        #hard_failures <- function_hard_failure(data_frames)
        #weak_failures <- function_weak_failure(data_frames)

}


indicator_borda <- c()
for (k in c(1:length(number_time_rules_borda)))
{
        if (number_time_rules_borda[k] > number_voltage_rules_borda[k])
        {
                indicator_borda <- c(indicator_borda,2)
        }else
        {
                indicator_borda <- c(indicator_borda,1)
        }
}

indicator_majority <- c()
for (k in c(1:length(number_time_rules_majority)))
{
        if (number_time_rules_majority[k] > number_voltage_rules_majority[k])
        {
                indicator_majority <- c(indicator_majority,2)
        }else
        {
                indicator_majority <- c(indicator_majority,1)
        }
}

df_borda_hard <- data.frame(cbind(hard_borda,indicator_borda))
df_borda_hard$indicator_borda <- factor(df_borda_hard$indicator_borda, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))

df_borda_weak <- data.frame(cbind(weak_borda,indicator_borda))
df_borda_weak$indicator_borda <- factor(df_borda_weak$indicator_borda, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))

df_borda_average <- data.frame(cbind(averages_borda,indicator_borda))
df_borda_average$indicator_borda <- factor(df_borda_average$indicator_borda, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))


df_majority_hard <- data.frame(cbind(hard_majority,indicator_majority))
df_majority_hard$indicator_majority <- factor(df_majority_hard$indicator_majority, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))

df_majority_weak <- data.frame(cbind(weak_majority,indicator_majority))
df_majority_weak$indicator_majority <- factor(df_majority_weak$indicator_majority, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))

df_majority_average <- data.frame(cbind(averages_majority,indicator_majority))
df_majority_average$indicator_majority <- factor(df_majority_average$indicator_majority, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))


averages_majority_figure <-ggplot(df_majority_average,aes(averages_majority,fill=indicator_majority)) +
        geom_histogram(binwidth = 2) +
        ylab("Number of runs") +
        ggtitle("Average SOC") 
ggsave(averages_majority_figure , file = paste("../latex/averages_majority_exp_b.eps",sep=""))


weak_majority_figure <- ggplot(df_majority_weak,aes(weak_majority,fill=indicator_majority)) +
        geom_histogram() +
        ylab("Number of runs") +
        ggtitle("Weak Failure") 
ggsave(weak_majority_figure , file = paste("../latex/weak_majority_exp_b.eps",sep=""))


hard_majority_figure <- ggplot(df_majority_hard,aes(hard_majority,fill=indicator_majority)) +
        geom_histogram() +
        ylab("Number of runs") +
        ggtitle("Hard Failure")
ggsave(hard_majority_figure , file = paste("../latex/hard_majority_exp_b.eps",sep=""))




averages_borda_figure <-ggplot(df_borda_average,aes(averages_borda,fill=indicator_borda)) +
        geom_histogram(binwidth = 2) +
        ylab("Number of runs") +
        ggtitle("Average SOC") 
ggsave(averages_borda_figure , file = paste("../latex/averages_borda_exp_b.eps",sep=""))


weak_borda_figure <- ggplot(df_borda_weak,aes(weak_borda,fill=indicator_borda)) +
        geom_histogram() +
        ylab("Number of runs") +
        ggtitle("Weak Failure") 
ggsave(weak_borda_figure , file = paste("../latex/weak_borda_exp_b.eps",sep=""))


hard_borda_figure <- ggplot(df_borda_hard,aes(hard_borda,fill=indicator_borda)) +
        geom_histogram() +
        ylab("Number of runs") +
        ggtitle("Hard Failure")
ggsave(hard_borda_figure , file = paste("../latex/hard_borda_exp_b.eps",sep=""))

#-------------------------------old_graphs---------------------------------------------------
# averages_majority_figure <- qplot(averages_majority,geom = "histogram",binwidth = 1) + 
#         ggtitle("Average SOC") + xlab("Average SOC")
# ggsave(averages_majority_figure , file = paste("../latex/averages_majority_exp_b.jpg",sep=""))
# ggsave(averages_majority_figure , file = paste("../latex/averages_majority_exp_b.eps",sep=""))
# 
# averages_borda_figure <- qplot(averages_borda,geom = "histogram",binwidth = 1) + 
#         ggtitle("Average SOC") + xlab("Average SOC")
# ggsave(averages_borda_figure , file = paste("../latex/averages_borda_exp_b_.jpg",sep=""))
# ggsave(averages_borda_figure , file = paste("../latex/averages_borda_exp_b_.eps",sep=""))
# 
# weak_borda_figure <- qplot(weak_borda,geom = "histogram",binwidth = 10) + 
#         ggtitle("Number of weak Failures") + xlab("Number of weak Failures")
# ggsave(weak_borda_figure , file = paste("../latex/weak_borda_exp_b.jpg",sep=""))
# ggsave(weak_borda_figure , file = paste("../latex/weak_borda_exp_b.eps",sep=""))
# 
# weak_majority_figure <- qplot(weak_majority,geom = "histogram",binwidth = 10) + 
#         ggtitle("Number of weak Failures") + xlab("Number of weak Failures")
# ggsave(weak_majority_figure , file = paste("../latex/weak_majority_exp_b.jpg",sep=""))
# ggsave(weak_majority_figure , file = paste("../latex/weak_majority_exp_b.eps",sep=""))
# 
# 
# hard_borda_figure <- qplot(hard_borda,geom = "histogram",binwidth = 1) + 
#         ggtitle("Number of hard Failures") + xlab("Number of hard Failures")
# ggsave(hard_borda_figure , file = paste("../latex/hard_borda_exp_b.jpg",sep=""))
# ggsave(hard_borda_figure , file = paste("../latex/hard_borda_exp_b.eps",sep=""))
# 
# hard_majority_figure <- qplot(hard_majority,geom = "histogram",binwidth = 1) + 
#         ggtitle("Number of hard Failures") + xlab("Number of hard Failures")
# ggsave(hard_majority_figure , file = paste("../latex/hard_majority_exp_b.jpg",sep=""))
# ggsave(hard_majority_figure , file = paste("../latex/hard_majority_exp_b.eps",sep=""))
# 
