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
There are two main ways to define the working directory that R will use. You can do this using `setwd()` and specify a particular directory you want to start from. Another way to accomplish this is through the use of **R projects**. If you prefer declaring your working directory using `setwd()`, you can place this bit of code `setwd(dirname(rstudioapi::getActiveDocumentContext()$path))` at the beginning of your script. R will then set the working directory to the folder that the script you are working with is located in. 

However, I do not recommend this approach for reasons outlined below. Instead, I would suggest using R projects. When working in **RStudio**, using **R Projects** is one of the best ways to keep your work organized, portable, and efficient. An **R Project** is essentially a self-contained workspace that helps manage files, working directories, and settings automatically.  

---

### Why Use R Projects?  

#### 1️⃣ **Automatic Working Directory Management**  
When you open an R Project, RStudio **automatically** sets the working directory to the project's folder. This means you don’t have to use `setwd()` manually or worry about absolute file paths.  

Example:  
- If your project folder is `C:/Users/YourName/Documents/MyProject`, then any file in this folder can be accessed with a **relative path**:  

```r
read.csv("data/my_data.csv")  # No need for long paths!
```

---

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

---

#### 3️⃣ **Easier Collaboration & Portability**  
If you share your project folder, others can open the `.Rproj` file in RStudio and immediately start working—no need to change file paths or set up the environment manually. This makes R Projects ideal for:  
✅ **Teamwork**  
✅ **Sharing with collaborators**  
✅ **Reproducible research**  

---

#### 4️⃣ **Integrated Version Control (Git)**  
If you use Git for version control, R Projects make it simple to track changes, commit updates, and collaborate through platforms like **GitHub**. You can set up a Git repository directly inside the project.  

---

#### 5️⃣ **Easy Switching Between Projects**  
With R Projects, you can **quickly switch** between different tasks without affecting the working directory or opening and closing scripts. Each project remembers its settings, so you don’t have to reconfigure things every time.  

---

## How to Create an R Project  
1️⃣ Open **RStudio**  
2️⃣ Click **File** → **New Project**  
3️⃣ Choose **New Directory** (or an existing folder)  
4️⃣ Select **New Project** and give it a name  
5️⃣ Click **Create Project** 🎉  

Now, whenever you open the `.Rproj` file, RStudio will automatically set everything up for you! 

You can open a project using `File > Open Project` in the top left of R Studio. You will then notice the projects name appearing in the top right. Furthermore, the `Files` view in the bottom right will automatically go to the destination of your selected project.

::: callout

## Why not to use `setwd()`
Here, say why not

:::

## Creating an R project
Let's go through the steps of setting up an R project together. First, decide if you want to use an existing folder or generate a brand new folder for your R project. I would suggest using a folder that is clean. For example, if you already created a folder to save the script from the lesson earlier, we can just use that.

To create a project, follow the steps outlined above and give it an appropriate name. Something along the lines of `r_workshop` or `r_tutorial`. Make sure the creation of your project was successful and you can see the name of your project in the top right corner.

## Saving Data

## Challenges

::: challenge
## Challenge 1:

Make sure you have project created.

Filestructure and data-folder (maybe with archive/ folder).

data, raw_data, archive, 

:::

::: challenge
## Challenge 2: 

Read in some dataset (maybe from web) and then save it in the data folder
:::

::: challenge
## Challenge 3: 

Make sure this worked, read in the data set from saved version
:::

::: challenge
## Challenge 4: Storing data

Compute the mean and sum of something in the dataset
:::

::: challenge
## Challenge 5: 

save the summary statistics under a new name in the data folder
:::

::::::::::::::::::::::::::::::::::::: keypoints 

- Some key point

::::::::::::::::::::::::::::::::::::::::::::::::
