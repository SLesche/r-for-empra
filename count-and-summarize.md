---
title: 'Count and Summarize'
teaching: 15
exercises: 10
---

:::::::::::::::::::::::::::::::::::::: questions 
- How does `count()` help in counting categorical data?  
- How do you compute summary statistics?
- How can you use `group_by()` to compute summary statistics for specific subgroups?  
- Why is it useful to combine `count()` with `filter()`?  
- How can you compute relative frequencies using `group_by()` and `mutate()`?  

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives
- Understand how to use `count()` to summarize categorical variables.  
- Learn to compute summary statistics using `summarize()`.  
- Explore how `group_by()` allows for subgroup analyses.  
- Use `filter()` to refine data before counting or summarizing.  
- Compute and interpret relative frequencies using `mutate()`.
::::::::::::::::::::::::::::::::::::::::::::::::

## Computing Summaries 

This lesson will teach you some of the last (and most important) functions used in the process of data exploration and data analysis. Today we will learn how to quickly count the number of appearances for a given value using `count()` and how to compute custom summary statistics using `summarize()`.

Taken together, these functions will let you quickly compute frequencies and average values in your data, the last step in descriptive analysis and sometimes a necessary prerequisite for inference methods. The ANOVA, for example, most often requires one value per participant per condition, often requiring you to average over multiple trials.


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
```

## Counting data
Let's start with the more simple function of the two, `count()`. This function works with the `tidyverse` framework and can thus easily be used with pipes. Simply pipe in your dataset and give the name of the column you want to receive a count for:


``` r
dass_data %>% 
  count(education)
```

``` output
  education     n
1         0   515
2         1  4066
3         2 15066
4         3 15120
5         4  5008
```

The count will always be in a column called `n`, including the number of occurrences for any given value (or combination of values) to the left of it.

Notably, you can also include multiple columns to get a count for each combination of values.


``` r
dass_data %>% 
  count(hand, voted)
```

``` output
   hand voted     n
1     0     0     4
2     0     1    51
3     0     2   118
4     1     0   284
5     1     1  9693
6     1     2 24765
7     2     0    36
8     2     1  1121
9     2     2  3014
10    3     0     3
11    3     1   183
12    3     2   503
```

::: callout
## Tip: Using comparisons in `count()`
You are not limited to comparing columns. You can also directly include comparisons in the `count()` function.
For example, we can count the education status and number of people who concluded the DASS-questionnaire in under 10 minutes.


``` r
dass_data %>% 
  count(testelapse < 600, education)
```

``` output
   testelapse < 600 education     n
1             FALSE         0    33
2             FALSE         1   220
3             FALSE         2  1025
4             FALSE         3   922
5             FALSE         4   333
6              TRUE         0   482
7              TRUE         1  3846
8              TRUE         2 14041
9              TRUE         3 14198
10             TRUE         4  4675
```

If you want to receive counts only for a specific part of the data, like in our case people faster than 10 minutes, it may be more clear to `filter()` first.


``` r
dass_data %>% 
  filter(testelapse < 600) %>% 
  count(education)
```

``` output
  education     n
1         0   482
2         1  3846
3         2 14041
4         3 14198
5         4  4675
```

:::

## Summarize
`summarize()` is one of the most powerful functions in `dplyr`. Let's use it to compute average scores for the DASS-questionnaire.

First, compute columns with the sum DASS score and mean DASS score for each participant again. You should have code for this in the script from last episode. Go have a look and copy the correct code here. Copying from yourself is highly encouraged in coding! It's very likely that you have spent some time solving a problem already, why not make use of that work.

::: callout
## Hint: Copy your own code
If you can't find it or want to use the exact same specification as me, here is a solution.

:::: solution

``` r
dass_data <- dass_data %>% 
  mutate(
    sum_dass_score = rowSums(across(starts_with("Q") & ends_with("A"))),
    mean_dass_score = rowMeans(across(starts_with("Q") & ends_with("A")))
  )
