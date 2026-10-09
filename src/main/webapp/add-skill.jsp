<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Skill - SkillTrack</title>
    <%@ include file="includes/header.jsp" %>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="includes/navbar.jsp" %>

    <main class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="app-card p-4 p-md-5">
                        
                        <div class="d-flex align-items-center mb-4 pb-2 border-bottom">
                            <a href="${pageContext.request.contextPath}/skills" class="btn btn-outline-secondary btn-sm me-3">
                                <i class="bi bi-arrow-left"></i>
                            </a>
                            <div>
                                <h4 class="fw-bold text-dark mb-0">Add New Skill</h4>
                                <p class="text-muted small mb-0">Record a new technical or soft skill</p>
                            </div>
                        </div>

                        <% if (error != null) { %>
                            <div class="alert alert-danger alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                <div><%= error %></div>
                            </div>
                        <% } %>

                        <form action="${pageContext.request.contextPath}/add-skill" method="POST">
                            
                            <!-- Skill Name -->
                            <div class="mb-3">
                                <label for="skillName" class="form-label fw-semibold">Skill Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="skillName" name="skillName" placeholder="e.g. Java Servlets & JSP" required autofocus>
                            </div>

                            <!-- Category -->
                            <div class="mb-3">
                                <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <select class="form-select" id="category" name="category" required>
                                    <option value="" disabled selected>-- Select Skill Category --</option>
                                    <option value="Programming">Programming (Java, Python, C++)</option>
                                    <option value="Web Development">Web Development (HTML, CSS, JS)</option>
                                    <option value="Database">Database & SQL (MySQL, PostgreSQL)</option>
                                    <option value="Data Structures & Algorithms">Data Structures & Algorithms</option>
                                    <option value="Frameworks & Tools">Frameworks & Tools (Git, Maven)</option>
                                    <option value="Soft Skills">Soft Skills & Communication</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <!-- Proficiency Level -->
                            <div class="mb-3">
                                <label for="level" class="form-label fw-semibold">Proficiency Level <span class="text-danger">*</span></label>
                                <select class="form-select" id="level" name="level" required>
                                    <option value="Beginner">Beginner</option>
                                    <option value="Intermediate" selected>Intermediate</option>
                                    <option value="Advanced">Advanced</option>
                                </select>
                            </div>

                            <!-- Learning Progress (Interactive Slider) -->
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <label for="progressRange" class="form-label fw-semibold mb-0">Current Progress (%)</label>
                                    <span class="badge bg-primary fs-6" id="progressDisplay">50%</span>
                                </div>
                                <input type="range" class="form-range" min="0" max="100" step="5" value="50" id="progressRange" name="progress">
                            </div>

                            <!-- Status -->
                            <div class="mb-4">
                                <label for="status" class="form-label fw-semibold">Status <span class="text-danger">*</span></label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="Not Started">Not Started</option>
                                    <option value="In Progress" selected>In Progress</option>
                                    <option value="Completed">Completed</option>
                                </select>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary-custom flex-grow-1">
                                    <i class="bi bi-save me-1"></i> Save Skill
                                </button>
                                <a href="${pageContext.request.contextPath}/skills" class="btn btn-outline-secondary">
                                    Cancel
                                </a>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
