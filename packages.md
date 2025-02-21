---
title: "Packages in R"
teaching: 10
exercises: 4
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is an R package?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to use R packages
- Explain how to use `library()` and the `::` operator

::::::::::::::::::::::::::::::::::::::::::::::::

## R Packages

It is possible to add functions to R by writing a package, or by obtaining a package written by someone else. As of this writing, there are over 7,000 packages available on CRAN (the comprehensive R archive network). R and RStudio have functionality for managing packages:

* You can see what packages are installed by typing `installed.packages()`
* You can install packages by typing `install.packages("packagename")`, where `packagename` is the package name, in quotes.
* You can update installed packages by typing `update.packages()`
* You can remove a package with `remove.packages("packagename")`
* You can make a package available for use with `library(packagename)`
* You can use a function from a package without loading it entirely using `packagename::functionname()`

### Demonstration


``` r
# Installing a package
install.packages("dplyr")
```

``` output
The following package(s) will be installed:
- dplyr [1.1.4]
These packages will be installed into "~/work/r-for-empra/r-for-empra/renv/profiles/lesson-requirements/renv/library/linux-ubuntu-jammy/R-4.4/x86_64-pc-linux-gnu".

# Installing packages --------------------------------------------------------
- Installing dplyr ...                          OK [linked from cache]
Successfully installed 1 package in 5.7 milliseconds.
```

``` r
# Loading a package
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
# Using a function without loading the entire package
dplyr::glimpse(mtcars)
```

``` output
Rows: 32
Columns: 11
$ mpg  <dbl> 21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19.2, 17.8,…
$ cyl  <dbl> 6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 8,…
$ disp <dbl> 160.0, 160.0, 108.0, 258.0, 360.0, 225.0, 360.0, 146.7, 140.8, 16…
$ hp   <dbl> 110, 110, 93, 110, 175, 105, 245, 62, 95, 123, 123, 180, 180, 180…
$ drat <dbl> 3.90, 3.90, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.92, 3.92,…
$ wt   <dbl> 2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190, 3.150, 3.…
$ qsec <dbl> 16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20.00, 22.90, 18…
$ vs   <dbl> 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,…
$ am   <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,…
$ gear <dbl> 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, 4, 4, 3, 3,…
$ carb <dbl> 4, 4, 1, 1, 2, 1, 4, 2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, 2, 1, 1, 2,…
```

### Why use `::`?
- Using `::` allows access to a specific function without attaching the entire package.
- This can help avoid function name conflicts between different packages.
- It is useful for one-off function calls where loading the full package is unnecessary.

::: challenge
## Challenge 1:

:::

::: keypoints
- R packages are "add-ons" to R, they provide useful new tools.
- Install a package using `install.packages("packagename")`.
- Use a package using `library(packagename)` at the beginning of your script.
- Use `::` to access specific functions from a package without loading it entirely.
:::

