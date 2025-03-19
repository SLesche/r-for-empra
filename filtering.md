---
title: 'Filtering data'
teaching: 15
exercises: 10
---

:::::::::::::::::::::::::::::::::::::: questions 

- How do you filter invalid data?
- How do you chain commands using the pipe `%>%`? 
- How can I select only some columns of my data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to filter rows using `filter()`
- Demonstrate how to select columns using `select()`
- Explain how to use the pipe `%>%` to facilitate clean code

::::::::::::::::::::::::::::::::::::::::::::::::

## Filtering
In the earlier episodes, we have already seen some impossible values in `age` and `testelapse`. In our analyses, we probably want to exclude those values, or at the very least investigate what is wrong. In order to do that, we need to *filter* our data - to make sure it only has those observations that we actually want. The `dplyr` package provides a useful function for this: `filter()`.

Let's start by again loading in our data, and also loading the package `dplyr`.


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

The `filter` function works with two key inputs, the data and the arguments that you want to filter by. The data is always the first argument in the filter function. The following arguments are the filter conditions. 
For example, in order to only include people that are 20 years old, we can run the following code:

``` r
twenty_year_olds <- filter(dass_data, age == 20)
# Lets make sure this worked
table(twenty_year_olds$age)
```

``` output

  20 
3789 
```

``` r
# range(twenty_year_olds$age) # OR THIS
# unique(twenty_year_olds$age) # OR THIS
# OR other things that come to mind can check this
```
Now, in order to only include participants aged between 0 and 100, which seems like a reasonable range, we can condition on `age >= 0 & age <= 100`.


``` r
valid_age_dass <- filter(dass_data, age >= 0 & age <= 100)
```

Let's check if this worked using a histogram.

``` r
hist(valid_age_dass$age, breaks = 50)
```

<img src="fig/filtering-rendered-unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

Looks good! Now it is always a good idea to inspect the values you removed from the data, in order to make sure that you did not remove something you intended to keep, and to learn something about the data you removed.

Let's first check how many rows of data we actually removed:

``` r
n_rows_original <- nrow(dass_data)

n_rows_valid_age <- nrow(valid_age_dass)

n_rows_removed <- n_rows_original - n_rows_valid_age

n_rows_removed
```

``` output
[1] 7
```

This seems okay! Only 7 removed cases out of almost 40000 entries is negligible. Nonentheless, let's investigate this further.


``` r
impossible_age_data <- filter(dass_data, age < 0 | age > 100)
```

Now we have a dataset that c




filter out the age thing. Notice the nmumber of rows. Talk about doing sanity checks to see if you actually filtered what you want

Now we can also filter to include. Lets do that and see what happend in the age columns

## Selecting columns
 
We dont want to inspect the whole thing, but just the columns that interest us

Let's use select to typr them

then inspect the age with some key demographics

::: callout
## Selecting a column twice
What happpens when you type column twice? Using everything() to relocate columns
:::

## Using the pipe `%>%` 
notice what we did before, what could make this easier?

Introduc3e the pipe, then use it with a plotting function (age dist, but now wihtout xlim())

- also something about functions and naming arguments (or not naming them)

::: callout
## Different pipes %>% vs. |>
- a word about base-r pipe |>

:::

## Common problems


## Challenges

Filter some column, then compute statistics

Filter based on multiple conditions using chaining

Give me a specific dataset with columns and filtered stuff

Save a specific dataset (that we will work with next)
  

::::::::::::::::::::::::::::::::::::: keypoints 


::::::::::::::::::::::::::::::::::::::::::::::::

