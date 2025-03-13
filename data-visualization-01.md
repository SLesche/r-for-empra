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

One option to get a quick overview of the data is... just looking at it! By clicking on the data in the *Environment* tab or typing `View(roy_kent_data)` in the console, you can inspect the data in R Studio. This will already show you how many observations (in this case rows) and variables (columns) the data has. We can also inspect the column names and see the first few entries. Look at the data, what might each column represent?

Now, let's go back to using programming to inspect data. We already learned about the handy function `glimpse()`, for which we need the `dplyr` package.


``` r
library(dplyr)

glimpse(roy_kent_data)
```

``` output
Rows: 34
Columns: 17
$ X                 <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1…
$ Character         <chr> "Roy Kent", "Roy Kent", "Roy Kent", "Roy Kent", "Roy…
$ Episode_order     <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1…
$ Season            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2…
$ Episode           <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, …
$ Season_Episode    <chr> "S1_e1", "S1_e2", "S1_e3", "S1_e4", "S1_e5", "S1_e6"…
$ F_count_RK        <int> 2, 2, 7, 8, 4, 2, 5, 7, 14, 5, 11, 10, 2, 2, 23, 12,…
$ F_count_total     <int> 13, 8, 13, 17, 13, 9, 15, 18, 22, 22, 16, 22, 8, 6, …
$ cum_rk_season     <int> 2, 4, 11, 19, 23, 25, 30, 37, 51, 56, 11, 21, 23, 25…
$ cum_total_season  <int> 13, 21, 34, 51, 64, 73, 88, 106, 128, 150, 16, 38, 4…
$ cum_rk_overall    <int> 2, 4, 11, 19, 23, 25, 30, 37, 51, 56, 67, 77, 79, 81…
$ cum_total_overall <int> 13, 21, 34, 51, 64, 73, 88, 106, 128, 150, 166, 188,…
$ F_score           <dbl> 0.1538462, 0.2500000, 0.5384615, 0.4705882, 0.307692…
$ F_perc            <dbl> 15.4, 25.0, 53.8, 47.1, 30.8, 22.2, 33.3, 38.9, 63.6…
$ Dating_flag       <chr> "No", "No", "No", "No", "No", "No", "No", "Yes", "Ye…
$ Coaching_flag     <chr> "No", "No", "No", "No", "No", "No", "No", "No", "No"…
$ Imdb_rating       <dbl> 7.8, 8.1, 8.5, 8.2, 8.9, 8.5, 9.0, 8.7, 8.6, 9.1, 7.…
```

This will tell us the variable type of each column, too. We can see that the first column `X` is of type *int*, and thus a numeric column. The second column is a character column which just contains the name of the hero of this data *Roy Kent*.

::: callout
write about X
:::

write about the background of the show (pics)

Write about the data and its origin (tidytuesday)

visualize the distribution of FCK

delve into data, visualize the amount of FCK by episode (line)

get descriptives of the other columns

visualize the relationship between FCK and Imdb_rating

make a plot of this, color by dating. And then save it

Challenges:

Make plot of IMbd and total fck by roy coaching, what do you notice

Some more descriptives

save the plot



::::::::::::::::::::::::::::::::::::: keypoints 

- Use `.md` files for episodes when you want static content
- Use `.Rmd` files for episodes when you need to generate output
- Run `sandpaper::check_lesson()` to identify any issues with your lesson
- Run `sandpaper::build_lesson()` to preview your lesson locally

::::::::::::::::::::::::::::::::::::::::::::::::