```
::::

:::

`summarize()` works similar to `mutate()` in that you have to specify a new name and a formula to receive your result.
To get the average score of the DASS over all participants, we use the `mean()` function.


``` r
dass_data %>% 
  summarize(
    mean_sum_dass = mean(sum_dass_score)
  )
```

``` output
  mean_sum_dass
1      100.2687
```
We can also compute multiple means over both the column containing the sum of DASS scores and the mean DASS score.

``` r
dass_data %>% 
  summarize(
    mean_sum_dass = mean(sum_dass_score),
    mean_mean_dass = mean(mean_dass_score)
  )
```

``` output
  mean_sum_dass mean_mean_dass
1      100.2687       2.387351
```

In addition, we can compute other values using any functions we feel are useful. For example, `n()` gives us the number of values, which can be useful when comparing averages for multiple groups.


``` r
dass_data %>% 
  summarize(
    mean_sum_dass = mean(sum_dass_score),
    mean_mean_dass = mean(mean_dass_score),
    n_subjecs = n(),
    max_total_dass_score = max(sum_dass_score),
    quantile_5_mean_dass = quantile(mean_dass_score, 0.05),
    quantile_95_mean_dass = quantile(mean_dass_score, 0.95)
  )
```

``` output
  mean_sum_dass mean_mean_dass n_subjecs max_total_dass_score
1      100.2687       2.387351     39775                  168
  quantile_5_mean_dass quantile_95_mean_dass
1             1.261905              3.595238
```

## Groups
So far, we could have done all of the above using basic R functions like `mean()` or `nrow()`. One of the benefits of `summarize()` is that it can be used in pipelines, so you could have easily applied filters before summarizing. However, the most important benefit is the ability to group the summary by other columns in the data. In order to do this, you need to call `group_by()`. 

This creates a special type of data format, called a *grouped data frame*. R remembers assigns each row of the data a group based on the values provided in the `group_by()` function. If you then use `summarize()`, R will compute the summary functions for each group separately.


``` r
dass_data %>% 
  group_by(education) %>% 
  summarize(
    mean_mean_dass_score = mean(mean_dass_score),
    n_subjects = n()
  )
```

``` output
# A tibble: 5 × 3
  education mean_mean_dass_score n_subjects
      <int>                <dbl>      <int>
1         0                 2.38        515
2         1                 2.64       4066
3         2                 2.47      15066
4         3                 2.31      15120
5         4                 2.18       5008
```
Now we are able to start learning interesting things about our data. For example, it seems like the average DASS score declines with higher levels of education (excluding the "missing" education = 0).

You can group by as many columns as you like. Summary statistics will then be computed for each combination of the columns:

``` r
dass_data %>% 
  group_by(education, urban) %>% 
  summarize(
    mean_mean_dass_score = mean(mean_dass_score),
    n_subjects = n()
  )
```

``` output
`summarise()` has grouped output by 'education'. You can override using the
`.groups` argument.
```

``` output
# A tibble: 20 × 4
# Groups:   education [5]
   education urban mean_mean_dass_score n_subjects
       <int> <int>                <dbl>      <int>
 1         0     0                 2.31         19
 2         0     1                 2.48        126
 3         0     2                 2.35        141
 4         0     3                 2.35        229
 5         1     0                 2.66         49
 6         1     1                 2.69        626
 7         1     2                 2.59       1578
 8         1     3                 2.66       1813
 9         2     0                 2.62        156
10         2     1                 2.46       3110
11         2     2                 2.43       4720
12         2     3                 2.50       7080
13         3     0                 2.29        118
14         3     1                 2.31       3351
15         3     2                 2.28       5162
16         3     3                 2.33       6489
17         4     0                 2.18         40
18         4     1                 2.19       1105
19         4     2                 2.14       1631
20         4     3                 2.20       2232
```

Similar to `count()` you can also include comparisons in `group_by()`

``` r
dass_data %>% 
  group_by(testelapse < 600) %>% 
  summarize(
    mean_mean_dass_score = mean(mean_dass_score),
    n_subjects = n()
  )
