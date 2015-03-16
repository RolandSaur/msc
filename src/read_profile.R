nameses <- c("UTC+1","van","tot","E1A","E1B","E1C","E2A","E2B","E3A","E3B","E3C","E3D","E4A")
df <- read.csv("profielen Elektriciteit 2015 versie 1.00.csv",sep = ",",skip=6,header = FALSE,col.names = nameses,nrows=35040)
