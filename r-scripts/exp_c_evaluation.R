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

function_return_rule_indicators <- function(df)
{
        num_time <- function_get_number_timerules(df)
        num_volt <- function_get_number_voltagerules(df)
        indicators <- c()
        for (k in c(1:100))
        {
                if (num_time[k] > num_volt[k])
                {
                        indicators <- c(indicators,2)
                }else 
                {
                        indicators <- c(indicators,1)
                }
        }
        return(indicators)
}


function_get_copy_value <- function(df)
{
        copy_value <- c()
        for (k in c(1:100))
        {
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                copy_value <- c(copy_value, untergruppe$copy_best)
        }
        return(copy_value)
}


function_get_learn_value <- function(df)
{
        learn_value <- c()
        for (k in c(1:100))
        {
                untergruppe <- subset(df[[k]],df[[k]]$voting == "True")
                learn_value <- c(learn_value, untergruppe$learn_change)
        }
        return(learn_value)
}


function_get_output <- function(df)
{
        weak_fails <- function_weak_failure()
}
#-----------------------------main code ---------------------------------
main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1:25)

output_results_all <- c()
for (i in runs) 
{
        folder <- paste(main_folder,"/exp_c_",i,sep="")
        data_frames <- list()
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_c_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        if (i == 1)
        {
                output_results_all <- data.frame(rep(data_frames[[1]]$copy_best[1],100),rep(data_frames[[1]]$learn_change[1],100),function_average(data_frames),function_weak_failure(data_frames),function_hard_failure(data_frames),function_return_rule_indicators(data_frames))
        }else{
                output_results_all <- rbind(output_results_all,data.frame(rep(data_frames[[1]]$copy_best[1],100),rep(data_frames[[1]]$learn_change[1],100),function_average(data_frames),function_weak_failure(data_frames),function_hard_failure(data_frames),function_return_rule_indicators(data_frames)))
        }
        
}
colnames(output_results_all) <- c("copy_best","learn","average_soc","weak_failure","hard_failure","Indicator")
some_other_stuff <- output_results_all

#output_results_all$Indicator <- factor(output_results_all$Indicator, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))

averages_all <- ggplot(output_results_all,aes(average_soc,fill= Indicator)) + 
        geom_bar(binwidth=5) +
        facet_grid(learn~copy_best,scales="free_x",labeller = label_both)


weak_failure_all <- ggplot(output_results_all,aes(weak_failure,fill=Indicator)) + 
        geom_bar(binwidth=5) +
        facet_grid(learn~copy_best,scales="free_x",labeller = label_both)

hard_failure_all <- ggplot(output_results_all,aes(hard_failure,fill=Indicator)) + 
        geom_bar(binwidth=5) +
        facet_grid(learn~copy_best,scales="free_x",labeller = label_both)



ggsave(averages_all,file = "../latex/averages_colored_c.eps")
ggsave(weak_failure_all,file = "../latex/weak_colored_c.eps")
ggsave(hard_failure_all,file = "../latex/hard_colored_c.eps")


