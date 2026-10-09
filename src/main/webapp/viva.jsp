<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Viva & Practical Preparation Master Guide - SkillTrack</title>
    <%@ include file="includes/header.jsp" %>
    <style>
        .viva-card {
            border-left: 4px solid var(--accent-blue);
            transition: all 0.2s ease;
        }
        .viva-card:hover {
            border-left-width: 7px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }
        .q-badge {
            background-color: #e0f2fe;
            color: #0369a1;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.85rem;
        }
        .ans-box {
            background-color: #f8fafc;
            border-left: 3px solid #10b981;
            padding: 12px 16px;
            border-radius: 0 8px 8px 0;
            margin-top: 10px;
        }
        .speech-box {
            background: linear-gradient(135deg, #1e3a8a 0%, #1e40af 100%);
            color: #ffffff;
            border-radius: 12px;
            padding: 24px;
        }
        .code-inline {
            background-color: #f1f5f9;
            color: #d97706;
            padding: 2px 6px;
            border-radius: 4px;
            font-family: monospace;
            font-size: 0.9em;
        }
        .highlight-table th {
            background-color: #f1f5f9;
            color: #1e293b;
            font-size: 0.85rem;
        }
        .highlight-table td {
            font-size: 0.875rem;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="includes/navbar.jsp" %>

    <main class="py-4">
        <div class="container">

            <!-- Page Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <span class="badge bg-warning text-dark px-3 py-1 rounded-pill mb-2 fw-bold">
                        <i class="bi bi-mortarboard-fill me-1"></i> Exam & Viva Master Guide
                    </span>
                    <h2 class="fw-bold text-dark mb-1">
                        Student Skill Management System — Complete Viva Questions & Answers
                    </h2>
                    <p class="text-muted mb-0 small">
                        All important concepts, architecture flows, code explanations, and viva questions frequently asked in Advanced Java practicals.
                    </p>
                </div>
                <div class="mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/<%= loggedInUser != null ? "dashboard" : "index.jsp" %>" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-arrow-left me-1"></i> Back to Application
                    </a>
                </div>
            </div>

            <!-- SECTION 1: OPENING INTRODUCTION PITCH -->
            <div class="speech-box shadow-sm mb-5">
                <div class="d-flex align-items-center mb-3">
                    <i class="bi bi-chat-quote-fill fs-2 text-warning me-2"></i>
                    <h4 class="fw-bold mb-0 text-white">1. Opening Speech: "Chalo batao kaunsa project banaya hai?"</h4>
                </div>
                
                <div class="bg-white text-dark p-4 rounded-3 mb-3 shadow-sm">
                    <h6 class="fw-bold text-primary mb-2">🗣️ Option 1: Hinglish / Hindi mein bolne ke liye (Best & Natural):</h6>
                    <p class="mb-2 lead fs-6" style="line-height: 1.7;">
                        <em>"Good morning / Good afternoon Sir!</em><br><br>
                        <em>Maine <strong>'Student Skill Management System' (SkillTrack)</strong> project banaya hai.</em><br><br>
                        <strong>📌 Project ka Purpose:</strong> <em>Yeh ek web portal hai jisme koi bhi student apne technical skills (jaise Core Java, Servlets, MySQL), unka learning progress percentage (0 se 100%), proficiency level aur apne academic goals ko track aur manage kar sakta hai.</em><br><br>
                        <strong>✨ Main Features:</strong><br>
                        1. <em>Student Registration aur Secure Session-based Login.</em><br>
                        2. <em>Dynamic Dashboard jisme Total Skills, Completed Skills, In-Progress aur Average Progress % calculate hoke dikhta hai.</em><br>
                        3. <em>Complete Skill CRUD Operations — yaani skill Create, Read, Update aur Delete karna.</em><br>
                        4. <em>Learning Goals Management with Target Deadlines.</em><br><br>
                        <strong>🛠️ Tech Stack & Architecture:</strong><br>
                        • <em>Yeh project <strong>MVC (Model-View-Controller)</strong> pattern par based hai.</em><br>
                        • <em>Frontend mein <strong>JSP, HTML5, CSS3, Bootstrap 5</strong> use kiya hai.</em><br>
                        • <em>Backend pure <strong>Java 8, Servlets 3.1, JavaBeans</strong>, aur <strong>JDBC (PreparedStatement)</strong> se banaya hai.</em><br>
                        • <em>Database <strong>MySQL 8.0</strong> hai aur application <strong>Apache Tomcat Server (Port 8085)</strong> par run ho rahi hai."</em>
                    </p>
                </div>

                <div class="bg-white text-dark p-4 rounded-3 shadow-sm">
                    <h6 class="fw-bold text-primary mb-2">🗣️ Option 2: Professional English Pitch:</h6>
                    <p class="mb-0 small text-muted" style="line-height: 1.6;">
                        <em>"Sir, I have developed the <strong>'Student Skill Management System'</strong>. It is an academic web application designed to help students track and manage their technical skills, monitor learning progress from 0 to 100%, and set academic learning goals. The project is implemented using standard <strong>MVC architecture</strong> with <strong>Java Servlets</strong> as Controller, <strong>JavaBeans</strong> as Model, <strong>JSP</strong> as View, and <strong>JDBC DAO</strong> connected to <strong>MySQL 8.0</strong>, deployed on <strong>Apache Tomcat</strong>."</em>
                    </p>
                </div>
            </div>

            <!-- SEARCH BAR FOR QUICK VIVA LOOKUP -->
            <div class="app-card p-3 mb-4 sticky-top bg-white" style="top: 70px; z-index: 10;">
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-search text-primary"></i></span>
                    <input type="text" id="vivaSearch" class="form-control" placeholder="Search viva questions (e.g. MVC, PreparedStatement, Session, CRUD, JSP vs Servlet, GET vs POST, Cascade, Driver)..." onkeyup="filterQuestions();">
                </div>
            </div>

            <!-- SECTION 2: ALL COMPREHENSIVE VIVA QUESTIONS & ANSWERS -->
            <div id="vivaContainer">

                <!-- ==================== CATEGORY 1: MVC & ARCHITECTURE ==================== -->
                <h5 class="fw-bold text-dark mb-3 mt-4">
                    <i class="bi bi-layers-half text-primary me-2"></i> Category 1: MVC Architecture & Core Concepts
                </h5>

                <!-- Q1 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="mvc model view controller architecture pattern layer">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q1</span>
                        <h6 class="fw-bold text-dark mb-0">What is MVC Architecture and how is it implemented in this project?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> MVC stands for <strong>Model-View-Controller</strong> design pattern. It separates the business logic, presentation, and data management:
                        <ul class="mb-1 mt-2">
                            <li><strong>Model (<code>model/</code>):</strong> JavaBeans (<code class="code-inline">User.java</code>, <code class="code-inline">Skill.java</code>, <code class="code-inline">Goal.java</code>) holding entity properties and getters/setters.</li>
                            <li><strong>View (<code>webapp/*.jsp</code>):</strong> JSP pages (<code class="code-inline">dashboard.jsp</code>, <code class="code-inline">skills.jsp</code>, <code class="code-inline">goals.jsp</code>) rendering HTML & Bootstrap UI.</li>
                            <li><strong>Controller (<code>controller/</code>):</strong> Java Servlets (<code class="code-inline">SkillServlet</code>, <code class="code-inline">LoginServlet</code>, <code class="code-inline">DashboardServlet</code>) that intercept requests, call DAO methods, and forward response to JSP views.</li>
                            <li><strong>DAO Layer (<code>dao/</code>):</strong> Data Access Objects executing secure JDBC database operations.</li>
                        </ul>
                    </div>
                </div>

                <!-- Q2 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="javabean pojo encapsulation serializable getter setter rules">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q2</span>
                        <h6 class="fw-bold text-dark mb-0">What is a JavaBean and what are its 4 mandatory rules?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> A JavaBean is a standard reusable POJO (Plain Old Java Object) class in Java that adheres to 4 conventions:
                        <ol class="mb-1 mt-2">
                            <li>Must implement <code class="code-inline">java.io.Serializable</code>.</li>
                            <li>Must have <strong>private fields</strong> (Data Encapsulation).</li>
                            <li>Must have a <strong>public no-argument constructor</strong> (default constructor).</li>
                            <li>Must provide <strong>public getters and setters</strong> (<code class="code-inline">getSkillName()</code>, <code class="code-inline">setSkillName()</code>).</li>
                        </ol>
                        <em>In our project, JavaBeans are used to encapsulate student, skill, and goal records safely across layers.</em>
                    </div>
                </div>

                <!-- Q3 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="jsp servlet difference vs when to use">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q3</span>
                        <h6 class="fw-bold text-dark mb-0">What is the difference between JSP and Servlet? When to use which?</h6>
                    </div>
                    <div class="ans-box">
                        <table class="table table-bordered table-sm highlight-table mb-2">
                            <thead>
                                <tr>
                                    <th>Feature</th>
                                    <th>Java Servlet</th>
                                    <th>JSP (JavaServer Pages)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Primary Role</strong></td>
                                    <td>Controller (Business Logic & Request Handling)</td>
                                    <td>View (Presentation & UI rendering)</td>
                                </tr>
                                <tr>
                                    <td><strong>Code Structure</strong></td>
                                    <td>Java code with embedded HTML (via <code class="code-inline">out.println</code>)</td>
                                    <td>HTML code with embedded Java tags (<code class="code-inline">&lt;% %&gt;</code>)</td>
                                </tr>
                                <tr>
                                    <td><strong>Translation</strong></td>
                                    <td>Directly compiled into bytecode (.class)</td>
                                    <td>Server automatically translates JSP into a Servlet first</td>
                                </tr>
                            </tbody>
                        </table>
                        <em>Rule of Thumb: Use Servlets for Processing/Routing (Controller) and JSP for Displaying UI (View).</em>
                    </div>
                </div>

                <!-- Q4 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="jsp lifecycle translation phase execution jspservice">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q4</span>
                        <h6 class="fw-bold text-dark mb-0">How does JSP work internally (JSP Life Cycle)?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> When a client requests a JSP page for the first time:
                        <ol class="mb-1 mt-2">
                            <li><strong>Translation:</strong> Tomcat's Jasper engine converts <code class="code-inline">page.jsp</code> into a Java Servlet source file (<code class="code-inline">page_jsp.java</code>).</li>
                            <li><strong>Compilation:</strong> The Java compiler compiles <code class="code-inline">page_jsp.java</code> into bytecode (<code class="code-inline">page_jsp.class</code>).</li>
                            <li><strong>Loading & Initialization:</strong> <code class="code-inline">jspInit()</code> is invoked once.</li>
                            <li><strong>Execution:</strong> <code class="code-inline">_jspService()</code> executes for every request to generate HTML response.</li>
                            <li><strong>Destruction:</strong> <code class="code-inline">jspDestroy()</code> executes when the page is unloaded.</li>
                        </ol>
                    </div>
                </div>

                <!-- Q5 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="doget dopost get post difference http methods form">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q5</span>
                        <h6 class="fw-bold text-dark mb-0">What is the difference between doGet() and doPost()? Why is POST used in login/forms?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong><code>doGet()</code>:</strong> Appends form parameters directly in the browser URL query string (<code class="code-inline">?id=5&status=Completed</code>). Used for fetching/reading data. Has URL length limits and is visible in browser history.</li>
                            <li><strong><code>doPost()</code>:</strong> Sends parameters securely inside the HTTP Request Body (not in URL). Used for sensitive data (Login/Password) and modifying database records (Insert/Update). Has no size limit.</li>
                        </ul>
                    </div>
                </div>

                <!-- Q6 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="forward sendredirect requestdispatcher difference http 302">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q6</span>
                        <h6 class="fw-bold text-dark mb-0">What is the difference between RequestDispatcher.forward() and response.sendRedirect()?</h6>
                    </div>
                    <div class="ans-box">
                        <table class="table table-bordered table-sm highlight-table mb-2">
                            <thead>
                                <tr>
                                    <th>Criteria</th>
                                    <th>RequestDispatcher.forward()</th>
                                    <th>response.sendRedirect()</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Location</strong></td>
                                    <td>Server-side transfer</td>
                                    <td>Client-side redirect (HTTP 302)</td>
                                </tr>
                                <tr>
                                    <td><strong>Browser URL</strong></td>
                                    <td>Does NOT change</td>
                                    <td>Changes to the new target URL</td>
                                </tr>
                                <tr>
                                    <td><strong>Request Scope</strong></td>
                                    <td>Attributes (<code class="code-inline">request.setAttribute()</code>) are preserved</td>
                                    <td>Old request is lost; browser makes a brand-new request</td>
                                </tr>
                                <tr>
                                    <td><strong>Speed</strong></td>
                                    <td>Faster (single round-trip)</td>
                                    <td>Slower (two round-trips)</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- ==================== CATEGORY 2: DATABASE & JDBC ==================== -->
                <h5 class="fw-bold text-dark mb-3 mt-4">
                    <i class="bi bi-database-fill-gear text-primary me-2"></i> Category 2: Database, JDBC & SQL Queries
                </h5>

                <!-- Q7 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="jdbc preparedstatement statement callablestatement sql injection">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q7</span>
                        <h6 class="fw-bold text-dark mb-0">What is the difference between Statement, PreparedStatement, and CallableStatement?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong><code>Statement</code>:</strong> Used for simple static SQL queries with no parameters. Compiles query every time and is vulnerable to SQL Injection.</li>
                            <li><strong><code>PreparedStatement</code> (Used in our project):</strong> Pre-compiled by database engine with parameterized inputs (<code class="code-inline">?</code> placeholders). Highly secure against SQL Injection and faster for repeated execution.</li>
                            <li><strong><code>CallableStatement</code>:</strong> Used to execute Stored Procedures and Stored Functions inside the database.</li>
                        </ul>
                    </div>
                </div>

                <!-- Q8 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="jdbc driver type 4 pure java class forname drivermanager">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q8</span>
                        <h6 class="fw-bold text-dark mb-0">Which JDBC Driver are we using and what does Class.forName() do?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong>Driver Type:</strong> We are using <strong>Type 4 JDBC Driver (Pure Java / Thin Driver)</strong> via <code class="code-inline">com.mysql.cj.jdbc.Driver</code> (<code class="code-inline">mysql-connector-j-8.0.33.jar</code>). It communicates directly with MySQL server using database socket protocol without native OS libraries.</li>
                            <li><strong><code>Class.forName("com.mysql.cj.jdbc.Driver")</code>:</strong> Dynamically loads the JDBC driver bytecode into memory and automatically registers it with <code class="code-inline">DriverManager</code>.</li>
                        </ul>
                    </div>
                </div>

                <!-- Q9 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="sql injection example how to prevent preparedstatement">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q9</span>
                        <h6 class="fw-bold text-dark mb-0">What is SQL Injection Attack and how does your project prevent it?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> SQL Injection is a vulnerability where an attacker injects malicious SQL input (e.g. entering <code class="code-inline">' OR '1'='1</code> in password field) to bypass login or delete data.
                        <br><strong>How our project prevents it:</strong>
                        <div class="mt-2">
                            In <code class="code-inline">UserDAO.java</code> and <code class="code-inline">SkillDAO.java</code>, we use <code class="code-inline">PreparedStatement</code>:
                            <br><code class="code-inline">String sql = "SELECT * FROM users WHERE email=? AND password=?";</code>
                            <br><code class="code-inline">ps.setString(1, email); ps.setString(2, password);</code>
                            <br>The database engine treats the input strictly as literal string values, never as executable SQL code.
                        </div>
                    </div>
                </div>

                <!-- Q10 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="schema foreign key cascade integrity users skills goals">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q10</span>
                        <h6 class="fw-bold text-dark mb-0">Explain Database Schema, Foreign Keys and ON DELETE CASCADE.</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> Our MySQL database is <strong><code>skilltrack_college</code></strong> with 3 tables:
                        <ul class="mb-1 mt-2">
                            <li><strong><code>users</code>:</strong> <code class="code-inline">id (PK)</code>, <code class="code-inline">name</code>, <code class="code-inline">email (UNIQUE)</code>, <code class="code-inline">password</code>, <code class="code-inline">created_at</code>.</li>
                            <li><strong><code>skills</code>:</strong> <code class="code-inline">id (PK)</code>, <code class="code-inline">user_id (FK)</code>, <code class="code-inline">skill_name</code>, <code class="code-inline">category</code>, <code class="code-inline">level</code>, <code class="code-inline">progress</code>, <code class="code-inline">status</code>.</li>
                            <li><strong><code>goals</code>:</strong> <code class="code-inline">id (PK)</code>, <code class="code-inline">user_id (FK)</code>, <code class="code-inline">goal_name</code>, <code class="code-inline">target_date</code>, <code class="code-inline">status</code>.</li>
                        </ul>
                        <strong>What is ON DELETE CASCADE?</strong>
                        <br>It maintains Referential Integrity. If a student account is removed from <code class="code-inline">users</code>, MySQL automatically deletes all related records in <code class="code-inline">skills</code> and <code class="code-inline">goals</code> to prevent orphan/garbage data.
                    </div>
                </div>

                <!-- Q11 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="dashboard sql count avg calculations group by">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q11</span>
                        <h6 class="fw-bold text-dark mb-0">What SQL queries are used for Dashboard Metric calculations?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> In <code class="code-inline">SkillDAO.java</code>:
                        <ul class="mb-1 mt-2">
                            <li><strong>Total Skills:</strong> <code class="code-inline">SELECT COUNT(*) FROM skills WHERE user_id = ?;</code></li>
                            <li><strong>Completed:</strong> <code class="code-inline">SELECT COUNT(*) FROM skills WHERE user_id = ? AND (status='Completed' OR progress=100);</code></li>
                            <li><strong>In Progress:</strong> <code class="code-inline">SELECT COUNT(*) FROM skills WHERE user_id = ? AND status='In Progress' AND progress &lt; 100;</code></li>
                            <li><strong>Average Progress %:</strong> <code class="code-inline">SELECT IFNULL(ROUND(AVG(progress)), 0) FROM skills WHERE user_id = ?;</code></li>
                        </ul>
                    </div>
                </div>

                <!-- ==================== CATEGORY 3: AUTHENTICATION & SESSIONS ==================== -->
                <h5 class="fw-bold text-dark mb-3 mt-4">
                    <i class="bi bi-shield-lock-fill text-primary me-2"></i> Category 3: Authentication & Session Management
                </h5>

                <!-- Q12 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="session tracking httpsession jsessionid cookies techniques">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q12</span>
                        <h6 class="fw-bold text-dark mb-0">What are the 4 Session Tracking techniques in Java? Which one is used here?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> HTTP is a stateless protocol. To maintain user state across requests, Java provides 4 mechanisms:
                        <ol class="mb-1 mt-2">
                            <li><strong><code>HttpSession</code> (Used in our project):</strong> Stores data on server memory and creates a unique <code class="code-inline">JSESSIONID</code> cookie in the client browser.</li>
                            <li><strong>Cookies:</strong> Small text files saved on client browser.</li>
                            <li><strong>URL Rewriting:</strong> Appending session ID in the URL (<code class="code-inline">;jsessionid=...</code>).</li>
                            <li><strong>Hidden Form Fields:</strong> Using <code class="code-inline">&lt;input type="hidden"&gt;</code> inside HTML forms.</li>
                        </ol>
                    </div>
                </div>

                <!-- Q13 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="login logout session lifecycle invalidate security">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q13</span>
                        <h6 class="fw-bold text-dark mb-0">How is user authentication and session security implemented?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong>Login Verification:</strong> <code class="code-inline">LoginServlet</code> authenticates email & password against database. If valid, it binds the user: <code class="code-inline">request.getSession(true).setAttribute("user", userObj);</code>.</li>
                            <li><strong>Page Protection:</strong> Servlets check <code class="code-inline">HttpSession session = request.getSession(false);</code>. If <code class="code-inline">session == null || session.getAttribute("user") == null</code>, user is redirected to <code class="code-inline">login.jsp?msg=auth_required</code>.</li>
                            <li><strong>Logout Invalidation:</strong> <code class="code-inline">LogoutServlet</code> invokes <code class="code-inline">session.invalidate();</code> which clears all server memory attributes for that student.</li>
                        </ul>
                    </div>
                </div>

                <!-- ==================== CATEGORY 4: CRUD FLOW ==================== -->
                <h5 class="fw-bold text-dark mb-3 mt-4">
                    <i class="bi bi-arrow-repeat text-primary me-2"></i> Category 4: Complete CRUD Flow Walkthrough
                </h5>

                <!-- Q14 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="crud create read update delete flow step by step walkthrough">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q14</span>
                        <h6 class="fw-bold text-dark mb-0">Walk through the complete CRUD code execution step-by-step.</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong>CREATE (Add Skill):</strong> User fills <code class="code-inline">add-skill.jsp</code> ➔ POSTs to <code class="code-inline">AddSkillServlet</code> ➔ Validates input ➔ Constructs <code class="code-inline">Skill</code> JavaBean ➔ <code class="code-inline">SkillDAO.addSkill(skill)</code> executes <code class="code-inline">INSERT INTO skills VALUES (...)</code> ➔ Redirects to <code class="code-inline">/skills</code> with flash alert.</li>
                            <li><strong>READ (View Skills Table):</strong> User opens <code class="code-inline">/skills</code> ➔ <code class="code-inline">SkillServlet</code> calls <code class="code-inline">SkillDAO.getSkillsByUserId(userId)</code> ➔ executes <code class="code-inline">SELECT</code> query ➔ sets <code class="code-inline">request.setAttribute("skills", list)</code> ➔ forwards to <code class="code-inline">skills.jsp</code>.</li>
                            <li><strong>UPDATE (Edit Skill):</strong> User clicks Edit ➔ <code class="code-inline">UpdateSkillServlet (GET)</code> fetches existing record by ID ➔ renders pre-filled <code class="code-inline">edit-skill.jsp</code> ➔ User modifies progress ➔ POSTs to <code class="code-inline">UpdateSkillServlet</code> ➔ executes <code class="code-inline">UPDATE skills SET... WHERE id=? AND user_id=?</code>.</li>
                            <li><strong>DELETE (Delete Skill):</strong> User clicks Delete ➔ JavaScript shows confirmation ➔ <code class="code-inline">DeleteSkillServlet</code> parses ID ➔ <code class="code-inline">SkillDAO.deleteSkill(id, userId)</code> executes <code class="code-inline">DELETE FROM skills WHERE id=? AND user_id=?</code>.</li>
                        </ul>
                    </div>
                </div>

                <!-- ==================== CATEGORY 5: SERVER & WEB.XML ==================== -->
                <h5 class="fw-bold text-dark mb-3 mt-4">
                    <i class="bi bi-hdd-network-fill text-primary me-2"></i> Category 5: Server, Deployment & NetBeans
                </h5>

                <!-- Q15 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="web.xml deployment descriptor servlet mapping url pattern welcome file">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q15</span>
                        <h6 class="fw-bold text-dark mb-0">What is the purpose of web.xml (Deployment Descriptor)?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> <code class="code-inline">web.xml</code> is the XML configuration file placed in <code class="code-inline">WEB-INF/</code> directory:
                        <ul class="mb-1 mt-2">
                            <li><strong>Servlet Mapping:</strong> Maps URL routes to Java Servlet classes (e.g. <code class="code-inline">&lt;url-pattern&gt;/login&lt;/url-pattern&gt;</code> ➔ <code class="code-inline">LoginServlet</code>).</li>
                            <li><strong>Welcome File List:</strong> Specifies the default homepage (<code class="code-inline">index.jsp</code>).</li>
                            <li><strong>Session Timeout:</strong> Configures inactivity timeout (<code class="code-inline">&lt;session-timeout&gt;30&lt;/session-timeout&gt;</code>).</li>
                        </ul>
                    </div>
                </div>

                <!-- Q16 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="validation client server javascript why both">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q16</span>
                        <h6 class="fw-bold text-dark mb-0">Why is both Client-Side and Server-Side Validation necessary?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong>Client-Side Validation (JavaScript / HTML5):</strong> Runs in user's browser. Provides immediate visual feedback (e.g. password matching, range slider 0-100%) without making unnecessary server network requests.</li>
                            <li><strong>Server-Side Validation (Java Servlets):</strong> Runs on Tomcat server. <strong>Mandatory for Security</strong> because attackers can disable browser JavaScript or send direct forged HTTP POST requests.</li>
                        </ul>
                    </div>
                </div>

                <!-- Q17 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="try with resources connection leak close autocloseable">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q17</span>
                        <h6 class="fw-bold text-dark mb-0">How does your project prevent Database Connection Leaks?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong> In all DAO classes, we use <strong>Java 7+ Try-with-Resources</strong>:
                        <br><code class="code-inline">try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) { ... }</code>
                        <br>Because <code class="code-inline">Connection</code>, <code class="code-inline">PreparedStatement</code>, and <code class="code-inline">ResultSet</code> implement <code class="code-inline">AutoCloseable</code>, Java guarantees they are automatically closed even if an SQL exception occurs.
                    </div>
                </div>

                <!-- Q18 -->
                <div class="app-card p-4 mb-3 viva-card" data-keywords="javax jakarta servlet difference tomcat 8 10">
                    <div class="d-flex align-items-center mb-2">
                        <span class="q-badge me-2">Q18</span>
                        <h6 class="fw-bold text-dark mb-0">Why is javax.servlet package used instead of jakarta.servlet?</h6>
                    </div>
                    <div class="ans-box">
                        <strong>Answer:</strong>
                        <ul class="mb-1 mt-2">
                            <li><strong><code>javax.servlet.*</code>:</strong> Standard package for Java EE 7 / Java EE 8 compatible with <strong>Apache Tomcat 8.x / 9.x</strong> and Java 8 (used in our project).</li>
                            <li><strong><code>jakarta.servlet.*</code>:</strong> Introduced in Jakarta EE 9+ requiring Tomcat 10+ and Java 11+.</li>
                        </ul>
                    </div>
                </div>

            </div>

        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

    <script>
        function filterQuestions() {
            const query = document.getElementById('vivaSearch').value.toLowerCase().trim();
            const cards = document.querySelectorAll('.viva-card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                const keywords = card.getAttribute('data-keywords') || '';
                if (text.includes(query) || keywords.includes(query)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>

</body>
</html>
