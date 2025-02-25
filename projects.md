---
title: 'Projects'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is an R project? 
- How do projects help me organize my scripts.

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain how projects can provide structure
- Explain what a "working directory" is and how to access files

::::::::::::::::::::::::::::::::::::::::::::::::

## Working Directory
It is very important that you keep your files somewhat orderly. This is important both for us humans to understand, but also for computers. Any time you need to access something outside your present R script, you will need to tell R where to find this. Understanding this is extremely important, as we will be working with external data a lot! This data will be saved somewhere on the computer and needs to find its way into the R session.

Understanding where a file is saved on your computer is key to understanding how to tell R to read it into your current session. There are two main ways to tell R how to find a file: *absolute* paths and *relative* paths. 

### Absolute Paths  

An **absolute path** is the full location of a file on your computer, starting from the root of your file system. It tells R exactly where to find the file, no matter where your R script is located.  

For example, the absolute path to a file stored in the `Documents/` folder most likely looks something like this:
- **Windows:** `"C:/Users/YourName/Documents/my_data.csv"`  
- **Mac/Linux:** `"/Users/YourName/Documents/my_data.csv"`  

::: callout
## 💡 **How to Find the Absolute Path of a File**:  

- On **Windows**, open File Explorer, navigate to your file, right-click it, and select **Properties**. The full file path will be shown in the "Location" field.  

- On **Mac**, open Finder, right-click the file, select **Get Info**, and look at "Where."  
:::

### Relative Paths  

A **relative path** specifies the location of a file in relation to the **working directory** of your R session. This is useful when working with projects that contain multiple files, as it keeps your code flexible and portable.  

The **working directory** is the default folder on your computer where R looks for files and saves new ones. Think of it as R’s **"home base"**—if you ask R to read or save a file without giving a full path, it will assume you’re talking about this location.  

You can check your current working directory by running:  


``` r
getwd()  # This tells you where R is currently looking for files
```

``` output
[1] "/home/runner/work/r-for-empra/r-for-empra/site/built"
```

In our case, this means if you try to read a file like this:  


``` r
read.csv("data.csv")
```

R will look for `data.csv` inside /home/runner/work/r-for-empra/r-for-empra/site/built.


If your files are stored somewhere else, you can change the working directory using:  


``` r
setwd("C:/Users/YourName/Desktop/MyNewFolder")  # Set a new working directory
```

Now, R will assume all file paths start from `"C:/Users/YourName/Desktop/MyNewFolder"`.  

### Why is the Working Directory Important?  
- It **saves you from typing long file paths** every time you load data.  
- It **keeps projects organized** by ensuring all files are in a central location.  
- It **makes your code portable**, so if you share your project, others won’t need to change file paths manually.

## R Projects
There are two main ways to define the working directory that R will use. You can do this using `setwd()` and specify a particular directory you want to start from. Another way to accomplish this is through the use of **R projects**

::: callout
## Why not to use `setwd()`
Here, say why not

:::

For projects, it’s best to keep all your files inside a single folder and set that folder as your working directory. If you use **RStudio**, an easier way to manage this is by using **Projects** (they automatically set the working directory when opened).

### Which One Should You Use?  
- **Use absolute paths** if the file is located outside your project folder or if you need a fixed reference.  
- **Use relative paths** when working within a project, as it makes your code more portable and easier to share with others.  

By understanding how file paths work, you can efficiently load and save data in R without errors! 🚀

## Saving Data

## Challenges
::: challenge
## Challenge 1:


:::

::: challenge
## Challenge 2: 

Some basic computation with this vector
:::

::: challenge
## Challenge 3: 

Where am I?
Save this vector in a subfolder called data
(you may need to create this folder first)
:::

::: challenge
## Challenge 4: Storing data
:::

::: challenge
## Challenge 5: Get a list of available files
Use list.files() to figure something out
:::

::: challenge 
## Challenge 6:
Create a new script for next episode. Save this with an appropriate name

In this script. Load the packages `dplyr` and ggplot
:::


::::::::::::::::::::::::::::::::::::: keypoints 

- 

::::::::::::::::::::::::::::::::::::::::::::::::
