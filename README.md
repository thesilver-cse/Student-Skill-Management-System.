# SkillTrack – Student Skill Management System
> **Academic Project for Advanced Java Technology Practical / Internal Assessment**

---

## 📌 1. Project Overview

**SkillTrack – Student Skill Management System** is a medium-complexity academic web application designed to help students track technical skills, monitor learning progress, set academic goals, and manage their educational profile.

The project strictly demonstrates core **Advanced Java Technology** concepts without third-party enterprise frameworks like Spring, Hibernate, or React, making it simple to demonstrate and explain during viva examinations.

---

## 🛠️ 2. Technology Stack

| Component | Technology Used | Version / Description |
|---|---|---|
| **Language** | Java | Java 8 (JDK 1.8) |
| **Server-Side API** | Java Servlets & JSP | Servlet 3.1 (`javax.servlet`) |
| **Design Pattern** | MVC (Model-View-Controller) | With DAO (Data Access Object) Pattern |
| **Data Layer** | JDBC (Java Database Connectivity) | `com.mysql.cj.jdbc.Driver` with `PreparedStatement` |
| **Database** | MySQL | MySQL Server 8.0 (`skilltrack_college`) |
| **Frontend UI** | JSP, HTML5, CSS3, Bootstrap 5 | Responsive Academic UI |
| **Application Server** | Apache Tomcat | Tomcat 8.x (**Port 8085**) |

---

## 🏗️ 3. Architecture (MVC Flow)

```text
[ Browser / JSP View ]
         │
    (HTTP Request)
         ↓
[ Java Servlet Controller ]
         │
    (Invokes DAO Method)
         ↓
[ Data Access Object (DAO) ]  ⟵ ⟶  [ JavaBean Model (POJO) ]
         │
    (JDBC PreparedStatement)
         ↓
[ MySQL Database (skilltrack_college) ]
```

### MVC Separation:
* **Model (`model/`)**: `User.java`, `Skill.java`, `Goal.java` (Encapsulated JavaBeans with private fields and getters/setters).
* **View (`webapp/*.jsp`)**: `index.jsp`, `login.jsp`, `register.jsp`, `dashboard.jsp`, `skills.jsp`, `add-skill.jsp`, `edit-skill.jsp`, `goals.jsp`, `profile.jsp`.
* **Controller (`controller/`)**: Java Servlets managing HTTP requests, session management, and redirection.
* **DAO (`dao/`)**: `DBConnection.java`, `UserDAO.java`, `SkillDAO.java`, `GoalDAO.java` executing SQL CRUD queries.

---

## 🗄️ 4. Database Schema (`skilltrack_college`)

Database script location: [`database/skilltrack_college.sql`](file:///c:/Users/91816/OneDrive/Desktop/Student%20Skill%20Management%20System/database/skilltrack_college.sql)

### 1. `users` Table
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 2. `skills` Table
```sql
CREATE TABLE skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    level VARCHAR(50) NOT NULL,
    progress INT NOT NULL DEFAULT 0,
    status VARCHAR(50) NOT NULL DEFAULT 'In Progress',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### 3. `goals` Table
```sql
CREATE TABLE goals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    goal_name VARCHAR(200) NOT NULL,
    target_date DATE,
    status VARCHAR(50) NOT NULL DEFAULT 'In Progress',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

---

## 🚀 5. How to Run the Project

### Step 1: Initialize Database
1. Open **MySQL Workbench** or MySQL CLI.
2. Execute the script [`database/skilltrack_college.sql`](file:///c:/Users/91816/OneDrive/Desktop/Student%20Skill%20Management%20System/database/skilltrack_college.sql).
3. Verify that database `skilltrack_college` and tables (`users`, `skills`, `goals`) are created.

### Step 2: Start Tomcat Server (Port 8085)
Double-click [`start-server.bat`](file:///c:/Users/91816/OneDrive/Desktop/Student%20Skill%20Management%20System/start-server.bat) or run from terminal:
```powershell
.\start-server.bat
```

### Step 3: Access Web Application
Open your web browser and navigate to:
```text
http://localhost:8085
```

---

## 🎯 6. Project Demonstration Walkthrough

1. **Landing Page:** Open `http://localhost:8085`.
2. **Student Registration:** Click **Register**, fill in name, email, and password.
3. **Student Login:** Login with registered credentials or use default test credentials (`rahul@example.com` / `password123`).
4. **Dashboard View:** Review 4 live dynamic metric cards:
   * Total Skills
   * Completed Skills
   * In-Progress Skills
   * Average Progress Percentage
5. **Skill CREATE:** Click **+ Add New Skill**, enter Skill Name (e.g. *Java Servlets*), Category (*Web Development*), Level (*Intermediate*), Progress (*75%*), Status (*In Progress*).
6. **Skill READ:** View skills in the structured **My Skills** table with color-coded badges and progress bars.
7. **Skill UPDATE:** Click the **Edit** icon, change progress from *75%* to *90%*, and save.
8. **Skill DELETE:** Click the **Delete** icon and confirm deletion.
9. **Goal Management:** Add learning goals, view deadlines, and toggle "Mark Completed".
10. **Profile Management:** View registered email, update full name or change password.
11. **Logout:** Click **Logout** to invalidate the session safely.

---

## 🎓 7. College Viva Questions & Answers

### Q1: What is the MVC architecture and how is it implemented in this project?
**Answer:** MVC separates the application into three layers:
- **Model:** Represents data objects (`User`, `Skill`, `Goal` JavaBeans).
- **View:** User interface created using JSP and HTML/CSS/Bootstrap.
- **Controller:** Java Servlets that handle HTTP requests, call DAO methods, and forward to JSP views.

### Q2: What is a JavaBean?
**Answer:** A JavaBean is a reusable Java class that follows standard conventions:
1. Implements `java.io.Serializable`.
2. Has private properties/fields (encapsulation).
3. Provides a public no-argument default constructor.
4. Exposes properties via public getter and setter methods.

### Q3: Why is `PreparedStatement` used instead of `Statement`?
**Answer:** 
1. **Security:** It prevents SQL Injection attacks by parameterizing input (`?` placeholders).
2. **Performance:** Pre-compiled by database engine for faster execution.
3. **Data Type Handling:** Automatically formats strings, dates, and integers.

### Q4: How is session management handled?
**Answer:** Using `HttpSession`:
- Upon successful login: `request.getSession(true).setAttribute("user", userObj);`
- In servlets/JSP: `session.getAttribute("user")` is checked for authentication.
- On logout: `session.invalidate()` destroys the session.

### Q5: What is the difference between `sendRedirect()` and `RequestDispatcher.forward()`?
**Answer:**
- `forward()` happens on the server side without changing the browser URL (keeps request attributes).
- `sendRedirect()` sends an HTTP 302 response to the client browser, prompting a new request to the target URL.

---

## 🔒 8. Project Isolation Note
* **Medium Project Port:** `8085` (`skilltrack_college` database)
* **Advanced Project Port:** `8084` (Remains completely untouched and independent)
