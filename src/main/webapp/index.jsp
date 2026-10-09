<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillTrack - Student Skill Management System</title>
    <%@ include file="includes/header.jsp" %>
</head>
<body>

    <!-- Dynamic Navigation Bar -->
    <%@ include file="includes/navbar.jsp" %>

    <!-- Hero Section -->
    <main class="py-5">
        <div class="container py-4">
            <div class="row align-items-center g-5">
                <div class="col-lg-7">
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill mb-3 fw-semibold">
                        <i class="bi bi-award-fill me-1"></i> Academic Practical Project
                    </span>
                    <h1 class="display-4 fw-bold text-dark mb-3">
                        Track, Manage & Improve Your <span class="text-primary">Skills</span>
                    </h1>
                    <p class="lead text-muted mb-4">
                        A structured student skill tracking portal developed with <strong>Java Servlets, JSP, JDBC & MySQL</strong>. Manage your technical competencies, track daily progress, and set academic learning goals.
                    </p>
                    <div class="d-flex flex-wrap gap-3">
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary-custom btn-lg px-4 shadow-sm">
                            <i class="bi bi-person-plus me-1"></i> Register as Student
                        </a>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-secondary btn-lg px-4">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Student Login
                        </a>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="app-card p-4 p-md-5 border-0 shadow-sm bg-white">
                        <h4 class="fw-bold text-primary mb-3">
                            <i class="bi bi-check2-circle me-1"></i> Project Highlights
                        </h4>
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex align-items-start mb-3">
                                <i class="bi bi-check-circle-fill text-success fs-5 me-2 mt-1"></i>
                                <div>
                                    <strong>Full Skill CRUD</strong>
                                    <div class="text-muted small">Create, Read, Update, and Delete skills easily.</div>
                                </div>
                            </li>
                            <li class="d-flex align-items-start mb-3">
                                <i class="bi bi-check-circle-fill text-success fs-5 me-2 mt-1"></i>
                                <div>
                                    <strong>Live Progress Metrics</strong>
                                    <div class="text-muted small">Calculates total, completed, in-progress, and avg progress.</div>
                                </div>
                            </li>
                            <li class="d-flex align-items-start mb-3">
                                <i class="bi bi-check-circle-fill text-success fs-5 me-2 mt-1"></i>
                                <div>
                                    <strong>Goal Management</strong>
                                    <div class="text-muted small">Set targeted learning deadlines and track status.</div>
                                </div>
                            </li>
                            <li class="d-flex align-items-start">
                                <i class="bi bi-check-circle-fill text-success fs-5 me-2 mt-1"></i>
                                <div>
                                    <strong>MVC Architecture</strong>
                                    <div class="text-muted small">Separated Model (JavaBean), View (JSP), Controller (Servlet), and DAO.</div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Academic Footer -->
    <%@ include file="includes/footer.jsp" %>

</body>
</html>
