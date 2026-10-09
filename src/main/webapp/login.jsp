<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String msg = request.getParameter("msg");
    String registered = request.getParameter("registered");

    if ("true".equals(registered)) {
        success = "Registration successful! Please sign in with your credentials.";
    } else if ("logged_out".equals(msg)) {
        success = "You have been successfully logged out.";
    } else if ("auth_required".equals(msg)) {
        error = "Please login first to access that page.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - SkillTrack</title>
    <%@ include file="includes/header.jsp" %>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="includes/navbar.jsp" %>

    <main class="container my-auto py-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="app-card p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="badge bg-primary-subtle text-primary p-3 rounded-circle mb-2">
                            <i class="bi bi-person-lock fs-3"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Student Login</h3>
                        <p class="text-muted small">Sign in to access your skills dashboard</p>
                    </div>

                    <% if (success != null) { %>
                        <div class="alert alert-success alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                            <div><%= success %></div>
                        </div>
                    <% } %>

                    <% if (error != null) { %>
                        <div class="alert alert-danger alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                            <div><%= error %></div>
                        </div>
                    <% } %>

                    <!-- Form with autocomplete disabled so browser does not autofill -->
                    <form action="${pageContext.request.contextPath}/login" method="POST" autocomplete="off">
                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" value="" placeholder="Enter your email address" required autocomplete="off">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label fw-semibold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-key"></i></span>
                                <input type="password" class="form-control" id="password" name="password" value="" placeholder="Enter your password" required autocomplete="new-password">
                            </div>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary-custom btn-lg">
                                <i class="bi bi-box-arrow-in-right me-1"></i> Sign In
                            </button>
                        </div>
                    </form>

                    <div class="text-center mt-3 pt-3 border-top">
                        <span class="text-muted small">Don't have an account?</span>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="fw-semibold text-primary text-decoration-none ms-1">Register now</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
