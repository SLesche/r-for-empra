---
title: "Packages in R"
teaching: 10
exercises: 4
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is an R package?
- How can we use R packages

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to use R packages
- Explain how to install R packages
- Understand the difference between installing and loading an R package

::::::::::::::::::::::::::::::::::::::::::::::::

## R Packages

Per default, R provides you with some basic functions like `sum()`, `mean()` or `t.test()`. These functions can already accomplish a lot, but for more specialized analyses or more user-friendly functions, you might want to use additional functions.

If you are in need of a specific function to achieve your goal, you can either write it yourself (more on this later) or use functions written by other users. These functions are often collected in so-called "packages". The official source for these packages on R is CRAN (the comprehensive R archive network).

::: callout
## Packages you may encounter
Packages make R really powerful. For 95% of your analysis-needs, there probably exists a package designed specifically to hand this. For example, some packages you might use often are `tidyverse` for data cleaning, `psych` for some psychology specific functions, `afex` for ANOVAs or `lme4` for multi-level models. You can even use R packages for more complicated analyses like structural equation models (`lavaan`) or bayesian modeling (`brms`). You can even write papers using R using `papaya`. Even this website was written using the R-packages `rmarkdown` and `sandpaper`.
:::

CRAN makes it really easy to use the over 7000 R packages other users provide. You can install them using `install.packages("packagename")` with the name of the package in quotation marks. This installs all functionalities of this packages on your machine. However, this package is not automatically available to you. Before using it in a script (or the console) you need to tell R to "activate" this package. You can do this using `library(packagename)`. This avoids loading all installed packages every time R is starting (which would take a while).

::: callout
## Using functions without loading a package
If you are only using a few functions from a certain package (maybe even only once), you can avoid loading the entire package and only specifically access that function using the `::` operator. You can do this by typing `packagename::function()`. If the package is installed, it will allow you to use that function without calling `library(packagename)` first. This may also be useful in cases where you want to allow the reader of your code to easily understand what package you used for a certain function.
:::

### Demonstration
First, we need to install a package. This will often generate a lot of text in your console. This is nothing to worry about. In most cases, it is enough to look at the last few messages, they will tell you what went wrong or whether everything went right.

``` r
install.packages("dplyr")
```

``` output
The following package(s) will be installed:
- dplyr [1.1.4]
These packages will be installed into "~/work/r-for-empra/r-for-empra/renv/profiles/lesson-requirements/renv/library/linux-ubuntu-jammy/R-4.4/x86_64-pc-linux-gnu".

# Installing packages --------------------------------------------------------
- Installing dplyr ...                          OK [linked from cache]
Successfully installed 1 package in 6.5 milliseconds.
```

Then, we will need to load the package to make its functions available for use. For most packages, this will also print a lot of messages in the console in the bottom left. Again, this is usually harmless. If something does go wrong, you will see the word `Error:` along with a message somewhere. `Warnings:` can often be ignored in package installation. 


``` r
# Loading the package dplyr
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

Now we can use all the functions that `dplyr` provides. Let's start by using `glimpse()` to get a quick glance at some data. For this case, we are using the `iris` data, that comes with your default R installation.


``` r
# iris is a dataset provided as default in R
glimpse(iris)
```

``` output
Rows: 150
Columns: 5
$ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9, 5.4, 4.…
$ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3.…
$ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5, 1.5, 1.…
$ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.…
$ Species      <fct> setosa, setosa, setosa, setosa, setosa, setosa, setosa, s…
```

``` r
# Using a function without loading the entire package
# dplyr::glimpse(iris)
```

Here, we can see that `iris` has 150 rows (or observations) and 5 columns (or variables). The first four variables are size measurements regarding length and width of sepal and petal and the fifth variable is a variable containing the species of flower.

## Challenges

::: challenge
## Challenge 1:

Install the following packages: `dplyr`, `ggplot2`, and `psych`.
:::

::: challenge
## Challenge 2:

Load the package `dplyr` and get an overview of the data `mtcars` using `glimpse()`. 
:::

::: challenge
## Challenge 3:

Figure out what kind of data `mtcars` contains. Make a list of the columns in the dataset and what they might mean.

:::: callout
## Hint
You are allowed to use Google (or other sources) for this. It is common practice to google information you don't know or look online for code that might help.
::::
:::

::: challenge
## Challenge 4:
Use the function `describe()` from the package `psych` *without* loading it first.

What differences do you notice between `glimpse()` and `describe()`?
:::

::: keypoints
- R packages are "add-ons" to R, they provide useful new tools.
- Install a package using `install.packages("packagename")`.
- Use a package using `library(packagename)` at the beginning of your script.
- Use `::` to access specific functions from a package without loading it entirely.
:::

