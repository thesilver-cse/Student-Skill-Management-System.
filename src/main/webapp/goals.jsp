<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ page import="model.Goal" %>
<%@ page import="java.util.List" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
        return;
    }

    List<Goal> goals = (List<Goal>) request.getAttribute("goals");
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Goals - SkillTrack</title>
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

            <!-- Page Title -->
            <div class="mb-4 pb-2 border-bottom">
                <h3 class="fw-bold text-dark mb-1">
                    <i class="bi bi-bullseye text-danger me-2"></i>Academic Learning Goals
                </h3>
                <p class="text-muted mb-0 small">
                    Plan your learning milestones, set target deadlines, and track your achievements.
                </p>
            </div>

            <div class="row g-4">
                
                <!-- Add Goal Form Card -->
                <div class="col-lg-5">
                    <div class="app-card p-4">
                        <h5 class="fw-bold text-dark mb-3">
                            <i class="bi bi-plus-circle text-primary me-1"></i> Add New Goal
                        </h5>

                        <form action="${pageContext.request.contextPath}/add-goal" method="POST">
                            <div class="mb-3">
                                <label for="goalName" class="form-label fw-semibold">Goal Description <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="goalName" name="goalName" rows="3" placeholder="e.g. Complete 50 LeetCode problems in Java" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="targetDate" class="form-label fw-semibold">Target Completion Date</label>
                                <input type="date" class="form-control" id="targetDate" name="targetDate">
                            </div>

                            <div class="mb-4">
                                <label for="status" class="form-label fw-semibold">Initial Status</label>
                                <select class="form-select" id="status" name="status">
                                    <option value="In Progress" selected>In Progress</option>
                                    <option value="Not Started">Not Started</option>
                                    <option value="Completed">Completed</option>
                                </select>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary-custom">
                                    <i class="bi bi-save me-1"></i> Save Learning Goal
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Goals List Table -->
                <div class="col-lg-7">
                    <div class="app-card p-4">
                        <h5 class="fw-bold text-dark mb-3">
                            <i class="bi bi-list-task text-primary me-1"></i> Current Goals
                        </h5>

                        <% if (goals == null || goals.isEmpty()) { %>
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-calendar2-x fs-1 d-block mb-2 text-secondary"></i>
                                <h6>No goals set yet!</h6>
                                <p class="small text-muted">Use the form on the left to set your first learning milestone.</p>
                            </div>
                        <% } else { %>
                            <div class="table-responsive">
                                <table class="table table-hover table-custom align-middle mb-0">
                                    <thead>
                                        <tr>
                                            <th>Goal</th>
                                            <th>Target Date</th>
                                            <th>Status</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Goal g : goals) { %>
                                            <tr>
                                                <td>
                                                    <div class="fw-semibold text-dark"><%= g.getGoalName() %></div>
                                                </td>
                                                <td>
                                                    <span class="small text-muted">
                                                        <i class="bi bi-calendar3 me-1"></i>
                                                        <%= g.getTargetDate() != null ? g.getTargetDate() : "Not set" %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <% if ("Completed".equalsIgnoreCase(g.getStatus())) { %>
                                                        <span class="badge bg-success px-2 py-1">Completed</span>
                                                    <% } else if ("In Progress".equalsIgnoreCase(g.getStatus())) { %>
                                                        <span class="badge bg-warning text-dark px-2 py-1">In Progress</span>
                                                    <% } else { %>
                                                        <span class="badge bg-secondary px-2 py-1">Not Started</span>
                                                    <% } %>
                                                </td>
                                                <td class="text-end">
                                                    <% if (!"Completed".equalsIgnoreCase(g.getStatus())) { %>
                                                        <a href="${pageContext.request.contextPath}/update-goal?id=<%= g.getId() %>&status=Completed" 
                                                           class="btn btn-sm btn-outline-success me-1" 
                                                           title="Mark as Completed">
                                                            <i class="bi bi-check-lg"></i>
                                                        </a>
                                                    <% } %>
                                                    <a href="${pageContext.request.contextPath}/delete-goal?id=<%= g.getId() %>" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       title="Delete Goal"
                                                       onclick="return confirmGoalDelete('<%= g.getGoalName().replace("'", "\\'") %>');">
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

            </div>
        </div>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
