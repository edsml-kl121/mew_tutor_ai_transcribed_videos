# Python, CLI, and GitHub: The Foundation Workflow

**Visual goal:** See how Python logic, terminal skills, and Git collaboration connect to form a practical foundation for AI Engineering.

[Read the detailed summary](./Summary.md)

## Big picture

The lesson moves from writing logic, to operating files and tools, to sharing changes with a team.

```mermaid
flowchart LR
    A["Python basics"] --> B["Write useful programs"]
    C["CLI skills"] --> D["Navigate and automate projects"]
    E["Git"] --> F["Track local history"]
    G["GitHub"] --> H["Collaborate in the cloud"]
    B --> I["AI Engineering application"]
    D --> I
    F --> H
    H --> I
```

### Visual learning path

1. Learn how data and control flow through Python.
2. Use the CLI to create, inspect, and automate a project structure.
3. Use Git to turn file changes into a reliable history.
4. Use GitHub branches, Pull Requests, and Issues to coordinate work.

## 1. How Python programs are assembled

Python starts with values and data structures, then adds decisions, repetition, reusable functions, and objects.

```mermaid
flowchart TD
    A["Values and variables"] --> B["Types: int, float, string, bool"]
    B --> C["Collections"]
    C --> C1["List: ordered items"]
    C --> C2["Set: unique items"]
    C --> C3["Dictionary: key and value"]
    C --> C4["Tuple: fixed sequence"]
    B --> D["Control flow"]
    D --> D1["if, elif, else"]
    D --> D2["for and range"]
    D1 --> E["Functions"]
    D2 --> E
    E --> F["Classes and methods"]
    F --> G["Inheritance and overriding"]
    E --> H["Read and write files"]
```

| Concept | Mental mapping | Typical use |
|---|---|---|
| Variable | Labeled value | Store a name, year, or total |
| Conditional | Decision gate | Choose output for a numeric range |
| Loop | Repeated path | Sum values or count items |
| Function | Reusable machine | Accept parameters and return a result |
| Class | Blueprint | Combine attributes and behavior |

`print()` and f-strings make invisible program state visible. A loop often uses an accumulator, while a function places that logic behind a reusable name. Python ranges are zero-indexed, so `range(n)` starts at `0` and stops before `n`.

## 2. CLI as the project's control surface

The terminal lets a developer manipulate the same folders and files that Python and Git use. Bash scripts turn a repeated command sequence into an executable procedure.

```mermaid
sequenceDiagram
    participant L as Learner
    participant T as Terminal
    participant F as File system
    participant V as VS Code
    L->>T: Run pwd and ls
    T->>F: Inspect current location
    F-->>T: Return folders and files
    L->>T: Run mkdir, cd, and touch
    T->>F: Create project structure
    L->>T: Run bash create.sh
    T->>F: Create village, houses, and letter
    L->>T: Run code .
    T->>V: Open current folder
```

Manual commands teach cause and effect. A `.sh` file captures those commands so the result can be recreated consistently. `echo` can reveal progress when debugging a script.

## 3. Git and GitHub collaboration loop

```mermaid
flowchart LR
    A["Clone or initialize repository"] --> B["Edit files"]
    B --> C["git status"]
    C --> D["git add"]
    D --> E["git commit"]
    E --> F["git push"]
    F --> G["Open Pull Request"]
    G --> H["Review and merge"]
    H --> I["Switch to local main"]
    I --> J["git pull origin main"]
    J --> B
    K["GitHub Issue"] --> B
    H --> L["Delete merged branch"]
```

| Tool | Scope | Main responsibility |
|---|---|---|
| Git | Local machine | Track changes, commits, and branches |
| GitHub | Cloud collaboration | Host repositories, review Pull Requests, manage Issues |
| Feature branch | Isolated line of work | Keep unfinished changes away from `main` |
| Pull Request | Review boundary | Discuss and merge a proposed change |

> **Mental model:** Python is the logic workshop, the CLI is the control panel, Git is the project time machine, and GitHub is the shared collaboration space.

## Check your understanding

1. How do variables, conditionals, loops, and functions build on one another?
2. Why automate the village folder exercise with Bash after creating it manually?
3. What is the difference between a local Git commit and a GitHub Pull Request?
4. Why should work happen on a feature branch before it is merged into `main`?
5. After a Pull Request is merged, how does the local `main` receive the change?
