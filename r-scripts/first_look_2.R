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

function_extract_time_failure <- function(df)
{
        time_data_frame <- c()
        for (k in c(1:100))
        {
                time_data_frame <- rbind(time_data_frame,subset(df[[k]],df[[k]]$inst_rule1 == 2))
        }
        
        return(time_data_frame)
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


function_av <- function(df)
{
        untergruppe <-df
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
        averages <- (summe/counter)
        return(averages)
}
function_hard <- function(df)
{
        summe <- 0
        for (i in c(1:24)){
                #print(i)
                agent_name <- paste("agent",i,"_soc", sep="")
                index <- which(colnames(df)==agent_name)
                log_vector <- (df[index]==0)
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
        return(summe)
}

get_indicator <- function(df)
{
        number_time_rules <- sum(as.numeric(df$inst_rule1==2))
        number_volt_rules <- sum(as.numeric(df$inst_rule1==1))
        if (number_time_rules > number_volt_rules)
        {
                return(2)
        }else
        {
                return(1)
        }
}
function_timeline_hard <- function(df)
{
        hard_1 <- c()
        hard_2 <- c()
        hard_3 <- c()
        indicator1 <- c()
        indicator2 <- c()
        indicator3 <- c()
        for (k in c(1:100))
        {
                data <- subset(df[[k]],df[[k]]$voting == "True")
                #print(max(data$time)-min(data$time))
                #subsetterz <- split(data, ceiling(seq_along(data$time)/((max(data$time)-min(data$time))/3)))
                
                data_1 <- subset(data, data$time < (min(data$time) +(1/3)*(max(data$time)-min(data$time))))
                data_2 <- subset(data, (data$time > (min(data$time) +(1/3)*(max(data$time)-min(data$time)))) & (data$time < (min(data$time) + (2/3)*(max(data$time)-min(data$time)))))
                data_3 <- subset(data, (data$time > (min(data$time) +(2/3)*(max(data$time)-min(data$time)))))
                data_1 <- data.frame(data_1)
                data_2 <- data.frame(data_2)
                data_3 <- data.frame(data_3)
                #print("after")
                hard_1 <- c(hard_1,function_hard(data_1))
                #print("1")
                hard_2 <- c(hard_2,function_hard(data_2))
                #print("2")
                hard_3 <- c(hard_3,function_hard(data_3))
                #print("3")
                indicator1 <- c(indicator1,get_indicator(data_1))
                #print("4")
                indicator2 <- c(indicator2,get_indicator(data_2))
                #print("5")
                indicator3 <- c(indicator3,get_indicator(data_3))
        }
        return(cbind(hard_1,indicator1,hard_2,indicator2,hard_3,indicator3))
}



function_timeline_average <- function(df)
{
        average_1 <- c()
        average_2 <- c()
        average_3 <- c()
        indicator1 <- c()
        indicator2 <- c()
        indicator3 <- c()
        for (k in c(1:100))
        {
                data <- subset(df[[k]],df[[k]]$voting == "True")
                #print(max(data$time)-min(data$time))
                #subsetterz <- split(data, ceiling(seq_along(data$time)/((max(data$time)-min(data$time))/3)))
                
                data_1 <- subset(data, data$time < (min(data$time) +(1/3)*(max(data$time)-min(data$time))))
                data_2 <- subset(data, (data$time > (min(data$time) +(1/3)*(max(data$time)-min(data$time)))) & (data$time < (min(data$time) + (2/3)*(max(data$time)-min(data$time)))))
                data_3 <- subset(data, (data$time > (min(data$time) +(2/3)*(max(data$time)-min(data$time)))))
                data_1 <- data.frame(data_1)
                data_2 <- data.frame(data_2)
                data_3 <- data.frame(data_3)
                #print("after")
                average_1 <- c(average_1,function_av(data_1))
                #print("1")
                average_2 <- c(average_2,function_av(data_2))
                #print("2")
                average_3 <- c(average_3,function_av(data_3))
                #print("3")
                indicator1 <- c(indicator1,get_indicator(data_1))
                #print("4")
                indicator2 <- c(indicator2,get_indicator(data_2))
                #print("5")
                indicator3 <- c(indicator3,get_indicator(data_3))
        }
        return(cbind(average_1,indicator1,average_2,indicator2,average_3,indicator3))
}


function_timeline_weak <- function(df)
{
        weak_1 <- c()
        weak_2 <- c()
        weak_3 <- c()
        indicator1 <- c()
        indicator2 <- c()
        indicator3 <- c()
        for (k in c(1:100))
        {
                data <- subset(df[[k]],df[[k]]$voting == "True")
                #print(max(data$time)-min(data$time))
                #subsetterz <- split(data, ceiling(seq_along(data$time)/((max(data$time)-min(data$time))/3)))
                
                data_1 <- subset(data, data$time < (min(data$time) +(1/3)*(max(data$time)-min(data$time))))
                data_2 <- subset(data, (data$time > (min(data$time) +(1/3)*(max(data$time)-min(data$time)))) & (data$time < (min(data$time) + (2/3)*(max(data$time)-min(data$time)))))
                data_3 <- subset(data, (data$time > (min(data$time) +(2/3)*(max(data$time)-min(data$time)))))
                data_1 <- data.frame(data_1)
                data_2 <- data.frame(data_2)
                data_3 <- data.frame(data_3)
                #print("after")
                weak_1 <- c(weak_1,function_av(data_1))
                #print("1")
                weak_2 <- c(weak_2,function_av(data_2))
                #print("2")
                weak_3 <- c(weak_3,function_av(data_3))
                #print("3")
                indicator1 <- c(indicator1,get_indicator(data_1))
                #print("4")
                indicator2 <- c(indicator2,get_indicator(data_2))
                #print("5")
                indicator3 <- c(indicator3,get_indicator(data_3))
        }
        return(cbind(weak_1,indicator1,weak_2,indicator2,weak_3,indicator3))
}
#-------------------------------------main_code---------------------------------------------------

# main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
# runs <- c(1,2,3)
# hard_failures <- c()
# weak_failures <- c()
# averages <- c()
# 
# 
# hard_failures_no <- c()
# weak_failures_no <- c()
# averages_no <- c()
# averages_all <- c()
# averages_all_no <- c()
# 
# averages_near <- c()
# averages_far <- c()
# 
# number_voltage_rules <- c()
# number_time_rules <- c()
# 
# for (i in runs) {
#         folder <- paste(main_folder,"/exp_a_",i,sep="")
#         data_frames <- list()
#         for (k in c(1:100)){
#                 filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
#                 print(filename)
#                 data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
#         }
#         #assign(paste("data_a_",i),function_average(data_frames))
#         hard_failures <- c(hard_failures,function_hard_failure(data_frames))
#         weak_failures <- c(weak_failures,function_weak_failure(data_frames))
#         averages <- c(averages,function_average_t(data_frames))
#         averages_all <- c(averages_all, function_average_t_all(data_frames))
#         
#         hard_failures_no <- c(hard_failures_no,function_hard_failure_no(data_frames))
#         weak_failures_no <- c(weak_failures_no,function_weak_failure_no(data_frames))
#         averages_no <- c(averages_no,function_average_f(data_frames))
#         averages_all_no <- c(averages_all_no, function_average_f_all(data_frames))
#         
#         
#         averages_near <- c(averages_near,function_average_t_near(data_frames))
#         averages_far <- c(averages_far,function_average_t_far(data_frames))
#         
#         number_voltage_rules <- c(number_voltage_rules,function_get_number_voltagerules(data_frames))
#         number_time_rules <- c(number_time_rules,function_get_number_timerules(data_frames))
# 
# }


#-----------------------------time_rule_parameter-------------------------------------------
main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1,2,3)
data_frames <- list()
time_runs <- c()
for (i in runs) {
        folder <- paste(main_folder,"/exp_a_",i,sep="")
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        time_runs <- rbind(time_runs,function_extract_time_failure(data_frames))
}

something <- data.frame(time_runs)

time_begin <- ggplot(something,aes(inst_rule2)) + geom_histogram() +
        xlab("time_begin") + ylab("Number of Runs")

time_end <- ggplot(something,aes(inst_rule3)) + geom_histogram() + 
        xlab("time_begin") + ylab("Number of Runs")

times <- ggplot(something, aes(inst_rule2,inst_rule3)) + stat_bin2d() +
        xlab("time_begin") + ylab("time_end")


ggsave(time_end,file = "../latex/time_end.eps")
ggsave(time_begin,file = "../latex/time_begin.eps")
ggsave(times,file = "../latex/two_d_time_rule.eps")
#-----------------------------Voltage_actions_correlations-------------------------------------------
# main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
# runs <- c(1,2,3)
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
# indicator <- c()
# for (k in c(1:length(number_time_rules)))
# {
#         if (number_time_rules[k] > number_voltage_rules[k])
#         {
#                 indicator <- c(indicator,2)
#         }else
#         {
#                 indicator <- c(indicator,1)
#         }
# }
# df_2 <- data.frame(cbind(hard_failures,indicator))
# df_2$indicator <- factor(df_2$indicator, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# df_2$hard_failures <- as.numeric(df_2$hard_failures)
# rule_colored_hard_failure <- ggplot(df_2,aes(hard_failures,fill=indicator)) + 
#         geom_histogram() +
#         ylab("Number of runs") +
#         ggtitle("Hard Failures colored by Rule") 
# ggsave(rule_colored_hard_failure , file = "../latex/hard_failure_colored_first_look.eps") 
# 


#-----------------------------------basic_output_of_histogramms---------------------------------------
# averages_figure <- qplot(averages,geom = "histogram",binwidth = 1) + 
#         ylab("Number of runs") +
#         ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")
# averages_no_figure <- qplot(averages_no,geom = "histogram",binwidth = 1) +
#         ylab("Number of runs") +
#         ggtitle("Average SOC without Institutional Rule") + xlab("Average SOC")
# 
# ggsave(averages_figure , file = "../latex/averages_first_2.eps")
# ggsave(averages_no_figure , file = "../latex/averages_no_first_2.eps") 
#         
# 
# averages_near_figure <- qplot(averages_near,geom = "histogram",binwidth = 1) +
#         ylab("Number of runs") +
#         ggtitle("Average SOC") + xlab("Average SOC")
# ggsave(averages_near_figure , file = "../latex/average_near_first_2.eps")
# 
# averages_far_figure <- qplot(averages_far,geom = "histogram",binwidth = 1) +
#         ylab("Number of runs") +
#         ggtitle("Average SOC") + xlab("Average SOC")
# ggsave(averages_far_figure , file = "../latex/average_far_first_2.eps")
# 
# 
# averages_all_figure <- qplot(averages_all,geom = "histogram",binwidth = 1) +
#         ylab("Number of runs") +
#         ggtitle("Average SOC with Institutional Rule") + xlab("Average SOC")
# 
# averages_all_no_figure <- qplot(averages_all_no,geom = "histogram",binwidth = 1) +
#         ylab("Number of runs") +
#         ggtitle("Average SOC without Institutional Rule") + xlab("Average SOC")
# 
# ggsave(averages_all_figure , file = "../latex/average_all_first_2.eps")
# ggsave(averages_all_no_figure , file = "../latex/average_all_no_first_2.eps")
# 
# weak_figure <- qplot(weak_failures,geom = "histogram",binwidth = 10) + 
#         ylab("Number of runs") +
#         ggtitle("Number of weak failures with Institutional Rule") + xlab("Number of weak Failures")
# weak_no_figure <- qplot(weak_failures_no,geom = "histogram",binwidth = 10) +
#         ylab("Number of runs") +
#         ggtitle("Number of weak failures without Institutional Rule") + xlab("Number of weak Failures")
# ggsave(weak_figure , file = "../latex/weak_first_2.eps")
# ggsave(weak_no_figure , file = "../latex/weak_no_first_2.eps")
# 
# hard_figure <- qplot(hard_failures,geom = "histogram",binwidth = 1) + 
#         ylab("Number of runs") +
#         ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
# hard_no_figure <- qplot(hard_failures_no,geom = "histogram",binwidth = 1) + 
#         ylab("Number of runs") +
#         ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
# ggsave(hard_figure , file = "../latex/hard_first_2.eps")
# ggsave(hard_no_figure , file = "../latex/hard_no_first_2.eps")

#----------------------------------t_test---------------------------------------
# t.test(averages, averages_no, "less", conf.level= 0.95)
# t.test(averages_all,averages_all_no, "less", conf.level= 0.95 )

#--------------------------------performance over time-------------------------------
# main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
# runs <- c(1,2,3)
# 
# 
# 
# for (i in runs) {
#         folder <- paste(main_folder,"/exp_a_",i,sep="")
#         data_frames <- list()
#         for (k in c(1:100)){
#                 filename <- paste(folder,"/exp_a_",i,"_",k,"_output.csv",sep="")
#                 print(filename)
#                 data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
#         }
#         if (i ==1)
#         {
#                 hard_timeline <- function_timeline_hard(data_frames)
#                 weak_timeline <- function_timeline_weak(data_frames)
#                 average_timeline <- function_timeline_average(data_frames)
#         }else 
#         {
#                 average_timeline <- rbind(average_timeline,function_timeline_average(data_frames))
#                 weak_timeline <- rbind(weak_timeline,function_timeline_weak(data_frames))
#                 hard_timeline <- rbind(hard_timeline,function_timeline_hard(data_frames))
#         }
#         #assign(paste("data_a_",i),function_average(data_frames))
# }
# average_timeline <- data.frame(average_timeline)
# weak_timeline <- data.frame(weak_timeline)
# hard_timeline <- data.frame(hard_timeline)
# 
# average_timeline$indicator1 <- factor(average_timeline$indicator1, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# average_timeline$indicator2 <- factor(average_timeline$indicator2, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# average_timeline$indicator3 <- factor(average_timeline$indicator3, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# 
# 
# weak_timeline$indicator1 <- factor(weak_timeline$indicator1, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# weak_timeline$indicator2 <- factor(weak_timeline$indicator2, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# weak_timeline$indicator3 <- factor(weak_timeline$indicator3, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# 
# hard_timeline$indicator1 <- factor(hard_timeline$indicator1, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# hard_timeline$indicator2 <- factor(hard_timeline$indicator2, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# hard_timeline$indicator3 <- factor(hard_timeline$indicator3, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# 
# mt <- ggplot(hard_timeline,aes(hard_1,fill =indicator1)) + geom_histogram(binwidth =1) +
#         ylab("Number of runs") +
#         xlab("Number of hard failures") +
#         ggtitle("")
# ggsave(mt,file = "../latex/hard_time_1.eps")
# 
# mt <- ggplot(hard_timeline,aes(hard_2,fill =indicator2)) + geom_histogram(binwidth =1) +
#         ylab("Number of runs") +
#         xlab("Number of hard failures") +
#         ggtitle("")
# ggsave(mt,file = "../latex/hard_time_2.eps")
# 
# mt <- ggplot(hard_timeline,aes(hard_3,fill =indicator3)) + geom_histogram(binwidth =1) +
#         ylab("Number of runs") +
#         xlab("Number of hard failures") +
#         ggtitle("")
# ggsave(mt,file = "../latex/hard_time_3.eps")
# 
# 
# mt <- ggplot(weak_timeline,aes(weak_1,fill =indicator1)) + geom_histogram(binwidth =1) +
#         ylab("Number of runs") +
#         xlab("Number of weak failures") +
#         ggtitle("")
# ggsave(mt,file = "../latex/weak_time_1.eps")
# 
# mt <- ggplot(weak_timeline,aes(weak_2,fill =indicator2)) + geom_histogram(binwidth =1) +
#         ylab("Number of runs") +
#         xlab("Number of weak failures") +
#         ggtitle("")
# ggsave(mt,file = "../latex/weak_time_2.eps")
# 
# mt <- ggplot(weak_timeline,aes(weak_3,fill =indicator3)) + geom_histogram(binwidth =1) +
#         ylab("Number of runs") +
#         xlab("Number of weak failures") +
#         ggtitle("")
# ggsave(mt,file = "../latex/weak_time_3.eps")
# 
# 
# 
# 
# mt <- ggplot(average_timeline,aes(average_1,fill =indicator1)) + geom_histogram() +
#         ylab("Number of runs") +
#         xlab("Average SOC") +
#         ggtitle("")
# ggsave(mt,file = "../latex/average_time_1.eps")
# 
# mt <- ggplot(average_timeline,aes(average_2,fill =indicator2)) + geom_histogram() +
#         ylab("Number of runs") +
#         xlab("Average SOC") +
#         ggtitle("")
# ggsave(mt,file = "../latex/average_time_2.eps")
# 
# mt <- ggplot(average_timeline,aes(average_3,fill =indicator3)) + geom_histogram() +
#         ylab("Number of runs") +
#         xlab("Average SOC") +
#         ggtitle("")
# ggsave(mt,file = "../latex/average_time_3.eps")