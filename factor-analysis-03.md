---
title: 'Factor Analysis - Advanced Measurement Models'
teaching: 10
exercises: 15
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a bifactor model?
- What is a hierachical model?
- How can I specify different types of measurement models?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Understand the difference between hierarchical, non-hierarchical and bifactor models
- Learn how to specify a hierarchical model
- Learn how to specify a bifactor model
- Learn how to evaluate hierarchical and bifactor models
::::::::::::::::::::::::::::::::::::::::::::::::

## Measurement Models

So far, we have looked at only 1-factor and correlated multiple factor models in CFAs. This lesson, we will extend this approach to more general models. For example, CFA models can not only incorporate a number of factors correlating with each other, but also support a kind of "second CFA" on the levels of factors. If you have multiple factors that correlate highly with each other, they might themselves have a higher order factor that can account for their covariation.

This is called a "hierarchical" model. We can simply extend our three factor model as follows.

## Hierarchical Models


``` r
library(lavaan)
```

``` output
This is lavaan 0.6-19
lavaan is FREE software! Please report any bugs.
```

``` r
model_cfa_hierarch <- c(
  "
  # Model Syntax
  # Define which items load on which factor
  depression =~ Q3A + Q5A + Q10A + Q13A + Q16A + Q17A + Q21A + Q24A + Q26A + Q31A + Q34A + Q37A + Q38A + Q42A
  
  anxiety =~ Q2A + Q4A + Q7A + Q9A + Q15A + Q19A + Q20A + Q23A + Q25A + Q28A + Q30A + Q36A + Q40A + Q41A
  
  stress =~ Q1A + Q6A + Q8A + Q11A + Q12A + Q14A + Q18A + Q22A + Q27A + Q29A + Q32A + Q33A + Q35A + Q39A
  
  # Now, not correlation between factors, but hierarchy
  high_level_fac =~ depression + anxiety + stress
  "
)
```

Let's load the data again and investigate this model:


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

fit_cfa_hierarch <- cfa(
  model = model_cfa_hierarch, 
  data = fa_data,
  )

summary(fit_cfa_hierarch, fit.measures = TRUE, standardized = TRUE)
```

``` output
lavaan 0.6-19 ended normally after 38 iterations

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
    Q3A                1.000                               0.808    0.776
    Q5A                0.983    0.006  155.298    0.000    0.794    0.742
    Q10A               1.156    0.007  175.483    0.000    0.934    0.818
    Q13A               1.077    0.006  173.188    0.000    0.870    0.810
    Q16A               1.077    0.006  165.717    0.000    0.870    0.782
    Q17A               1.158    0.007  172.607    0.000    0.936    0.807
    Q21A               1.221    0.007  182.633    0.000    0.986    0.844
    Q24A               0.987    0.006  159.408    0.000    0.797    0.758
    Q26A               1.020    0.006  162.877    0.000    0.824    0.771
    Q31A               0.966    0.006  156.243    0.000    0.780    0.746
    Q34A               1.169    0.007  175.678    0.000    0.944    0.819
    Q37A               1.118    0.007  168.220    0.000    0.903    0.791
    Q38A               1.229    0.007  180.035    0.000    0.993    0.834
    Q42A               0.826    0.006  131.716    0.000    0.668    0.646
  anxiety =~                                                             
    Q2A                1.000                               0.563    0.506
    Q4A                1.282    0.014   93.090    0.000    0.722    0.691
    Q7A                1.303    0.014   94.229    0.000    0.734    0.707
    Q9A                1.323    0.014   93.485    0.000    0.745    0.696
    Q15A               1.116    0.013   89.051    0.000    0.629    0.636
    Q19A               1.077    0.013   83.014    0.000    0.606    0.565
    Q20A               1.473    0.015   96.526    0.000    0.830    0.742
    Q23A               0.898    0.011   84.756    0.000    0.506    0.584
    Q25A               1.244    0.014   89.922    0.000    0.701    0.647
    Q28A               1.468    0.015   98.046    0.000    0.827    0.767
    Q30A               1.260    0.014   90.684    0.000    0.710    0.657
    Q36A               1.469    0.015   96.658    0.000    0.827    0.744
    Q40A               1.374    0.015   93.607    0.000    0.774    0.698
    Q41A               1.256    0.014   91.905    0.000    0.707    0.674
  stress =~                                                              
    Q1A                1.000                               0.776    0.750
    Q6A                0.943    0.007  137.700    0.000    0.732    0.695
    Q8A                0.974    0.007  142.400    0.000    0.756    0.717
    Q11A               1.030    0.007  152.388    0.000    0.799    0.761
    Q12A               0.969    0.007  139.655    0.000    0.752    0.704
    Q14A               0.797    0.007  111.328    0.000    0.619    0.572
    Q18A               0.824    0.007  116.739    0.000    0.639    0.598
    Q22A               0.947    0.007  141.491    0.000    0.735    0.713
    Q27A               0.995    0.007  146.259    0.000    0.772    0.734
    Q29A               1.020    0.007  149.023    0.000    0.791    0.746
    Q32A               0.872    0.007  130.509    0.000    0.677    0.663
    Q33A               0.970    0.007  142.052    0.000    0.753    0.715
    Q35A               0.849    0.007  129.452    0.000    0.658    0.658
    Q39A               0.956    0.007  144.730    0.000    0.742    0.727
  high_level_fac =~                                                      
    depression         1.000                               0.802    0.802
    anxiety            0.776    0.009   88.349    0.000    0.893    0.893
    stress             1.171    0.009  124.409    0.000    0.978    0.978

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
   .depression        0.233    0.003   77.473    0.000    0.357    0.357
   .anxiety           0.064    0.002   41.710    0.000    0.202    0.202
   .stress            0.027    0.002   14.464    0.000    0.044    0.044
    high_level_fac    0.420    0.006   70.881    0.000    1.000    1.000
