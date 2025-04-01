---
title: 'Midterms'
teaching: 4
exercises: 20
---

:::::::::::::::::::::::::::::::::::::: questions 

- No new questions today, only application

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Apply learnings from previous episodes to new data
- Get to know data by visual inspection, data visualization and descriptive statistics
- Filter data to include only valid values
- Compute new columns
- Compute summary statistics

::::::::::::::::::::::::::::::::::::::::::::::::

## A new dataset approaches
Welcome to the "Midterms"! Today, we there will be no new lessons or functions that you have to understand. This episode is all about applying the things you already learnt to new data. We will use data collected by a previous Empra, who were investigating the impact of color on intelligence test performance. 

Here, they tried to replicate an effect published by Elliot et al. (2007) concerning "the effect of red on performance attainment". The original study showed that the presentation of the color red, for example by showing the participant a number in red, lowers the performance on a subsequent intelligence test. The tried to replicate this study online, by coloring the whole intelligence test red.

![Intelligence Test (HeiQ) Item with red background](fig/red_heiq.png){alt='Picture of intelligence test item in red'}

The performance of participants completing the test with red background could then be compared to participants with a green background and those with a grey/black background. 

Additionally, a bachelor thesis integrated into the same project collected data on physical activity.

## Your task

In this episode, there will only be challenges that contain the key functions introduced in earlier episodes. 
The challenges will guide you through the process of getting to know the data and applying your knowledge to new data. 
I will not provide solutions to this challenge in the current file, as you are encouraged to try solving this for yourself. As such, you may also use different methods than I, which lead to the same outcome or allow similar conclusions. If you get stuck, ask ChatGPT or a friend, or sleep on it! That often helped me.

Each challenge will include a short hint to the episode that contains information on how to solve it.

Try to write a "clean" script, using proper variable names and comments to describe what you are doing. 

## Challenges

::: challenge
## Challenge 1 (*Vectors and variable types*)

Create a script called *midterms_firstname_lastname.R* in the current project. Load the packages `dplyr`, `ggplot2` and `psych`. Install any packages that you have not yet installed.

:::

::: challenge
## Challenge 2 (*Projects*)

Download the data [here](data/empra_color_intelligence_clean.csv) and store it in your `raw_data/` folder. Then load it into the current session using an appropriate function.
:::

::: challenge
## Challenge 3 (*Data Visualization (1)*)

Get to know the data. What are the column names? What type of information does each column store? Inspect the data visually and get the column names using an R function. Which columns are relevant for intelligence test performance? Which columns are related to physical activity?

:::


::: challenge
## Challenge 4 (*Data Visualization (1)* / *Filtering data*)

Get an overview of descriptive statistics of the whole dataset. Inspect the mean, minimum and maximum values in the columns you think are relevant. What do you notice? Use `select()` to create a smaller dataset that only includes the items you think are relevant to make the overview simpler.

:::


::: challenge
## Challenge 5 (*Filtering data*)

The column *item_kont* includes information about the response to a control item. This item is so easy, that everyone should answer it correctly, given that they payed attention. If the value in item_kont is 1, the answer is correct. Otherwise it is incorrect. 

Exclude all participants who did not answer correctly to the control item. Conduct sanity checks. How many participants were excluded? Did those participants have answers to the other questions?

:::

::: challenge
## Challenge 6 (*Creating new columns*)

Create new columns for each of the items that are named `itemNUMBER_accuracy`. Each entry should be 1 if the participant answered that item correctly and 0 if they did not. 

If possible, use `mutate()` and `across()` for this. Otherwise, simply use 12 lines of `mutate()`. Make sure to conduct sanity checks whether this worked.
:::

::: challenge
## Challenge 7 (*Creating new columns*)

Create a column containing the total score of a participant. This should be the number of items they responded to correctly.

:::


::: challenge
## Challenge 8 (*Data Visualization (2)*)

Compute key summary statistics of the total score of participants. Inspect the distribution of values using `hist()`. What do you notice? Are the minimum / maximum values plausible?

:::

::: challenge
## Challenge 9 (*Filtering data*)

Each item had 9 possible answers. Exclude participants who achieved a score that was below random chance.

Additionally, the columns beginning with *dq_* include information about *disqualification_criteria*. Exclude participants based on the following criteria:

- dq_meaningless_responses = 3
- dq_distraction = 3

:::


::: challenge
## Challenge 10 (*Count and summarize*)

Count the number of occurrences of each of the three conditions in `fragebogen_der_im_interview_verwendet_wurde`.
:::


::: challenge
## Challenge 11 (*Count and summarize*)

Compute the average score by condition. Include the number of participants by condition and the standard deviation, too.

:::


::: challenge
## Challenge 12 - New!

Create a visualization showing the scores by condition. Here apply some of the knowledge from *Data visualization (2)* and add Google or ChatGPT to create a plot showing the condition differences (or lack thereof) in intelligence test scores.

:::

::::::::::::::::::::::::::::::::::::: keypoints 

- Apply what you have learned in new data!

::::::::::::::::::::::::::::::::::::::::::::::::

