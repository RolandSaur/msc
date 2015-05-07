library(ggplot2)
library(reshape)

z = c("a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15","a16","a17","a18","a19","a20","a21","a22","a23","a24","time")
x <- data.frame(read.csv('/home/saur/test.txt', sep=",", col.names = z,header=FALSE))

plot <- ggplot(data = x,aes(x=time)) + 
        geom_line(aes(y=a1,color = "level1")) + 
        geom_line(aes(y=a2,color = "level2")) +
        geom_line(aes(y=a3,color = "level3")) +
        geom_line(aes(y=a4,color = "level4")) +
        geom_line(aes(y=a5,color = "level5")) +
        geom_line(aes(y=a6,color = "level6")) + 
        scale_colour_manual("",breaks = c("level1","level2","level3","level4","level5","level6"),values=c("level1"="green","level2"="blue","level3"="yellow","level4"="purple","level5"="brown","level6"="red")) + 
        xlab("time") + 
        ylab("State of charge") +
        ggtitle("Battery charge over time")

ggsave(filename ='/home/saur/tragedy_of_commons.jpg', plot)