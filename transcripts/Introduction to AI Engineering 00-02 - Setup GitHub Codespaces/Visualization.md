# GitHub Codespaces: From Repository to Cloud Workspace

**Visual goal:** Understand how a learner creates, uses, verifies, and stops a GitHub Codespace without running the workshop code directly on a laptop.

[Read the detailed summary](./Summary.md)

## Big picture

```mermaid
flowchart LR
    A["Learner in a web browser"] --> B["GitHub workshop repository"]
    B --> C["GitHub Codespace"]
    C --> D["Cloud container on GitHub server"]
    D --> E["VS Code-like workspace"]
    E --> F["Integrated Terminal"]
    F --> G["Run Python exercise"]
```

### Visual learning path

1. Decide whether a cloud workspace is more convenient than running code locally.
2. Sign in to GitHub and open the workshop repository.
3. Create a codespace from the repository's **Code** menu.
4. Wait while GitHub provisions the cloud container and workspace.
5. Use the VS Code-like editor and integrated Terminal.
6. Run exercise `01` to confirm that Python code works.
7. Stop the codespace when the session is complete.

## 1. Exact setup journey

```mermaid
flowchart TD
    A["Open workshop repository"] --> B{"Signed in to GitHub?"}
    B -->|No| C["Create an account or sign in"]
    C --> D["Select green Code button"]
    B -->|Yes| D
    D --> E["Open Codespaces"]
    E --> F["Select Create codespace on main"]
    F --> G["GitHub spins up cloud container"]
    G --> H["Wait for provisioning"]
    H --> I["Codespace workspace is ready"]
```

## 2. Local laptop and Codespaces mapping

| Learning need | Local approach | Codespaces approach |
|---|---|---|
| Open an editor | Desktop VS Code | VS Code-like browser workspace |
| Enter commands | Laptop Terminal | Integrated Codespaces Terminal |
| Execute Python | Local machine | Cloud container on GitHub's server |
| Store the active environment | Laptop resources | Provisioned codespace workspace |
| End the session | Close local tools | Select **Stop Codespace** |

```mermaid
flowchart TB
    subgraph Local["Local approach"]
        L1["Laptop"] --> L2["Desktop VS Code"]
        L2 --> L3["Local Terminal"]
        L3 --> L4["Run code locally"]
    end
    subgraph Cloud["Codespaces approach"]
        C1["Browser"] --> C2["GitHub repository"]
        C2 --> C3["Cloud VS Code-like workspace"]
        C3 --> C4["Integrated Terminal"]
        C4 --> C5["Run code on GitHub server"]
    end
```

> **Mental model:** A GitHub repository is the entry point, **Create codespace on main** starts a cloud container, and the browser becomes the window into a VS Code-like workspace running on GitHub's server.

## 3. Verify the workspace with the course exercise

```mermaid
flowchart TD
    A["Codespace is ready"] --> B["Open exercise 01"]
    B --> C["Introduction to Python"]
    C --> D{"Choose what to run"}
    D -->|Notebook| E["Open and run a notebook"]
    D -->|Python script| F["Open integrated Terminal"]
    F --> G["Run python example.py"]
    E --> H["Observe execution in Codespaces"]
    G --> H
    H --> I["Cloud workspace is working"]
```

Command demonstrated in the lesson:

```bash
python example.py
```

## 4. Usage decision and shutdown habit

```mermaid
flowchart TD
    A["Need to run a learning task"] --> B{"Convenient to run it on the laptop?"}
    B -->|Yes| C["Local development remains an option"]
    B -->|No| D["Provision GitHub Codespace"]
    D --> E["Use browser editor and Terminal"]
    E --> F{"Finished learning session?"}
    F -->|No| E
    F -->|Yes| G["Select Stop Codespace"]
    G --> H["Conserve the monthly allowance"]
```

The instructor states that a free GitHub account has `120 hours per month` for Codespaces and describes that amount as sufficient for learning.

## Check your understanding

1. Which repository button and section lead to **Create codespace on main**?
2. What does GitHub provision after the learner requests a new codespace?
3. How is the Codespaces interface similar to desktop Visual Studio Code?
4. Which command is used to demonstrate the `example.py` exercise?
5. Why should the learner select **Stop Codespace** after finishing?
