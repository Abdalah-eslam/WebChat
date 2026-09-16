# WbChat 💬

> A real-time web chat application built with Java Servlets, JSP, MySQL, JWT authentication, and WebSocket.

WbChat is a full-stack Java web application focused on building a real-time chat experience using the Jakarta Servlet ecosystem. The project combines traditional server-side rendering with JSP, JDBC-based database access, cookie-based JWT authentication, and WebSocket communication for live messaging.

---

## ✨ Overview

WbChat allows users to create accounts, sign in securely, discover public conversations, join conversations, and communicate in real time.

The project was built to practice and connect the main concepts of Java Enterprise Web Development into one complete application rather than isolated examples.

### What WbChat supports

- User registration and login
- Password hashing with BCrypt
- JWT-based authentication
- JWT stored in a browser cookie
- Authentication Filter for protected resources
- Public conversations
- Conversation creation
- Conversation membership
- Member count display
- Real-time messaging using WebSocket
- Sending messages without refreshing the page
- Loading previous messages from MySQL
- Message editing
- Message deletion
- Sender information for messages
- Session-based user information
- Responsive dark UI
- Server-side request handling with Servlets and JSP

---

## 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| **Java** | Core application language |
| **Jakarta Servlets** | HTTP request/response handling |
| **JSP** | Server-side rendered UI |
| **JDBC** | Database communication |
| **MySQL** | Persistent data storage |
| **WebSocket** | Real-time communication |
| **JWT** | Authentication and identity claims |
| **BCrypt** | Password hashing and verification |
| **HTML5** | Page structure |
| **CSS3** | UI styling and responsive layout |
| **JavaScript** | Client-side interactions and WebSocket communication |
| **Apache Tomcat** | Java web application runtime |
| **Eclipse** | Development environment |

---

## 🧩 Architecture

The project follows a layered structure to keep responsibilities separated:

```text
                    ┌──────────────────────┐
                    │       Browser        │
                    │     JSP + JS + CSS   │
                    └──────────┬───────────┘
                               │
                  HTTP Request │ HTTP Response
                               │
                    ┌──────────▼───────────┐
                    │       Filters        │
                    │  Authentication     │
                    └──────────┬───────────┘
                               │
                    ┌──────────▼───────────┐
                    │      Servlets        │
                    │ Request Handling     │
                    └──────────┬───────────┘
                               │
                    ┌──────────▼───────────┐
                    │       Services       │
                    │   Business Logic     │
                    └──────────┬───────────┘
                               │
                    ┌──────────▼───────────┐
                    │         DAO          │
                    │     JDBC / SQL       │
                    └──────────┬───────────┘
                               │
                    ┌──────────▼───────────┐
                    │        MySQL         │
                    │      Database        │
                    └──────────────────────┘
```

For real-time chat operations, WebSocket provides a separate communication path:

```text
Browser JavaScript
        │
        │ WebSocket
        ▼
 WebSocket Endpoint
        │
        ▼
 Message Handling
        │
        ├──── Save / Update / Delete
        │
        ▼
      MySQL
        │
        ▼
 Broadcast message to connected clients
```

---

## 🔐 Authentication Flow

Authentication is handled using JWT and a servlet Filter.

```text
User
 │
 ▼
Login JSP
 │
 ▼
Login Servlet
 │
 ▼
Auth Service
 │
 ├── Verify password with BCrypt
 │
 └── Generate JWT
 │
 ▼
JWT Cookie
 │
 ▼
Browser stores cookie
 │
 ▼
Future protected requests
 │
 ▼
Authentication Filter
 │
 ├── Read JWT cookie
 ├── Validate JWT signature / claims
 └── Continue request
        │
        ▼
     Protected Servlet
```

The authentication Filter keeps protected routes behind JWT validation, while public routes such as login and registration can remain accessible without authentication.

---

## 💬 Real-Time Chat

The chat started with normal Servlet request/response handling and was then extended with WebSocket to make the conversation real time.

### Traditional request flow

