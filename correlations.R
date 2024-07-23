corstars <- function(x,
                     method = c("pearson", "spearman"),
                     remove_triangle = c("upper", "lower"),
                     result = c("none", "html", "latex")) {
  # Compute correlation matrix
  require(Hmisc)
  x <- as.matrix(x)
  correlation_matrix <- rcorr(x, type = method[1])
  r <- correlation_matrix$r # Matrix of correlation coeficients
  p <- correlation_matrix$P # Matrix of p-value

  ## Define notions for significance levels; spacing is important.
  mystars <- ifelse(p < .0001, "****",
                    ifelse(p < .001, "*** ",
                           ifelse(p < .01, "**  ",
                                  ifelse(p < .05, "*   ", "    "))))

  ## trunctuate the correlation matrix to two decimal
  r <- format(round(cbind(rep(-1.11, ncol(x)), r), 2))[, -1]

  ## build a new matrix that includes the correlations with
  # their apropriate stars
  r_new <- matrix(paste(r, mystars, sep = ""), ncol = ncol(x))
  diag(r_new) <- paste(diag(r), " ", sep = "")
  rownames(r_new) <- colnames(x)
  colnames(r_new) <- paste(colnames(x), "", sep = "")

  if (remove_triangle[1] == "upper") {
    ## remove upper triangle of correlation matrix
    r_new <- as.matrix(r_new)
    r_new[upper.tri(r_new, diag = TRUE)] <- ""
    r_new <- as.data.frame(r_new)
  } else if (remove_triangle[1] == "lower") {
    ## remove lower triangle of correlation matrix
    r_new <- as.matrix(r_new)
    r_new[lower.tri(r_new, diag = TRUE)] <- ""
    r_new <- as.data.frame(r_new)
  }

  ## remove last column and return the correlation matrix
  r_new <- cbind(r_new[1:seq_along(r_new) - 1])
  if (result[1] == "none") {
    return(r_new)
  } else {
    if (result[1] == "html") print(xtable(r_new), type = "html")
    else print(xtable(r_new), type = "latex")
  }
}

library(corrplot)
library(xtable)
library("PerformanceAnalytics")

team_data <- read.csv("~/team_efficiency/all_teams_corr.txt")
# All teams
chart.Correlation(transform(team_data, Setting =
                              as.numeric(as.factor(team_data$Setting)))[2:6])
# Local only
chart.Correlation(team_data[team_data$Setting == "L", ][3:6])
# Remote only
chart.Correlation(team_data[team_data$Setting == "R", ][3:6])
# Bubble nonsense plot
corrplot(res, type = "lower", order = "hclust", tl.col = "black", tl.srt = 0,
         mar = c(0, 2, 0, 0))

library("stargazer")
m1 <- lm(Efficiency ~ LSM, data = team_data)
m2 <- lm(Efficiency ~ Setting, data = team_data)
m3 <- lm(Efficiency ~ Setting + LSM, data = team_data)
m4 <- lm(Efficiency ~ Setting + LSM + Education + Tenure, data = team_data)
m5 <- lm(Efficiency ~ Setting + LSM * Setting + Education + Tenure,
         data = team_data)
m6 <- lm(Efficiency ~ LSM * Setting, data = team_data)
stargazer(m1, m2, m3, m4, m5, m6, type = "latex",
          dep.var.labels = c("Team efficiency"))

library(ggplot2)
ggplot(team_data,
       aes(x = LSM, y = Efficiency, color = Setting, group = Setting)) +
  geom_point() + geom_line()
ggplot(team_data,
       aes(x = LSM, y = Efficiency, color = Setting, group = Setting)) +
  geom_point() +
  geom_text(size = 3, aes(label = Setting, color = Setting),
            nudge_x = 0.001, hjust = 0, data = team_data) +
  guides(color = FALSE) + geom_smooth(method = "lm", se = FALSE)

avPlots(model_remote)