#------------------------------------------------------------------------------------------------
#------------------------------------old_code----------------------------------------------------
# 
# for (k in c(0:8)){
#         assign(paste("average_copy_",k,sep=""),c())
#         assign(paste("weak_copy_",k,sep=""),c())
#         assign(paste("hard_copy_",k,sep=""),c())
#         assign(paste("rules_copy_",k,sep=""),c())
#         assign(paste("learn_val_",k,sep=""),c())
# }
# for (k in c(1:9)){
#         assign(paste("average_learn_",k,sep=""),c())
#         assign(paste("weak_learn_",k,sep=""),c())
#         assign(paste("hard_learn_",k,sep=""),c())
#         assign(paste("rules_learn_",k,sep=""),c())
#         assign(paste("copy_val_",k,sep=""),c())
# }
# 
# 
# 
# for (i in runs) {
#         folder <- paste(main_folder,"/exp_c_",i,sep="")
#         data_frames <- list()
#         for (k in c(1:100)){
#                 filename <- paste(folder,"/exp_c_",i,"_",k,"_output.csv",sep="")
#                 print(filename)
#                 data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
#         }
#         #assign(paste("data_a_",i),function_average(data_frames))
#         print((data_frames[[1]]$majority[1] =="False"))
#         for (k in c(0:8)){
#                 if (data_frames[[1]]$copy_best[1] == (k/10.0)) {
#                         temp_av <- get(paste("average_copy_",k,sep=""))
#                         temp_weak <- get(paste("weak_copy_",k,sep=""))
#                         temp_hard <- get(paste("hard_copy_",k,sep=""))
#                         temp_indicators <- get(paste("rules_copy_",k,sep=""))
#                         temp_learn_val <- get(paste("learn_val_",k,sep=""))
#                         
#                         assign(paste("average_copy_",k,sep=""),c(temp_av,function_average(data_frames)))
#                         assign(paste("weak_copy_",k,sep=""),c(temp_weak,function_weak_failure(data_frames)))
#                         assign(paste("hard_copy_",k,sep=""),c(temp_hard,function_hard_failure(data_frames)))
#                         assign(paste("rules_copy_",k,sep=""),c(temp_indicators,function_return_rule_indicators(data_frames)))
#                         assign(paste("learn_val_",k,sep=""),c(temp_learn_val,function_get_learn_value(data_frames)))
#                 }
#         }
#         for (k in c(1:9)){
#                 if (data_frames[[1]]$learn_change[1] == (k/10.0)) {
#                         temp_av <- get(paste("average_learn_",k,sep=""))
#                         temp_weak <- get(paste("weak_learn_",k,sep=""))
#                         temp_hard <- get(paste("hard_learn_",k,sep=""))
#                         temp_indicators <- get(paste("rules_learn_",k,sep=""))
#                         temp_copy_val <- get(paste("copy_val_",k,sep=""))
#                         
#                         assign(paste("average_learn_",k,sep=""),c(temp_av,function_average(data_frames)))
#                         assign(paste("weak_learn_",k,sep=""),c(temp_weak,function_weak_failure(data_frames)))
#                         assign(paste("hard_learn_",k,sep=""),c(temp_hard,function_hard_failure(data_frames)))
#                         assign(paste("rules_learn_",k,sep=""),c(temp_indicators,function_return_rule_indicators(data_frames)))
#                         assign(paste("copy_val_",k,sep=""),c(temp_learn_val,function_get_copy_value(data_frames)))
#                 }
#         }
#         #averages <- function_average(data_frames) 
#         #hard_failures <- function_hard_failure(data_frames)
#         #weak_failures <- function_weak_failure(data_frames)
#         
# }


