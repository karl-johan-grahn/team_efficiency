corstars <-function(x, method=c("pearson", "spearman"), removeTriangle=c("upper", "lower"),
                    result=c("none", "html", "latex")){
  #Compute correlation matrix
  require(Hmisc)
  x <- as.matrix(x)
  correlation_matrix<-rcorr(x, type=method[1])
  R <- correlation_matrix$r # Matrix of correlation coeficients
  p <- correlation_matrix$P # Matrix of p-value 
  
  ## Define notions for significance levels; spacing is important.
  mystars <- ifelse(p < .0001, "****", ifelse(p < .001, "*** ", ifelse(p < .01, "**  ", ifelse(p < .05, "*   ", "    "))))
  
  ## trunctuate the correlation matrix to two decimal
  R <- format(round(cbind(rep(-1.11, ncol(x)), R), 2))[,-1]
  
  ## build a new matrix that includes the correlations with their apropriate stars
  Rnew <- matrix(paste(R, mystars, sep=""), ncol=ncol(x))
  diag(Rnew) <- paste(diag(R), " ", sep="")
  rownames(Rnew) <- colnames(x)
  colnames(Rnew) <- paste(colnames(x), "", sep="")
  
  ## remove upper triangle of correlation matrix
  if(removeTriangle[1]=="upper"){
    Rnew <- as.matrix(Rnew)
    Rnew[upper.tri(Rnew, diag = TRUE)] <- ""
    Rnew <- as.data.frame(Rnew)
  }
  
  ## remove lower triangle of correlation matrix
  else if(removeTriangle[1]=="lower"){
    Rnew <- as.matrix(Rnew)
    Rnew[lower.tri(Rnew, diag = TRUE)] <- ""
    Rnew <- as.data.frame(Rnew)
  }
  
  ## remove last column and return the correlation matrix
  Rnew <- cbind(Rnew[1:length(Rnew)-1])
  if (result[1]=="none") return(Rnew)
  else{
    if(result[1]=="html") print(xtable(Rnew), type="html")
    else print(xtable(Rnew), type="latex") 
  }
}

library(corrplot)
library(xtable)
library("PerformanceAnalytics")

team_data <- read.csv("~/team_efficiency/all_teams_corr.txt")
# All teams
chart.Correlation(transform(team_data, Setting = as.numeric(as.factor(team_data$Setting)))[2:6])
# Local only
chart.Correlation(team_data[team_data$Setting=="L",][3:6])
# Remote only
chart.Correlation(team_data[team_data$Setting=="R",][3:6])
# Bubble nonsense plot
#corrplot(res, type="lower", order="hclust", tl.col="black", tl.srt=0, mar = c(0,2,0,0))

library("stargazer")
m1 <- lm(Efficiency~LSM, data=team_data)
m2 <- lm(Efficiency~Setting, data=team_data)
m3 <- lm(Efficiency~Setting+LSM, data=team_data)
m4 <- lm(Efficiency~Setting+LSM+Education+Tenure, data=team_data)
m5 <- lm(Efficiency~Setting+LSM*Setting+Education+Tenure, data=team_data)
m6 <- lm(Efficiency~LSM*Setting, data=team_data)
stargazer(m1, m2, m3, m4, m5, m6, type="latex",
          dep.var.labels=c("Team efficiency"))

library(ggplot2)
ggplot(team_data, aes(x=LSM, y=Efficiency, color=Setting, group=Setting)) + geom_point() + geom_line()
ggplot(team_data, aes(x=LSM, y=Efficiency, color=Setting, group=Setting)) + geom_point() + geom_text(size=3, aes(label=Setting, color=Setting), nudge_x=0.001, hjust=0, data=team_data) + guides(color=FALSE) + geom_smooth(method="lm", se=F)

#avPlots(model_remote)
