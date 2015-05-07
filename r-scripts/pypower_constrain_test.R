library(ggplot2)
library(reshape)

z <- c("branch1","branch2","branch3","branch4")
x <- data.frame(read.csv('/home/saur/constraint_test.txt', sep=",", col.names = z,header=FALSE))
xx <- melt(x, varnames=z)

plot <- ggplot(data = xx,aes(x=variable, y= value, ymin=0.94)) + 
  geom_point() + 
  geom_hline(yintercept=0.96,color="red") +
  xlab("Branch") +
  ylab("Voltage") +
  ggtitle("Minimum voltage in Branch(constrained)")
print(plot)
ggsave(filename='/home/saur/constrained.jpg',plot)


y <- data.frame(read.csv('/home/saur/unconstraint_test.txt', sep=",", col.names = z,header=FALSE))
yy <- melt(y, varnames=z)

plot2 <- ggplot(data = yy,aes(x=variable, y= value, ymin=0.94)) + 
  geom_point() + 
  geom_hline(yintercept=0.96,color="red") +
  xlab("Branch") +
  ylab("Voltage") +
  ggtitle("Minimum voltage in Branch(unconstrained)")
print(plot2)
ggsave(filename='/home/saur/unconstrained.jpg',plot2)