# OssaNMA

This is a package for the optimal sample size allocation for a new trial when leveraging evidence from existing network meta-analysis.

## How to install
You can install this through use devtools

`devtools::install_github("fangshuye/OssaNMA")`

## Import
`library(OssaNMA)`

## Example Code for ssnma()

Assuming a new two-arm trial comparing treatment 1 and treatment 2 is to be planned. The two treatments exist in the existing network, which serves as a foundation to analyze the new trial with the existing network using network meta-analysis (NMA).

Given that the risk of treatment 1 is 0.2, the risk of treatment 2 is 0.3, and the standard error of the estimated effect size between two treatments from the existing NMA is 0.3, ssnma() can be applied to solve the minimum required total sample size for the new trial to achieve a power of 0.8 and allocate it to each treatment group under different allocation method (even or uneven) and analysis method (with or without the existing network):

#### Uneven allocation, analyze the new trial with the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "with", allocation = "uneven")`

#### Even allocation, analyze the new trial with the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "with", allocation = "even")`

#### Uneven allocation, analyze the new trial without the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "without", allocation = "uneven")`

#### Even allocation, analyze the new trial without the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "without", allocation = "even")`