```

``` output
# A tibble: 2 × 3
  `testelapse < 600` mean_mean_dass_score n_subjects
  <lgl>                             <dbl>      <int>
1 FALSE                              2.33       2533
2 TRUE                               2.39      37242
```

::: callout
## Warning: Remember to `ungroup()`

R remembers the `group_by()` function as long as you don't use `ungroup()` or `summarize()`. This may have unwanted side-effects. Make sure that each `group_by()` is followed by an `ungroup()`.


``` r
dass_data %>% 
  group_by(education) %>% 
  mutate(
    within_education_id = row_number()
  ) %>% 
  ungroup()
```

``` output
# A tibble: 39,775 × 175
     Q1A   Q1I   Q1E   Q2A   Q2I   Q2E   Q3A   Q3I   Q3E   Q4A   Q4I   Q4E   Q5A
   <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
 1     4    28  3890     4    25  2122     2    16  1944     4     8  2044     4
 2     4     2  8118     1    36  2890     2    35  4777     3    28  3090     4
 3     3     7  5784     1    33  4373     4    41  3242     1    13  6470     4
 4     2    23  5081     3    11  6837     2    37  5521     1    27  4556     3
 5     2    36  3215     2    13  7731     3     5  4156     4    10  2802     4
 6     1    18  6116     1    28  3193     2     2 12542     1     8  6150     3
 7     1    20  4325     1    34  4009     2    38  3604     3    40  4826     4
 8     1    34  4796     1     9  2618     1    39  5823     1    12  6596     3
 9     4     4  3470     4    14  2139     3     1 11043     4    20  1829     3
10     3    38  5187     2    28  2600     4     9  2015     1     7  3111     4
# ℹ 39,765 more rows
# ℹ 162 more variables: Q5I <int>, Q5E <int>, Q6A <int>, Q6I <int>, Q6E <int>,
#   Q7A <int>, Q7I <int>, Q7E <int>, Q8A <int>, Q8I <int>, Q8E <int>,
#   Q9A <int>, Q9I <int>, Q9E <int>, Q10A <int>, Q10I <int>, Q10E <int>,
#   Q11A <int>, Q11I <int>, Q11E <int>, Q12A <int>, Q12I <int>, Q12E <int>,
#   Q13A <int>, Q13I <int>, Q13E <int>, Q14A <int>, Q14I <int>, Q14E <int>,
#   Q15A <int>, Q15I <int>, Q15E <int>, Q16A <int>, Q16I <int>, Q16E <int>, …
```

:::

## `count()` + `group_by()`
You can also make use of `group_by()` to compute relative frequencies in count-tables easily. For example,
counting the education status by handedness is not informative. 


``` r
dass_data %>% 
  filter(hand %in% c(1, 2)) %>% # Focus on right vs. left
  count(hand, education)
```

``` output
   hand education     n
1     1         0   434
2     1         1  3481
3     1         2 13102
4     1         3 13326
5     1         4  4399
6     2         0    57
7     2         1   412
8     2         2  1623
9     2         3  1561
10    2         4   518
```
This just tells us that there are more right-handed people. However, the percentage of education by handedness would be much more interesting. To that end, we can group by handedness and compute the percentage easily. 


``` r
dass_data %>% 
  filter(hand %in% c(1, 2)) %>% # Focus on right vs. left
  count(hand, education) %>% 
  group_by(hand) %>% 
  mutate(percentage = n / sum(n)) %>% 
  mutate(percentage = round(percentage*100, 2)) %>% 
  ungroup()
```

``` output
# A tibble: 10 × 4
    hand education     n percentage
   <int>     <int> <int>      <dbl>
 1     1         0   434       1.25
 2     1         1  3481      10.0 
 3     1         2 13102      37.7 
 4     1         3 13326      38.4 
 5     1         4  4399      12.7 
 6     2         0    57       1.37
 7     2         1   412       9.88
 8     2         2  1623      38.9 
 9     2         3  1561      37.4 