```
Again, let's look at the fit indices first. The hierarchical model with three factors showed acceptable fit to the data $\chi^2(816) = 107309.08, p < 0.001, CFI = 0.90, RMSEA = 0.06$, 95% CI = $[0.06; 0.06]$. Similarly, the loadings on the first-order factors (depression, anxiety, stress) also look good and we do not observe any issues in the variance.

If you have a good memory, you might notice that the fit statistics are identical to those in the correlated 3-factors model. This is because the higher order factor in this case only restructures the bivariate correlations into factor loadings. However, this is not true for all number of factors. In models with more than 3 first-order factors, establishing a second-order factor loading on all of them introduces more constraints than allowing the factors to correlate freely.


``` r
# Semplot here?
```

The hierarchical model allows us to investigate two very important things. Firstly, we can investigate the presence of a higher order factor. This is only the case if 1) the model fit is acceptable, 2) the factor loadings on this second-order factor are high enough and 3) the variance of the second-order factor is significantly different from 0. In this case, all three things are true, supporting the conclusion that a model with a higher order factor that contributes variance to all lower factors fits the data well.

Secondly, they are extremely useful in Structural Equation Models (SEM), as this higher-order factor can then itself be correlated to other outcomes, and allows researchers to investigate how much the general factor is associated with other items.


## Bi-Factor Models

In this hierarchical case, we assume that the higher-order factor captures the shared variance of all first-order factors. So the higher-order factor only contributes variance to the observed variables *indirectly* through the first-order factors (depression etc.). 

Bi-factor models change this behavior significantly. They do not impose a hierarchical structure but rather partition the variance in the observed variables into a general factor and specific factors. In the case of the DASS, a bifactor model would assert that each item is mostly determined by a general "I'm doing bad factor" and depending on the item context, depression, anxiety, or stress specifically contribute to the response on the specific item. 

In contrast to a hierarchical model, this g-factor is directly influencing responses in the items and is *not related* to the specific factors. These models are often employed when researchers have good reason to believe that there are some specific factors unrelated to general response, as for example when using multiple tests measuring the same construct. One might introduce a general factor for construct and several specific factors capturing measurement specific variance (e.g. g factor for Openness, specific factors for self-rating vs. other-rating).

The model syntax displays this direct loading and the uncorrelated latent variables:

``` r
model_cfa_bifac <- c(
  "
  # Model Syntax
  # Define which items load on which factor
  depression =~ Q3A + Q5A + Q10A + Q13A + Q16A + Q17A + Q21A + Q24A + Q26A + Q31A + Q34A + Q37A + Q38A + Q42A
  
  anxiety =~ Q2A + Q4A + Q7A + Q9A + Q15A + Q19A + Q20A + Q23A + Q25A + Q28A + Q30A + Q36A + Q40A + Q41A
  
  stress =~ Q1A + Q6A + Q8A + Q11A + Q12A + Q14A + Q18A + Q22A + Q27A + Q29A + Q32A + Q33A + Q35A + Q39A
  
  # Direct loading of the items on the general factor
  g_dass =~ Q3A + Q5A + Q10A + Q13A + Q16A + Q17A + Q21A + Q24A + Q26A + Q31A + Q34A + Q37A + Q38A + Q42A +Q2A + Q4A + Q7A + Q9A + Q15A + Q19A + Q20A + Q23A + Q25A + Q28A + Q30A + Q36A + Q40A + Q41A + Q1A + Q6A + Q8A + Q11A + Q12A + Q14A + Q18A + Q22A + Q27A + Q29A + Q32A + Q33A + Q35A + Q39A
  
  # Define correlations between factors using ~~
  depression ~~ 0*anxiety
  depression ~~ 0*stress
  anxiety ~~ 0*stress
  
  g_dass ~~ 0*depression
  g_dass ~~ 0*stress
  g_dass ~~ 0*anxiety
  "
)
```


``` r
fit_cfa_bifac <- cfa(model_cfa_bifac, data = fa_data)

