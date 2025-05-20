---
title: 't-Test'
teaching: 10
exercises: 3
---

:::::::::::::::::::::::::::::::::::::: questions 

- When can I use a t-test?
- What type of t-test should I use?
- How can I run a t-test in R?
- How should I interpret the results of a t-test

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain the assumptions behind a t-test.
- Demonstrate how to check the assumptions of a t-test.
- Show when to use a paired t-test, an independent samples t-test or a one-sample t-test.
- Learn practical applications of the t-test in R.
- Explain key issues in t-test interpretation.

::::::::::::::::::::::::::::::::::::::::::::::::

## Inferential statistics
So far, we have not "tested" anything. We have only described values and visualized distributions. We have stayed in the cozy realm of *descriptive statistics*. With descriptive statistics, we can describe data, we can look at a graph and say "this bar is higher than the other one". Importantly, these conclusions are only truly valid for the present data! Meaning that we cannot generalize our results into other data, other samples, and more generally *the population*. Today, we will venture out into the different, scary world of *inferential statistics* that aims to address this problem.

Importantly, generalizing the results to a population is most often the goal of (psychological) research. Whatever a current sample does is irrelevant, we want to know whether the effect, the correlation, or the factor structure is present for the whole population from which we randomly selected some participants for our study.

This can be addressed by inferential (frequentist) statistics, asking the key question: "is this finding *significant*?". Or, is my finding of an effect in a sample likely to be the result from a true effect in a population (significant) or just due to random sampling error. 

Inferential statistics encompasses a large number of methods: t-tests, ANOVAs, linear regression only to name a few. For now, we will start out with the t-test which is useful when investigating mean values:
Is the mean value of one group significantly higher than another group? Is my mean value significantly different from 0? This allows us to go beyond 

Somehting about I will not go into details of statistical tests (recommendation).

Just broadly, we assume some distribution of the key statistic of interest (the test statistic) in the population given a null hypothesis (mean is 0, means are identical). This test statistic is...
Then, we check our empirical test statistic. We can place this into the distribution to see how likely we are to observe this, given our assumptions in the test. In psychology we say that if it is less than 5% likely, we reject our assumptions of a null hypothesis. 

This is true for all frequentists tests, they make some assumptions of a null hypothesis and the p-value indicates how likely we are to observe our current data given this null hypothesis. If we are less than 5% likely, we say that the null hypothesis is not true and reject it.


For example, something with mean value in dass data. Show some group differences based on education. 
Then illustrate the basic logic of the t-test. 

show the basic t-test formula in r

then discuss assumptions of the t-test-
- independence, random sampling, (approx) normal dist, variance
- talk about robustness

show how to check the assumptions of the t-test. When is that an issue, when not?

There are different types of t-tests. Show what each of them are and show example uses in the dass data (maybe with half-splits in DASS?, check against two groups and criterium).

Now show how to interpret the t-test. Show and discuss the summary output. Explain how to report it in text and go over effect sizes!!

Show how to compute cohens d and why this is important. 

Give personal recommendations. Focus on effect sizes, report p-values. Same when reading some paper. p-value is necessary, but it is mainly a function of sample size. So take with caution.
Say something about no evidence for null. Something with BAYES

Now what if multiple groups? Outlook for next time: ANOVA




::: challenge 

## Challenge 1

Read in data and compute mean

:::

::: challenge 

## Challenge 2

Check the assumptions of a t tesrt

:::

::: challenge 

## Challenge 3

compute several t-tests, one-sample and independent samples

:::

::: challenge 

## Challenge 4

compute t.test with different vectors and t-test using formula

:::

::: challenge 

## Challenge 5

write a report of a t-test with effect size aswell.

:::

::::::::::::::::::::::::::::::::::::: keypoints 

- Something

::::::::::::::::::::::::::::::::::::::::::::::::

