# Introduction to AI Engineering: Creating Python Virtual Environments

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_021-_creating_virtual_environments_v1 (360p).mp4`

## Overview

This session explains why Python projects should use separate virtual environments and demonstrates two approaches: Python's built-in `venv` module and Conda. The central goal is to keep each project's dependencies isolated, lean, reproducible, and easier to maintain.

## 1. Why Dependency Isolation Matters

Real projects rarely implement everything from scratch. They depend on reusable libraries such as pandas and, in later AI work, larger packages such as sentence-transformers. As projects grow, their dependency lists also grow.

Without isolation, two main problems appear:

- **Dependency conflicts:** Different projects or libraries may require incompatible package versions.
- **Harder and slower maintenance:** Unnecessary packages increase installation time and can make later build or Docker image creation slower.

The recommended development practice is to give each project its own environment and the smallest practical dependency list. The instructor distinguishes this development-time isolation from production containerization, which is covered separately.

## 2. Dependency Management Across Languages

The underlying idea is not unique to Python. Different ecosystems record and install dependencies in different ways:

- Python commonly uses `requirements.txt` and a virtual environment directory.
- JavaScript commonly uses `package.json`.

The exact tools differ, but the shared principle is to define the packages needed by each project rather than mixing every dependency into one global environment.

## 3. Creating an Environment with `venv`

The first approach uses Python's built-in virtual environment support:

```bash
python -m venv myenv
```

This creates a local folder containing the environment's Python tooling and activation script. On macOS or Linux, activate it with:

```bash
source myenv/bin/activate
```

Useful commands demonstrated include:

```bash
pip list
pip install -r requirements.txt
deactivate
```

`pip list` shows that a fresh environment contains very few packages. Installing from `requirements.txt` adds the packages needed by the project. After deactivation, those project-specific packages are no longer the active environment's package set.

### Important behavior

Running `python -m venv myenv` only creates the environment folder. It does not activate the environment automatically. Because the activation script lives inside that folder, activation normally uses a path relative to the project's location.

## 4. Creating and Managing Environments with Conda

Conda offers another way to create environments:

```bash
conda create --name mytest python=3.11
conda activate mytest
pip list
conda deactivate
```

The instructor also demonstrates listing previously created Conda environments and switching into an environment by name.

Unlike a project-local `venv` directory, Conda stores managed environments in a central location. This makes them easier to activate from different working directories.

## 5. `venv` Compared with Conda

### Python `venv`

- Built into Python.
- Lightweight.
- Creates an environment folder inside or near the project.
- Requires activating the environment through its filesystem path.

### Conda

- Requires installing Conda or Anaconda.
- Uses more disk space and supporting tooling.
- Makes named environments easier to list, activate, and manage from anywhere.
- Can simplify environment and dependency management for some workflows.

Neither option is declared universally better. The instructor recommends choosing one approach, learning it well, and using it consistently.

## Practical Exercise

1. Create a new project folder.
2. Create a clean environment with either `python -m venv` or `conda create`.
3. Activate the environment.
4. Run `pip list` and confirm that the environment begins with a minimal package set.
5. Add packages to `requirements.txt`.
6. Install them with `pip install -r requirements.txt`.
7. Deactivate the environment and observe that the active package context changes.

## Takeaways and Action Items

- Use a separate virtual environment for each Python project.
- Keep dependency lists as lean as possible.
- Record required packages in `requirements.txt`.
- Pin package versions in serious or production-oriented projects to reduce incompatibility risk.
- Use `venv` when a lightweight, project-local solution is preferred.
- Use Conda when named, centrally managed environments are more convenient.
- Treat virtual environments as the development isolation layer and containerization as a later production concern.
