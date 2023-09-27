# OssaNMA

This is a package for the optimal sample size allocation for a new trial when leveraging evidence from existing network meta-analysis.

## How to install
You can install this through use devtools

`devtools::install_github("fangshuye/OssaNMA")`

## Import
`library(OssaNMA)`

## Example Code for ssnma()

Assuming a new two-arm trial comparing treatment 1 and treatment 2 is to be planned. The two treatments exist in the existing network, which serves as a foundation to analyze the new trial with the existing network using network meta-analysis (NMA).

Given that the risk of treatment 1 is 0.2, the risk of treatment 2 is 0.3, and the standard error of the estimated effect size between two treatments from the existing NMA is 0.3, `ssnma()` can be applied to solve the minimum required total sample size for the new trial to achieve a power of 0.8 and allocate it to each treatment group under different allocation method (even or uneven) and analysis method (with or without the existing network):

#### Uneven allocation, analyze the new trial with the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "with", allocation = "uneven")`
        
The output is  
`#> $sample_size`<br>
`#> [1] 187 163`<br>
`#> `<br>
`#> $power`<br>
`#> [1] 0.801`

#### Even allocation, analyze the new trial with the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "with", allocation = "even")`

#### Uneven allocation, analyze the new trial without the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "without", allocation = "uneven")`

#### Even allocation, analyze the new trial without the existing network
`ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, power.level = 0.8, 
        sig.level = 0.05, method = "without", allocation = "even")`

## Example Code for ssanma()

Assume that we have the same new trial planned as the previous section, the goal in this section is to calculate the optimal sample size allocation to each treatment group with a fixed total sample size of 200 to maximize the power, `ssanma()` is used:

`ssanma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, N = 200, sig.level = 0.05,
        method = "with")`

The output is<br>
`#> $sample_alloc`<br>
`#> [1] 107  93`<br>
`#>`<br>
`#> $power`<br>
`#> [1] 0.679`

As we can see, the optimal way is to allocate 107 subjects to group 1 and 93 subjects to group 2. The corresponding power is 0.679.

We may wonder, if we were to analyze it traditionally without the existing network, what would be the optimal sample allocation and power? By changing the `method` to `without`, we have:

`ssanma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, N = 200, sig.level = 0.05,
        method = "without")`
The output is<br>
`#> $sample_alloc`<br>
`#> [1] 107  93`<br>
`#>`<br>
`#> $power`<br>
`#> [1] 0.37`

The optimal sample allocation when we analyze the new trial traditionally is the same to previously. However, the power decreased greatly compared to analyzing it with the existing network.

We may also wonder, what’s the power if we allocate it evenly to each group? The parameter `allocation` can be used:

`ssanma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.3, N = 200, 
        sig.level = 0.05, method = "with", allocation = "even")`
The output is<br> 
`#> $sample_alloc`<br>
`#> [1] 100 100`<br>
`#>` <br>
`#> $power`<br>
`#> [1] 0.678`


