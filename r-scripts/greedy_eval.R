library(ggplot2)


function_average_far <- function(data_frame) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <- subset(data_frame, data_frame$run_id == k)
                averages <- c(averages, mean(untergruppe$a6))
        }
        return(averages)
}

function_average_near <- function(data_frame) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <- subset(data_frame, data_frame$run_id == k)
                averages <- c(averages, mean(untergruppe$a1))
        }
        return(averages)
}

function_average_all <- function(df) {
        averages <- c()
        for (k in c(1:100)){
                untergruppe <- subset(data_frame, data_frame$run_id == k)
                summe <- 0
                counter <- 0
                #print(untergruppe)
                for (i in c(1:24)){
                        summe <- summe + sum(untergruppe[[i]])
                        counter <- counter + length(untergruppe[[i]])
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
                untergruppe <- subset(df , df$run_id == k )
                #print(k)
                for (i in c(1:24)){
                        #print(i)
                        log_vector <- (untergruppe[i]==0)
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
                }
                hard_fails <- c(hard_fails,summe)
        }
        return(hard_fails)
}

function_weak_failure <- function(df){
        weak_fails <- c()
        for (k in c(1:100)){
                summe <- 0 
                untergruppe <- subset(df, df$run_id == k)
                for (i in c(1:24)){
                        number_fails <- 0 
                        x <- untergruppe[[i]]
                        #print(length(x))
                        xx <- split(x, ceiling(seq_along(x)/96))
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

filename <- "/home/saur/Documents/master/output_data/greedy_folder/greedy_runs.csv"
data_frame <- read.csv(filename, header = TRUE, sep = ",")

averages <- function_average_all(data_frame)
averages_near <- function_average_near(data_frame)
averages_far <- function_average_far(data_frame)

hard_failures <- function_hard_failure(data_frame)
weak_failures <- function_weak_failure(data_frame)

averages_figure <- qplot(averages,geom = "histogram",binwidth = 0.5) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure , file = "../latex/averages_first_greedy.eps")

weak_figure <- qplot(weak_failures,geom = "histogram",binwidth = 10) + 
        ggtitle("Number of weak failures with Institutional Rule") + xlab("Number of weak Failures")
ggsave(weak_figure , file = "../latex/weak_first_greedy.eps")

hard_figure <- qplot(hard_failures,geom = "histogram",binwidth = 50) + 
        ggtitle("Number of hard failures with Institutional Rule") + xlab("Number of hard Failures")
ggsave(hard_figure , file = "../latex/hard_first_greedy.eps")



averages_figure_near <- qplot(averages_near,geom = "histogram",binwidth = 0.5) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure_near , file = "../latex/averages_first_greedy_near.eps")


averages_figure_far <- qplot(averages_far,geom = "histogram",binwidth = 0.5) + 
        ggtitle("Average SOC") + xlab("Average SOC")
ggsave(averages_figure_far , file = "../latex/averages_first_greedy_far.eps")