#-------------------------------------------averages-------------------------------------------------
# 
# data_averages_copy <- data.frame(get(paste("average_copy_",0,sep="")),rep(0,length(get(paste("average_copy_",0,sep="")))),get(paste("rules_copy_",0,sep="")))
# colnames(data_averages_copy) <- c("Averages","copy_best","indicators")
# for (k in c(1:8)){
#         data_out <- data.frame(get(paste("average_copy_",k,sep="")),rep(k,length(get(paste("average_copy_",k,sep="")))),get(paste("rules_copy_",k,sep="")))
#         colnames(data_out) <- c("Averages","copy_best","indicators")
#         data_averages_copy <- rbind(data_averages_copy,data_out)
# }
# 
# copy_averages_figure <- ggplot(data_averages_copy, aes(factor(copy_best), Averages)) + geom_boxplot() +
#         xlab("Copy best behavior") +
#         ylab("Average SOC")
# 
# ggsave(copy_averages_figure,file = "../latex/copy_average_c.jpg")
# 
# 
# 
# data_averages_learn <- data.frame(get(paste("average_learn_",1,sep="")),rep(1,length(get(paste("average_learn_",1,sep="")))),get(paste("rules_learn_",1,sep="")))
# colnames(data_averages_learn) <- c("Averages","learn","indicators")
# for (k in c(2:9)){
#         data_out <- data.frame(get(paste("average_learn_",k,sep="")),rep(k,length(get(paste("average_learn_",k,sep="")))),get(paste("rules_learn_",k,sep="")))
#         colnames(data_out) <- c("Averages","learn","indicators")
#         data_averages_learn <- rbind(data_averages_learn,data_out)
# }
# 
# learn_averages_figure <- ggplot(data_averages_learn, aes(factor(learn), Averages)) + geom_boxplot() +
#         xlab("Learning behavior") +
#         ylab("Average SOC")
# 
# ggsave(learn_averages_figure,file = "../latex/learn_average_c.jpg")
# 
# 
# 
# 
# 
# #-----------------weak error---------------------------------------------------
# data_weak_copy <- data.frame(get(paste("weak_copy_",0,sep="")),rep(0,length(get(paste("weak_copy_",0,sep="")))),get(paste("rules_copy_",0,sep="")))
# colnames(data_weak_copy) <- c("Weak_Failures","copy_best","indicators")
# for (k in c(1:8)){
#         data_out <- data.frame(get(paste("weak_copy_",k,sep="")),rep(k,length(get(paste("weak_copy_",k,sep="")))),get(paste("rules_copy_",k,sep="")))
#         colnames(data_out) <- c("Weak_Failures","copy_best","indicators")
#         data_weak_copy <- rbind(data_weak_copy,data_out)
# }
# 
# copy_weak_figure <- ggplot(data_weak_copy, aes(factor(copy_best), Weak_Failures)) + geom_boxplot() +
#         xlab("Copy best behavior") +
#         ylab("Number of Weak Failures")
# 
# ggsave(copy_weak_figure,file = "../latex/copy_weak_c.jpg")
# 
# 
# 
# data_weak_learn <- data.frame(get(paste("weak_learn_",1,sep="")),rep(1,length(get(paste("weak_learn_",1,sep="")))),get(paste("rules_learn_",1,sep="")))
# colnames(data_weak_learn) <- c("Weak_failures","learn","indicators")
# for (k in c(2:9)){
#         data_out <- data.frame(get(paste("weak_learn_",k,sep="")),rep(k,length(get(paste("weak_learn_",k,sep="")))),get(paste("rules_learn_",k,sep="")))
#         colnames(data_out) <- c("Weak_failures","learn","indicators")
#         data_weak_learn <- rbind(data_weak_learn,data_out)
# }
# 
# learn_weak_figure <- ggplot(data_weak_learn, aes(factor(learn), Weak_failures)) + geom_boxplot() +
#         xlab("Learning behavior") +
#         ylab("Number of Weak Failures")
# 
# ggsave(learn_weak_figure,file = "../latex/learn_weak_c.jpg")
# 
# 
# 
# #-----------------hard error---------------------------------------------------
# data_hard_copy <- data.frame(get(paste("weak_copy_",0,sep="")),rep(0,length(get(paste("hard_copy_",0,sep="")))),get(paste("rules_copy_",0,sep="")))
# colnames(data_hard_copy) <- c("hard_Failures","copy_best","indicators")
# for (k in c(1:8)){
#         data_out <- data.frame(get(paste("weak_copy_",k,sep="")),rep(k,length(get(paste("hard_copy_",k,sep="")))),get(paste("rules_copy_",k,sep="")))
#         colnames(data_out) <- c("hard_Failures","copy_best","indicators")
#         data_hard_copy <- rbind(data_hard_copy,data_out)
# }
# 
# copy_hard_figure <- ggplot(data_hard_copy, aes(factor(copy_best), hard_Failures)) + geom_boxplot() +
#         xlab("Copy best behavior") +
#         ylab("Number of Hard Failures")
# 
# ggsave(copy_hard_figure,file = "../latex/copy_hard_c.jpg")
# 
# 
# 
# data_hard_learn <- data.frame(get(paste("hard_learn_",1,sep="")),rep(1,length(get(paste("hard_learn_",1,sep="")))),get(paste("rules_learn_",1,sep="")))
# colnames(data_hard_learn) <- c("hard_failures","learn","indicators")
# for (k in c(2:9)){
#         data_out <- data.frame(get(paste("hard_learn_",k,sep="")),rep(k,length(get(paste("hard_learn_",k,sep="")))),get(paste("rules_learn_",k,sep="")))
#         colnames(data_out) <- c("hard_failures","learn","indicators")
#         data_hard_learn <- rbind(data_hard_learn,data_out)
# }
# 
# learn_hard_figure <- ggplot(data_hard_learn, aes(factor(learn), hard_failures)) + geom_boxplot() +
#         xlab("Learning behavior") +
#         ylab("Number of Hard Failures")
# 
# ggsave(learn_hard_figure,file = "../latex/learn_hard_c.jpg")
# 
# 
# #----------------------------color coded rules -------------------------------------------------------
# 
# data_averages_copy$indicators <- factor(data_averages_copy$indicators, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# mt <- ggplot(data_averages_copy,aes(Averages,fill=factor(indicators)))
# first_test <- mt + geom_bar(binwidth = 5)
# first_test <- first_test + facet_grid(~copy_best,scales="free",labeller = label_both) +
#         ylab("Number of runs")
# 
# 
# 
# data_averages_learn$indicators <- factor(data_averages_learn$indicators, levels=c("1","2"),labels=c("Voltage-rule","Time-rule"))
# mt <- ggplot(data_averages_learn,aes(Averages,fill=factor(indicators)))
# first_test <- mt + geom_bar(binwidth = 5)
# first_test <- first_test + facet_grid(~copy_best,scales="free",labeller = label_both) +
#         ylab("Number of runs")



