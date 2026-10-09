<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
        return;
    }

    User userProfile = (User) request.getAttribute("userProfile");
    if (userProfile == null) {
        userProfile = loggedInUser;
    }

    Integer totalSkills = (Integer) request.getAttribute("totalSkills");
    Integer completedSkills = (Integer) request.getAttribute("completedSkills");
    Integer totalGoals = (Integer) request.getAttribute("totalGoals");

    if (totalSkills == null) totalSkills = 0;
    if (completedSkills == null) completedSkills = 0;
    if (totalGoals == null) totalGoals = 0;

    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile - SkillTrack</title>
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
                    <i class="bi bi-person-badge text-primary me-2"></i>Student Profile
                </h3>
                <p class="text-muted mb-0 small">
                    Manage your account settings and view your academic learning summary.
                </p>
            </div>

            <div class="row g-4">
                
                <!-- Left: Profile Summary Card -->
                <div class="col-lg-4">
                    <div class="app-card p-4 text-center">
                        <div class="badge bg-primary-subtle text-primary p-4 rounded-circle mb-3">
                            <i class="bi bi-person-fill display-4"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1"><%= userProfile.getName() %></h4>
                        <p class="text-muted small mb-3"><%= userProfile.getEmail() %></p>
                        
                        <hr class="my-3">

                        <div class="row text-center g-2">
                            <div class="col-4">
                                <div class="fw-bold fs-5 text-primary"><%= totalSkills %></div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Skills</div>
                            </div>
                            <div class="col-4">
                                <div class="fw-bold fs-5 text-success"><%= completedSkills %></div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Completed</div>
                            </div>
                            <div class="col-4">
                                <div class="fw-bold fs-5 text-warning"><%= totalGoals %></div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Goals</div>
                            </div>
                        </div>

                        <hr class="my-3">

                        <div class="text-muted small">
                            <i class="bi bi-calendar-check me-1"></i> Member Since: 
                            <span class="fw-semibold text-dark"><%= userProfile.getCreatedAt() != null ? userProfile.getCreatedAt().substring(0, 10) : "Active" %></span>
                        </div>
                    </div>
                </div>

                <!-- Right: Edit Profile Form -->
                <div class="col-lg-8">
                    <div class="app-card p-4">
                        <h5 class="fw-bold text-dark mb-4">
                            <i class="bi bi-gear text-primary me-1"></i> Update Profile Information
                        </h5>

                        <form action="${pageContext.request.contextPath}/profile" method="POST">
                            
                            <div class="mb-3">
                                <label for="name" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control" id="name" name="name" value="<%= userProfile.getName() %>" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Email Address (Registered)</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <input type="email" class="form-control bg-light" value="<%= userProfile.getEmail() %>" disabled readonly>
                                </div>
                                <small class="text-muted">Email address is your unique academic login ID and cannot be changed.</small>
                            </div>

                            <hr class="my-4">
                            <h6 class="fw-bold text-dark mb-3">
                                <i class="bi bi-shield-lock me-1"></i> Change Password (Optional)
                            </h6>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label for="newPassword" class="form-label fw-semibold small">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Leave blank to keep current">
                                </div>
                                <div class="col-md-6">
                                    <label for="confirmPassword" class="form-label fw-semibold small">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password">
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <button type="submit" class="btn btn-primary-custom px-4">
                                    <i class="bi bi-check2-circle me-1"></i> Save Changes
                                </button>
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
