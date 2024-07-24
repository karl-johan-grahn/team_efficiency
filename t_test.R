average_mrs_local <- c(27.50, 74.50, 243.83, 232.67, 104.33, 145)
average_mrs_remote <- c(423.80, 143.67, 613, 324, 137.67, 304.20)

team_efficiency_local <- c(1, .57671, 1, 1, .69437)
team_efficiency_remote <- c(.80314, .86054, .87218, .69371, 1, 1, .75182)
t.test(team_efficiency_local, team_efficiency_remote, paired = TRUE)

my_data <- data.frame(
  group = rep(c("local", "remote"), each = 6),
  weight = c(average_mrs_local, average_mrs_remote)
)

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

# Since the sample size is not large enough (less than 30), we need to check
# whether the differences of the pairs follow a normal distribution
# compute the difference
d <- with(my_data,
          weight[group == "local"] - weight[group == "remote"])
# Shapiro-Wilk normality test for the differences
shapiro.test(d)
# From the output, the p-value is greater than the significance level 0.05
# implying that the distribution of the differences (d) are not significantly
# different from normal distribution. In other words, we can assume the
# normality.
t.test(weight ~ group, data = my_data, paired = TRUE)
t.test(weight ~ group, data = my_data, paired = TRUE, alt = "less")
t.test(average_mrs_local, average_mrs_remote, paired = TRUE)
