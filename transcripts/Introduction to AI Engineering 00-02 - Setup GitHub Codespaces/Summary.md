# GitHub Codespaces Setup for Browser-Based Learning

**Format:** Thai-language walkthrough with English GitHub, Codespaces, VS Code, Terminal, Python, and cloud terminology  
**Source video:** `00_02_setup_GitHub_CodeSpaces.mov`  
**Authoritative transcript:** `transcript.txt`

## Overview

This short lesson introduces GitHub Codespaces as an alternative learning environment for people who do not want to run course code and tasks on their own laptop. Instead of installing and executing everything locally, a learner can provision a cloud workspace from the workshop repository and use a browser-based interface that closely resembles Visual Studio Code.

The instructor demonstrates the complete path: sign in to GitHub, create a codespace from the repository's green **Code** menu, wait for provisioning, use the integrated Terminal, run a Python exercise, and stop the codespace after use.

## 1. Why Use GitHub Codespaces?

The usual approach is to open a Terminal and run Python code or other commands directly on a personal computer. The instructor offers GitHub Codespaces as another option, especially for learners who are not comfortable or able to use their own laptop for course code.

GitHub Codespaces lets the learner:

- Run code through the internet from the GitHub website.
- Use a development environment hosted on GitHub's servers.
- Avoid running the course workload directly on the local machine, described in Thai as not affecting "เครื่องของเรา".
- Work in a browser interface that looks almost the same as desktop Visual Studio Code.

The transcript presents this as a free option with a monthly usage allowance for a free GitHub account.

## 2. Sign In and Open the Workshop Repository

Before creating a codespace:

1. Open the GitHub page for the instructor's workshop or hands-on exercise.
2. Sign in to GitHub.
3. If you do not yet have a GitHub account, create one and then sign in.

The creation controls are shown after the learner is logged in and viewing the exercise repository.

## 3. Create a Codespace

From the workshop repository:

1. Select the green **Code** button.
2. Move to the **Codespaces** section or tab.
3. Select **Create codespace on main**.
4. Wait while GitHub provisions the codespace and prepares the workspace.

The instructor explains that this action spins up a container on the cloud. The result is a development workspace that runs on GitHub's server and is accessed through the browser.

Provisioning takes a short time. When it finishes, the learner sees an interface that is nearly the same as VS Code on a local computer, except this VS Code environment is running in the cloud on GitHub.

## 4. Use the Browser-Based Workspace

The codespace includes a Terminal that can be used much like the Terminal on a laptop. Commands such as `python` are available from this integrated Terminal.

The key mapping is:

| Local development concept | GitHub Codespaces equivalent |
|---|---|
| Code and tools on the laptop | Code and tools in a cloud container |
| Desktop VS Code | VS Code-like browser workspace |
| Local Terminal | Integrated Terminal in the codespace |
| Local compute | GitHub server compute |

The instructor's main point is that learners can write and run code online without making their own laptop the execution environment.

## 5. Demonstration: Run a Python Exercise

To show that the environment works, the instructor opens exercise `01`, described as `Introduction to Python`.

The demonstrated choices are:

- Open and run a notebook in the codespace, or
- Run the `example.py` script from the Terminal.

The command shown is:

```bash
python example.py
```

The successful script run demonstrates that the learner can execute the workshop's Python code in the cloud-based codespace.

## 6. Stop the Codespace After Use

When the learning session is finished, select **Stop Codespace**. This is an important usage habit because Codespaces has a limited allowance.

The instructor states that a free account receives:

- Approximately one hundred or more hours of Codespaces usage.
- Specifically, `120 hours per month` in the explanation.

The instructor considers this sufficient for learning, but learners should still stop the codespace when they have finished using it.

## Caveats from the Lesson

- A GitHub account and sign-in are required before following the demonstrated repository flow.
- The workspace must finish provisioning before it is ready.
- Codespaces usage is limited, even though the free-account allowance is presented as ample for course learning.
- The transcript demonstrates Python execution but does not describe installing extra dependencies or changing the codespace configuration.
- The lesson presents Codespaces as an optional alternative, not as a requirement to replace local development.

## Practical Setup Checklist

1. Create a GitHub account if needed.
2. Sign in to GitHub.
3. Open the workshop or hands-on exercise repository.
4. Select **Code**.
5. Open **Codespaces**.
6. Select **Create codespace on main**.
7. Wait for the workspace to be provisioned.
8. Open the integrated Terminal.
9. Navigate to exercise `01`, `Introduction to Python`.
10. Open a notebook or run:

```bash
python example.py
```

11. Confirm that the script runs in the cloud workspace.
12. Select **Stop Codespace** when finished.

## Takeaways and Action Items

- Use GitHub Codespaces when running code locally is inconvenient.
- Think of a codespace as a cloud container with a VS Code-like browser interface and integrated Terminal.
- Start it from the repository using **Code** > **Codespaces** > **Create codespace on main**.
- Validate the environment by running an actual course exercise, such as `python example.py`.
- Stop the codespace after each session to conserve the monthly allowance.
- Keep local development as an option. The instructor introduces Codespaces as an additional learning tool.
