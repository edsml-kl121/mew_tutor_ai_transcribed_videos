# Python Virtual Environments: Isolate Each Project

**Visual goal:** Understand how `venv`, Conda, and dependency files keep Python projects separate, lean, and reproducible.

[Read the detailed summary](./Summary.md)

## Big picture

A virtual environment creates a boundary around one project's Python interpreter and installed packages. The project should contain only the dependencies it needs.

```mermaid
flowchart TD
    G["Global or mixed package space"] --> C1["Version conflicts"]
    G --> C2["Unnecessary packages"]
    G --> C3["Slower installation and builds"]
    P1["Project A"] --> E1["Environment A"]
    P2["Project B"] --> E2["Environment B"]
    E1 --> D1["Only A dependencies"]
    E2 --> D2["Only B dependencies"]
    D1 --> R1["Lean and maintainable"]
    D2 --> R2["Independent versions"]
```

### Visual learning path

1. Identify why globally mixed packages create risk.
2. Create a clean environment for one project.
3. Activate it before installing or running project code.
4. Install the declared dependencies from `requirements.txt`.
5. Deactivate it when switching context.
6. Choose either project-local `venv` or centrally managed Conda and use it consistently.

## 1. Environment lifecycle with `venv`

Creating an environment and activating it are separate actions. Creation builds the folder. Activation changes which Python and package set the shell uses.

```mermaid
stateDiagram-v2
    [*] --> NoEnvironment
    NoEnvironment --> Created: python -m venv myenv
    Created --> Active: source myenv/bin/activate
    Active --> Inspected: pip list
    Inspected --> DependenciesInstalled: pip install -r requirements.txt
    DependenciesInstalled --> Active: run project work
    Active --> Deactivated: deactivate
    Deactivated --> Active: activate again
```

```mermaid
flowchart LR
    A["Project folder"] --> B["myenv folder"]
    A --> C["requirements.txt"]
    A --> D["Python source files"]
    C --> E["Declared project packages"]
    E -->|pip install| B
    B --> F["Environment Python"]
    B --> G["Environment site packages"]
    D -->|run while active| F
```

`pip list` is a useful checkpoint. A newly created environment should begin with very few packages. After installation, it should show the libraries required by the project and their supporting dependencies.

## 2. `venv` and Conda mapping

```mermaid
flowchart TD
    Q["Which environment style fits the workflow?"] --> A["Prefer built-in and lightweight"]
    Q --> B["Prefer named central management"]
    A --> V["Use venv"]
    B --> C["Use Conda"]
    V --> V1["Create: python -m venv myenv"]
    V1 --> V2["Activate by filesystem path"]
    C --> C1["Create: conda create --name mytest python=3.11"]
    C1 --> C2["Activate by environment name"]
```

| Concern | Python `venv` | Conda |
|---|---|---|
| Installation | Built into Python | Requires Conda or Anaconda |
| Storage model | Folder inside or near project | Managed in a central location |
| Activation | Uses a filesystem path | Uses an environment name |
| Weight | Lightweight | More tooling and disk usage |
| Best fit | Simple project-local isolation | Convenient listing and switching |

Neither tool is universally better. Both provide the important boundary between projects. Conda can also specify the Python version during creation, as shown with Python 3.11.

## 3. Dependencies across development stages

```mermaid
flowchart LR
    A["Developer selects libraries"] --> B["Record in requirements.txt"]
    B --> C["Create clean environment"]
    C --> D["Install requirements"]
    D --> E["Run and test project"]
    E --> F["Recreate environment later"]
    B --> G["Pin versions for serious projects"]
    G --> H["Reduce incompatibility risk"]
    D --> I["Keep package list lean"]
    I --> J["Faster maintenance and smaller future builds"]
```

The same principle appears in other ecosystems. Python commonly uses `requirements.txt` plus an environment, while JavaScript commonly declares dependencies in `package.json`. The syntax differs, but the goal is the same: each project declares its own needs.

Virtual environments are the development isolation layer. Production containerization is a related but later concern, not a replacement demonstrated in this lesson.

> **Mental model:** Treat each project as a separate room. The virtual environment is the room, `requirements.txt` is its packing list, activation opens its door, and deactivation returns you to the hallway.

## Check your understanding

1. Why can one global package collection create dependency conflicts?
2. What is the difference between creating and activating a `venv`?
3. Why should `pip list` be small in a fresh environment?
4. How does Conda activation differ from `venv` activation?
5. Why should production-oriented projects pin dependency versions?
