library(ggplot2)
library(reshape2)

fd = read.table('Lastprofil_Haushalt.csv',head =TRUE, skip = 4,sep=',')
Time_steps =seq(from = 1,to = 96, by = 1)
fd$Time_steps <- Time_steps
fd$gruppe <- rep(1,96)
yy = fd$Werktage.2
# plot(xx,yy,'l')
plotler = ggplot(data=fd,aes(x= Time_steps, y= Werktage.2,group = gruppe)) +
  geom_line() +
  geom_point(size=2) +
  xlab("Time") +
  ylab("Load") + 
  scale_y_discrete(breaks = seq(0, 0.2, by = 0.05))+
  ggtitle("Standard Load Profile")

ggsave(plotler,filename = "loadprofile.png")
