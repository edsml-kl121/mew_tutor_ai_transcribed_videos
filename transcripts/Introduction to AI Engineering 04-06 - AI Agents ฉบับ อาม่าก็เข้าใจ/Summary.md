# Introduction to AI Engineering 04.06: AI Agents Explained Simply

**Format:** Thai-language conceptual lecture with English engineering terminology  
**Source:** `transcript.txt` in this lesson directory  
**Thai lesson title:** `AI Agents ฉบับ อาม่าก็เข้าใจ`

## Overview

This lesson explains an **AI Agent** through a familiar goal: booking a flight to Japan. The key engineering question is not whether AI can use tools, but who controls the workflow.

- In a **Programmatic Workflow**, a developer defines the steps and rules.
- In an **Agentic Workflow**, an LLM receives a goal and tools, then decides what to do and in what order.

The instructor compares the speed, development effort, adaptability, cost, predictability, and reasoning requirements of both approaches. The practical recommendation is conservative: prefer programmatic control for most real production work today, and use an agentic workflow only when the task genuinely benefits from autonomy and has acceptable risk.

## 1. The Example Goal: Book a Flight to Japan

The lecture starts with a frequently used AI Agent example:

```text
Book a flight ticket to Japan around 10 November.
```

Completing this goal can require several capabilities:

- **Web search** to find airlines or booking options
- **Image Understanding** to interpret a website screen
- **Clicking** and **scrolling** to navigate
- **Typing** to enter dates and other details
- **Clarification** to ask the human which option is acceptable

A possible task sequence is:

1. Extract useful keywords from the request.
2. Search for flights to Japan.
3. Open a relevant airline or booking link.
4. Understand the page layout.
5. Select dates and other filters.
6. Run the search.
7. Present options for human selection.
8. Click and type the remaining information to finish the transaction.

The tools alone do not define an agent. The central issue is how the system chooses and orders these actions.

## 2. Programmatic Workflow

In a programmatic design, a developer writes the control flow:

```text
extract keywords
then search
then open a link
then inspect the page
then select dates
then ask for clarification
then complete the transaction
```

The implementation may use rules, `if/else` conditions, loops, and site-specific steps.

### Strengths

- Execution is fast after the workflow is built.
- Behavior is explainable because people designed the flow.
- The steps are predictable and easier to test.
- Developers can control risky actions and approval points.

### Limitations

- **Time to develop control flow is long**, especially for complex tasks.
- Different websites can have different layouts and interaction patterns.
- Many variations require additional custom rules.
- A rigid flow may fail when the environment changes in an unexpected way.

Programmatic control works especially well when the process and environment are stable enough to describe explicitly.

## 3. Agentic Workflow

In the agentic approach, the system provides the LLM with two main things:

1. A **goal**
2. A set of **tools**

The developer does not prescribe every step from beginning to end. The LLM plans how to use the tools, observes results, and decides what to do next.

Conceptually:

```text
Goal + Tools -> LLM Agent -> planned tool calls -> result
```

This makes the workflow more **autonomous**. It can potentially interact with and adapt to environments that are too variable for a simple fixed script.

### Strengths

- Less developer effort may be needed to encode a long control flow.
- The agent can select steps based on the current environment.
- It can address complex tasks whose exact sequence is not known in advance.
- It may adapt when websites or intermediate results differ.

### Limitations

- **Time to think is very long** compared with fixed code.
- Planning and reasoning generate more tokens.
- More tokens make the workflow more **costly**.
- AI decides the control flow, so errors in reasoning can produce wrong actions.
- The result is harder to predict, explain, test, and control.

The instructor notes that a model needs strong reasoning to perform this role well. Models or research directions mentioned include **O1** and **DeepSeek R1**, while a less reasoning-focused model may not produce a dependable agentic workflow.

## 4. Why Reasoning Quality Matters

An agentic workflow is useful only if the model can plan correctly. A mistake is not limited to a bad text response. It can affect:

- Which tool is selected
- Which argument is passed
- Which website element is clicked
- Whether sufficient information has been gathered
- Whether a transaction proceeds incorrectly

This is why autonomy increases engineering risk. Better reasoning can reduce errors, but the lecture does not treat current agent behavior as proven or fully reliable.

## 5. Agent Frameworks

Frameworks help bridge the gap between giving an LLM a goal and tools, and obtaining a working agent loop. The lesson mentions:

- **LlamaIndex**
- **CrewAI**
- **LangChain**
- Cloud **Agent Builder** offerings

These frameworks can provide the mechanics for tool registration, planning, calling tools, and continuing until the goal is addressed. The recommendation is to use an existing framework rather than building all agent infrastructure from scratch, while still customizing it when necessary.

## 6. Engineering Decision: Programmatic or Agentic?

The choice depends on the task.

| Consideration | Programmatic Workflow | Agentic Workflow |
|---|---|---|
| Control flow owner | Developer | LLM |
| Runtime speed | Usually faster | Slower because the model plans |
| Development effort | Higher for complex flows | Potentially lower for flexible flows |
| Predictability | High | Lower |
| Environment variation | Requires explicit handling | Can potentially adapt |
| Token cost | Lower | Higher |
| Testing | More straightforward | Harder because behavior varies |
| Reasoning dependency | Low | High |
| Production risk | Easier to constrain | Greater when actions matter |

The instructor's current personal rule of thumb is approximately:

- **99 percent programmatic** for real-world implementation
- **1 percent agentic** for suitable, lower-risk problems

This is not presented as a permanent universal formula. It reflects the instructor's view that agentic systems are still closer to an evolving science than a proven default.

## Practical Exercise

Use the flight-booking example to compare the two designs:

1. List all tools the system would need.
2. Write a fixed programmatic sequence with explicit human approval.
3. Rewrite the design as `Goal + Tools` for an agent.
4. Identify which steps could cause financial or operational harm.
5. Decide which steps must remain deterministic.
6. Estimate how many LLM planning calls the agentic version might require.
7. Explain whether environmental variation justifies the added cost and risk.

## Takeaways / Action Items

- Define an AI Agent as a system that autonomously chooses actions and tools to pursue a goal.
- Separate the idea of having tools from the question of who controls the workflow.
- Prefer programmatic workflows when predictability, speed, testing, and safety are primary.
- Consider agentic workflows when the task is genuinely complex, variable, and difficult to encode.
- Require strong reasoning models for workflows in which AI controls the next action.
- Expect agentic systems to use more time, tokens, and money.
- Keep a human clarification or approval step before consequential transactions.
- Use established frameworks such as LlamaIndex, CrewAI, LangChain, or cloud Agent Builders instead of rebuilding common agent mechanics.
- Treat current agentic systems as an engineering tradeoff, not an automatic upgrade.
