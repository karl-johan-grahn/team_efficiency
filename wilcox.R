average_mrs_local <- c(22.6, 94.7, 243.8, 16.5)
average_mrs_remote <- c(375.4, 113.5, 613.1, 82.7)

mu <- rbind(mean(average_mrs_local), mean(average_mrs_remote))
sds <- rbind(sd(average_mrs_local), sd(average_mrs_remote))
results1 <- cbind(mu, sds)
colnames(results1) <- c("Mean", "SD")
rownames(results1) <- c("Local", "Remote")
dif <- average_mrs_remote - average_mrs_local
hist(dif, main = "Histogram of difference in MR events", xlab = "Differences")
qqnorm(dif)
qqline(dif)
shapiro.test(dif)

median(average_mrs_local)
median(average_mrs_remote)

wilcox.test(average_mrs_local, average_mrs_remote, paired = TRUE, exact = TRUE)
