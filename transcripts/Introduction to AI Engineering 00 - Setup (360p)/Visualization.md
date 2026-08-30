# Course Setup: From Empty Machine to Ready Workspace

**Visual goal:** See how accounts, local tools, and Terminal verification combine into a course-ready development environment.

[Read the detailed summary](./Summary.md)

## Big picture

```mermaid
flowchart TD
    A["Open GitHub course prepwork"] --> B["Create online accounts"]
    A --> C["Install local tools"]
    B --> B1["Google Colab"]
    B --> B2["GitHub"]
    B --> B3["Render"]
    C --> C1["Python 3.11"]
    C --> C2["Git"]
    C --> C3["Visual Studio Code"]
    C --> C4["Anaconda and Conda"]
    C --> C5["Docker or Podman"]
    B1 --> D["Ready for course exercises"]
    B2 --> D
    B3 --> D
    C1 --> E["Verify in Terminal"]
    C2 --> E
    C4 --> E
    C5 --> E
    C3 --> D
    E --> D
```

### Visual learning path

1. Start with the `00` prepwork instructions in the course repository.
2. Prepare the accounts that provide notebooks, code hosting, and deployment.
3. Install the local coding and runtime tools.
4. Choose Docker Desktop or Podman Desktop according to availability and policy.
5. Verify command-line tools in Terminal.
6. Begin the exercises only after the required checks succeed.

## 1. What each setup item enables

```mermaid
flowchart LR
    G["Google Colab account"] --> N["Hosted notebook access"]
    H["GitHub account"] --> R["Course code and remote repositories"]
    T["Render account"] --> W["Later web service deployment"]
    P["Python 3.11"] --> X["Run course Python labs"]
    V["Visual Studio Code"] --> Y["Write and edit exercise code"]
    I["Git command line"] --> Z["Track and push code"]
    C["Conda"] --> M["Manage Python environments"]
    D["Docker or Podman"] --> O["Run container workflows"]
```

| Setup item | Type | Role in the course | Important note |
|---|---|---|---|
| Google Colab | Account | Hosted notebook work | A Google account can be used |
| GitHub | Account | Access and host code | Different from installing Git |
| Render | Account | Deploy web services later | Introduced for session 03 work |
| Python 3.11 | Local software | Run Python labs | Recommended course version |
| Git | Local software | Version control from Terminal | Used instead of relying only on a GUI |
| VS Code | Local software | Main code editor | Exercises are written here |
| Anaconda and Conda | Local software | Easier environment management | Recommended, not presented as mandatory |
| Docker or Podman | Local software | Container tooling | Podman is the alternative if Docker is restricted |

## 2. Container tool decision

```mermaid
flowchart TD
    A["Need course container tooling"] --> B{"Is Docker allowed and available?"}
    B -->|Yes| C["Install Docker Desktop"]
    B -->|No| D["Install Podman Desktop"]
    C --> E["Run docker in Terminal"]
    D --> F["Run podman in Terminal"]
    E --> G{"Command recognized?"}
    F --> G
    G -->|Yes| H["Container tool ready"]
    G -->|No| I["Review installation and shell access"]
```

## 3. Verification loop

```mermaid
flowchart LR
    A["Install a tool"] --> B["Open Terminal"]
    B --> C["Enter the command name"]
    C --> D{"Help or usage output appears?"}
    D -->|Yes| E["Tool is available"]
    D -->|No| F["Command not found or unrecognized"]
    F --> G["Fix installation or command path"]
    G --> C
    E --> H["Check the next tool"]
```

Useful checks from the lesson:

```bash
git
conda
python
docker
```

Use `podman` instead of `docker` when Podman Desktop is the selected container tool.

> **Mental model:** The accounts are keys to external services, the installed applications are tools on your workbench, and Terminal checks prove that the workbench is actually usable.

## Check your understanding

1. Why is creating a GitHub account not enough to use Git from Terminal?
2. Why does the instructor recommend Python 3.11?
3. What later course activity is the Render account intended to support?
4. When should a learner choose Podman Desktop instead of Docker Desktop?
5. What Terminal result suggests that an installation still needs attention?

