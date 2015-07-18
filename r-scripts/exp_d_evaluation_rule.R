library(ggplot2)

#---------------------------function definitios------------------------------------
rules_distances <- function(df){
        initial_rule <- c(1,1,20,5,5,0)
        rule_dist <-c()
        min_id <- min(df$run_id)
        max_id <- max(df$run_id)
        for (k in c(min_id:max_id)){
                untergruppe <- subset(df, df$run_id ==k)
                max_time <- max(untergruppe$time)
                unteruntergruppe <- subset(untergruppe, untergruppe$time ==max_time)
                distance <- 0
                for (z in c(1:6)){
                        inst_name <- paste("inst_rule",z,sep="")
                        index <- which(colnames(unteruntergruppe)==inst_name)
                        #print((unteruntergruppe[index]-initial_rule[z])^2)
                        distance <- distance + (unteruntergruppe[index]-initial_rule[z])^2
                }
                rule_dist <- c(rule_dist,sqrt(distance))
        }
        return(rule_dist)
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

#--------------------------Read the data in -------------------------

filename <- "/home/saur/Documents/master/experiment4_output/output_csv_exp4.csv"
data_frame <- read.csv(filename, header = TRUE, sep = ",")

data_majority <- subset(data_frame, data_frame$majority =="True")
data_borda <- subset(data_frame, data_frame$majority =="False")



#------------------------------distribution of rules--------------------------------

majority_rules <- c()
for (i in c(min(data_majority$run_id):max(data_majority$run_id)))
{
        this_run <- subset(data_majority, data_majority$run_id == i)
        this_run_inst <- subset(this_run,this_run$inst_rule1 == 1)
        
        majority_rules <- rbind(majority_rules,function_extract_voltage_soc_action(this_run_inst))
}



borda_rules <- c()
for (i in c(min(data_borda$run_id):max(data_borda$run_id)))
{
        this_run <- subset(data_borda, data_borda$run_id == i)
        this_run_inst <- subset(this_run,this_run$inst_rule1 == 1)
        
        borda_rules <- rbind(borda_rules,function_extract_voltage_soc_action(this_run_inst))
}


majority_rules$Voltage_thresholds <- factor(majority_rules$Voltage_thresholds)
mt <- ggplot(majority_rules,aes(SOC_thresholds,fill=Voltage_thresholds))
first_test <- mt + geom_bar(binwidth = 5)
first_test <- first_test + facet_grid(Actions2 ~ Actions1,scales="free",labeller = label_both) +
        ylab("Number of runs")
ggsave(first_test,file = "../latex/rules_voltage_d_majority.eps")


borda_rules$Voltage_thresholds <- factor(borda_rules$Voltage_thresholds)
mt <- ggplot(borda_rules,aes(SOC_thresholds,fill=Voltage_thresholds))
first_test <- mt + geom_bar(binwidth = 5)
first_test <- first_test + facet_grid(Actions2 ~ Actions1,scales="free",labeller = label_both) +
        ylab("Number of runs")
ggsave(first_test,file = "../latex/rules_voltage_d_borda.eps")


#------------------------make the rule distance graphs----------------------------
# rule_dist_borda <- rules_distances(data_borda)
# rule_dist_majority <- rules_distances(data_majority)
# 
# 
# figure_dist_borda <- qplot(rule_dist_borda,geom = "histogram",binwidth =1) +
#         xlim(0,80) + xlab("Distance")
# 
# figure_dist_majority <- qplot(rule_dist_majority,geom = "histogram",binwidth =1) +
#         xlim(0,80) + xlab("Distance")
# 
# ggsave(figure_dist_majority , file = "../latex/dist_majority_d.jpg")
# ggsave(figure_dist_borda , file = "../latex/dist_borda_d.jpg")