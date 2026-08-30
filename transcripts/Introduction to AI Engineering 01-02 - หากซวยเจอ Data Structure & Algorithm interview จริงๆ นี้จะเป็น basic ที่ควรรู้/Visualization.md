# Data Structures and Algorithms: The Interview Basics Map

**Visual goal:** Connect data representation, algorithm choice, and complexity before practicing individual coding problems.

[Read the detailed summary](./Summary.md)

## Big picture

```mermaid
flowchart TD
    P["Coding problem"] --> Q["Understand the required operations"]
    Q --> D["Choose a data structure"]
    D --> A["Choose an algorithm"]
    A --> C["Analyze time complexity"]
    A --> S["Analyze space complexity"]
    C --> O["Optimize when needed"]
    S --> O
    O --> R["Correct and scalable solution"]
    D --> D1["List, stack, queue, dictionary"]
    D --> D2["Linked list, tree, graph"]
    A --> A1["Search and sort"]
    A --> A2["Recursion and dynamic programming"]
    A --> A3["DFS and BFS"]
```

### Visual learning path

1. Learn what each structure stores and which operations it makes natural.
2. Read Big O as growth in work or memory, not as an exact runtime.
3. Compare linear search with binary search.
4. Compare simple sorting with more efficient sorting.
5. Recognize recursive and dynamic programming problem shapes.
6. Compare deep-first and level-first traversal.
7. Practice selecting the structure and algorithm together.

## 1. Data structure behavior map

```mermaid
flowchart LR
    I["Incoming data"] --> L["List or array"]
    I --> S["Stack"]
    I --> Q["Queue"]
    I --> H["Dictionary or hash table"]
    I --> T["Tree"]
    I --> G["Graph"]
    L --> L1["Ordered collection and iteration"]
    S --> S1["Last In, First Out"]
    Q --> Q1["First In, First Out"]
    H --> H1["Key-value lookup"]
    T --> T1["Hierarchical comparison and traversal"]
    G --> G1["Connected-node traversal"]
```

| Structure or method | Core mental picture | Typical operation highlighted | Complexity idea from the lesson |
|---|---|---|---|
| List or array | Ordered row of elements | Loop or search through values | A full scan is `O(n)` |
| Linked list | Nodes connected by pointers | Follow links from node to node | Search commonly requires traversal |
| Stack | Pile of books | Remove the latest item | LIFO |
| Queue | Customer line | Serve the earliest item | FIFO |
| Dictionary | Key-value index | Retrieve by key | Typical lookup discussed as `O(1)` |
| Ordered binary tree | Repeated left or right choice | Narrow the search path | Search can follow `O(log n)` behavior |
| Graph | Network of connected nodes | Explore connections | Use traversal strategies such as DFS or BFS |

## 2. Complexity growth map

```mermaid
flowchart TD
    N["Input size n grows"] --> C1["O(1): work stays constant"]
    N --> C2["O(log n): repeatedly reduce the problem"]
    N --> C3["O(n): inspect elements linearly"]
    N --> C4["O(n log n): efficient sorting pattern"]
    N --> C5["O(n squared): nested growth"]
    C1 --> E1["Dictionary key lookup"]
    C2 --> E2["Binary search"]
    C3 --> E3["Sequential scan"]
    C4 --> E4["Efficient built-in sorting"]
    C5 --> E5["Bubble Sort"]
```

Time complexity asks how work grows. Space complexity asks how storage grows. Both should be considered in the worst-case scenario discussed by the instructor.

## 3. Binary search decision flow

```mermaid
flowchart TD
    A["Need to find a target"] --> B{"Is the collection sorted?"}
    B -->|No| C["Binary search assumption is not met"]
    B -->|Yes| D["Inspect the middle value"]
    D --> E{"Target equals middle?"}
    E -->|Yes| F["Return the match"]
    E -->|No| G{"Target is smaller?"}
    G -->|Yes| H["Keep the left half"]
    G -->|No| I["Keep the right half"]
    H --> J["Repeat on the remaining half"]
    I --> J
    J --> D
```

## 4. DFS and BFS traversal contrast

```mermaid
flowchart LR
    A["Start node"] --> B["Choose traversal"]
    B --> D["Depth-First Search"]
    B --> F["Breadth-First Search"]
    D --> D1["Follow one branch deeply"]
    D1 --> D2["Backtrack"]
    D2 --> D3["Explore another branch"]
    F --> F1["Visit nearby nodes"]
    F1 --> F2["Complete the current level"]
    F2 --> F3["Move to the next level"]
```

| Question | DFS | BFS |
|---|---|---|
| First movement | Down one branch | Across the current level |
| Thai memory cue | `ไปลึกก่อน` | `เชิงกว้างก่อน` |
| Revisit behavior | Backtrack after reaching depth | Continue level by level |
| Shared purpose | Explore connected nodes | Explore connected nodes |

## 5. From recursion to dynamic programming

```mermaid
flowchart TD
    A["Large problem"] --> B["Express smaller subproblems"]
    B --> C["Recursive self-call"]
    C --> D{"Stopping condition reached?"}
    D -->|No| B
    D -->|Yes| E["Return and combine results"]
    B --> F["Repeated or overlapping subproblems"]
    F --> G["Dynamic Programming approach"]
    G --> H["Build an optimal result"]
    H --> I["Coin Change: minimum coins for target 11"]
```

> **Mental model:** A data structure is the shape of your storage, an algorithm is the route through that shape, and Big O tells you how the journey grows when the data becomes large.

## Check your understanding

1. Why can a dictionary lookup avoid the full scan required by a list search?
2. What assumption must hold before binary search can repeatedly discard half of the data?
3. Why is Bubble Sort useful to learn even though Python already provides efficient sorting?
4. How does `ไปลึกก่อน` distinguish DFS from BFS?
5. In the Coin Change example, what is being minimized?

