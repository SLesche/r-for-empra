---
title: 'Packages in R'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is an R package?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how to use R packages
- Demonstrate how to include pieces of code, figures, and nested challenge blocks

::::::::::::::::::::::::::::::::::::::::::::::::

## R Packages

It is possible to add functions to R by writing a package, or by
obtaining a package written by someone else. As of this writing, there
are over 7,000 packages available on CRAN (the comprehensive R archive
network). R and RStudio have functionality for managing packages:

* You can see what packages are installed by typing
  `installed.packages()`
* You can install packages by typing `install.packages("packagename")`,
  where `packagename` is the package name, in quotes.
* You can update installed packages by typing `update.packages()`
* You can remove a package with `remove.packages("packagename")`
* You can make a package available for use with `library(packagename)`


::: keypoints
- R packages are "add-ons" to R, they provide useful new tools
- install a package using `install.packages("packagename")`
- use a package using `library(packagename)` at the beginning of you script
:::
