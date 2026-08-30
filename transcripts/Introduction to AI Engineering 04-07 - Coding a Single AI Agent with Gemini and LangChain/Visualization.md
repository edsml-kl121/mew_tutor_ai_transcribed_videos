# Coding a Single AI Agent with Gemini and LangChain

**Visual goal:** Follow a user request from chat input through Gemini planning, LangChain tool execution, conversation memory, and the final application response.

[Read the detailed summary](./Summary.md)

## Single-agent anatomy

```mermaid
flowchart LR
    U["User request"] --> A["Single AI Agent"]
    H["Conversation history"] --> A
    P["System prompt"] --> A
    A --> M["Gemini model"]
    M --> T{"Select a tool?"}
    T -->|Yes| F["Call function with arguments"]
    F --> O["Tool observation"]
    O --> M
    T -->|No| R["Final response"]
```

The model does not execute business logic by itself. It selects a registered function, supplies arguments, observes the result, and then responds.

## Meeting function-calling sequence

```mermaid
sequenceDiagram
    participant U as User
    participant G as Gemini
    participant P as PythonApp
    participant T as ScheduleTool
    U->>G: Schedule Bob and Alice at 10 AM
    G-->>P: schedule_meeting plus arguments
    P->>T: Call attendees, date, time, topic
    T-->>P: Success result
    P->>G: Function response
    G-->>U: Meeting confirmation
```

## Multi-tool reasoning

```mermaid
flowchart TD
    Q["Find Alice email and schedule a meeting"] --> A["Agent reads request"]
    A --> C["Call get_contact"]
    C --> E["Receive Alice email"]
    E --> S["Call schedule_meeting"]
    S --> R["Return combined result"]

    P["Start the party"] --> D["Agent infers required effects"]
    D --> D1["Start music"]
    D --> D2["Change lights"]
    D --> D3["Activate disco ball"]
```

| Component | Main responsibility | Lesson example |
|---|---|---|
| User request | Express a goal in natural language | Schedule meeting or order apples |
| Model | Select tools and extract arguments | Gemini 2 Flash |
| Tool description | Explain when a function should be called | Search inventory or process order |
| System prompt | Define reasoning and behavior rules | Ask for missing order fields |
| Memory | Preserve earlier conversation | Remember customer ID and name |
| Tool implementation | Perform deterministic work | Mock contact, search, or order function |
| Framework | Connect model, tools, prompt, and memory | LangChain |

> **Mental model:** The LLM is a coordinator, not the business system. Prompts and descriptions tell it which door to choose, tools do the actual work behind each door, and memory carries facts from one turn to the next.

## Retail application architecture

```mermaid
flowchart LR
    U["Customer browser"] --> F["Streamlit frontend"]
    F -->|user_input and session_id| B["Flask chat endpoint"]
    B --> A["LangChain agent"]
    A --> G["Gemini 2 Flash"]
    A --> I["Inventory search tool"]
    A --> O["Order processing tool"]
    A <--> H["Session chat history"]
    I --> A
    O --> A
    A --> B
    B --> F
    F --> U
```

## Missing-information state flow

```mermaid
stateDiagram-v2
    [*] --> ReceiveOrder
    ReceiveOrder --> ValidateFields
    ValidateFields --> AskUser: Fields missing
    AskUser --> StoreInHistory
    StoreInHistory --> ValidateFields
    ValidateFields --> CallOrderTool: All fields present
    CallOrderTool --> ConfirmOrder
    ConfirmOrder --> [*]
```

## Direct API or LangChain?

```mermaid
flowchart TD
    A["Choose implementation layer"] --> B{"Need easy provider switching?"}
    B -->|Yes| L["Consider LangChain"]
    B -->|No| C{"Need built-in agent memory and patterns?"}
    C -->|Yes| L
    C -->|No| D["Consider direct Gemini API"]
    L --> E["Accept extra dependencies and abstraction"]
    D --> F["Accept more provider-specific code"]
    E --> G["Test tools, prompts, and memory"]
    F --> G
```

## Visual learning path

1. Begin with one function and inspect Gemini's selected name and arguments.
2. Register several tools and test both one-tool and multi-tool requests.
3. Understand how observations return to the model before its final answer.
4. Add LangChain when memory and model portability become useful.
5. Connect Streamlit, the `/chat` backend, session history, and retail tools.
6. Test missing fields before replacing mock functions with real systems.

## Check your understanding

1. Why are function descriptions and docstrings part of agent behavior?
2. What information must return to Gemini after Python calls a tool?
3. How does a session ID help the retail agent complete an order across messages?
4. What portability benefit does LangChain provide, and what complexity does it add?
5. Why should mock scheduling and ordering functions be tested before real integrations are enabled?
