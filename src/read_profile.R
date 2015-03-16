#read the data and give the columns meaningful names based on the csv file
nameses <- c("UTC+1","van","tot","E1A","E1B","E1C","E2A","E2B","E3A","E3B","E3C","E3D","E4A")
df <- read.csv("profielen Elektriciteit 2015 versie 1.00.csv",sep = ",",skip=6,header = FALSE,col.names = nameses,nrows=35040)


#cut the date and only leave the time in the van column
df$van <- sapply(df$van,substr,12,16)

#create the different profiles

E1A_profile <- with(df,tapply(E1A,van,mean))
E1A_sd <-with(df,tapply(E1A,van,sd))

E1B_profile <- with(df,tapply(E1B,van,mean))
E1B_sd <-with(df,tapply(E1B,van,sd))

E1C_profile <- with(df,tapply(E1C,van,mean))
E1C_sd <-with(df,tapply(E1C,van,sd))

E2A_profile <- with(df,tapply(E2A,van,mean))
E2A_sd <-with(df,tapply(E2A,van,sd))

E2B_profile <- with(df,tapply(E2B,van,mean))
E2B_sd <-with(df,tapply(E2B,van,sd))

E3A_profile <- with(df,tapply(E3A,van,mean))
E3A_sd <-with(df,tapply(E3A,van,sd))

E3B_profile <- with(df,tapply(E3B,van,mean))
E3B_sd <-with(df,tapply(E3B,van,sd))

E3C_profile <- with(df,tapply(E3C,van,mean))
E3C_sd <-with(df,tapply(E3C,van,sd))

E3D_profile <- with(df,tapply(E3D,van,mean))
E3D_sd <-with(df,tapply(E3D,van,sd))

E4A_profile <- with(df,tapply(E4A,van,mean))
E4A_sd <-with(df,tapply(E4A,van,sd))
#combine all profiles in one data frame
loadprofile <- data.frame(E1A_profile,E1B_profile,E1C_profile,E2A_profile,E2B_profile,E3A_profile,E3B_profile,E3C_profile,E3D_profile,E4A_profile,E1A_sd,E1B_sd,E1C_sd,E2A_sd,E2B_sd,E3A_sd,E3B_sd,E3C_sd,E3D_sd,E4A_sd)

write.csv(loadprofile,file = "loadprofile.csv")