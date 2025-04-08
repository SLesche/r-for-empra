---
title: 'Projects'
teaching: 10
exercises: 5
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
Last week we worked with scripts and some basic computations using vectors. 
Most likely, you wrote down a lot of code and saved the script somewhere on your computer.
Once you start working with multiple scripts and datasets, it becomes very important that you keep your files somewhat orderly. 

This is important both for us humans to understand, but also for computers. Any time you need to access something outside your present R script, you will need to tell R where to find this. The data will be saved somewhere on the computer and needs to find its way into the R session.

Understanding where a file is saved on your computer is key to understanding how to tell R to read it into your current session. There are two main ways to tell R how to find a file: *absolute* paths and *relative* paths. 

### Absolute Paths  

An **absolute path** is the full location of a file on your computer, starting from the root of your file system. It tells R exactly where to find the file, no matter where your R script is located. Think of it like an address in a town. *1404 Mansfield St, Chippewa Falls, WI 54729* tells you exactly where a house is located. 

For example, the absolute path to a file stored in the `Documents/` folder most likely looks something like this:

- **Windows:** `"C:/Users/YourName/Documents/my_data.csv"`  
- **Mac/Linux:** `"/Users/YourName/Documents/my_data.csv"`  

::: callout
## How to Find the Absolute Path of a File:  

- On **Windows**, open File Explorer, navigate to your file, right-click it, and select **Properties**. The full file path will be shown in the "Location" field.  

- On **Mac**, open Finder, right-click the file, select **Get Info**, and look at "Where."  
:::

### Relative Paths  

A **relative path** specifies the location of a file in relation to the **working directory** of your R session. This is useful when working with projects that contain multiple files, as it keeps your code flexible and portable. Think of this like the direction, "just follow the road until the roundabout and then take the second exit". If the starting point is well defined, this is enough information to find the target.

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

There are two main ways to define the working directory that R will use. You can do this using `setwd()` and specify a particular directory you want to start from. Another way to accomplish this is through the use of **R projects**. These projects automatically set your working directory to the place that the project is located. More about projects in just a second.

If you prefer declaring your working directory using `setwd()`, you can place this bit of code `setwd(dirname(rstudioapi::getActiveDocumentContext()$path))` at the beginning of your script. R will then set the working directory to the folder that the script you are working with is located in. 

### Why is the Working Directory Important?  
- It **saves you from typing long file paths** every time you load data.  
- It **keeps projects organized** by ensuring all files are in a central location.  
- It **makes your code portable**, so if you share your project, others won’t need to change file paths manually.

## R Projects
I do not recommend using `setwd()`. Instead, I would suggest using R projects. When working in **RStudio**, using **R Projects** is one of the best ways to keep your work organized, portable, and efficient. An **R Project** is essentially a self-contained workspace that helps manage files, working directories, and settings automatically.

There are several reasons why I prefer R projects:

#### 1️⃣ **Automatic Working Directory Management**  
When you open an R Project, RStudio **automatically** sets the working directory to the project's folder. This means you don’t have to use `setwd()` manually or worry about absolute file paths.  

Example:  
- If your project folder is `C:/Users/YourName/Documents/MyProject`, then any file in this folder can be accessed with a **relative path**:  

```r
read.csv("data/my_data.csv")  # No need for long paths!
```

#### 2️⃣ **Keeps Everything Organized**  
An R Project keeps **all related files**—scripts, datasets, plots, and outputs—in one place. This is especially useful when working on multiple projects, preventing files from getting mixed up.  

A typical project folder might look like this:  
```
MyProject/
│── data/         # Raw data files
│── scripts/      # R scripts
│── output/       # Processed results
│── MyProject.Rproj  # The project file
```
This structure helps keep your work clean and easy to navigate.  


#### 3️⃣ **Easier Collaboration & Portability**  
If you share your project folder, others can open the `.Rproj` file in RStudio and immediately start working—no need to change file paths or set up the environment manually. This makes R Projects ideal for:  
✅ **Teamwork**  
✅ **Sharing with collaborators**  
✅ **Reproducible research**  


