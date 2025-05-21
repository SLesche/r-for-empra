---
title: 'Factor Analysis - CFA'
teaching: 10
exercises: 15
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a confirmatory factor analysis?
- How can I run CFA in R?
- How can I specify CFA models using lavaan?
- How can I interpret the results of a CFA and EFA in R?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand the difference between exploratory and confirmatory factor analysis
- Learn how to conduct confirmatory factor analysis in R
- Learn how to interpret the results of confirmatory factor analysis in R

::::::::::::::::::::::::::::::::::::::::::::::::

## Confirmatory Factor Analysis (CFA)
In the previous lesson, we approached the DASS as if we had no knowledge about the underlying factor structure. However, this is not really the case, since there is a specific theory proposing three interrelated factors. We can use confirmatory factor analysis to test whether this theory can adequately explain the item correlations found here.

Importantly, we not only need a theory of the number of factors, but also which items are supposed to load on which factor. This will be necessary when establishing our CFA model. Furthermore, we will test whether a one-factor model also is supported by the data and compare these two models, evaluating which one is better.

The main R package we will be using is `lavaan`. This package is widely used for Structural Equation Modeling (SEM) in R. CFA is a specific type of model in the general SEM framework. The lavaan homepage provides a great tutorial on CFA, as well (https://lavaan.ugent.be/tutorial/cfa.html). For a more detailed tutorial in SEM and mathematics behind CFA, please refer to the lavaan homepage or [this introduction](https://stats.oarc.ucla.edu/r/seminars/rsem/).

For now, let's walk through the steps of a CFA in our specific case. First of all, in order to do *confirmatory* factor analysis, we need to have a hypothesis to confirm. How many factors, which variables are supposed to span which factor?
Secondly, we need to investigate the correlation matrix for any issues (low correlations, correlations = 1). Then, we need to define our model properly using lavaan syntax. And finally, we can run our model and interpret our results.

## Model Specification
Let's start by defining the theory and the model syntax.

The DASS has 42 items and measures three scales: depression, anxiety, and stress. These scale are said to be intercorrelated, as they share common causes (genetic, environmental etc.). Furthermore, the DASS provides a detailed manual as to which items belong to which scales. The sequence of items and their respective scales is:


``` r
library(dplyr)
```

``` output

Attaching package: 'dplyr'
```

``` output
The following objects are masked from 'package:stats':

    filter, lag
```

``` output
The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union
```

``` r
dass_data <- read.csv("data/kaggle_dass/data.csv")

fa_data <- dass_data %>% 
  filter(testelapse < 600) %>% 
  select(starts_with("Q")& ends_with("A"))

item_scales_dass <- c(
  "S", "A", "D", "A", "D", "S", "A", 
  "S", "A", "D", "S", "S", "D", "S",
  "A", "D", "D", "S", "A", "A", "D",
  "S", "A", "D", "A", "D", "S", "A", 
  "S", "A", "D", "S", "S", "D", "S",
  "A", "D", "D", "S", "A", "A", "D"
)

item_scales_dass_data <- data.frame(
  item_nr = 1:42,
  scale = item_scales_dass
)

item_scales_dass_data
```

``` output
   item_nr scale
1        1     S
2        2     A
3        3     D
4        4     A
5        5     D
6        6     S
7        7     A
8        8     S
9        9     A
10      10     D
11      11     S
12      12     S
13      13     D
14      14     S
15      15     A
16      16     D
17      17     D
18      18     S
19      19     A
20      20     A
21      21     D
22      22     S
23      23     A
24      24     D
25      25     A
26      26     D
27      27     S
28      28     A
29      29     S
30      30     A
31      31     D
32      32     S
33      33     S
34      34     D
35      35     S
36      36     A
37      37     D
38      38     D
39      39     S
40      40     A
41      41     A
42      42     D
```

::: callout
## Scales vs. Factors

There is an important difference between *scales* and *factors*. Again, factors represent mathematical constructs discovered or constructed during factor analysis. Scales represent a collection of items bound together by the authors of the test and said to measure a certain construct. These two words cannot be used synonymously. Scales refer to item collections whereas factors refer to solutions of factor analysis. A scale can build a factor, in fact its items should span a common factor if the scale is constructed well. But a scale is not the same thing as a factor.
:::

Now, in order to define our model we need to keep the distinction between manifest and latent variables in mind. Our manifest, *measured* variables are the items. The factors are the latent variable. We can also define which manifest variables contribute to which latent variables. In lavaan, this can be specified in the model code using a special syntax.


``` r
library(lavaan)
```

``` output
This is lavaan 0.6-19
lavaan is FREE software! Please report any bugs.
```

``` r
model_cfa_3facs <- c(
  "
  # Model Syntax
  
  # =~ is like in linear regression
  # left hand is latent factor, right hand manifest variables contributing
  
  # Define which items load on which factor
  depression =~ Q3A + Q5A + Q10A + Q13A + Q16A + Q17A + Q21A + Q24A + Q26A + Q31A + Q34A + Q37A + Q38A + Q42A
  
  anxiety =~ Q2A + Q4A + Q7A + Q9A + Q15A + Q19A + Q20A + Q23A + Q25A + Q28A + Q30A + Q36A + Q40A + Q41A
  
  stress =~ Q1A + Q6A + Q8A + Q11A + Q12A + Q14A + Q18A + Q22A + Q27A + Q29A + Q32A + Q33A + Q35A + Q39A
  
  # Define correlations between factors using ~~
  depression ~~ anxiety
  depression ~~ stress
  anxiety ~~ stress
  "
)
```

Now, we can fit this model using `cfa()`.


``` r
fit_cfa_3facs <- cfa(
  model = model_cfa_3facs, 
  data = fa_data,
  )
```

To inspect the model results, we use `summary()`.


``` r
summary(fit_cfa_3facs, fit.measures = TRUE, standardize = TRUE)
```

``` output
lavaan 0.6-19 ended normally after 46 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        87

  Number of observations                         37242

Model Test User Model:
                                                        
  Test statistic                              107309.084
  Degrees of freedom                                 816
  P-value (Chi-square)                             0.000

Model Test Baseline Model:

  Test statistic                           1037764.006
  Degrees of freedom                               861
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.897
  Tucker-Lewis Index (TLI)                       0.892

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)           -1857160.022
  Loglikelihood unrestricted model (H1)   -1803505.480
                                                      
  Akaike (AIC)                             3714494.044
  Bayesian (BIC)                           3715235.735
  Sample-size adjusted Bayesian (SABIC)    3714959.249

Root Mean Square Error of Approximation:

  RMSEA                                          0.059
  90 Percent confidence interval - lower         0.059
  90 Percent confidence interval - upper         0.059
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    0.000

Standardized Root Mean Square Residual:

  SRMR                                           0.042

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  depression =~                                                         
    Q3A               1.000                               0.808    0.776
    Q5A               0.983    0.006  155.298    0.000    0.794    0.742
    Q10A              1.156    0.007  175.483    0.000    0.934    0.818
    Q13A              1.077    0.006  173.188    0.000    0.870    0.810
    Q16A              1.077    0.006  165.717    0.000    0.870    0.782
    Q17A              1.158    0.007  172.607    0.000    0.936    0.807
    Q21A              1.221    0.007  182.633    0.000    0.986    0.844
    Q24A              0.987    0.006  159.408    0.000    0.797    0.758
    Q26A              1.020    0.006  162.876    0.000    0.824    0.771
    Q31A              0.966    0.006  156.243    0.000    0.780    0.746
    Q34A              1.169    0.007  175.678    0.000    0.944    0.819
    Q37A              1.118    0.007  168.220    0.000    0.903    0.791
    Q38A              1.229    0.007  180.035    0.000    0.993    0.834
    Q42A              0.826    0.006  131.716    0.000    0.668    0.646
  anxiety =~                                                            
    Q2A               1.000                               0.563    0.506
    Q4A               1.282    0.014   93.089    0.000    0.722    0.691
    Q7A               1.303    0.014   94.229    0.000    0.734    0.707
    Q9A               1.323    0.014   93.485    0.000    0.745    0.696
    Q15A              1.116    0.013   89.050    0.000    0.629    0.636
    Q19A              1.077    0.013   83.014    0.000    0.606    0.565
    Q20A              1.473    0.015   96.526    0.000    0.830    0.742
    Q23A              0.898    0.011   84.756    0.000    0.506    0.584
    Q25A              1.244    0.014   89.922    0.000    0.701    0.647
    Q28A              1.468    0.015   98.046    0.000    0.827    0.767
    Q30A              1.260    0.014   90.684    0.000    0.710    0.657
    Q36A              1.469    0.015   96.658    0.000    0.827    0.744
    Q40A              1.374    0.015   93.607    0.000    0.774    0.698
    Q41A              1.256    0.014   91.905    0.000    0.707    0.674
  stress =~                                                             
    Q1A               1.000                               0.776    0.750
    Q6A               0.943    0.007  137.700    0.000    0.732    0.695
    Q8A               0.974    0.007  142.400    0.000    0.756    0.717
    Q11A              1.030    0.007  152.388    0.000    0.799    0.761
    Q12A              0.969    0.007  139.655    0.000    0.752    0.704
    Q14A              0.797    0.007  111.328    0.000    0.619    0.572
    Q18A              0.824    0.007  116.739    0.000    0.639    0.598
    Q22A              0.947    0.007  141.490    0.000    0.735    0.713
    Q27A              0.995    0.007  146.258    0.000    0.772    0.734
    Q29A              1.020    0.007  149.022    0.000    0.791    0.746
    Q32A              0.872    0.007  130.508    0.000    0.677    0.663
    Q33A              0.970    0.007  142.051    0.000    0.753    0.715
    Q35A              0.849    0.007  129.451    0.000    0.658    0.658
    Q39A              0.956    0.007  144.729    0.000    0.742    0.727

Covariances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  depression ~~                                                         
    anxiety           0.326    0.004   73.602    0.000    0.716    0.716
    stress            0.491    0.005   93.990    0.000    0.784    0.784
  anxiety ~~                                                            
    stress            0.381    0.005   76.884    0.000    0.873    0.873

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .Q3A               0.431    0.003  128.109    0.000    0.431    0.398
   .Q5A               0.515    0.004  129.707    0.000    0.515    0.450
   .Q10A              0.431    0.003  125.297    0.000    0.431    0.331
   .Q13A              0.398    0.003  125.958    0.000    0.398    0.345
   .Q16A              0.481    0.004  127.782    0.000    0.481    0.389
   .Q17A              0.467    0.004  126.117    0.000    0.467    0.348
   .Q21A              0.394    0.003  122.826    0.000    0.394    0.288
   .Q24A              0.471    0.004  129.017    0.000    0.471    0.426
   .Q26A              0.463    0.004  128.367    0.000    0.463    0.405
   .Q31A              0.486    0.004  129.556    0.000    0.486    0.444
   .Q34A              0.439    0.004  125.238    0.000    0.439    0.330
   .Q37A              0.487    0.004  127.220    0.000    0.487    0.374
   .Q38A              0.430    0.003  123.805    0.000    0.430    0.304
   .Q42A              0.622    0.005  132.512    0.000    0.622    0.583
   .Q2A               0.922    0.007  133.250    0.000    0.922    0.744
   .Q4A               0.572    0.004  127.940    0.000    0.572    0.523
   .Q7A               0.539    0.004  127.113    0.000    0.539    0.500
   .Q9A               0.590    0.005  127.667    0.000    0.590    0.515
   .Q15A              0.581    0.004  130.109    0.000    0.581    0.595
   .Q19A              0.785    0.006  132.085    0.000    0.785    0.681
   .Q20A              0.561    0.004  124.984    0.000    0.561    0.449
   .Q23A              0.493    0.004  131.617    0.000    0.493    0.658
   .Q25A              0.681    0.005  129.719    0.000    0.681    0.581
   .Q28A              0.478    0.004  123.083    0.000    0.478    0.412
   .Q30A              0.662    0.005  129.348    0.000    0.662    0.568
   .Q36A              0.551    0.004  124.837    0.000    0.551    0.446
   .Q40A              0.631    0.005  127.580    0.000    0.631    0.513
   .Q41A              0.601    0.005  128.683    0.000    0.601    0.546
   .Q1A               0.467    0.004  126.294    0.000    0.467    0.437
   .Q6A               0.571    0.004  129.082    0.000    0.571    0.516
   .Q8A               0.541    0.004  128.138    0.000    0.541    0.486
   .Q11A              0.464    0.004  125.600    0.000    0.464    0.421
   .Q12A              0.574    0.004  128.705    0.000    0.574    0.504
   .Q14A              0.785    0.006  132.627    0.000    0.785    0.672
   .Q18A              0.733    0.006  132.077    0.000    0.733    0.642
   .Q22A              0.523    0.004  128.331    0.000    0.523    0.492
   .Q27A              0.510    0.004  127.255    0.000    0.510    0.461
   .Q29A              0.498    0.004  126.551    0.000    0.498    0.443
   .Q32A              0.585    0.004  130.300    0.000    0.585    0.561
   .Q33A              0.541    0.004  128.213    0.000    0.541    0.489
   .Q35A              0.568    0.004  130.460    0.000    0.568    0.567
   .Q39A              0.491    0.004  127.618    0.000    0.491    0.471
    depression        0.653    0.007   88.452    0.000    1.000    1.000
    anxiety           0.317    0.006   50.766    0.000    1.000    1.000
    stress            0.602    0.007   83.798    0.000    1.000    1.000
```

Now, this output contains several key pieces of information: 

- fit statistics for the model
- information on item loadings on the latent variables (factors)
- information on the correlations between the latent variables
- information on the variance of latent and manifest variables

Let's walk through the output one-by-one.

## Fit measures

The model fit is evaluated using three key criteria.

The first is the Chi^2 statistic. This evaluates whether the model adequately reproduces the covariance matrix in the real data or whether there is some deviation. Significant results indicate that the model does not reproduce the covariance matrix. However, this is largely dependent on sample size and not informative in practice. The CFA model is always a reduction of the underlying covariance matrix. That is the whole point of a model. Therefore, do not interpret the chi-square test and its associated p-value. Nonetheless, it is customary to report this information when presenting the model fit.

The following two fit statistics are independent of sample size and widely accepted in practice.

The CFI (Comparative Fit Index) is an indicator of fit. It ranges between 0 and 1 with 0 meaning horrible fit and 1 reflecting perfect fit. Values above 0.8 are acceptable and CFI > 0.9 is considered good. This index is independent of sample size and robust against violations of some assumptions CFA makes. It is however dependent on the number of free parameters as it does not include a penalty for additional parameters. Therefore, models with more parameter will generally have better CFI than parsimonious models with fewer parameters.

The RMSEA (Root Mean Squared Error Approximation) is an indicator of misfit that includes a penalty for the number of parameters. The higher the RMSEA, the worse. Generally, RMSEA < 0.05 is considered good and RMSEA < 0.08 acceptable. Models with RMSEA > 0.10 should not be interpreted. This fit statistic indicates whether the model fits the data well while controlling for the number of parameters specified.

It is customary to report all three of these measures when reporting the results of a CFA. Similarly, you should also interpret both the CFI and RMSEA, as bad fits in both statistics can indicate issues in the model specification. The above model would be reported as follows. 

The model with three correlated factors showed acceptable fit to the data $\chi^2(816) = 107309.08, p < 0.001, CFI = 0.90, RMSEA = 0.06$, 95% CI = $[0.06; 0.06]$.

In a future section, we will explore how you can compare models and select models based on these fit statistics. Here, it is important to focus on fit statistics that incorporate the number of free parameters like the RMSEA. Otherwise, more complex models will always outperform less complex models. 

In addition to the statistics presented above, model comparison is often based on information criteria, like the AIC (Akaike Information Criterion) or the BIC (Bayesian Information Criterion). Here, lower values indicate better models. These information criteria also penalize complexity and are thus well suited for model comparison. More on this in the later section.

## Loadings on latent variables
The next section in the model summary output display information on the latent variables. Specifically how highly the manifest variables "load" onto the latent variables they were assigned to. Here, loadings > 0.6 are considered high and at least one of the manifest variables should load highly on the latent variables. If all loadings are low, this might indicate that the factor you are trying to define does not really exist, as there is little relation between the manifest variables specified to load on this factor.

Importantly, the output shows two columns with loadings. The first column "Estimate" shows unstandardized loadings (like regression weights in a linear model). The last two columns "std.lv" and "std.all" show two different standardization techniques of the loadings. For now, focus on the "std.all" column. This can be interpreted in similar fashion as the factor loadings in the EFA. 

In our example, these loadings are looking very good, especially for the depression scale. But for all scales, almost all items show standardized loadings of > 0.6, indicating that they reflect the underlying factor well.

::: callout
## Key Difference between EFA and CFA

These loadings highlight a key difference between CFA and a factor analysis with a fixed number of factors as conducted following an EFA.

In the EFA case, item *cross-loadings* are allowed. An item can load onto all factors. This is not the case in theory (unless explicitly stated). Here, the items only load onto the factor as specified in the model syntax. This is also why we obtain different loadings and correlations between factors in this CFA example compared to the three-factor FA from the previous episode.
:::

## Correlations between latent variables
The next section in the output informs us about the covariances between the latent variables. The "Estimate" column again shows the unstandardized solution while the "std.all" column reflects the standardized solution. The "std.all" column can be interpreted like a correlation (only on a latent level).

Here, we can see high correlations > 0.7 between our three factors. Anxiety and stress even correlate to 0.87! Maybe there is one underlying "g" factor of depression in our data after all? We will investigate this further in the section regarding model comparison. 

## Variances
The last section of the summary output displays the variances of the errors of manifest variables and the variance of the latent variables. Here, you should make sure that all values in "Estimate" are positive and that the variance of the latent variables differs significantly from 0, the results for this test are printed in "P(>|z|)". 

For CFA this section is not that relevant and plays a larger role in other SEM models.

## Model Comparison
The last thing we will learn in this episode is how to leverage the fit statistics and other model information to compare different models. For example, remember that the EFA showed that the first factor had an extremely large eigenvalue, indicating that one factor already explained a substantial amount of variance.

A skeptic of the DASS might argue that it does not measure three distinct scales after all, but rather one unifying "I'm doing bad" construct. Therefore, this skeptic might generate a competing model of the DASS, with only one factor on which all items are loading.

Let's first test the fit statistics of this model and then compare the two approaches.


``` r
model_cfa_1fac <- c(
  "
  # Model Syntax G Factor Model DASS
  
  # Define only one general factor
  g_dass =~ Q3A + Q5A + Q10A + Q13A + Q16A + Q17A + Q21A + Q24A + Q26A + Q31A + Q34A + Q37A + Q38A + Q42A +Q2A + Q4A + Q7A + Q9A + Q15A + Q19A + Q20A + Q23A + Q25A + Q28A + Q30A + Q36A + Q40A + Q41A + Q1A + Q6A + Q8A + Q11A + Q12A + Q14A + Q18A + Q22A + Q27A + Q29A + Q32A + Q33A + Q35A + Q39A
  "
)

fit_cfa_1fac <- cfa(model_cfa_1fac, data = fa_data)

summary(fit_cfa_1fac, fit.measures = TRUE, standardize = TRUE)
```

``` output
lavaan 0.6-19 ended normally after 25 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                        84

  Number of observations                         37242

Model Test User Model:
                                                        
  Test statistic                              235304.681
  Degrees of freedom                                 819
  P-value (Chi-square)                             0.000

Model Test Baseline Model:

  Test statistic                           1037764.006
  Degrees of freedom                               861
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.774
  Tucker-Lewis Index (TLI)                       0.762

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)           -1921157.820
  Loglikelihood unrestricted model (H1)   -1803505.480
                                                      
  Akaike (AIC)                             3842483.641
  Bayesian (BIC)                           3843199.757
  Sample-size adjusted Bayesian (SABIC)    3842932.805

Root Mean Square Error of Approximation:

  RMSEA                                          0.088
  90 Percent confidence interval - lower         0.087
  90 Percent confidence interval - upper         0.088
  P-value H_0: RMSEA <= 0.050                    0.000
  P-value H_0: RMSEA >= 0.080                    1.000

Standardized Root Mean Square Residual:

  SRMR                                           0.067

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  g_dass =~                                                             
    Q3A               1.000                               0.761    0.731
    Q5A               1.016    0.007  142.019    0.000    0.773    0.722
    Q10A              1.100    0.008  144.449    0.000    0.837    0.733
    Q13A              1.113    0.007  156.040    0.000    0.846    0.788
    Q16A              1.060    0.007  142.723    0.000    0.806    0.725
    Q17A              1.147    0.008  148.618    0.000    0.872    0.753
    Q21A              1.168    0.008  150.256    0.000    0.889    0.760
    Q24A              0.991    0.007  140.991    0.000    0.754    0.717
    Q26A              1.057    0.007  148.520    0.000    0.804    0.752
    Q31A              0.962    0.007  137.412    0.000    0.732    0.700
    Q34A              1.156    0.008  150.634    0.000    0.879    0.762
    Q37A              1.063    0.008  139.320    0.000    0.809    0.709
    Q38A              1.166    0.008  147.074    0.000    0.887    0.745
    Q42A              0.865    0.007  124.363    0.000    0.658    0.637
    Q2A               0.663    0.008   87.349    0.000    0.504    0.453
    Q4A               0.806    0.007  114.105    0.000    0.613    0.587
    Q7A               0.806    0.007  114.965    0.000    0.613    0.591
    Q9A               0.901    0.007  125.202    0.000    0.686    0.641
    Q15A              0.748    0.007  111.994    0.000    0.569    0.576
    Q19A              0.675    0.007   92.306    0.000    0.513    0.478
    Q20A              1.008    0.007  134.599    0.000    0.767    0.686
    Q23A              0.585    0.006   99.515    0.000    0.445    0.514
    Q25A              0.787    0.007  107.302    0.000    0.599    0.553
    Q28A              0.968    0.007  134.071    0.000    0.737    0.684
    Q30A              0.907    0.007  124.927    0.000    0.690    0.639
    Q36A              1.034    0.007  139.134    0.000    0.787    0.708
    Q40A              0.935    0.007  125.352    0.000    0.711    0.641
    Q41A              0.773    0.007  108.798    0.000    0.588    0.560
    Q1A               0.956    0.007  138.241    0.000    0.727    0.704
    Q6A               0.869    0.007  122.694    0.000    0.661    0.629
    Q8A               0.961    0.007  136.064    0.000    0.731    0.693
    Q11A              0.987    0.007  140.627    0.000    0.751    0.715
    Q12A              0.943    0.007  131.722    0.000    0.718    0.672
    Q14A              0.724    0.007   98.622    0.000    0.551    0.510
    Q18A              0.784    0.007  108.318    0.000    0.596    0.558
    Q22A              0.929    0.007  134.440    0.000    0.707    0.685
    Q27A              0.950    0.007  134.779    0.000    0.723    0.687
    Q29A              0.972    0.007  137.073    0.000    0.740    0.698
    Q32A              0.826    0.007  119.966    0.000    0.628    0.615
    Q33A              0.954    0.007  135.255    0.000    0.725    0.689
    Q35A              0.812    0.007  120.437    0.000    0.618    0.618
    Q39A              0.916    0.007  133.922    0.000    0.697    0.683

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .Q3A               0.505    0.004  132.069    0.000    0.505    0.466
   .Q5A               0.550    0.004  132.300    0.000    0.550    0.479
   .Q10A              0.602    0.005  132.010    0.000    0.602    0.463
   .Q13A              0.439    0.003  130.205    0.000    0.439    0.380
   .Q16A              0.587    0.004  132.219    0.000    0.587    0.475
   .Q17A              0.582    0.004  131.451    0.000    0.582    0.433
   .Q21A              0.576    0.004  131.207    0.000    0.576    0.422
   .Q24A              0.539    0.004  132.416    0.000    0.539    0.486
   .Q26A              0.496    0.004  131.465    0.000    0.496    0.434
   .Q31A              0.559    0.004  132.788    0.000    0.559    0.511
   .Q34A              0.557    0.004  131.148    0.000    0.557    0.419
   .Q37A              0.648    0.005  132.595    0.000    0.648    0.498
   .Q38A              0.629    0.005  131.668    0.000    0.629    0.444
   .Q42A              0.635    0.005  133.849    0.000    0.635    0.595
   .Q2A               0.985    0.007  135.470    0.000    0.985    0.795
   .Q4A               0.717    0.005  134.451    0.000    0.717    0.656
   .Q7A               0.702    0.005  134.407    0.000    0.702    0.651
   .Q9A               0.675    0.005  133.792    0.000    0.675    0.589
   .Q15A              0.652    0.005  134.557    0.000    0.652    0.668
   .Q19A              0.889    0.007  135.325    0.000    0.889    0.771
   .Q20A              0.662    0.005  133.053    0.000    0.662    0.529
   .Q23A              0.551    0.004  135.083    0.000    0.551    0.736
   .Q25A              0.814    0.006  134.773    0.000    0.814    0.694
   .Q28A              0.619    0.005  133.100    0.000    0.619    0.533
   .Q30A              0.689    0.005  133.811    0.000    0.689    0.591
   .Q36A              0.616    0.005  132.614    0.000    0.616    0.499
   .Q40A              0.724    0.005  133.782    0.000    0.724    0.588
   .Q41A              0.755    0.006  134.707    0.000    0.755    0.686
   .Q1A               0.539    0.004  132.706    0.000    0.539    0.505
   .Q6A               0.669    0.005  133.958    0.000    0.669    0.605
   .Q8A               0.577    0.004  132.918    0.000    0.577    0.520
   .Q11A              0.539    0.004  132.455    0.000    0.539    0.489
   .Q12A              0.624    0.005  133.301    0.000    0.624    0.548
   .Q14A              0.864    0.006  135.115    0.000    0.864    0.740
   .Q18A              0.786    0.006  134.728    0.000    0.786    0.689
   .Q22A              0.564    0.004  133.067    0.000    0.564    0.530
   .Q27A              0.584    0.004  133.037    0.000    0.584    0.528
   .Q29A              0.576    0.004  132.822    0.000    0.576    0.513
   .Q32A              0.648    0.005  134.127    0.000    0.648    0.621
   .Q33A              0.581    0.004  132.993    0.000    0.581    0.525
   .Q35A              0.620    0.005  134.099    0.000    0.620    0.619
   .Q39A              0.556    0.004  133.113    0.000    0.556    0.534
    g_dass            0.579    0.007   81.612    0.000    1.000    1.000
```
The one factor model showed a poor fit to the data $\chi^2(819) = 235304.68, p < 0.001, CFI = 0.77, RMSEA = 0.09$, 95% CI = $[0.09; 0.09]$.

This already shows that the idea of only one unifying factor in the DASS does not reflect the data well. We can formally test the difference in the $\chi^2$ statistic using `anova()`, not to be confused with the ANOVA.


``` r
anova(fit_cfa_1fac, fit_cfa_3facs)
```

``` output

Chi-Squared Difference Test

               Df     AIC     BIC  Chisq Chisq diff  RMSEA Df diff Pr(>Chisq)
fit_cfa_3facs 816 3714494 3715236 107309                                     
fit_cfa_1fac  819 3842484 3843200 235305     127996 1.0703       3  < 2.2e-16
                 
fit_cfa_3facs    
fit_cfa_1fac  ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
This output displays that the three factor model shows better information criteria (AIC and BIC) and that it also has lower (better) $\chi^2$ statistics, significantly so. Coupled with an improved RMSEA for the three factor model, this evidence strongly suggests that the three factor model is better suited to explain the DASS data than the one factor model.


::: challenge 

## Challenge 1

Read in data and answer the question: do we have a hypothesis as to how the structure should be?

:::

::: challenge 

## Challenge 2

Run a CFA with three factors
:::

::: challenge 

## Challenge 3

Interpret some results
:::

::: challenge 

## Challenge 4

Run a cfa with one factor, interpret some results

:::

::: challenge 

## Challenge 5

Compare the models from challenge 3 and challenge 4, which one fits better?

:::

::::::::::::::::::::::::::::::::::::: keypoints 

- Something

::::::::::::::::::::::::::::::::::::::::::::::::

