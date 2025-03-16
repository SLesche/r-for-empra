---
title: 'Data Visualization (2)'
teaching: 15
exercises: 5
---

:::::::::::::::::::::::::::::::::::::: questions 

- How can you visualize categorical data?
- How to visualize the relationship of categorical and numerical data?
- 

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Get to know the DASS data from Kaggle
- Explain how to plot distribution of numerical data using `geom_histogram()` and `geom_density()`
- Demonstrate how to group distributions by categorical variables

::::::::::::::::::::::::::::::::::::::::::::::::

## A new set of data

In this section, we will work with a new set of data. Download this data [here](data/kaggle_dass/data.csv) and place it in your `data` folder. There is also a codebook available to download [here](data/kaggle_dass/codebook.txt). 

Some description of the dass data

Let's read in the data first. In my case, it is placed inside a subfolder of `data/` called `kaggle_dass/`. You may need to adjust the path on your end.

``` r
dass_data <- read.csv("data/kaggle_dass/data.csv")
```

As you might already see, this data is quite large. In the *Environment* tab we can see that it contains almost 40.000 entries and 172 variables. For now, we will be working with some of the demographic statistics. We will delve into the actual score in a later episode. You can find information on this data in the codebook provided [here](data/kaggle_dass/codebook.txt). 

Read this codebook in order to familiarize yourself with the data. Then inspect it visually by clicking on the frame or running `View(dass_data)`. What do you notice?

First, let's start getting an overview of the demographics of test-takers. What is their gender, age and education? Compute descriptive statistics for age and inspect gender and education using `table()`


``` r
table(dass_data$gender)
```

``` output

    0     1     2     3 
   67  8789 30367   552 
```

``` r
mean(dass_data$age)
```

``` output
[1] 23.61217
```

``` r
sd(dass_data$age)
```

``` output
[1] 21.58172
```

``` r
range(dass_data$age) # This outputs min() and max() at the same time
```

``` output
[1]   13 1998
```

``` r
table(dass_data$education)
```

``` output

    0     1     2     3     4 
  515  4066 15066 15120  5008 
```
The maximum value of age seems a bit implausible, unless Elrond has decided to take the DASS after Galadriel started flirting with Sauron (sorry, Annatar) again.

## Histograms
We can get an overview of age by using our trust `hist()`:

``` r
hist(dass_data$age)
```

<img src="fig/data-visualization-02-rendered-unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

However, this graph is heavily skewed by the outliers in age. We can address this issue easily by converting to a `ggplot` histogram. The `xlim()` layer can restrict the values that are displayed in the plot and gives us a warning about how many values were discarded.


``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age)
)+
  geom_histogram()+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age)): could not find function "ggplot"
```

Again, the number of bins might be a bit small:

``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age)
)+
  geom_histogram(bins = 100)+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age)): could not find function "ggplot"
```
We can also adjust the size of the bins, not the number of bins by using the `binwidth` argument.


``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age)
)+
  geom_histogram(binwidth = 1)+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age)): could not find function "ggplot"
```
## Density plots
Often, what interests us is not the number of occurrences for a given value, but rather which values are common and which values are uncommon. By dividing the number of occurrences for a given value by the total number of observation, we can obtain a *density-plot*. In `ggplot` you achieve this by using `geom_density()` instead of `geom_histogram()`.


``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age)
)+
  geom_density()+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age)): could not find function "ggplot"
```

This describes the overall age distribution, but we can also look at the age distribution by education status. What would you expect? 

Again, we do this by using the `color` argument in `aes()`, as I want different colored density plots for each education level.

``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age, color = education)
)+
  geom_density()+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age, color = education)): could not find function "ggplot"
```

It seems like this didn't work. And the warning message tells us why. We forgot to specify a `group` variable that tells the plotting function that we not only want different colors, we also want different lines, grouped by education status:


``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age, color = education, group = education)
)+
  geom_density()+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age, color = education, : could not find function "ggplot"
```

Because education is a numerical variable, `ggplot` uses a sliding color scale to color its values. I think it looks a little more beautiful if we declare that despite having numbers as entries, `education` is not strictly numerical. The different numbers represent distinct levels of educational attainment. We can encode this using `factor()` to convert `education` into a variable-type called *factor* that has this property. 


``` r
dass_data$education <- factor(dass_data$education)
ggplot(
  data = dass_data,
  mapping = aes(x = age, color = education, group = education)
)+
  geom_density()+
  xlim(0, 100)
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age, color = education, : could not find function "ggplot"
```

We can make this graph look a little bit better by filling in the area under the curves with the color aswell and making them slightly transparent. This can be done using the `fill` argument and the `alpha` argument. Let's also give the graph a proper title and labels.


``` r
ggplot(
  data = dass_data,
  mapping = aes(x = age, color = education, group = education, fill = education)
)+
  geom_density(alpha = 0.5)+
  xlim(0, 100)+
  labs(
    title = "Age distribution by education status",
    x = "Age",
    y = "Density"
  ) +
  theme_minimal()
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = age, color = education, : could not find function "ggplot"
```

## Bar Charts
As a last step of exploration, let's visualize the number of people that achieved a certain educational status. A bar chart is perfect for this:


``` r
ggplot(
  data = dass_data,
  mapping = aes(x = education)
)+
  geom_bar()
```

``` error
Error in ggplot(data = dass_data, mapping = aes(x = education)): could not find function "ggplot"
```

This visualizes the same numbers as `table(dass_data$education)` and sometimes, you may not need to create a plot if the numbers already tell *you* everything you need to know. However, remember that often you need to communicate your results to other people. And as they say "A picture says more than 1000 words".

Now do by gender, stacked in percentages

something about knowing your data...

## Challenges

What is difference bewteen QNUmberI, A, and E?

Descriptives of the elapse times, what might be outliers?

Plot urban and familysize / married

Plot elapse time and engnat why might differences be?

::::::::::::::::::::::::::::::::::::: keypoints 

-

::::::::::::::::::::::::::::::::::::::::::::::::

