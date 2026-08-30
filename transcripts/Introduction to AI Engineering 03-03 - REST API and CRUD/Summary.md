# Introduction to AI Engineering: REST APIs and CRUD

**Format:** Thai-language lecture and FastAPI coding demonstration with English API, HTTP, SQL, and database terminology  
**Source:** `transcript.txt` from `Introduction to AI Engineering 03-03 - REST API and CRUD`

## Overview

This lesson connects REST API request methods to CRUD operations and demonstrates the full lifecycle with a FastAPI backend and a database. The learner starts the application, sends requests with `curl`, inspects the corresponding route code, and observes how SQL changes the stored items.

The central mapping is:

- **Create** with `POST`
- **Read** with `GET`
- **Update** with `PUT`
- **Delete** with `DELETE`

The instructor uses an Airbnb or Booking.com analogy throughout: viewing hotels or bookings, creating a booking, changing its details, and cancelling it.

## 1. API Request Anatomy Review

An API lets a client send a request to a server. The server processes that request and returns a response. The lecture recalls a ChatGPT-style example in which a message is sent to a service and the generated answer is returned.

Important request parts include:

- **URL path or endpoint:** identifies the operation or resource, such as an item route.
- **Headers:** carry metadata, including an API key or secret used for authentication.
- **Body:** carries submitted data, such as a user query, item name, or description.

The HTTP method adds another part of the request's meaning by indicating whether the client wants to read, create, update, or delete data.

## 2. CRUD Through a Booking Analogy

### Read with `GET`

`GET` retrieves data without creating a new record. In the booking analogy, it can list all available hotels, list existing bookings, or retrieve one booking by its ID.

### Create with `POST`

`POST` submits data to create a new resource. Booking a hotel sends the new booking information to the server, stores it in the database, and returns a success result.

### Update with `PUT`

`PUT` changes an existing resource. For example, a traveler who booked one date can update the booking to another date. The demo uses an item ID in the URL and replacement values in the request data.

### Delete with `DELETE`

`DELETE` removes an existing resource. In the analogy, this is cancelling a booking. At the database level, the selected row is deleted.

## 3. Prepare and Run the FastAPI Backend

The backend is written with FastAPI. The instructor navigates to the CRUD exercise stage, creates or activates a Python environment, and installs the packages in `requirements.txt`.

The application is then started with Uvicorn on port 5000:

```bash
uvicorn app:app --reload --port 5000
```

A second Terminal window is used to send requests while the server keeps running in the first one. The request examples are copied from the exercise README and sent with `curl`.

## 4. Database Initialization

The application contains database initialization logic. It creates or opens the database file and populates initial data when the expected data is not already present.

The demo database stores items with fields including:

- Item ID
- Name
- Description

This initial data makes it possible to call the read endpoints before creating new items.

## 5. Read Operations

### Get all items

The FastAPI route for the item collection uses a `GET` operation. Its database logic runs a query equivalent to:

```sql
SELECT * FROM item
```

The rows are returned to the client as dictionary-like data.

### Get one item

A second `GET` route accepts an item ID in the URL path. Requesting an ID such as `2` returns the matching item rather than the full collection.

This demonstrates the distinction between:

- A collection endpoint that returns all items.
- A resource endpoint that identifies one item by ID.

## 6. Create an Item with `POST`

The `POST` demonstration sends a name and description. The instructor changes the example to a hotel context, creating an item named `Grand Hyatt` with a hotel description.

The server:

1. Receives the submitted name and description.
2. Executes an SQL `INSERT` operation.
3. Commits the transaction to save the data.
4. Returns a success response containing the created item information.

The created record receives item ID `7` in the demonstrated run. A later `GET` confirms that the new item is present.

## 7. Update an Item with `PUT`

The update request identifies item `7` in the URL and supplies changed details, including a revised `Grand Hyatt` name and description.

The server:

1. Finds the item for the provided ID.
2. Reads the replacement values from the request.
3. Executes an SQL `UPDATE`.
4. Commits the change.
5. Returns a success response.

Retrieving the items again confirms that item `7` now contains the new details.

## 8. Delete an Item with `DELETE`

The delete request targets item `7`.

The server:

1. Selects the item identified by the URL.
2. Executes an SQL `DELETE`.
3. Commits the transaction.
4. Returns confirmation that deletion succeeded.

A following read shows that item `7` is no longer in the database. The instructor emphasizes that deletion removes the corresponding database row.

## 9. `curl` and Postman

The demonstration uses `curl` from Terminal, but Postman is offered as a graphical alternative. Both can send `GET`, `POST`, `PUT`, and `DELETE` requests. The difference is mainly interaction style:

- `curl` expresses the request as a command.
- Postman lets the learner configure and send it through an application interface.

## Practical Exercise Flow

1. Enter the CRUD exercise directory.
2. Create and activate a Python environment.
3. Install `requirements.txt`.
4. Start FastAPI with Uvicorn on port 5000.
5. Keep the server running and open a second Terminal.
6. Send the README's `GET` request for all items.
7. Send a `GET` request for one item ID.
8. Send a `POST` request that creates an item.
9. Run `GET` again to verify creation.
10. Send a `PUT` request for that item's ID.
11. Run `GET` again to verify the update.
12. Send a `DELETE` request for that ID.
13. Run `GET` once more to verify deletion.
14. Trace each request from the FastAPI route to its SQL statement and returned response.

## Takeaways and Action Items

- Treat REST methods as explicit intentions applied to resources.
- Remember the CRUD mapping: `POST`, `GET`, `PUT`, and `DELETE`.
- Use collection routes for groups of items and ID-based routes for individual items.
- Understand how URL paths, headers, bodies, and methods combine to define a request.
- Commit database writes after `INSERT`, `UPDATE`, and `DELETE`.
- Verify every write operation with a later read.
- Use either `curl` or Postman to practice requests, but learn to inspect the backend route and SQL as well as the client response.

