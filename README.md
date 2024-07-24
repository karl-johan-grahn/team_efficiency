# Team Efficiency

This repository contains utility functions for the MBA dissertation by [`Grahn and Martins (2021)`](https://www.diva-portal.org/smash/record.jsf?pid=diva2%3A1572012&dswid=-7928). These functions can be used to reproduce the research, or extend the research by analyzing even more data.

`R` was used for graph generation and for DEA calculations because Python lacked DEA support and did not have as good graph support.

Most of the other scripts are in Python in the [`slack_export_parsing`](https://github.com/karl-johan-grahn/slack_export_parsing) repository.

## Data

The actual data collected for the dissertation is available in anonymous form in [`all_teams.txt`](./all_teams.txt) and [`all_teams_corr.txt`](./all_teams_corr.txt).

## DEA

The [`dea.R`](./dea.R) script is for comparing team efficiencies through DEA.

## Correlations

The [`correlations.R`](./correlations.R) script is for generating correlation matrices.

## Pair plots

The [`pair_plot.R`](./pair_plot.R) script is for generating pair plots.

## t-test

The [`t_test.R`](./t_test.R) script is for doing a t test.

## Wilcox

The [`wilcox.R`](./wilcox.R) script was not used in the research but can be used for doing a `Wilcoxon` rank sum and signed rank test.
