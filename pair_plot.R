library(ggpubr)
team_data <- read.csv("~/team_efficiency/all_teams_corr.txt")
lsm_local <- team_data$LSM[1:5]
lsm_remote <- team_data$LSM[c(6, 8, 9, 11, 12)]
d <- data.frame(Local = lsm_local, Remote = lsm_remote)
p <- ggpaired(d, cond1 = "Local", cond2 = "Remote",
              xlab = "Setting", ylab = "LSM score",
              legend = "none",
              fill = "condition", palette = "npg",
              width = 0.1, line.color = "gray")
p + geom_text(label = c("Team 1", "Team 3", "Team 4", "Team 6", "Team 7",
                        "Team 1", "Team 3", "Team 4", "Team 6", "Team 7"),
              nudge_x = 0.2, check_overlap = TRUE)

efficiency_local <- team_data$Efficiency[1:5]
efficiency_remote <- team_data$Efficiency[c(6, 8, 9, 11, 12)]
d <- data.frame(Local = efficiency_local, Remote = efficiency_remote)
p <- ggpaired(d, cond1 = "Local", cond2 = "Remote",
              xlab = "Setting", ylab = "Efficiency score",
              legend = "none",
              fill = "condition", palette = "npg",
              width = 0.1, line.color = "gray")
p + geom_text(label = c("Team 1", "Team 3", "Team 4", "Team 6", "Team 7",
                        "Team 1", "Team 3", "Team 4", "Team 6", "Team 7"),
              nudge_x = 0.2, check_overlap = TRUE)
