# What Is a Multi-Agent System?

**Visual goal:** Understand when one tool-heavy agent should become a supervisor that coordinates smaller, domain-specialized agents.

[Read the detailed summary](./Summary.md)

## Big picture: distribute responsibilities

A single agent works well with a few tools. As unrelated tools accumulate, prompt complexity, tool confusion, context use, and token cost grow. A multi-agent design groups tools by domain and lets a supervisor route requests.

```mermaid
flowchart LR
    U["User request"] --> S["Supervisor agent"]
    S --> SA["Sales agent"]
    S --> HR["HR agent"]
    S --> PA["Procurement agent"]
    SA --> ST["Sales tools"]
    HR --> HT["HR tools"]
    PA --> PT["Procurement tools"]
    SA --> S
    HR --> S
    PA --> S
    S --> O["Final response"]
```

The supervisor needs domain-level routing knowledge, not every low-level tool. Each specialist receives a narrower prompt and only relevant tools.

## Why the single-agent design becomes difficult

```mermaid
flowchart TD
    A["More tools on one agent"] --> B["Longer tool descriptions"]
    A --> C["More routing choices"]
    B --> D["Larger system prompt"]
    D --> E["Higher token cost"]
    D --> F["Less context for useful work"]
    C --> G["More tool confusion"]
    G --> H["Harder testing and control"]
    E --> I["Production risk"]
    F --> I
    H --> I
```

| Design concern | One agent with many tools | Supervisor with specialists |
|---|---|---|
| Prompt scope | Broad and increasingly complex | Narrow per specialist |
| Tool selection | Many unrelated choices | Few domain-relevant choices |
| Deployment | Coupled | Can be independent |
| Scaling | Scale the whole agent | Scale high-traffic agents |
| Request latency | Often fewer handoffs | More model and network calls |
| Operational maturity | Simpler topology | More experimental and complex |

> **Mental model:** Treat the supervisor like a company reception desk. It understands which department owns a request, while each department knows its own procedures and tools. Adding departments improves specialization, but every handoff adds coordination time.

## Separation of concerns

Specialists can evolve similarly to microservices. A change in the Sales agent should not directly alter the HR agent, and traffic-heavy services can receive more resources.

```mermaid
flowchart TB
    S["Supervisor contract"]
    S --> A["Sales service"]
    S --> B["HR service"]
    S --> C["Procurement service"]
    A --> A1["Sales prompt and tools"]
    B --> B1["HR prompt and tools"]
    C --> C1["Procurement prompt and tools"]
    A --> AS["Scale independently"]
    B --> BS["Deploy independently"]
    C --> CS["Add or remove independently"]
```

## Architecture decision path

Multi-agent is an option, not a default. The lecture stresses latency, behavioral complexity, and limited production maturity, especially in the current Thai adoption context.

```mermaid
flowchart TD
    A["Start with function calling"] --> B["Build one agent"]
    B --> C["Are tools numerous and unrelated?"]
    C -->|No| D["Keep the single agent"]
    C -->|Yes| E["Can domains be separated clearly?"]
    E -->|No| F["Improve prompts or use deterministic routing"]
    E -->|Yes| G["Prototype supervisor and specialists"]
    G --> H["Measure latency, cost, accuracy, and control"]
    H --> I["Production evidence strong enough?"]
    I -->|Yes| J["Adopt with monitoring"]
    I -->|No| K["Keep experimenting"]
```

Frameworks such as LangChain, LangGraph, LlamaIndex, CrewAI, and Agent Development Kits can help with prototypes. Learning should progress from provider function calling to a single agent, then to small multi-agent exercises.

## Visual learning path

1. Begin with the single-agent pressure points: prompt size and tool-selection difficulty.
2. Group tools into meaningful business domains.
3. Place a supervisor above the specialist agents.
4. Compare modularity and independent scaling against added handoff latency.
5. Decide from evidence whether multi-agent or deterministic routing is safer for production.

## Check your understanding

1. Why does a large tool list consume context even before a tool is called?
2. What knowledge belongs in the supervisor versus a specialist?
3. How does separation of concerns help deployment and scaling?
4. Why can a multi-agent response be slower?
5. What should a learner master before treating multi-agent architecture as a production option?