summary(fit_cfa_bifac, fit.measures = TRUE, standardized = TRUE)
```

``` output
lavaan 0.6-19 ended normally after 90 iterations

  Estimator                                         ML
  Optimization method                           NLMINB
  Number of model parameters                       126

  Number of observations                         37242

Model Test User Model:
                                                       
  Test statistic                              72120.789
  Degrees of freedom                                777
  P-value (Chi-square)                            0.000

Model Test Baseline Model:

  Test statistic                           1037764.006
  Degrees of freedom                               861
  P-value                                        0.000

User Model versus Baseline Model:

  Comparative Fit Index (CFI)                    0.931
  Tucker-Lewis Index (TLI)                       0.924

Loglikelihood and Information Criteria:

  Loglikelihood user model (H0)           -1839565.874
  Loglikelihood unrestricted model (H1)   -1803505.480
                                                      
  Akaike (AIC)                             3679383.748
  Bayesian (BIC)                           3680457.922
  Sample-size adjusted Bayesian (SABIC)    3680057.494

Root Mean Square Error of Approximation:

  RMSEA                                          0.050
  90 Percent confidence interval - lower         0.049
  90 Percent confidence interval - upper         0.050
  P-value H_0: RMSEA <= 0.050                    0.968
  P-value H_0: RMSEA >= 0.080                    0.000

Standardized Root Mean Square Residual:

  SRMR                                           0.031

Parameter Estimates:

  Standard errors                             Standard
  Information                                 Expected
  Information saturated (h1) model          Structured

