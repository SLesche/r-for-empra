---
title: 'Filtering data'
teaching: 15
exercises: 10
---

:::::::::::::::::::::::::::::::::::::: questions 

- When is my data *tidy*?
- How do you filter invalid data?
- How do you chain commands using the pipe `%>%`? 

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain the concept of *tidy data*
- Explain how to use `filter()`
- Explain how to use the pipe `%>%` to facilitate clean code

::::::::::::::::::::::::::::::::::::::::::::::::

## Filtering
In the earlier episodes, we have already seen some impossible values in `age` and `testelapse`. In our analyses, we probably want to exclude those values, or at the very least investigate, what is wrong. In order to do that, we need to *filter* our data - to make sure it only has those observations that we actually want. The `dplyr` package provides a useful function for this: `filter()`.

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

The `filter` function works on arguments data,...
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

## Challenges

Filter some column, then compute statistics

Filter based on multiple conditions using chaining

Give me a specific dataset with columns and filtered stuff

Save a specific dataset (that we will work with next)
  

::::::::::::::::::::::::::::::::::::: keypoints 


::::::::::::::::::::::::::::::::::::::::::::::::

