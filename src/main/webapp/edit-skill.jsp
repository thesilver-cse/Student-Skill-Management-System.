<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Skill" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
        return;
    }

    Skill skill = (Skill) request.getAttribute("skill");
    if (skill == null) {
        response.sendRedirect(request.getContextPath() + "/skills?error=Skill+not+found");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Skill - SkillTrack</title>
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
                                <h4 class="fw-bold text-dark mb-0">Edit Skill</h4>
                                <p class="text-muted small mb-0">Update your learning progress and proficiency</p>
                            </div>
                        </div>

                        <% if (error != null) { %>
                            <div class="alert alert-danger alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                <div><%= error %></div>
                            </div>
                        <% } %>

                        <form action="${pageContext.request.contextPath}/edit-skill" method="POST">
                            
                            <!-- Hidden ID field -->
                            <input type="hidden" name="id" value="<%= skill.getId() %>">

                            <!-- Skill Name -->
                            <div class="mb-3">
                                <label for="skillName" class="form-label fw-semibold">Skill Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="skillName" name="skillName" value="<%= skill.getSkillName() %>" required autofocus>
                            </div>

                            <!-- Category -->
                            <div class="mb-3">
                                <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <select class="form-select" id="category" name="category" required>
                                    <option value="Programming" <%= "Programming".equals(skill.getCategory()) ? "selected" : "" %>>Programming (Java, Python, C++)</option>
                                    <option value="Web Development" <%= "Web Development".equals(skill.getCategory()) ? "selected" : "" %>>Web Development (HTML, CSS, JS)</option>
                                    <option value="Database" <%= "Database".equals(skill.getCategory()) ? "selected" : "" %>>Database & SQL (MySQL, PostgreSQL)</option>
                                    <option value="Data Structures & Algorithms" <%= "Data Structures & Algorithms".equals(skill.getCategory()) ? "selected" : "" %>>Data Structures & Algorithms</option>
                                    <option value="Frameworks & Tools" <%= "Frameworks & Tools".equals(skill.getCategory()) ? "selected" : "" %>>Frameworks & Tools (Git, Maven)</option>
                                    <option value="Soft Skills" <%= "Soft Skills".equals(skill.getCategory()) ? "selected" : "" %>>Soft Skills & Communication</option>
                                    <option value="Other" <%= "Other".equals(skill.getCategory()) ? "selected" : "" %>>Other</option>
                                </select>
                            </div>

                            <!-- Proficiency Level -->
                            <div class="mb-3">
                                <label for="level" class="form-label fw-semibold">Proficiency Level <span class="text-danger">*</span></label>
                                <select class="form-select" id="level" name="level" required>
                                    <option value="Beginner" <%= "Beginner".equalsIgnoreCase(skill.getLevel()) ? "selected" : "" %>>Beginner</option>
                                    <option value="Intermediate" <%= "Intermediate".equalsIgnoreCase(skill.getLevel()) ? "selected" : "" %>>Intermediate</option>
                                    <option value="Advanced" <%= "Advanced".equalsIgnoreCase(skill.getLevel()) ? "selected" : "" %>>Advanced</option>
                                </select>
                            </div>

                            <!-- Learning Progress (Interactive Slider) -->
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <label for="progressRange" class="form-label fw-semibold mb-0">Current Progress (%)</label>
                                    <span class="badge bg-primary fs-6" id="progressDisplay"><%= skill.getProgress() %>%</span>
                                </div>
                                <input type="range" class="form-range" min="0" max="100" step="5" value="<%= skill.getProgress() %>" id="progressRange" name="progress">
                            </div>

                            <!-- Status -->
                            <div class="mb-4">
                                <label for="status" class="form-label fw-semibold">Status <span class="text-danger">*</span></label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="Not Started" <%= "Not Started".equalsIgnoreCase(skill.getStatus()) ? "selected" : "" %>>Not Started</option>
                                    <option value="In Progress" <%= "In Progress".equalsIgnoreCase(skill.getStatus()) ? "selected" : "" %>>In Progress</option>
                                    <option value="Completed" <%= "Completed".equalsIgnoreCase(skill.getStatus()) ? "selected" : "" %>>Completed</option>
                                </select>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary-custom flex-grow-1">
                                    <i class="bi bi-check-circle me-1"></i> Update Skill
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
