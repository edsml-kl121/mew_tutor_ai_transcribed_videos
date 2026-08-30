# REST APIs and CRUD: Request to Database and Back

**Visual goal:** See how HTTP methods, FastAPI routes, and SQL operations form one complete resource lifecycle.

[Read the detailed summary](./Summary.md)

## Big picture

```mermaid
flowchart LR
    C["Client using curl or Postman"] --> R["HTTP request"]
    R --> F["FastAPI route"]
    F --> S["SQL operation"]
    S --> D["Database"]
    D --> S
    S --> F
    F --> P["HTTP response"]
    P --> C
    R --> M["Method: GET, POST, PUT, or DELETE"]
    R --> U["URL path and item ID"]
    R --> H["Headers and authentication data"]
    R --> B["Request body"]
```

### Visual learning path

1. Review the parts of an API request.
2. Map each CRUD intention to its HTTP method.
3. Start the FastAPI server and keep it running.
4. Send requests from a second Terminal with `curl`.
5. Trace each route into its SQL operation.
6. Verify creates, updates, and deletes by reading the data again.
7. Repeat the same lifecycle with Postman if a graphical client is preferred.

## 1. CRUD mapping

```mermaid
flowchart TD
    A["Work with a resource"] --> B{"What should happen?"}
    B -->|Create a new item| C["POST"]
    B -->|Read items| D["GET"]
    B -->|Change an existing item| E["PUT"]
    B -->|Remove an item| F["DELETE"]
    C --> C1["SQL INSERT and commit"]
    D --> D1["SQL SELECT"]
    E --> E1["SQL UPDATE and commit"]
    F --> F1["SQL DELETE and commit"]
```

| User intention | Booking analogy | HTTP method | Database operation | Expected result |
|---|---|---|---|---|
| View hotels or bookings | Browse all or one booking | `GET` | `SELECT` | Existing data is returned |
| Make a booking | Create a new reservation | `POST` | `INSERT` | A new row and ID are created |
| Change booking details | Move to a different date | `PUT` | `UPDATE` | The selected row changes |
| Cancel a booking | Remove the reservation | `DELETE` | `DELETE` | The selected row disappears |

## 2. Collection route and item route

```mermaid
flowchart TD
    A["Client wants data"] --> B{"All items or one item?"}
    B -->|All items| C["GET item collection route"]
    C --> D["SELECT all rows from item"]
    D --> E["Return a list of item dictionaries"]
    B -->|One item| F["GET route with item ID"]
    F --> G["Find the matching ID"]
    G --> H["Return one item"]
```

The URL path tells FastAPI which resource is targeted. Adding an item ID narrows the request from the collection to one resource.

## 3. Create, verify, update, verify, delete, verify

```mermaid
flowchart LR
    A["POST Grand Hyatt"] --> B["Item 7 created"]
    B --> C["GET items"]
    C --> D["Confirm item 7 exists"]
    D --> E["PUT item 7"]
    E --> F["Details changed"]
    F --> G["GET items"]
    G --> H["Confirm new details"]
    H --> I["DELETE item 7"]
    I --> J["Row removed"]
    J --> K["GET items"]
    K --> L["Confirm item 7 is absent"]
```

This verification loop is important. A success response is useful, but a subsequent read demonstrates the resulting database state.

## 4. Runtime workflow

```mermaid
flowchart TD
    A["Enter the CRUD exercise directory"] --> B["Create and activate environment"]
    B --> C["Install requirements.txt"]
    C --> D["Start Uvicorn on port 5000"]
    D --> E["Keep server Terminal running"]
    E --> F["Open a second Terminal"]
    F --> G["Copy curl commands from README"]
    G --> H["Observe response"]
    H --> I["Inspect FastAPI route and SQL"]
    I --> G
```

Server command shown in the lesson:

```bash
uvicorn app:app --reload --port 5000
```

## 5. Request tool comparison

| Concern | `curl` | Postman |
|---|---|---|
| Interface | Terminal command | Graphical application |
| Request method | Written in command options | Selected in the interface |
| URL, headers, and body | Encoded in the command | Entered in separate fields |
| Repeating an example | Re-run or edit the command | Save and resend the request |
| Lesson preference | Used in the demonstration | Offered as an alternative |

> **Mental model:** An HTTP method is a verb, the URL is the noun, FastAPI is the dispatcher, SQL performs the storage action, and the response reports what happened.

## Check your understanding

1. Which HTTP method and SQL operation create a new item?
2. How does an item collection route differ from a route containing an item ID?
3. Why should database writes be committed?
4. Why does the exercise run a `GET` after each create, update, or delete?
5. Which request parts can carry the endpoint, authentication information, and submitted item details?

