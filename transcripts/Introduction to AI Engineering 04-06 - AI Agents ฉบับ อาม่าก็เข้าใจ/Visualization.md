# AI Agents Explained Simply

**Visual goal:** See how the same flight-booking goal becomes either a fixed developer-controlled workflow or an autonomous LLM-controlled workflow.

[Read the detailed summary](./Summary.md)

## Big picture: goal, tools, and control

```mermaid
flowchart LR
    U["User goal: book a flight to Japan"] --> C{"Who controls the steps?"}
    C -->|Developer| P["Programmatic Workflow"]
    C -->|LLM| A["Agentic Workflow"]
    P --> R["Rules, if else, fixed sequence"]
    A --> G["Goal plus available tools"]
    R --> O["Booking options"]
    G --> O
    O --> H["Human clarification and selection"]
```

The same tools can appear in both systems. What changes is whether the developer or the LLM decides the order of actions.

## Tool map for the booking task

```mermaid
flowchart TB
    B["Book flight ticket"]
    B --> S["Web search"]
    B --> V["Image Understanding"]
    B --> N["Click and scroll"]
    B --> T["Type dates and details"]
    B --> Q["Ask for clarification"]
    S --> F["Find airline options"]
    V --> L["Interpret page layout"]
    N --> D["Select filters"]
    T --> X["Prepare transaction"]
    Q --> H["Human chooses an option"]
```

## Two control flows

```mermaid
flowchart TD
    P0["Programmatic request"] --> P1["Extract keywords"]
    P1 --> P2["Search flights"]
    P2 --> P3["Open known page"]
    P3 --> P4["Follow coded rules"]
    P4 --> P5["Ask human"]
    P5 --> P6["Complete approved action"]

    A0["Agentic request"] --> A1["LLM inspects goal"]
    A1 --> A2["Choose a tool"]
    A2 --> A3["Observe result"]
    A3 --> A4{"Goal complete?"}
    A4 -->|No| A1
    A4 -->|Yes| A5["Return result"]
```

| Dimension | Programmatic Workflow | Agentic Workflow |
|---|---|---|
| Decision maker | Developer | LLM |
| Build effort | Long for complex variations | Less explicit control-flow coding |
| Runtime | Fast | Slower planning loop |
| Predictability | High | Lower |
| Adaptation | Coded case by case | Potentially adapts from observations |
| Cost | Lower token use | More reasoning tokens |
| Main risk | Missing an unhandled case | Wrong AI reasoning or action |

> **Mental model:** Tools are the hands, the goal is the destination, and control flow is the driver. A programmatic system lets the developer drive. An agentic system lets the LLM drive, so its reasoning quality and safety boundaries become critical.

## Agentic reasoning loop

```mermaid
stateDiagram-v2
    [*] --> Understand
    Understand --> Plan
    Plan --> SelectTool
    SelectTool --> Execute
    Execute --> Observe
    Observe --> Plan: More work needed
    Observe --> Clarify: Human choice needed
    Clarify --> Plan
    Observe --> Finish: Goal reached
    Finish --> [*]
```

## Engineering decision tree

```mermaid
flowchart TD
    A["Define the task"] --> B{"Can the steps be specified reliably?"}
    B -->|Yes| C["Start programmatic"]
    B -->|No| D{"Is the environment highly variable?"}
    D -->|No| E["Improve rules and deterministic routing"]
    D -->|Yes| F{"Is action risk acceptable?"}
    F -->|No| G["Keep human approval and deterministic actions"]
    F -->|Yes| H["Prototype an agentic workflow"]
    H --> I["Measure reasoning errors, latency, tokens, and cost"]
    I --> J{"Evidence good enough?"}
    J -->|No| C
    J -->|Yes| K["Deploy with controls"]
```

## Visual learning path

1. Start with the user's goal and list the required tools.
2. Notice that tools do not automatically make a system agentic.
3. Compare developer-controlled steps with the LLM planning loop.
4. Connect autonomy to reasoning quality, latency, token cost, and risk.
5. Choose programmatic control by default, then justify any move toward autonomy.

## Check your understanding

1. What is the defining control difference between a programmatic and an agentic workflow?
2. Why can an agent adapt to different websites more easily than a fixed script?
3. Why does agentic planning increase both latency and cost?
4. Which flight-booking step should include explicit human clarification?
5. Why does the instructor currently favor programmatic workflows for most production tasks?
