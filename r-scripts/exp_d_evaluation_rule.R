library(ggplot2)


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


#------------------------------------------------------------------------------------

filename <- "/home/saur/Documents/master/experiment4_output/output_csv_exp4.csv"
data_frame <- read.csv(filename, header = TRUE, sep = ",")

data_majority <- subset(data_frame, data_frame$majority =="True")
data_borda <- subset(data_frame, data_frame$majority =="False")

rule_dist_borda <- rules_distances(data_borda)
rule_dist_majority <- rules_distances(data_majority)


figure_dist_borda <- qplot(rule_dist_borda,geom = "histogram",binwidth =1) +
        xlim(0,80) + xlab("Distance")

figure_dist_majority <- qplot(rule_dist_majority,geom = "histogram",binwidth =1) +
        xlim(0,80) + xlab("Distance")

ggsave(figure_dist_majority , file = "../latex/dist_majority_d.jpg")
ggsave(figure_dist_borda , file = "../latex/dist_borda_d.jpg")