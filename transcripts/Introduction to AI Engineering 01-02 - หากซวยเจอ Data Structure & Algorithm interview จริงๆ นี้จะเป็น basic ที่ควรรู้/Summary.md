# Introduction to AI Engineering: Data Structures and Algorithms Interview Basics

**Format:** Thai-language conceptual lecture with English data structure, algorithm, and complexity terminology  
**Source:** `transcript.txt` from `Introduction to AI Engineering 01-02 - หากซวยเจอ Data Structure & Algorithm interview จริงๆ นี้จะเป็น basic ที่ควรรู้`

## Overview

This lesson gives a practical map of Data Structures and Algorithms for learners who may encounter a coding interview. The Thai framing, "หากซวยเจอ Data Structure & Algorithm interview จริงๆ นี้จะเป็น basic ที่ควรรู้", is intentionally pragmatic: learners do not need mastery of every topic, but should recognize the common structures, understand why access patterns matter, and know the major algorithm families worth practicing.

The instructor gives two reasons to study the subject:

- Software engineering interviews may test it.
- Familiarity with these patterns helps developers write faster code and reason about optimization in large-scale systems.

## 1. Data Structures and Algorithms

A **data structure** is a way to store information so it can be accessed and manipulated effectively. An **algorithm** is a step-by-step method for solving a problem.

In an interview, the two ideas work together:

1. Choose an appropriate way to represent the data.
2. Apply a procedure that solves the problem.
3. Evaluate how much time and space the solution needs.
4. Improve the solution when a better access pattern or algorithm is available.

The objective is usually to minimize both **time complexity** and **space complexity**, while still producing correct and understandable code.

## 2. Common Data Structures

The instructor identifies lists or arrays, stacks, queues, and dictionaries as especially common in Thai coding interviews. Linked lists, trees, and graphs may also appear, depending on the company.

### List or Array

A list or array stores an ordered collection of elements. Typical work includes appending elements, accessing them, and looping through the collection. Searching an unsorted list may require checking elements one by one.

### Linked List

A linked list stores values in nodes. Each node uses a pointer or reference to connect to the next node. This differs from treating the collection as one directly indexed array.

### Stack

A stack follows **Last In, First Out**, or LIFO. The lesson uses a pile of books as the analogy: the last book placed on top is the first one removed. In Python, a list and operations such as `pop` can model this behavior.

### Queue

A queue follows **First In, First Out**, or FIFO. The analogy is a line of customers buying burgers: the person who enters the line first is served and leaves first, while new arrivals join the back.

### Dictionary or Hash Table

A dictionary stores **key-value pairs**. Instead of scanning every value, code can retrieve a value through its key. This gives very fast lookup behavior in the typical complexity model discussed in the lesson.

### Binary Tree

A binary tree organizes data into connected nodes. For ordered values, each comparison can direct a search toward one side of the tree. The example contrasts checking values sequentially with using comparisons to reach a target such as 15 in fewer steps.

### Graph

A graph represents connected nodes. The lesson introduces it as another structure that can appear in interviews and later connects tree or graph traversal to Depth-First Search and Breadth-First Search.

## 3. Time and Space Complexity

**Time complexity** describes how runtime grows as input size `n` grows. **Space complexity** describes how much storage is required as the input grows. The discussion focuses on worst-case reasoning.

Important complexity patterns in the lesson include:

- `O(1)`: constant-time access, illustrated by retrieving a dictionary value through a key.
- `O(log n)`: growth that results from repeatedly reducing the search area, illustrated by binary search and ordered tree search.
- `O(n)`: linear growth, illustrated by scanning a collection from beginning to end.
- `O(n log n)`: the complexity associated with efficient sorting and Python's built-in sorting behavior in the lecture.
- `O(n^2)`: quadratic growth, illustrated by Bubble Sort.

Big O is not a stopwatch measurement. It is a way to compare how solutions scale as the amount of data approaches a very large size.

## 4. Searching with Binary Search

Binary search assumes the collection is already sorted.

The process is:

1. Inspect the middle value.
2. Compare the target with that value.
3. Discard the half that cannot contain the target.
4. Repeat on the remaining half.

The lesson contrasts a sequential scan through 16 values with repeatedly halving the search space. The halving strategy needs far fewer checks and is described as `O(log n)`.

## 5. Sorting Algorithms

Sorting transforms an unordered collection, such as `3, 1, 2, 4`, into ordered data.

The instructor highlights:

- **Bubble Sort:** easy to implement, but has `O(n^2)` time complexity.
- **Merge Sort and other efficient sorts:** generally faster, but require more implementation effort.
- **Python built-in sorting:** already available and implemented efficiently, so production code does not normally need a hand-written sorting algorithm.

The educational value of implementing sorting yourself is to understand the mechanics and complexity tradeoffs, not to replace a reliable built-in function.

## 6. Recursion and Dynamic Programming

**Recursion** occurs when a function calls itself. A factorial function is used as the example: the function reduces the problem and invokes itself again. A valid recursive solution also needs a stopping condition, even though the lecture focuses mainly on recognizing the self-call pattern.

**Dynamic Programming** is presented as a step beyond basic recursion. The example is the **Coin Change** problem:

- Available coin values are `1`, `2`, and `5`.
- The target amount is `11`.
- The goal is to use the minimum number of coins.
- The demonstrated minimum is three coins: `5 + 5 + 1`.

This type of problem asks the learner to combine smaller subproblems into an optimal result.

## 7. Depth-First Search and Breadth-First Search

### Depth-First Search

Depth-First Search, or DFS, follows one branch as deeply as possible before returning and exploring another branch. The instructor describes it as "ไปลึกก่อน", or going deep first.

### Breadth-First Search

Breadth-First Search, or BFS, explores nodes level by level. It first covers the nearby width of the structure, then proceeds to the next level. The Thai explanation emphasizes "เชิงกว้างก่อน", or going broad first.

## Practical Study Exercises

1. Implement a stack with a Python list and `pop`.
2. Model a FIFO queue and compare its removal order with a stack.
3. Store names and values in a dictionary, then retrieve a value by key.
4. Implement binary search on a sorted list.
5. Implement Bubble Sort, record its nested comparisons, and compare it with Python's built-in sorting.
6. Write a recursive factorial function with a clear stopping condition.
7. Solve the Coin Change example for coins `1`, `2`, and `5` with target `11`.
8. Traverse the same small tree using both DFS and BFS, then compare the visitation order.
9. Practice these patterns with coding exercises such as LeetCode problems.

## Takeaways and Action Items

- Learn the commonly tested structures first: arrays or lists, stacks, queues, and dictionaries.
- Add linked lists, trees, and graphs according to the interviews you expect.
- Always connect a data structure choice to its access and storage costs.
- Know the difference among `O(1)`, `O(log n)`, `O(n)`, `O(n log n)`, and `O(n^2)`.
- Use binary search only when its sorted-data assumption is satisfied.
- Understand classic algorithms even when a language provides efficient built-ins.
- Practice recursion, Coin Change, DFS, and BFS as recognizable interview patterns.
- Aim for useful fundamentals rather than trying to master every possible algorithm at once.

