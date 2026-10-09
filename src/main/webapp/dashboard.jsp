<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Skill" %>
<%@ page import="model.Goal" %>
<%@ page import="java.util.List" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
        return;
    }

    Integer totalSkills = (Integer) request.getAttribute("totalSkills");
    Integer completedSkills = (Integer) request.getAttribute("completedSkills");
    Integer inProgressSkills = (Integer) request.getAttribute("inProgressSkills");
    Integer avgProgress = (Integer) request.getAttribute("avgProgress");
    
    List<Skill> skillList = (List<Skill>) request.getAttribute("skillList");
    List<Goal> goalList = (List<Goal>) request.getAttribute("goalList");

    if (totalSkills == null) totalSkills = 0;
    if (completedSkills == null) completedSkills = 0;
    if (inProgressSkills == null) inProgressSkills = 0;
    if (avgProgress == null) avgProgress = 0;

    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - SkillTrack</title>
    <%@ include file="includes/header.jsp" %>
</head>
<body class="d-flex flex-column min-vh-100">

    <%@ include file="includes/navbar.jsp" %>

    <main class="py-4">
        <div class="container">
            
            <!-- Alert Notifications -->
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

            <!-- Welcome Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h2 class="fw-bold text-dark mb-1">
                        Welcome, <%= loggedInUser.getName() %>! 👋
                    </h2>
                    <p class="text-muted mb-0 small">
                        Here is your current skill learning progress overview and academic goals summary.
                    </p>
                </div>
                <div class="mt-3 mt-md-0 d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/add-skill.jsp" class="btn btn-primary-custom">
                        <i class="bi bi-plus-circle me-1"></i> Add New Skill
                    </a>
                    <a href="${pageContext.request.contextPath}/goals.jsp" class="btn btn-outline-primary">
                        <i class="bi bi-bullseye me-1"></i> Add Goal
                    </a>
                </div>
            </div>

            <!-- 4 Summary Metric Cards -->
            <div class="row g-3 mb-4">
                <div class="col-sm-6 col-lg-3">
                    <div class="app-card stat-card">
                        <div class="stat-label">Total Skills</div>
                        <div class="stat-number text-primary mt-1"><%= totalSkills %></div>
                        <div class="text-muted small mt-2">
                            <i class="bi bi-stack me-1"></i> Total registered skills
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="app-card stat-card stat-completed">
                        <div class="stat-label">Completed Skills</div>
                        <div class="stat-number text-success mt-1"><%= completedSkills %></div>
                        <div class="text-muted small mt-2">
                            <i class="bi bi-check2-all me-1"></i> 100% progress achieved
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="app-card stat-card stat-inprogress">
                        <div class="stat-label">In Progress</div>
                        <div class="stat-number text-warning mt-1"><%= inProgressSkills %></div>
                        <div class="text-muted small mt-2">
                            <i class="bi bi-hourglass-split me-1"></i> Currently active learning
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3">
                    <div class="app-card stat-card stat-avg">
                        <div class="stat-label">Average Progress</div>
                        <div class="stat-number text-dark mt-1"><%= avgProgress %>%</div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: <%= avgProgress %>%;" aria-valuenow="<%= avgProgress %>" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <!-- Skills Section -->
                <div class="col-lg-8">
                    <div class="app-card p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold text-dark mb-0">
                                <i class="bi bi-code-slash text-primary me-2"></i> My Skills Overview
                            </h5>
                            <a href="${pageContext.request.contextPath}/skills" class="btn btn-sm btn-outline-secondary">
                                View Full Table <i class="bi bi-arrow-right ms-1"></i>
                            </a>
                        </div>

                        <% if (skillList == null || skillList.isEmpty()) { %>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                <h6>No skills added yet!</h6>
                                <p class="small mb-3">Add your first technical skill to start tracking your learning progress.</p>
                                <a href="${pageContext.request.contextPath}/add-skill.jsp" class="btn btn-primary-custom btn-sm">
                                    <i class="bi bi-plus-circle me-1"></i> Add First Skill
                                </a>
                            </div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-hover table-custom mb-0">
                                    <thead>
                                        <tr>
                                            <th>Skill Name</th>
                                            <th>Category</th>
                                            <th>Level</th>
                                            <th>Progress</th>
                                            <th>Status</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Skill s : skillList) { %>
                                            <tr>
                                                <td class="fw-semibold text-dark"><%= s.getSkillName() %></td>
                                                <td><span class="text-secondary small"><%= s.getCategory() %></span></td>
                                                <td>
                                                    <% if ("Beginner".equalsIgnoreCase(s.getLevel())) { %>
                                                        <span class="badge badge-level-beginner px-2 py-1">Beginner</span>
                                                    <% } else if ("Intermediate".equalsIgnoreCase(s.getLevel())) { %>
                                                        <span class="badge badge-level-intermediate px-2 py-1">Intermediate</span>
                                                    <% } else { %>
                                                        <span class="badge badge-level-advanced px-2 py-1">Advanced</span>
                                                    <% } %>
                                                </td>
                                                <td style="min-width: 140px;">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <div class="progress flex-grow-1">
                                                            <div class="progress-bar <%= s.getProgress() >= 80 ? "bg-success" : (s.getProgress() >= 40 ? "bg-primary" : "bg-warning") %>" 
                                                                 role="progressbar" 
                                                                 style="width: <%= s.getProgress() %>%;"></div>
                                                        </div>
                                                        <span class="small fw-semibold"><%= s.getProgress() %>%</span>
                                                    </div>
                                                </td>
                                                <td>
                                                    <% if ("Completed".equalsIgnoreCase(s.getStatus())) { %>
                                                        <span class="badge badge-status-completed px-2 py-1">Completed</span>
                                                    <% } else if ("In Progress".equalsIgnoreCase(s.getStatus())) { %>
                                                        <span class="badge badge-status-inprogress px-2 py-1">In Progress</span>
                                                    <% } else { %>
                                                        <span class="badge badge-status-notstarted px-2 py-1">Not Started</span>
                                                    <% } %>
                                                </td>
                                                <td class="text-end">
                                                    <a href="${pageContext.request.contextPath}/edit-skill?id=<%= s.getId() %>" class="btn btn-sm btn-outline-primary" title="Edit Skill">
                                                        <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/delete-skill?id=<%= s.getId() %>" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       title="Delete Skill"
                                                       onclick="return confirmSkillDelete('<%= s.getSkillName().replace("'", "\\'") %>');">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    </div>
                </div>

                <!-- Goals Widget -->
                <div class="col-lg-4">
                    <div class="app-card p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold text-dark mb-0">
                                <i class="bi bi-bullseye text-danger me-2"></i> Learning Goals
                            </h5>
                            <a href="${pageContext.request.contextPath}/goals.jsp" class="btn btn-sm btn-outline-secondary">
                                Manage
                            </a>
                        </div>

                        <% if (goalList == null || goalList.isEmpty()) { %>
                            <div class="text-center py-4 text-muted">
                                <i class="bi bi-calendar-check fs-2 d-block mb-1 text-secondary"></i>
                                <p class="small mb-2">No active learning goals.</p>
                                <a href="${pageContext.request.contextPath}/goals.jsp" class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-plus"></i> Set a Goal
                                </a>
                            </div>
                        <% } else { %>
                            <ul class="list-group list-group-flush">
                                <% for (Goal g : goalList) { %>
                                    <li class="list-group-item px-0 py-2 border-0 border-bottom">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h6 class="mb-1 text-dark fw-semibold small"><%= g.getGoalName() %></h6>
                                                <div class="text-muted small">
                                                    <i class="bi bi-calendar3 me-1"></i> Target: <%= g.getTargetDate() != null ? g.getTargetDate() : "No date" %>
                                                </div>
                                            </div>
                                            <span class="badge <%= "Completed".equalsIgnoreCase(g.getStatus()) ? "bg-success" : "bg-warning text-dark" %> rounded-pill small">
                                                <%= g.getStatus() %>
                                            </span>
                                        </div>
                                    </li>
                                <% } %>
                            </ul>
                        <% } %>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
