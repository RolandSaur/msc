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


function_average_t_near <- function(df) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <- df[[k]]
                summe <- 0
                counter <- 0
                #print(untergruppe)
                for (i in c(1)){
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


function_average_t_far <- function(df) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <-df[[k]]
                summe <- 0
                counter <- 0
                #print(untergruppe)
                for (i in c(6)){
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


function_extract_lowest_failure <- function(df)
{
        voltage_data_frame <- c()
        for (k in c(1:100))
        {
                voltage_data_frame <- rbind(voltage_data_frame,subset(df[[k]],df[[k]]$inst_rule1 == 1))
        }

        return(voltage_data_frame)
}

function_extract_voltage_action <- function(df)
{
        Actions1 <- df$inst_rule4
        Actions2 <- df$inst_rule5
        Voltage_thresholds <- df$inst_rule2
        output_data <- data.frame(cbind(Actions1,Actions2,Voltage_thresholds))
        return(output_data)
}

function_extract_voltage_soc_action <- function(df)
{
        Actions1 <- df$inst_rule4
        Actions2 <- df$inst_rule5
        Voltage_thresholds <- df$inst_rule2
        SOC_thresholds <- df$inst_rule3
        output_data <- data.frame(cbind(Actions1,Actions2,SOC_thresholds,Voltage_thresholds))
        return(output_data)
}

function_extract_below_failure_from_voltage <- function(df,hard_fails_threshold)
{
        voltage_data_frame <- c()
        hard_fails <- function_hard_failure(df)
        for (k in c(1:100))
        {
                if (hard_fails[k] < hard_fails_threshold )
                {
                        voltage_data_frame <- rbind(voltage_data_frame,subset(df[[k]],df[[k]]$inst_rule1 == 1))
                }
        }
        
        return(voltage_data_frame)
}


#----------------------------------------------------------------------------------------------------

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

averages_near <- c()
averages_far <- c()

number_voltage_rules <- c()
number_time_rules <- c()

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
        
        
        averages_near <- c(averages_near,function_average_t_near(data_frames))
        averages_far <- c(averages_far,function_average_t_far(data_frames))
        
        number_voltage_rules <- c(number_voltage_rules,function_get_number_voltagerules(data_frames))
        number_time_rules <- c(number_time_rules,function_get_number_timerules(data_frames))

}

#-----------------------------Voltage_actions_correlations-------------------------------------------
# data_frames <- list()
# low_failure_run <- c()
# for (i in runs) {
#         folder <- paste(main_folder,"/exp_a_",i,sep="")
#         for (k in c(1:100)){
#                 filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
#                 print(filename)
#                 data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
#         }
#         low_failure_run <- rbind(low_failure_run,function_extract_lowest_failure(data_frames))
# }
# #low_failure_run <-function_extract_lowest_failure(data_frames)
# #low_failure_data <-function_extract_voltage_action(low_failure_run)
# 
# 
# low_failure_soc_data <- function_extract_voltage_soc_action(low_failure_run)
# low_failure_soc_data$Voltage_thresholds <- factor(low_failure_soc_data$Voltage_thresholds)
# mt <- ggplot(low_failure_soc_data,aes(SOC_thresholds,fill=Voltage_thresholds))
# first_test <- mt + geom_bar(binwidth = 5)
# first_test <- first_test + facet_grid(Actions2 ~ Actions1,scales="free_x",labeller = label_both) +
#         ylab("Number of runs")
# ggsave(first_test,file = "../latex/rules_voltage_soc_first_look.eps")
# 

# data_frames <- list()
# low_vol_fail_run <- c()
# for (i in runs) {
#         folder <- paste(main_folder,"/exp_a_",i,sep="")
#         for (k in c(1:100)){
#                 filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
#                 print(filename)
#                 data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
#         }
#         low_vol_fail_run <- rbind(low_vol_fail_run,function_extract_below_failure_from_voltage(data_frames,5))
# }
# low_failure_soc_data <- function_extract_voltage_soc_action(low_vol_fail_run)
# low_failure_soc_data$Voltage_thresholds <- factor(low_failure_soc_data$Voltage_thresholds)
# mt <- ggplot(low_failure_soc_data,aes(SOC_thresholds,fill=Voltage_thresholds))
# plot_low_fail_rules <- mt + geom_bar(binwidth = 5)
# plot_low_fail_rules <- plot_low_fail_rules + facet_grid(Actions2 ~ Actions1,scales="free_x",labeller = label_both) +
#         ylab("Number of runs")
# ggsave(plot_low_fail_rules , file = "../latex/hard_failure_colored_low_look.eps")

#----------------------------------hard_failures_color coded --------------------------------------
indicator <- c()
for (k in c(1:length(number_time_rules)))
{
        if (number_time_rules[k] > number_voltage_rules[k])
        {
                indicator <- c(indicator,2)
        }else
        {
                indicator <- c(indicator,1)
        }
}
df_2 <- data.frame(cbind(hard_failures,indicator))
df_2$indicator <- factor(df_2$indicator, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
df_2$hard_failures <- as.numeric(df_2$hard_failures)
rule_colored_hard_failure <- ggplot(df_2,aes(hard_failures,fill=indicator)) + 
        geom_histogram() +
        ylab("Number of runs") +
        ggtitle("Hard Failures colored by Rule") 
ggsave(rule_colored_hard_failure , file = "../latex/hard_failure_colored_first_look.eps") 



#-----------------------------------basic_output_of_histogramms---------------------------------------
# averages_figure <- qplot(averages,geom = "histogram",binwidth = 1) + 
#         ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")
# averages_no_figure <- qplot(averages_no,geom = "histogram",binwidth = 1) +
#         ggtitle("Average SOC without Institutional Rule") + xlab("Average SOC")
# 
# ggsave(averages_figure , file = "../latex/averages_first_2.eps")
# ggsave(averages_no_figure , file = "../latex/averages_no_first_2.eps") 
#         
# 
# averages_near_figure <- qplot(averages_near,geom = "histogram",binwidth = 1) +
#         ggtitle("Average SOC") + xlab("Average SOC")
# ggsave(averages_near_figure , file = "../latex/average_near_first_2.eps")
# 
# averages_far_figure <- qplot(averages_far,geom = "histogram",binwidth = 1) +
#         ggtitle("Average SOC") + xlab("Average SOC")
# ggsave(averages_far_figure , file = "../latex/average_far_first_2.eps")
# 
# 
# averages_all_figure <- qplot(averages_all,geom = "histogram",binwidth = 1) +
#         ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")
# 
# averages_all_no_figure <- qplot(averages_all_no,geom = "histogram",binwidth = 1) +
#         ggtitle("Average SOC without Institutional Rule") + xlab("Average SOC")
# 
# ggsave(averages_all_figure , file = "../latex/average_all_first_2.eps")
# ggsave(averages_all_no_figure , file = "../latex/average_all_no_first_2.eps")
# 
# weak_figure <- qplot(weak_failures,geom = "histogram",binwidth = 10) + 
#         ggtitle("Number of weak failures with Institutional Rule") + xlab("Number of weak Failures")
# weak_no_figure <- qplot(weak_failures_no,geom = "histogram",binwidth = 10) +
#         ggtitle("Number of weak failures without Institutional Rule") + xlab("Number of weak Failures")
# ggsave(weak_figure , file = "../latex/weak_first_2.eps")
# ggsave(weak_no_figure , file = "../latex/weak_no_first_2.eps")
# 
# hard_figure <- qplot(hard_failures,geom = "histogram",binwidth = 1) + 
#         ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
# hard_no_figure <- qplot(hard_failures_no,geom = "histogram",binwidth = 1) + 
#         ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
# ggsave(hard_figure , file = "../latex/hard_first_2.eps")
# ggsave(hard_no_figure , file = "../latex/hard_no_first_2.eps")

#----------------------------------t_test---------------------------------------
t.test(averages, averages_no, "less", conf.level= 0.95)
t.test(averages_all,averages_all_no, "less", conf.level= 0.95 )