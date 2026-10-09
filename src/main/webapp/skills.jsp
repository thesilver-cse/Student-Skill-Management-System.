<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Skill" %>
<%@ page import="java.util.List" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
        return;
    }

    List<Skill> skills = (List<Skill>) request.getAttribute("skills");
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Skills - SkillTrack</title>
    <%@ include file="includes/header.jsp" %>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="includes/navbar.jsp" %>

    <main class="py-4">
        <div class="container">
            
            <!-- Toast / Alert notifications -->
            <% if (successMsg != null) { %>
                <div class="alert alert-success alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                    <div><%= successMsg %></div>
                </div>
            <% } %>
            <% if (errorMsg != null) { %>
                <div class="alert alert-danger alert-dismiss-auto d-flex align-items-center mb-4" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                    <div><%= errorMsg %></div>
                </div>
            <% } %>

            <!-- Page Title and Actions -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h3 class="fw-bold text-dark mb-1">
                        <i class="bi bi-code-square text-primary me-2"></i>My Skills Management
                    </h3>
                    <p class="text-muted mb-0 small">
                        View, update progress, edit details, or remove skills from your student profile.
                    </p>
                </div>
                <div class="mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/add-skill.jsp" class="btn btn-primary-custom">
                        <i class="bi bi-plus-lg me-1"></i> Add New Skill
                    </a>
                </div>
            </div>

            <!-- Skills Table Card -->
            <div class="app-card p-4">
                <% if (skills == null || skills.isEmpty()) { %>
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary"></i>
                        <h5>No Skills Found</h5>
                        <p class="small text-muted mb-3">You have not registered any skills yet. Start by adding one!</p>
                        <a href="${pageContext.request.contextPath}/add-skill.jsp" class="btn btn-primary-custom btn-sm">
                            <i class="bi bi-plus-circle me-1"></i> Add Skill Now
                        </a>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-hover table-custom align-middle mb-0">
                            <thead>
                                <tr>
                                    <th style="width: 5%;">#</th>
                                    <th style="width: 25%;">Skill Name</th>
                                    <th style="width: 15%;">Category</th>
                                    <th style="width: 15%;">Proficiency Level</th>
                                    <th style="width: 20%;">Learning Progress</th>
                                    <th style="width: 10%;">Status</th>
                                    <th style="width: 10%;" class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    int count = 1;
                                    for (Skill s : skills) { 
                                %>
                                    <tr>
                                        <td class="text-muted fw-semibold"><%= count++ %></td>
                                        <td>
                                            <div class="fw-bold text-dark"><%= s.getSkillName() %></div>
                                            <div class="text-muted small">Added: <%= s.getCreatedAt() != null ? s.getCreatedAt().substring(0, 10) : "N/A" %></div>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-secondary border px-2 py-1"><%= s.getCategory() %></span>
                                        </td>
                                        <td>
                                            <% if ("Beginner".equalsIgnoreCase(s.getLevel())) { %>
                                                <span class="badge badge-level-beginner px-2 py-1">Beginner</span>
                                            <% } else if ("Intermediate".equalsIgnoreCase(s.getLevel())) { %>
                                                <span class="badge badge-level-intermediate px-2 py-1">Intermediate</span>
                                            <% } else { %>
                                                <span class="badge badge-level-advanced px-2 py-1">Advanced</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="progress flex-grow-1" style="height: 10px;">
                                                    <div class="progress-bar <%= s.getProgress() >= 80 ? "bg-success" : (s.getProgress() >= 40 ? "bg-primary" : "bg-warning") %>" 
                                                         role="progressbar" 
                                                         style="width: <%= s.getProgress() %>%;"
                                                         aria-valuenow="<%= s.getProgress() %>" 
                                                         aria-valuemin="0" 
                                                         aria-valuemax="100"></div>
                                                </div>
                                                <span class="small fw-bold"><%= s.getProgress() %>%</span>
                                            </div>
                                        </td>
                                        <td>
                                            <% if ("Completed".equalsIgnoreCase(s.getStatus())) { %>
                                                <span class="badge badge-status-completed px-2 py-1">
                                                    <i class="bi bi-check-circle me-1"></i> Completed
                                                </span>
                                            <% } else if ("In Progress".equalsIgnoreCase(s.getStatus())) { %>
                                                <span class="badge badge-status-inprogress px-2 py-1">
                                                    <i class="bi bi-hourglass-split me-1"></i> In Progress
                                                </span>
                                            <% } else { %>
                                                <span class="badge badge-status-notstarted px-2 py-1">
                                                    <i class="bi bi-circle me-1"></i> Not Started
                                                </span>
                                            <% } %>
                                        </td>
                                        <td class="text-end">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/edit-skill?id=<%= s.getId() %>" 
                                                   class="btn btn-outline-primary" 
                                                   title="Edit Skill">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/delete-skill?id=<%= s.getId() %>" 
                                                   class="btn btn-outline-danger" 
                                                   title="Delete Skill"
                                                   onclick="return confirmSkillDelete('<%= s.getSkillName().replace("'", "\\'") %>');">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
