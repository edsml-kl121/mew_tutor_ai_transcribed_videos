# Introduction to AI Engineering: Course Setup

**Format:** Thai-language setup walkthrough with English technical terminology  
**Source:** `transcript.txt` from `Introduction to AI Engineering 00 - Setup (360p)`

## Overview

This lesson prepares a macOS machine for the course. It separates the work into two groups: creating the online accounts used by later lessons and installing the local development tools needed for coding, environment management, version control, and containers. The instructor finishes with simple Terminal checks so learners can confirm that the command-line tools are available before starting the exercises.

## 1. Open the Course Prepwork

The setup instructions are located in the provided GitHub course link under the `00` prepwork section. The instructor describes roughly seven setup items and recommends completing them before attempting the course exercises.

The checklist includes both account setup and software installation. Learners should follow the linked instructions for each product because signup and installation screens may change.

## 2. Create the Required Accounts

### Google Colab

Create or sign in to a Google Colab account. Learners who already have a Google account can use it for Colab.

### GitHub

Create or sign in to a GitHub account. GitHub will be used to access and work with course code. The lesson distinguishes the GitHub website from the local Git command-line tool, which must also be installed.

### Render

Create an account at Render.com. The course will use Render around session 03 to deploy web services without requiring a paid hosting setup for the demonstrated work.

## 3. Install the Local Development Tools

The walkthrough assumes macOS. Installation steps on other operating systems may differ.

### Python 3.11

Download and install Python 3.11. The instructor emphasizes this version because the course labs are designed to run with Python 3.11, reducing the chance of version-related incompatibilities.

### Git

Install Git locally, not only a GitHub account or a graphical GitHub client. The course will use Git from the command line to save code history and push code to GitHub.

### Visual Studio Code

Install Visual Studio Code as the main place for writing code and completing exercises. The lesson briefly points out that VS Code supports add-on features through extensions, but does not require a specific extension setup here.

### Anaconda and Conda

Installing Anaconda is recommended because Conda can make Python environment creation and management easier. The instructor treats it as helpful rather than strictly required.

### Docker Desktop or Podman Desktop

Install Docker Desktop for container-related work. If an employer or company policy does not allow Docker, Podman Desktop is presented as an alternative. The instructor notes that Podman is lighter weight and can serve the same course need.

## 4. Verify the Installation in Terminal

Open Terminal and enter each tool name to confirm that the shell recognizes it. A help or usage message generally indicates that installation succeeded. A "command not found" or unrecognized-command response indicates that the tool is not installed correctly or is not available on the shell path.

Checks demonstrated or described include:

```bash
git
conda
python
docker
```

If using Podman instead of Docker:

```bash
podman
```

The instructor's Python installation reports Python 3.11.5. Learners do not need that exact patch version, but the course recommendation is Python 3.11.

## Practical Setup Checklist

1. Open the GitHub course repository and locate the `00` prepwork instructions.
2. Create or verify Google Colab, GitHub, and Render accounts.
3. Install Python 3.11.
4. Install the local Git command-line tool.
5. Install Visual Studio Code.
6. Install Anaconda if using Conda for environment management.
7. Install Docker Desktop, or use Podman Desktop when Docker is unavailable.
8. Open Terminal and run the relevant tool names.
9. Resolve every missing-command result before beginning the exercises.

## Takeaways and Action Items

- Finish the prepwork before starting the coding exercises.
- Keep the distinction clear between a GitHub account and the local Git tool.
- Use Python 3.11 to match the course labs.
- Use VS Code as the course coding workspace.
- Install Conda if easier environment creation is useful to you.
- Prepare either Docker Desktop or Podman Desktop for container work.
- Verify installations from Terminal rather than assuming a graphical installation completed successfully.