#### 4️⃣ **Integrated Version Control (Git)**  
If you use Git for version control, R Projects make it simple to track changes, commit updates, and collaborate through platforms like **GitHub**. You can set up a Git repository directly inside the project.  

#### 5️⃣ **Easy Switching Between Projects**  
With R Projects, you can **quickly switch** between different tasks without affecting the working directory or opening and closing scripts. Each project remembers its settings, so you don’t have to reconfigure things every time.  


## How to Create an R Project  
1️⃣ Open **RStudio**  
2️⃣ Click **File** → **New Project**  
3️⃣ Choose **New Directory** (or an existing folder)  
4️⃣ Select **New Project** and give it a name  
5️⃣ Click **Create Project** 🎉  

Now, whenever you open the `.Rproj` file, RStudio will automatically set everything up for you! 

You can open a project using `File > Open Project` in the top left of R Studio. You will then notice the projects name appearing in the top right. Furthermore, the `Files` view in the bottom right will automatically go to the destination of your selected project.

## Creating an R project
Let's go through the steps of setting up an R project together. First, decide if you want to use an existing folder or generate a brand new folder for your R project. I would suggest using a folder that is clean. For example, use the folder `r_for_empra` that you created a couple lessons earlier!

To create a project, follow the steps outlined above. Make sure the creation of your project was successful and you can see the name of your project in the top right corner. If you are creating the project in a new folder, you will have to give it a sensible name!

## Challenges

::: challenge
## Challenge 1:

Make sure you have the project created. In the folder that the project is created in, add the following sub-folders:
`data`, `processed_data` and `archive`. You can do this either in the file explorer of your computer, or by using the bottom right window of RStudio.

`data` will house all the raw data files that we are working with in this tutorial. `processed_data` will be used to save data that we processed in some way and want to reuse later on. `archive` is a folder to store old scripts or data-sets that you will no longer use. You can also delete those files, but I often find it easier to just "shove them under the bed" so that I *could* still use them later on.

Get an overview of the folders in your project by running `list.dirs(recursive = FALSE)`. This should return the folders you just created and a folder where R-project information is stored.

If you do not see the folders you just created, make sure you created and opened the project and that the folders are in the same space as your `.Rproj` project file.
:::

::: challenge
## Challenge 2: 

Download the following [data](data/roy_kent_f_count.csv) and place it in the `data` folder. Make sure to give it an appropriate name. The data contains information about the number of times the character *Roy Kent* used the f-word in the show *Ted Lasso*.

:::

::: challenge
## Challenge 3: 

Test the data you just downloaded. Read it into R and give it an appropriate name. 

Hint: You may need to research how to read `.csv` files into R first.

:::: solution
## Solution


``` r
roy_kent_data <- read.csv("data/roy_kent_f_count.csv")
```
::::
:::

::: challenge
## Challenge 4:

Familiarize yourself with the data. What columns are there (use `colnames(data)`). Compute the average amount of times Roy Kent says "Fuck" in an episode. Compute the total amount of times he said it throughout the series.

:::: solution

``` r
average_f_count <- mean(roy_kent_data$F_count_RK)
total_f_count <- sum(roy_kent_data$F_count_RK)

# Because, cum_rk_overall is a running (cumulative) total:
total_f_count <- max(roy_kent_data$cum_rk_overall)
```

::::

:::

::::::::::::::::::::::::::::::::::::: keypoints  

- The **working directory** is where R looks for and saves files.  
- Absolute paths give full file locations; relative paths use the working directory.  
- **R Projects** manage the working directory automatically, keeping work organized.  
- Using R Projects makes code **portable, reproducible, and easier to share**.  
- A structured project with separate folders for data and scripts improves workflow.  

::::::::::::::::::::::::::::::::::::::::::::::::
