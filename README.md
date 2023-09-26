# OssaNMA

This is a package for the optimal sample size allocation for a new trial when leveraging evidence from existing network meta-analysis.

## How to install
You can install this through use devtools

`devtools::install_github("fangshuye/OssaNMA")`

## Import
`library(OssaNMA)`

## Example Code
`# Analyze the new trial with the existing network

ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, sig.level = 0.05, method = "with", allocation = "uneven")
`