Latent Variables:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  depression =~                                                         
    Q3A               1.000                               0.476    0.457
    Q5A               0.838    0.011   77.509    0.000    0.399    0.373
    Q10A              1.408    0.014  104.191    0.000    0.670    0.587
    Q13A              0.930    0.010   88.624    0.000    0.443    0.412
    Q16A              1.143    0.012   92.973    0.000    0.544    0.489
    Q17A              1.242    0.013   97.712    0.000    0.591    0.510
    Q21A              1.494    0.014  108.013    0.000    0.711    0.609
    Q24A              0.960    0.011   85.644    0.000    0.457    0.434
    Q26A              0.862    0.011   81.459    0.000    0.410    0.384
    Q31A              0.967    0.011   85.275    0.000    0.461    0.440
    Q34A              1.252    0.013   99.210    0.000    0.596    0.517
    Q37A              1.380    0.014  101.533    0.000    0.657    0.576
    Q38A              1.546    0.014  107.851    0.000    0.736    0.618
    Q42A              0.655    0.011   61.266    0.000    0.312    0.302
  anxiety =~                                                            
    Q2A               1.000                               0.288    0.258
    Q4A               1.573    0.037   42.513    0.000    0.452    0.433
    Q7A               1.940    0.044   44.187    0.000    0.558    0.538
    Q9A               0.232    0.018   12.886    0.000    0.067    0.062
    Q15A              1.207    0.030   39.724    0.000    0.347    0.351
    Q19A              1.288    0.033   38.640    0.000    0.370    0.345
    Q20A              0.442    0.020   22.556    0.000    0.127    0.114
    Q23A              1.100    0.028   39.596    0.000    0.316    0.365
    Q25A              1.342    0.034   40.033    0.000    0.386    0.357
    Q28A              0.667    0.021   31.767    0.000    0.192    0.178
    Q30A              0.170    0.019    9.086    0.000    0.049    0.045
    Q36A              0.402    0.019   21.113    0.000    0.116    0.104
    Q40A              0.292    0.019   15.254    0.000    0.084    0.076
    Q41A              1.866    0.043   43.679    0.000    0.537    0.511
  stress =~                                                             
    Q1A               1.000                               0.381    0.368
    Q6A               0.790    0.016   49.154    0.000    0.301    0.286
    Q8A              -0.056    0.014   -4.124    0.000   -0.021   -0.020
    Q11A              1.079    0.017   62.272    0.000    0.411    0.391
    Q12A             -0.463    0.015  -29.980    0.000   -0.176   -0.165
    Q14A              0.800    0.018   44.430    0.000    0.304    0.282
    Q18A              0.754    0.017   43.691    0.000    0.287    0.269
    Q22A              0.187    0.013   13.917    0.000    0.071    0.069
    Q27A              0.993    0.017   58.180    0.000    0.378    0.359
    Q29A              0.605    0.014   42.099    0.000    0.230    0.217
    Q32A              0.737    0.016   46.342    0.000    0.281    0.275
    Q33A             -0.525    0.016  -33.597    0.000   -0.200   -0.190
    Q35A              0.680    0.015   44.095    0.000    0.259    0.259
    Q39A              0.538    0.014   38.401    0.000    0.205    0.201
  g_dass =~                                                             
    Q3A               1.000                               0.647    0.621
    Q5A               1.058    0.008  127.074    0.000    0.685    0.639
    Q10A              1.034    0.008  131.792    0.000    0.669    0.586
    Q13A              1.158    0.008  140.588    0.000    0.749    0.697
    Q16A              1.036    0.008  127.946    0.000    0.670    0.603
    Q17A              1.128    0.008  135.443    0.000    0.730    0.630
    Q21A              1.100    0.008  139.112    0.000    0.711    0.609
    Q24A              0.996    0.008  126.030    0.000    0.644    0.612
    Q26A              1.103    0.008  133.013    0.000    0.713    0.668
    Q31A              0.959    0.008  122.467    0.000    0.620    0.592
    Q34A              1.138    0.008  137.814    0.000    0.736    0.638
    Q37A              0.996    0.008  125.672    0.000    0.644    0.565
    Q38A              1.086    0.008  135.445    0.000    0.703    0.590
    Q42A              0.914    0.008  110.771    0.000    0.592    0.572
    Q2A               0.764    0.010   78.619    0.000    0.494    0.444
    Q4A               0.956    0.010  100.570    0.000    0.618    0.592
    Q7A               0.947    0.009  100.271    0.000    0.613    0.590
    Q9A               1.152    0.010  114.816    0.000    0.745    0.696
    Q15A              0.856    0.009   96.201    0.000    0.554    0.560
    Q19A              0.802    0.009   84.718    0.000    0.519    0.483
    Q20A              1.245    0.011  117.876    0.000    0.805    0.720
    Q23A              0.667    0.008   86.982    0.000    0.431    0.498
    Q25A              0.953    0.010   97.541    0.000    0.617    0.570
    Q28A              1.238    0.010  120.648    0.000    0.800    0.743
    Q30A              1.095    0.010  109.651    0.000    0.709    0.656
    Q36A              1.247    0.011  118.553    0.000    0.807    0.726
    Q40A              1.173    0.010  113.292    0.000    0.759    0.684
    Q41A              0.910    0.009   96.144    0.000    0.589    0.561
    Q1A               1.111    0.010  113.901    0.000    0.719    0.695
    Q6A               1.058    0.010  108.405    0.000    0.684    0.651
    Q8A               1.187    0.010  118.873    0.000    0.768    0.729
    Q11A              1.139    0.010  114.602    0.000    0.737    0.702
    Q12A              1.260    0.010  122.913    0.000    0.815    0.764
    Q14A              0.871    0.010   90.195    0.000    0.563    0.521
    Q18A              0.916    0.010   95.101    0.000    0.593    0.555
    Q22A              1.118    0.010  115.483    0.000    0.723    0.702
    Q27A              1.091    0.010  110.804    0.000    0.706    0.671
    Q29A              1.171    0.010  116.850    0.000    0.757    0.715
    Q32A              0.968    0.009  103.368    0.000    0.626    0.613
    Q33A              1.271    0.010  124.894    0.000    0.822    0.781
    Q35A              0.945    0.009  103.042    0.000    0.611    0.611
    Q39A              1.091    0.010  113.992    0.000    0.706    0.692

