library(ggplot2)
library(reshape2)

fd = read.table('Lastprofil_Haushalt.csv',head =TRUE, skip = 4,sep=',',dec=',')
Time_steps =seq(from = 1,to = 96, by = 1)
fd$Time_steps <- Time_steps
fd$gruppe <- rep(1,96)
yy = fd$Werktage.2 * 8 * 4
# plot(xx,yy,'l')
plotler = ggplot(data=fd,aes(x= Time_steps, y= 8*4*Werktage.2,group = gruppe)) +
  geom_line() +
  geom_point(size=2) +
  xlab("Time step") +
  ylab("Load") + 
  ggtitle("Standard Load Profile")

ggsave(plotler,filename = "loadprofile.png")