#---------------------------combined data frame-----------------------------------------------------
# data_averages_copy_learn <- data.frame(get(paste("average_copy_",0,sep="")),rep(0,length(get(paste("average_copy_",0,sep="")))),get(paste("rules_copy_",0,sep="")),get(paste("learn_val_",0,sep="")))
# colnames(data_averages_copy) <- c("Averages","copy_best","indicators","learn")
# for (k in c(1:8)){
#         data_out <- data.frame(get(paste("average_copy_",k,sep="")),rep(k,length(get(paste("average_copy_",k,sep="")))),get(paste("rules_copy_",k,sep="")),get(paste("learn_val_",k,sep="")))
#         colnames(data_out) <- c("Averages","copy_best","indicators","learn")
#         data_averages_copy <- rbind(data_averages_copy,data_out)
# }
# 
# data_weak_copy_learn <- data.frame(get(paste("weak_copy_",0,sep="")),rep(0,length(get(paste("weak_copy_",0,sep="")))),get(paste("rules_copy_",0,sep="")),get(paste("learn_val_",0,sep="")))
# colnames(data_weak_copy) <- c("Weak_Failures","copy_best","indicators","learn")
# for (k in c(1:8)){
#         data_out <- data.frame(get(paste("weak_copy_",k,sep="")),rep(k,length(get(paste("weak_copy_",k,sep="")))),get(paste("rules_copy_",k,sep="")),get(paste("learn_val_",k,sep="")))
#         colnames(data_out) <- c("Weak_Failures","copy_best","indicators","learn")
#         data_weak_copy <- rbind(data_weak_copy,data_out)
# }
# 
# data_hard_copy_learn <- data.frame(get(paste("weak_copy_",0,sep="")),rep(0,length(get(paste("hard_copy_",0,sep="")))),get(paste("rules_copy_",0,sep="")),get(paste("learn_val_",0,sep="")))
# colnames(data_hard_copy) <- c("hard_Failures","copy_best","indicators","learn")
# for (k in c(1:8)){
#         data_out <- data.frame(get(paste("weak_copy_",k,sep="")),rep(k,length(get(paste("hard_copy_",k,sep="")))),get(paste("rules_copy_",k,sep="")),get(paste("learn_val_",k,sep="")))
#         colnames(data_out) <- c("hard_Failures","copy_best","indicators","learn")
#         data_hard_copy <- rbind(data_hard_copy,data_out)
# }
