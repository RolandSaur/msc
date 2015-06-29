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
main_folder <- "/home/saur/Documents/master/output_data/main_node_folder"
runs <- c(1:25)


for (k in c(0:8)){
        assign(paste("average_copy_",k,sep=""),c())
        assign(paste("weak_copy_",k,sep=""),c())
        assign(paste("hard_copy_",k,sep=""),c())
}
for (k in c(1:9)){
        assign(paste("average_learn_",k,sep=""),c())
        assign(paste("weak_learn_",k,sep=""),c())
        assign(paste("hard_learn_",k,sep=""),c())
}

for (i in runs) {
        folder <- paste(main_folder,"/exp_c_",i,sep="")
        data_frames <- list()
        for (k in c(1:100)){
                filename <- paste(folder,"/exp_c_",i,"_",k,"_output.csv",sep="")
                print(filename)
                data_frames[[k]] <-read.csv(filename, header = TRUE, sep = ",")
        }
        #assign(paste("data_a_",i),function_average(data_frames))
        print((data_frames[[1]]$majority[1] =="False"))
        for (k in c(0:8)){
                if (data_frames[[1]]$copy_best[1] == (k/10.0)) {
                        temp_av <- get(paste("average_copy_",k,sep=""))
                        temp_weak <- get(paste("weak_copy_",k,sep=""))
                        temp_hard <- get(paste("hard_copy_",k,sep=""))
                        assign(paste("average_copy_",k,sep=""),c(temp_av,function_average(data_frames)))
                        assign(paste("weak_copy_",k,sep=""),c(temp_weak,function_weak_failure(data_frames)))
                        assign(paste("hard_copy_",k,sep=""),c(temp_hard,function_hard_failure(data_frames)))
                }
        }
        for (k in c(1:9)){
                if (data_frames[[1]]$learn_change[1] == (k/10.0)) {
                        temp_av <- get(paste("average_learn_",k,sep=""))
                        temp_weak <- get(paste("weak_learn_",k,sep=""))
                        temp_hard <- get(paste("hard_learn_",k,sep=""))
                        assign(paste("average_learn_",k,sep=""),c(temp_av,function_average(data_frames)))
                        assign(paste("weak_learn_",k,sep=""),c(temp_weak,function_weak_failure(data_frames)))
                        assign(paste("hard_learn_",k,sep=""),c(temp_hard,function_hard_failure(data_frames)))
                }
        }
        #averages <- function_average(data_frames) 
        #hard_failures <- function_hard_failure(data_frames)
        #weak_failures <- function_weak_failure(data_frames)
        
}

data_averages_copy <- data.frame(get(paste("average_copy_",0,sep="")),rep(0,length(get(paste("average_copy_",0,sep="")))))
colnames(data_averages_copy) <- c("Averages","copy_best")
for (k in c(1:8)){
        data_out <- data.frame(get(paste("average_copy_",k,sep="")),rep(k,length(get(paste("average_copy_",k,sep="")))))
        colnames(data_out) <- c("Averages","copy_best")
        data_averages_copy <- rbind(data_averages_copy,data_out)
}

copy_averages_figure <- ggplot(data_averages_copy, aes(factor(copy_best), Averages)) + geom_boxplot() +
        xlab("Copy best behavior") +
        ylab("Average SOC")

ggsave(copy_averages_figure,file = "../latex/copy_average_c.jpg")



data_averages_learn <- data.frame(get(paste("average_learn_",1,sep="")),rep(1,length(get(paste("average_learn_",1,sep="")))))
colnames(data_averages_learn) <- c("Averages","learn")
for (k in c(2:9)){
        data_out <- data.frame(get(paste("average_learn_",k,sep="")),rep(k,length(get(paste("average_learn_",k,sep="")))))
        colnames(data_out) <- c("Averages","learn")
        data_averages_learn <- rbind(data_averages_learn,data_out)
}

learn_averages_figure <- ggplot(data_averages_learn, aes(factor(learn), Averages)) + geom_boxplot() +
        xlab("Learning behavior") +
        ylab("Average SOC")

ggsave(learn_averages_figure,file = "../latex/learn_average_c.jpg")



#-----------------weak error---------------------------------------------------
data_weak_copy <- data.frame(get(paste("weak_copy_",0,sep="")),rep(0,length(get(paste("weak_copy_",0,sep="")))))
colnames(data_weak_copy) <- c("Weak_Failures","copy_best")
for (k in c(1:8)){
        data_out <- data.frame(get(paste("weak_copy_",k,sep="")),rep(k,length(get(paste("weak_copy_",k,sep="")))))
        colnames(data_out) <- c("Weak_Failures","copy_best")
        data_weak_copy <- rbind(data_weak_copy,data_out)
}

copy_weak_figure <- ggplot(data_weak_copy, aes(factor(copy_best), Weak_Failures)) + geom_boxplot() +
        xlab("Copy best behavior") +
        ylab("Number of Weak Failures")

ggsave(copy_weak_figure,file = "../latex/copy_weak_c.jpg")



data_weak_learn <- data.frame(get(paste("weak_learn_",1,sep="")),rep(1,length(get(paste("weak_learn_",1,sep="")))))
colnames(data_weak_learn) <- c("Weak_failures","learn")
for (k in c(2:9)){
        data_out <- data.frame(get(paste("weak_learn_",k,sep="")),rep(k,length(get(paste("weak_learn_",k,sep="")))))
        colnames(data_out) <- c("Weak_failures","learn")
        data_weak_learn <- rbind(data_weak_learn,data_out)
}

learn_weak_figure <- ggplot(data_weak_learn, aes(factor(learn), Weak_failures)) + geom_boxplot() +
        xlab("Learning behavior") +
        ylab("Number of Weak Failures")

ggsave(learn_weak_figure,file = "../latex/learn_weak_c.jpg")



#-----------------hard error---------------------------------------------------
data_hard_copy <- data.frame(get(paste("weak_copy_",0,sep="")),rep(0,length(get(paste("hard_copy_",0,sep="")))))
colnames(data_hard_copy) <- c("hard_Failures","copy_best")
for (k in c(1:8)){
        data_out <- data.frame(get(paste("weak_copy_",k,sep="")),rep(k,length(get(paste("hard_copy_",k,sep="")))))
        colnames(data_out) <- c("hard_Failures","copy_best")
        data_hard_copy <- rbind(data_hard_copy,data_out)
}

copy_hard_figure <- ggplot(data_hard_copy, aes(factor(copy_best), hard_Failures)) + geom_boxplot() +
        xlab("Copy best behavior") +
        ylab("Number of Hard Failures")

ggsave(copy_hard_figure,file = "../latex/copy_hard_c.jpg")



data_hard_learn <- data.frame(get(paste("hard_learn_",1,sep="")),rep(1,length(get(paste("hard_learn_",1,sep="")))))
colnames(data_hard_learn) <- c("hard_failures","learn")
for (k in c(2:9)){
        data_out <- data.frame(get(paste("hard_learn_",k,sep="")),rep(k,length(get(paste("hard_learn_",k,sep="")))))
        colnames(data_out) <- c("hard_failures","learn")
        data_hard_learn <- rbind(data_hard_learn,data_out)
}

learn_hard_figure <- ggplot(data_hard_learn, aes(factor(learn), hard_failures)) + geom_boxplot() +
        xlab("Learning behavior") +
        ylab("Number of Hard Failures")

ggsave(learn_hard_figure,file = "../latex/learn_hard_c.jpg")