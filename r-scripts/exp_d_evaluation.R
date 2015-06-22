library(ggplot2)





function_average <- function(df) {
        averages <- c()
        #print(df)
        low_run_id <- min(df$run_id)
        high_run_id <- max(df$run_id)
        for (k in c(low_run_id:high_run_id)){
                #print(k)
                z <- as.integer(k)
                untergruppe <- subset(df, df$run_id == z)
                #print(untergruppe)
                averages <- c(averages, mean(untergruppe$agent6_soc))
        }
        return(averages)
}


function_hard_failure <- function(df){
        hard_fails <- c()
        low_run_id <- min(df$run_id)
        high_run_id <- max(df$run_id)
        for (k in c(low_run_id:high_run_id)){
                summe <- 0
                #print(k)
                untergruppe <- subset(df , df$run_id == k )
                #print(k)
                for (i in c(1:24)){
                        #print(i)
                        agent_name <- paste("agent",i,"_soc", sep="")
                        index <- which(colnames(untergruppe)==agent_name)
                        log_vector <- (untergruppe[index]==0)
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
                }
                hard_fails <- c(hard_fails,summe)
        }
        return(hard_fails)
}

function_weak_failure <- function(df){
        weak_fails <- c()
        low_run_id <- min(df$run_id)
        high_run_id <- max(df$run_id)
        for (k in c(low_run_id:high_run_id)){
                summe <- 0 
                untergruppe <- subset(df, df$run_id == k)
                #print(untergruppe)
                for (i in c(1:24)){
                        agent_name <- paste("agent",i,"_soc", sep="")
                        number_fails <- 0 
                        index <- which(colnames(untergruppe)==agent_name) 
                        x <- untergruppe[[index]]
                        #print(x)
                        #print(length(x))
                        xx <- split(x, ceiling(seq_along(x)/96))
                        #print(length(xx))
                        #print(length(xx))
                        for (z in c(1:length(xx))){
                                #print((xx[[z]]))
                                #print(xx[[z]]==40)
                                #print(xx[[z]])
                                if (sum(xx[[z]]==40.0)==0){
                                        number_fails <- number_fails +1
                                }
                        }
                        summe <- summe + number_fails
                }
                weak_fails <- c(weak_fails,summe)
        }
        return(weak_fails)
}


#------------------------------------------------------------------------------

filename <- "/home/saur/Documents/master/experiment4_output/output_csv_exp4.csv"
data_frame <- read.csv(filename, header = TRUE, sep = ",")

data_majority <- subset(data_frame, data_frame$majority =="True")
data_borda <- subset(data_frame, data_frame$majority =="False")

averages_majority <- function_average(data_majority)
hard_failures_majority <- function_hard_failure(data_majority)
weak_failures_majority <- function_weak_failure(data_majority)

averages_borda <- function_average(data_borda)
hard_failures_borda <- function_hard_failure(data_borda)
weak_failures_borda <- function_weak_failure(data_borda)

averages_figure_majority <- qplot(averages_majority,geom = "histogram",binwidth = 0.5) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure_majority , file = "../latex/averages_d_majority.jpg")

weak_figure_majority <- qplot(weak_failures_majority,geom = "histogram",binwidth = 50) + 
        ggtitle("Number of weak failures with Institutional Rule") + xlab("Number of weak Failures")
ggsave(weak_figure_majority , file = "../latex/weak_d_majority.jpg")

hard_figure_majority <- qplot(hard_failures_majority,geom = "histogram",binwidth = 10) + 
        ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
ggsave(hard_figure_majority , file = "../latex/hard_d_majority.jpg")



averages_figure_borda <- qplot(averages_borda,geom = "histogram",binwidth = 0.5) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure_borda , file = "../latex/averages_d_borda.jpg")

weak_figure_borda <- qplot(weak_failures_borda,geom = "histogram",binwidth = 50) + 
        ggtitle("Number of weak failures with Institutional Rule") + xlab("Number of weak Failures")
ggsave(weak_figure_borda , file = "../latex/weak_d_borda.jpg")

hard_figure_borda <- qplot(hard_failures_borda,geom = "histogram",binwidth = 10) + 
        ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
ggsave(hard_figure_borda , file = "../latex/hard_d_borda.jpg")