Covariances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
  depression ~~                                                         
    anxiety           0.000                               0.000    0.000
    stress            0.000                               0.000    0.000
  anxiety ~~                                                            
    stress            0.000                               0.000    0.000
  depression ~~                                                         
    g_dass            0.000                               0.000    0.000
  stress ~~                                                             
    g_dass            0.000                               0.000    0.000
  anxiety ~~                                                            
    g_dass            0.000                               0.000    0.000

Variances:
                   Estimate  Std.Err  z-value  P(>|z|)   Std.lv  Std.all
   .Q3A               0.439    0.003  129.116    0.000    0.439    0.405
   .Q5A               0.519    0.004  131.501    0.000    0.519    0.452
   .Q10A              0.406    0.003  120.568    0.000    0.406    0.312
   .Q13A              0.398    0.003  128.596    0.000    0.398    0.345
   .Q16A              0.492    0.004  128.021    0.000    0.492    0.398
   .Q17A              0.460    0.004  125.804    0.000    0.460    0.343
   .Q21A              0.354    0.003  115.937    0.000    0.354    0.259
   .Q24A              0.484    0.004  130.257    0.000    0.484    0.437
   .Q26A              0.465    0.004  130.540    0.000    0.465    0.407
   .Q31A              0.499    0.004  130.430    0.000    0.499    0.455
   .Q34A              0.433    0.003  124.935    0.000    0.433    0.325
   .Q37A              0.456    0.004  122.826    0.000    0.456    0.350
   .Q38A              0.381    0.003  115.828    0.000    0.381    0.269
   .Q42A              0.621    0.005  133.654    0.000    0.621    0.581
   .Q2A               0.912    0.007  132.163    0.000    0.912    0.736
   .Q4A               0.506    0.004  117.060    0.000    0.506    0.463
   .Q7A               0.391    0.004   96.997    0.000    0.391    0.363
   .Q9A               0.586    0.005  130.242    0.000    0.586    0.512
   .Q15A              0.549    0.004  126.066    0.000    0.549    0.563
   .Q19A              0.746    0.006  127.751    0.000    0.746    0.647
   .Q20A              0.585    0.005  129.861    0.000    0.585    0.468
   .Q23A              0.463    0.004  126.185    0.000    0.463    0.618
   .Q25A              0.642    0.005  125.465    0.000    0.642    0.548
   .Q28A              0.484    0.004  128.458    0.000    0.484    0.417
   .Q30A              0.661    0.005  131.247    0.000    0.661    0.567
   .Q36A              0.571    0.004  129.586    0.000    0.571    0.463
   .Q40A              0.647    0.005  130.851    0.000    0.647    0.526
   .Q41A              0.466    0.004  105.809    0.000    0.466    0.424
   .Q1A               0.407    0.004  113.121    0.000    0.407    0.381
   .Q6A               0.548    0.004  125.196    0.000    0.548    0.495
   .Q8A               0.521    0.004  126.156    0.000    0.521    0.469
   .Q11A              0.391    0.004  108.324    0.000    0.391    0.355
   .Q12A              0.444    0.004  109.048    0.000    0.444    0.390
   .Q14A              0.757    0.006  128.517    0.000    0.757    0.649
   .Q18A              0.708    0.005  128.759    0.000    0.708    0.620
   .Q22A              0.535    0.004  130.122    0.000    0.535    0.503
   .Q27A              0.466    0.004  116.394    0.000    0.466    0.421
   .Q29A              0.497    0.004  127.087    0.000    0.497    0.442
   .Q32A              0.572    0.004  127.129    0.000    0.572    0.548
   .Q33A              0.392    0.004  101.742    0.000    0.392    0.354
   .Q35A              0.561    0.004  128.205    0.000    0.561    0.560
   .Q39A              0.501    0.004  128.729    0.000    0.501    0.481
    depression        0.227    0.004   56.333    0.000    1.000    1.000
    anxiety           0.083    0.004   23.169    0.000    1.000    1.000
    stress            0.145    0.004   38.869    0.000    1.000    1.000
    g_dass            0.418    0.006   65.244    0.000    1.000    1.000
