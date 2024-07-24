library("deaR")
team_data <- read.csv("~/team_efficiency/all_teams.txt")

eff <- function(data) {
  data_example <- read_data(data,
                            inputs = 2:3,
                            outputs = 4:6)
  result <- model_basic(data_example,
                        orientation = "io",
                        rts = "crs")
  efficiencies(result)
}

eff(team_data)

# Teams participating both before and after
before <- team_data[c(1:5), ]
eff(before)
after <- team_data[c(6, 8, 9, 11, 12), ]
eff(after)

local <- team_data[c(1, 2, 3, 5), ]
eff(local)
remote <- team_data[c(4, 6:13), ]
eff(remote)
