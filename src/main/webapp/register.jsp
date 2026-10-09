<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration - SkillTrack</title>
    <%@ include file="includes/header.jsp" %>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="includes/navbar.jsp" %>

    <main class="container my-auto py-5">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-5">
                <div class="app-card p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="badge bg-primary-subtle text-primary p-3 rounded-circle mb-2">
                            <i class="bi bi-person-plus-fill fs-3"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Student Registration</h3>
                        <p class="text-muted small">Create your account to start managing your skills</p>
                    </div>

                    <% if (error != null) { %>
                        <div class="alert alert-danger alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                            <div><%= error %></div>
                        </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/register" method="POST" autocomplete="off" onsubmit="return validateRegisterForm();">
                        <div class="mb-3">
                            <label for="name" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="name" name="name" value="" placeholder="e.g. Rahul Sharma" required autofocus autocomplete="off">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" value="" placeholder="e.g. student@college.edu" required autocomplete="off">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label fw-semibold">Password <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" value="" placeholder="Enter password" required autocomplete="new-password">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label fw-semibold">Confirm Password <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" value="" placeholder="Re-enter password" required autocomplete="new-password">
                            </div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary-custom btn-lg">
                                <i class="bi bi-check-circle me-1"></i> Register Account
                            </button>
                        </div>
                    </form>

                    <div class="text-center mt-3 pt-3 border-top">
                        <span class="text-muted small">Already have an account?</span>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="fw-semibold text-primary text-decoration-none ms-1">Login here</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