```

This model shows good fit to the data $\chi^2(777) = 72120.79, p < 0.001, CFI = 0.93, RMSEA = 0.05$, 95% CI = $[0.05; 0.05]$. We can additionally observe no issues in the loadings on the general factor. For the specific factors, there are items that do not seem to measure anything factor-specific in addition to the general factor, as they show loadings near zero on their specific factor. 

From this model, we seomthing general factor, specific is  abit low. But good fit

What might this mean for DASS - general score supported. Some specific subtests might not measure their things but something else entirely

## Model Comparison - Nested models
Nested models, and comparisons of models

Declaring a winner for our DASS data


``` r
model_cfa_1fac <- c(
  "
  # Model Syntax G Factor Model DASS
  
  # Define only one general factor
  g_dass =~ Q3A + Q5A + Q10A + Q13A + Q16A + Q17A + Q21A + Q24A + Q26A + Q31A + Q34A + Q37A + Q38A + Q42A +Q2A + Q4A + Q7A + Q9A + Q15A + Q19A + Q20A + Q23A + Q25A + Q28A + Q30A + Q36A + Q40A + Q41A + Q1A + Q6A + Q8A + Q11A + Q12A + Q14A + Q18A + Q22A + Q27A + Q29A + Q32A + Q33A + Q35A + Q39A
  "
)

fit_cfa_1fac <- cfa(model_cfa_1fac, data = fa_data)

model_cfa_3facs <- c(
  "
  # Model Syntax
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
fit_cfa_3facs <- cfa(
  model = model_cfa_3facs, 
  data = fa_data,
  )
```


``` r
fitmeasures(fit_cfa_1fac, c("df", "chisq", "pvalue", "cfi", "rmsea"))
```

``` output
        df      chisq     pvalue        cfi      rmsea 
   819.000 235304.681      0.000      0.774      0.088 
```

``` r
fitmeasures(fit_cfa_3facs, c("df", "chisq", "pvalue", "cfi", "rmsea"))
```

``` output
        df      chisq     pvalue        cfi      rmsea 
   816.000 107309.084      0.000      0.897      0.059 
```

``` r
fitmeasures(fit_cfa_hierarch, c("df", "chisq", "pvalue", "cfi", "rmsea"))
```

``` output
        df      chisq     pvalue        cfi      rmsea 
   816.000 107309.084      0.000      0.897      0.059 
```

``` r
fitmeasures(fit_cfa_bifac, c("df", "chisq", "pvalue", "cfi", "rmsea"))
```

``` output
       df     chisq    pvalue       cfi     rmsea 
  777.000 72120.789     0.000     0.931     0.050 
```

Something about the fit-stats


``` r
anova(fit_cfa_1fac, fit_cfa_3facs, fit_cfa_hierarch, fit_cfa_bifac)
```

``` warning
Warning: lavaan->lavTestLRT():  
   some models have the same degrees of freedom
```

``` output

Chi-Squared Difference Test

                  Df     AIC     BIC  Chisq Chisq diff   RMSEA Df diff
fit_cfa_bifac    777 3679384 3680458  72121                           
fit_cfa_3facs    816 3714494 3715236 107309      35188 0.15556      39
fit_cfa_hierarch 816 3714494 3715236 107309          0 0.00000       0
fit_cfa_1fac     819 3842484 3843200 235305     127996 1.07032       3
                 Pr(>Chisq)    
fit_cfa_bifac                  
fit_cfa_3facs     < 2.2e-16 ***
fit_cfa_hierarch               
fit_cfa_1fac      < 2.2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



::: callout
## Important - CFA vs. EFA
Important note, do not confuse confirmatory with exploratory research!

:::

## A look to SEM
Outlook, SEM? Correlation of anxiety with big 5 estimates?

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

