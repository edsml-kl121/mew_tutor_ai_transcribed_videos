# Introduction to AI Engineering 04.9: What Is a Multi-Agent System?

**Format:** Thai-language lecture with English technical terminology  
**Source:** `introduction_to_ai_engineering_049_-_what_is_a_multi_agent_system_v1 (360p).mp4`

## Overview

This session explains why a **multi-agent system** can be preferable to one large AI agent with many tools. The instructor reviews the structure of an AI agent, identifies the control and token-cost problems that appear as tool counts grow, and presents a supervisor with specialized sub-agents as a possible solution.

The lecture also covers benefits, production concerns, and practical technologies for beginning multi-agent development. The Thai market context is explicit: multi-agent systems are still largely experimental, and adoption in real production systems in Thailand remains limited.

## 1. Recap: What Is an AI Agent?

An AI agent is described as a system backed by a Large Language Model such as ChatGPT, Claude, or Gemini. The model is given:

- Tools, such as sending email or performing web search
- Conversation history
- A user request

The agent decides which tool to call and uses it to accomplish the task. For example, when asked to send an email, it can select a `send_email` tool and execute the action.

This approach works well with a small number of tools. The difficulty increases when a single agent receives 10 or more tools.

## 2. Problems with One Agent and Many Tools

The instructor highlights two major problems.

### Control and Prompt Complexity

Every tool needs a clear description, and the system prompt must explain when and how the agent should use each tool. As the number of tools increases:

- Prompt design becomes harder.
- The agent can confuse tools or choose incorrectly.
- Behavior becomes less controllable.
- Testing and production readiness become more difficult.

### Context Window and Token Cost

Long system prompts and many tool descriptions consume more tokens. This can:

- Increase inference cost.
- Use a larger portion of the context window.
- Reduce the room available for user input and useful working context.
- Increase the chance that the model cannot respond effectively.

These issues can make a single agent with many tools impractical for production.

## 3. Multi-Agent Architecture

Instead of assigning every tool to one agent, the system can introduce a main agent that routes work to specialized sub-agents.

An example organization is:

- Main or supervisor agent
  - Sales agent
  - HR agent
  - Procurement agent

Each specialized agent receives only the tools and instructions relevant to its domain. The supervisor does not need to understand every low-level tool. It only needs to decide which domain agent should handle the request.

This reduces the agent-to-tool ratio and makes each prompt easier to design. It also reduces the risk of overwhelming one agent with unrelated responsibilities.

## 4. Benefits of Multi-Agent Systems

### Separation of Concerns

Agents can be developed as independent services. Changes to a Sales agent should not directly affect an HR agent, similar to independently maintained microservices.

This modularity also makes it easier to:

- Add a new agent.
- Remove an existing agent.
- Deploy agents separately.
- Assign different teams to different domains.

### Role Specialization

Each agent focuses on one business area and receives only the tools it needs. A specialized agent can be prompted and evaluated for a narrower task instead of being expected to perform many unrelated functions.

### Scalability and Flexibility

Agents can be hosted and scaled independently. For example, if the Sales agent receives substantially more traffic, its service can receive more CPU or RAM without scaling every other agent equally.

Independent deployment also allows the architecture to evolve by plugging agents in or out with less impact on the overall ecosystem.

## 5. Limitations and Production Concerns

### Latency

A multi-agent request may involve several API calls across different services or cloud regions. Each handoff adds network and model latency, so the complete response can be slower than a single-agent response.

### Experimental Maturity

The instructor characterizes current multi-agent development as experimental. Organizations are exploring it, but proven production adoption is still uncertain.

This concern is especially relevant in Thailand, where many teams are still experimenting rather than deploying multi-agent systems at scale. A single AI agent is already difficult to control. Connecting several agents increases the operational and behavioral complexity.

For many production projects, a more deterministic workflow may still be easier to control and deliver successfully.

## 6. How to Start Learning

The suggested progression is:

1. Learn direct function calling from providers such as Google or OpenAI.
2. Build and understand a single AI agent.
3. Experiment with agent frameworks such as:
   - LangChain
   - LangGraph
   - LlamaIndex
   - CrewAI
4. Explore Agent Development Kits that support coded agent and multi-agent construction.

The instructor mentions Google and IBM as visible providers of Agent Development Kit style tooling at the time of the lecture.

Because the technology remains experimental, the recommendation is to learn through frameworks and small exercises before treating multi-agent architecture as a default production choice.

## Takeaways / Action Items

- Do not keep adding tools to a single agent without considering prompt size, cost, and tool-selection accuracy.
- Split agents by meaningful business domains when specialization and independent deployment provide clear value.
- Keep the supervisor focused on routing rather than giving it every low-level tool.
- Evaluate latency and operational complexity before selecting a multi-agent design.
- Recognize that multi-agent systems are promising but not automatically production-ready.
- Begin with function calling and single-agent development, then experiment with LangChain, LangGraph, LlamaIndex, CrewAI, or an Agent Development Kit.
- In Thai production contexts, compare multi-agent architecture with more deterministic routing before committing to implementation.
