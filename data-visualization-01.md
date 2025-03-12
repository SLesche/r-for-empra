---
title: 'data-visualization-01'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How can you get an overview of data?
- How do you visualize distributions of data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Learn how to read in `.csv` files
- Learn how to explore a dataset for the first time
- Learn how to visualize key statistics of data

::::::::::::::::::::::::::::::::::::::::::::::::

## Reading in data

You already had to read in data in the last lesson. Data comes in many shapes and sizes. The format of data you had to read in the last session is called `csv`, for *comma-separated values*. This is one of the most common data formats. It gets its name because all values are separated from each other using a comma ",". Here in Germany, `csv` files are sometimes separated by a semicolon ";" instead. This can be adjusted in R-code by using `read.csv("path/to/file", sep = ";")` and declaring the semicolon as the separating variable.

::: callout
## Reading data requires specific functions
There are several other common formats including `.xlsx` for excel files, `.sav` for SPSS files, `.txt` for simple text files and `.rdata` for a special R-specific data format. These files can not be read in by `read.csv()`, as this is only for `.csv` files. Instead, use specific functions for each format like `readxl::read_excel()`, or `haven::read_sav()`.
:::

Let's again read in the data about Roy Kent's potty-mouth.


``` r
roy_kent_data <- read.csv("data/roy_kent_f_count.csv")
```

## Getting a glimpse of the data

When starting out with some data you received, it is important to familiarize yourself with the basics of this data first. What columns does it have, what information is contained in each row? What do the columns mean?

One option to get a quick overview of the data is... just looking at it! By clicking on the data in the *Environment* tab or typing `View(roy_kent_data)` in the console, you can inspect the data in R Studio.


::::::::::::::::::::::::::::::::::::: keypoints 

- Use `.md` files for episodes when you want static content
- Use `.Rmd` files for episodes when you need to generate output
- Run `sandpaper::check_lesson()` to identify any issues with your lesson
- Run `sandpaper::build_lesson()` to preview your lesson locally

::::::::::::::::::::::::::::::::::::::::::::::::