```text
Chat page
   │
   ▼
Chat Servlet
   │
   ▼
Service
   │
   ▼
DAO
   │
   ▼
MySQL
   │
   ▼
JSP renders conversation
```

### Real-time flow

```text
User A
   │
   │ WebSocket message
   ▼
WebSocket Server
   │
   ├── process message
   ├── persist message
   └── broadcast update
          │
          ├──────────────► User A
          │
          └──────────────► User B / other members
```

This removes the need to refresh the page every time a new message arrives.

---

## 🗄️ Database Design

The application uses MySQL with a relational structure centered around users, conversations, membership, and messages.

```text
users
 │
 │ 1
 │
 ├──────────────< conversation_user >──────────────┐
 │                                                   │
 │                                                   │
 │                                                   ▼
 │                                            conversations
 │                                                   │
 │                                                   │ 1
 │                                                   │
 │                                                   ▼
 │                                               messages
 │                                                   ▲
 │                                                   │
 └──────────────────── sender_id ───────────────────┘
```

### Main tables

#### `users`

Stores registered users and authentication-related information.

Typical data includes:

- `id`
- `username`
- `email`
- `password`
- `created_at`

#### `conversations`

Stores conversation information such as its name, creator, visibility, and creation time.

#### `conversation_user`

A junction table that represents the many-to-many relationship between users and conversations.

#### `messages`

Stores chat messages and their relationship with the conversation and sender.

Typical data includes:

- `id`
- `conversation_id`
- `sender_id`
- `content`
- `created_at`

---

## 🧱 Project Structure

The project is organized around clear responsibilities:

```text
src/
├── DTO/
│   ├── Userdto.java
│   ├── ConvesartionData.java
│   └── ...
│
├── Models/
│   └── ...
│
├── DAO/
│   └── ...
│
├── Services/
│   └── Auth_Service.java
│   └── ...
│
├── Servlets/
│   ├── Login Servlet
│   ├── Register Servlet
│   ├── Chat Servlet
│   ├── Conversation Servlet
│   └── ...
│
├── Filters/
│   └── Auth Filter
│
└── WebSocket/
    └── ...

WebContent/
├── login.jsp
├── register.jsp
├── home.jsp
├── chat.jsp
└── ...
```

> Package and file names may vary slightly depending on the final project version. The important idea is the separation between presentation, request handling, business logic, data access, filters, and real-time communication.

---

## 🚀 Main Features in Detail

### 👤 Authentication

- User registration
- User login
- Password hashing with BCrypt
- JWT generation
- JWT validation
- Authentication through a Servlet Filter
- Session attributes for current user information

### 🏠 Conversations

- Display available public conversations
- Create a new conversation
- Display conversation name and description
- Display current member count
- Open a specific conversation using its ID

### 👥 Membership

- Connect users with conversations through `conversation_user`
- Track the number of members in a conversation
- Display conversation members inside the chat screen

### 💬 Messaging

- Load existing messages
- Show sender username
- Show message timestamp
- Send messages in real time
- Edit messages
- Delete messages
- Identify the current user's own messages

### 🎨 UI / UX

- Dark modern interface
- Gold accent color
- Responsive layout
- Login and registration loading states
- Chat members sidebar
- Empty states for conversations
- Modal for creating conversations

---

## 🧠 Java Web Concepts Used

This project was also built as a practical implementation of core Java Enterprise concepts:

- HTTP request / response lifecycle
- `doGet()` and `doPost()`
- `RequestDispatcher`
- `forward()` vs `sendRedirect()`
- Servlet Filters
- Cookies
- HTTP Session
- Request attributes
- Query parameters
- `PreparedStatement`
- `ResultSet`
- SQL joins
- Database relationships
- DTOs
- DAO pattern
- Service layer
- Exception handling
- JWT claims
- WebSocket communication

---

## 🔄 Example Request Flow

Opening a conversation:

```text
User clicks a conversation
        │
        ▼
/chat?chatId=1
        │
        ▼
Authentication Filter
        │
        ▼
Chat Servlet
        │
        ▼
Chat Service
        │
        ├── Conversation data
        ├── Members
        └── Latest messages
                │
                ▼
              DAO
                │
                ▼
              MySQL
                │
                ▼
         request attributes
                │
                ▼
             chat.jsp
```

