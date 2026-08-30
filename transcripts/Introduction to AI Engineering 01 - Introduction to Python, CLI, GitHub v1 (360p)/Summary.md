# Introduction to AI Engineering: Session 1 - Python, CLI, and GitHub

**Format:** Thai-language lecture with English technical terminology  
**Duration:** Approximately 97 minutes  
**Source:** `introduction_to_ai_engineering_01_-_introduction_to_python,_cli,_github_v1 (360p).mp4`

## Overview

This opening session builds the foundation needed for later AI Engineering application work. It introduces three main areas: Python programming basics, command-line interface (CLI) skills, and the Git/GitHub collaboration workflow. The material is intentionally broad and beginner-friendly rather than an expert-level treatment.

## 1. Python Basics

### Why Python

Python is widely used in AI and machine learning, data analysis with tools such as pandas and PySpark, and web backends built with FastAPI or Flask. Although Python itself can be much slower than C, many performance-critical libraries such as NumPy use optimized C or C++ implementations behind the scenes. This combines approachable syntax with practical performance.

### Core concepts

- **Printing:** Use `print()` to inspect intermediate values and debug program behavior.
- **Variables and data types:** Work with `int`, `float`, `string`, and `bool`, and inspect values with `type()`.
- **String formatting:** Use f-strings such as `f"{name}"` to embed values in text.
- **Conditionals:** Apply `if`, `elif`, and `else` to select behavior based on conditions or numeric ranges.
- **Functions:** Package reusable logic into functions with parameters and return values.
- **Loops:** Use constructs such as `for i in range(n)` and remember that Python ranges are zero-indexed.
- **Data structures:** Use lists, sets, dictionaries, and tuples for different storage needs.
- **File handling:** Read from and write to text files.
- **Object-oriented programming:** Define classes with attributes and methods, then extend them through inheritance and method overriding.

### Notebook setup and shortcuts

Google Colab and Jupyter notebooks are recommended for learning and experimentation, but not as the main format for production code.

- `Shift+Enter`: Run the current cell
- `Esc`, then `B`: Add a cell below
- `Esc`, then `A`: Add a cell above
- `Cmd+/`: Comment or uncomment a line

### Exercises

- Print a name and the current year with an f-string.
- Sum the numbers 1 through 10 with a loop and accumulator.
- Print different outputs for several numeric ranges.
- Write a function that adds two ages and returns a formatted string.
- Write a function that sums a list of numbers.
- Count the elements in a list.
- Build a dictionary mapping month names to month numbers.
- Create a `Person` class, then a `Male` subclass that inherits and overrides behavior.

### Homework

1. Write a function that returns the maximum and minimum values from a list, in that order.
2. List the numbers below 10 that are multiples of 3 or 5.
3. Complete the two additional code-reading exercises provided in the course material.

## 2. Command-Line Interface

The terminal demonstration uses macOS and covers common file and folder operations:

```bash
ls
mkdir folder_name
pwd
cd folder_name
touch file_name
rm file_name
```

Tab completion is used to navigate more quickly. For VS Code integration, install the `code` shell command through the Command Palette, then open the current directory with:

```bash
code .
```

### Bash scripting demo

A `.sh` script automates the creation of a folder structure containing `village`, `house1`, `house2`, `house3`, and `letter.txt`. The script is run with:

```bash
bash create.sh
```

The instructor also uses `echo` to show progress and debug script execution.

### Exercise

Recreate the specified village and house folder structure twice:

1. Manually with terminal commands.
2. Automatically with a Bash script.

## 3. Git and GitHub

Git is presented as local version control for tracking changes and history. GitHub is the cloud platform used to host repositories and collaborate with a team.

### Demonstrated workflow

```bash
git clone <url>
git init
git status
git add .
git commit -m "message"
git push
git checkout -b feature-exercise1
git branch
git pull origin main
```

The end-to-end demonstration includes:

1. Clone an existing repository.
2. Create a GitHub account and public repository.
3. Initialize a local repository and make the first commit.
4. Push the `main` branch to GitHub.
5. Check untracked and modified files with `git status`.
6. Create and switch to a feature branch.
7. Commit and push the feature-branch changes.
8. Open a Pull Request, assign a reviewer, merge it, and delete the merged branch.
9. Return to local `main` and pull the merged changes.
10. Create a GitHub Issue, make the related code change, and close the issue.

Merge conflicts are identified as an important real-world topic, but are not covered in depth in this session.

## Takeaways and Action Items

- Complete the Python homework and code-reading exercises.
- Install or confirm access to Python 3.11 or later, Git, and VS Code. Anaconda is optional.
- Install the VS Code `code` shell command for terminal use.
- Practice creating the folder exercise manually and with a Bash script.
- Practice the complete GitHub workflow: repository, branch, commit, push, Pull Request, merge, pull, Issue, and closure.
- Treat this session as a foundation for the more complex AI Engineering applications introduced later.
