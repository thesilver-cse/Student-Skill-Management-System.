<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User navUser = (User) session.getAttribute("user");
    String navCurrentURI = request.getRequestURI();
%>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/<%= navUser != null ? "dashboard" : "index.jsp" %>">
            <i class="bi bi-mortarboard-fill text-warning"></i>
            <span>SkillTrack</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <% if (navUser != null) { %>
                    <li class="nav-item">
                        <a class="nav-link <%= navCurrentURI.contains("dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/dashboard">
                            <i class="bi bi-speedometer2 me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= (navCurrentURI.contains("skills") || navCurrentURI.contains("skill")) ? "active" : "" %>" href="${pageContext.request.contextPath}/skills">
                            <i class="bi bi-code-slash me-1"></i> My Skills
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= navCurrentURI.contains("goals") ? "active" : "" %>" href="${pageContext.request.contextPath}/goals">
                            <i class="bi bi-bullseye me-1"></i> Goals
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= navCurrentURI.contains("profile") ? "active" : "" %>" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person-circle me-1"></i> Profile
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link <%= navCurrentURI.endsWith("index.jsp") || navCurrentURI.endsWith("/") ? "active" : "" %>" href="${pageContext.request.contextPath}/index.jsp">
                            <i class="bi bi-house-door me-1"></i> Home
                        </a>
                    </li>
                <% } %>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <% if (navUser != null) { %>
                    <li class="nav-item me-3 text-white-50 d-none d-lg-block">
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">
                            <i class="bi bi-person-badge me-1 text-primary"></i> <%= navUser.getName() %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-light btn-sm px-3 rounded-pill" href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right me-1"></i> Logout
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item me-2">
                        <a class="btn btn-outline-light btn-sm px-3" href="${pageContext.request.contextPath}/login.jsp">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-warning btn-sm px-3 fw-semibold text-dark" href="${pageContext.request.contextPath}/register.jsp">
                            <i class="bi bi-person-plus-fill me-1"></i> Register
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