Sending a new real-time message:

```text
User types message
        │
        ▼
JavaScript
        │
        ▼
WebSocket
        │
        ▼
Server
        │
        ├── Process message
        ├── Persist data
        └── Broadcast update
                │
                ▼
        Connected clients
```

---

## 🖼️ Screenshots

The project screenshots are available in the [`ScreenShots`](./ScreenShots) folder.

### Login

![WbChat Login](./ScreenShots/WbChat%20-%20Personal%20-%20Microsoft%E2%80%8B%20Edge%209_16_2026%202_53_06%20PM.png)

### Registration / UI

![WbChat Screenshot](./ScreenShots/WbChat%20-%20Personal%20-%20Microsoft%E2%80%8B%20Edge%209_16_2026%202_53_13%20PM.png)

### Home / Conversations

![WbChat Home](./ScreenShots/WbChat%20-%20Personal%20-%20Microsoft%E2%80%8B%20Edge%209_16_2026%202_54_00%20PM.png)

### Chat

![WbChat Chat](./ScreenShots/WbChat%20-%20Personal%20-%20Microsoft%E2%80%8B%20Edge%209_16_2026%207_56_09%20PM.png)

### Real-Time Messaging

![WbChat Real-Time](./ScreenShots/WbChat%20-%20Personal%20-%20Microsoft%E2%80%8B%20Edge%209_16_2026%207_56_33%20PM.png)

---

## ⚙️ Setup

### Prerequisites

Make sure the following are installed:

- Java JDK
- Apache Tomcat
- MySQL Server
- Eclipse IDE or another Java web development environment
- MySQL Connector/J

### Database

Create the MySQL database and tables used by the application, then update the database connection configuration with your local credentials.

The application expects a MySQL database for storing users, conversations, memberships, and messages.

### Run the project

1. Import the project into Eclipse as a Dynamic Web Project.
2. Configure the Apache Tomcat server.
3. Add the MySQL Connector/J dependency to the web application's runtime classpath.
4. Create and configure the MySQL database.
5. Update the database connection settings.
6. Start Tomcat.
7. Open the application in your browser.

---

## 🔒 Security Practices Used

- Passwords are hashed with BCrypt instead of storing plain-text passwords.
- Authentication uses signed JWT tokens.
- JWT validation is performed before protected resources are accessed.
- SQL parameters are passed through `PreparedStatement` rather than string concatenation.
- Authentication logic is separated from individual protected Servlets through a Filter.

> Production deployments should additionally review cookie security attributes, transport security (HTTPS), input validation, CSRF protection where applicable, output encoding, rate limiting, secret management, and authorization checks for every protected operation.

---

## 📌 Why I Built This Project

WbChat was built as a practical Java Enterprise project to bring together the backend concepts required to build a real web application from scratch.

Instead of treating Servlets, JSP, JDBC, authentication, database relationships, and WebSocket as separate topics, the project combines them into one working system.

The project helped me practice:

- Designing a relational database
- Building Servlet-based web applications
- Separating application layers
- Implementing authentication
- Working with cookies and sessions
- Writing SQL with JDBC
- Handling database relationships
- Building server-rendered JSP pages
- Adding real-time communication with WebSocket
- Connecting frontend JavaScript with a Java backend

---

## 📈 Possible Future Improvements

Some natural next steps for the project could include:

- Online / offline presence tracking
- Typing indicators
- Message delivery / read status
- File and image sharing
- Pagination / infinite scrolling for older messages
- Better authorization rules for conversation owners
- Automated tests
- Containerized deployment with Docker
- Production deployment with HTTPS

---

## 👨‍💻 Author

**Abdullah Islam**

Backend / Java Developer in progress, building practical applications with Java, Servlets, JSP, databases, and real-time technologies.

---

## ⭐ Project

If you find the project useful or interesting, feel free to explore the source code and the implementation details.
