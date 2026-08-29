# Introduction to AI Engineering — Session 1: Python, CLI, GitHub

**Format:** Thai-language lecture with English technical terminology · **Duration:** ~97 minutes
**Source:** `introduction_to_ai_engineering_01_-_introduction_to_python,_cli,_github_v1 (360p).mp4`

## Overview

First session of an AI Engineering course series. The instructor frames this as foundation-building before tackling more complex application-building work in later sessions. Three topics are covered in order: **Python basics**, **command-line interface (CLI/terminal)**, and **Git/GitHub**.

## 1. Python Basics

**Why Python:** Popular for AI/ML, data analysis (pandas, PySpark), and web backends (FastAPI, Flask) despite being notably slow (~11x slower than C in benchmarks shown). It remains popular because it's easy to write, and performance-critical libraries (NumPy, etc.) are implemented in C/C++ under the hood — so Python code calling those libraries still runs fast. Essential for data analyst / data scientist / data engineer roles.

**Core concepts covered, in order:**
- **Printing** — the most important early tool for debugging; print intermediate values to see what a program is doing at each step
- **Variables & data types** — `int`, `float`, `string`, `bool`; using `type()` to check a variable's type; f-strings (`f"{name}"`) for embedding variables in printed text
- **Conditionals** — `if` / `elif` / `else`, including chaining several range checks (e.g., 0–3, 4–7, ≥8)
- **Functions** — write logic once, reuse via arguments/return values; parameter names are arbitrary and only meaningful inside the function
- **Loops** — `for i in range(n)` (0-indexed); walked through summing numbers 1–10 by iterating and accumulating
- **Data structures** — list/array, `set` (auto-deduplicates), `dictionary` (key–value, e.g. mapping month name → number), `tuple` (immutable, rarely used)
- **File handling** — reading/writing text files from code
- **Object-oriented programming** — classes with attributes and methods (`Person` class example with `name`/`age`, a `scream()` method); **inheritance** (a `Male` subclass inheriting from `Person`); **polymorphism** via method overriding

**Practical setup:** Google Colab / Jupyter notebooks for learning and experimentation (not for production code). Keyboard shortcuts shown: Shift+Enter (run cell), Esc+B (new cell below), Esc+A (new cell above), Cmd+/ (comment line).

**In-class exercises:** print name + current year using f-strings; sum 1–10 via a for-loop; conditional printing based on value ranges; write a function to sum two ages and return as a formatted string; write a function to sum a list of numbers; count elements in a list; build a month-name-to-number dictionary; OOP class exercise (Person/Male).

**Homework assigned:**
1. Implement a function returning the max and min of a list, in that order
2. List numbers below 10 that are multiples of 3 or 5
3. Two additional "read the code" style problems

## 2. Command Line Interface (CLI / Terminal)

Basic terminal fluency, demonstrated on macOS:
- `ls` — list directory contents
- `mkdir` — create a folder
- `pwd` — print current directory
- `cd` — change directory (with tab-completion)
- `touch` — create an empty file
- `rm` — delete a file
- **VS Code integration:** installing the `code` shell command (Cmd+Shift+P → "Shell Command: Install 'code' command in PATH") so `code .` opens the current folder in VS Code
- **Bash scripting:** writing a `.sh` file to automate a sequence of terminal commands (creating a folder tree: `village/house1/house2/house3` with a `letter.txt`), run via `bash create.sh`; `echo` used for logging/debug output during script execution

**Exercise:** recreate a specific nested folder/file structure (village → house1/2/3 → letter.txt) both manually and via a bash script.

## 3. Git & GitHub

**Prerequisites to install:** Python 3.11+, Git, VS Code, (optionally) Anaconda.

**Concepts:** Git = local version control (tracks file changes/history on your machine). GitHub = cloud platform for hosting Git repos and collaborating with a team.

**Workflow demonstrated, in order:**
1. `git clone <url>` — clone an existing repo (HTTPS or SSH)
2. Create a new GitHub account + a new public repository
3. `git init`, `git add .`, `git commit -m "message"` — initialize and make a first commit
4. `git push` (with upstream branch setup) — push to the `main` branch
5. `git status` — check untracked/modified files before staging
6. `git checkout -b feature-exercise1` — create and switch to a new branch; `git branch` to list branches
7. Make a change, `git add` / `commit` / `push` on the feature branch
8. On GitHub: open a **Pull Request**, self-assign as reviewer, **merge** the PR, then delete the merged branch
9. `git pull origin main` — sync local `main` with remote after a merge
10. Create a GitHub **Issue**, assign it, resolve the underlying code change, then close the issue

**Note:** merge conflicts were flagged as a real-world topic but intentionally not covered in depth in this session (big-picture overview only).

## Recap (as stated by instructor)

Python is broadly useful (AI/ML, data analysis, web) despite being slow, because of its ease of use and optimized underlying libraries. Covered: print, variables, data types, conditionals, functions, data structures, file I/O, packages, OOP. Also covered: CLI basics for file/folder operations, and Git/GitHub for team collaboration (branches, PRs, merging, issues). Explicitly framed as a broad, beginner-level overview — not expert-level — to give tools for later, more complex sessions in the series.

## Takeaways / Action Items
- Complete the two Python homework problems (min/max of a list; multiples of 3 or 5 below 10) plus the two "read the code" exercises
- Ensure local environment is set up: Python 3.11+, Git, VS Code (with `code` CLI command installed), Anaconda (optional)
- Practice the terminal exercise (recreate the village/house folder structure manually and via a bash script)
- Practice the full GitHub workflow end-to-end: repo → branch → PR → merge → issue → close