10     2         4   518      12.4 
```

As you can see, `group_by()` also works in combination with `mutate()`. This means that calling `sum(n)` computes the total of `n` for the given group. Which is why `n / sum(n)` yields the relative frequency.

## Challenges

::: challenge
## Challenge 1

How many of the subjects voted in a national election last year? Use `count()` to receive an overview.

:::

::: challenge
## Challenge 2

Get an overview of the number of people that voted based on whether their age is greater than 30. Make sure you only include subjects that are older than 18 in this count.

:::

::: challenge
## Challenge 3

Get a summary of the mean score on the DASS by whether somebody voted in a national election in past year.
What do you notice? Why might this be the case? There are no right or wrong answers here, just think of some reasons.

:::

::: challenge
## Challenge 4

Get a summary of the mean DASS score based on age groups. Use `mutate()` and `case_when()` to define a new `age_group` column with the following cutoffs.

- < 18 = "underage"
- 18 - 25 = "youth"
- 26 - 35 = "adult"
- 36 - 50 = "middle-age"
- 50+ = "old"

:::: solution


``` r
dass_data %>% 
  mutate(
    age_group = case_when(
      age < 18 ~ "underage",
      age >= 18 & age <= 25 ~ "youth",
      age >= 26 & age <= 35 ~ "adult",
      age >= 36 & age <= 50 ~ "middle-age",
      age > 50 ~ "old"
    )
  ) %>% 
  group_by(age_group) %>% 
  summarize(
    mean_score = mean(mean_dass_score),
    n_entries = n()
  )
```

``` output
# A tibble: 5 × 3
  age_group  mean_score n_entries
  <chr>           <dbl>     <int>
1 adult            2.23      6229
2 middle-age       2.10      2288
3 old              1.97       950
4 underage         2.64      7269
5 youth            2.40     23039
```
::::
:::

::: challenge
## Challenge 5

Compute the relative frequency of whether somebody voted or not based on their age group (defined above). Make sure you compute the percentage of people that voted given their age, not the percentage of age given their voting status. 

:::

::: challenge
## Challenge 6

Sort the above output by the relative frequency of people that voted. Use the `arrange()` function after counting and computing the percentage. Use the help `?arrange`, Google or ChatGPT to figure out how to use this function.

:::: solution

``` r
dass_data %>% 
  filter(voted > 0) %>% # Don't include missing values of voted = 0
  mutate(
    age_group = case_when(
      age < 18 ~ "underage",
      age >= 18 & age <= 25 ~ "youth",
      age >= 26 & age <= 35 ~ "adult",
      age >= 36 & age <= 50 ~ "middle-age",
      age > 50 ~ "old"
    )
  ) %>% 
  count(age_group, voted) %>% 
  group_by(age_group) %>% 
  mutate(
    percentage = round(n / sum(n) * 100, 2)
  ) %>% 
  arrange(desc(percentage))
```

``` output
# A tibble: 10 × 4
# Groups:   age_group [5]
   age_group  voted     n percentage
   <chr>      <int> <int>      <dbl>
 1 underage       2  7125      98.9 
 2 youth          2 17534      76.7 
 3 old            1   573      61.8 
 4 adult          1  3710      60.0 
 5 middle-age     1  1346      59.4 
 6 middle-age     2   919      40.6 
 7 adult          2  2468      40.0 
 8 old            2   354      38.2 
 9 youth          1  5337      23.3 
10 underage       1    82       1.14
```

::::

What can you learn by the output? 

:::

::::::::::::::::::::::::::::::::::::: keypoints 

- Use `count()` to compute the number of occurrences for (combinations) of columns
- Use `summarize()` to compute any summary statistics for your data
- Use `group_by()` to group your data so you can receive summaries for each group separately
- Combine functions like `filter()`, `group_by()` and `summarize()` using the pipe to receive specific results

::::::::::::::::::::::::::::::::::::::::::::::::

