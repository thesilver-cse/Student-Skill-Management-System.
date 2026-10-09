package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GoalDAO;
import dao.SkillDAO;
import dao.UserDAO;
import model.User;

/**
 * ProfileServlet - Handles viewing and updating student profile information.
 * 
 * Flow:
 * GET: Fetches fresh User record from UserDAO and renders profile.jsp.
 * POST: Validates updated name and optional new password, updates DB, and updates session.
 */
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private SkillDAO skillDAO;
    private GoalDAO goalDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        skillDAO = new SkillDAO();
        goalDAO = new GoalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        User freshUser = userDAO.getUserById(sessionUser.getId());
        if (freshUser == null) {
            freshUser = sessionUser;
        }

        int totalSkills = skillDAO.getTotalSkillsCount(sessionUser.getId());
        int completedSkills = skillDAO.getCompletedSkillsCount(sessionUser.getId());
        int totalGoals = goalDAO.getGoalsByUserId(sessionUser.getId()).size();

        request.setAttribute("userProfile", freshUser);
        request.setAttribute("totalSkills", totalSkills);
        request.setAttribute("completedSkills", completedSkills);
        request.setAttribute("totalGoals", totalGoals);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        String name = request.getParameter("name");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile?error=Name+cannot+be+empty.");
            return;
        }

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/profile?error=Passwords+do+not+match.");
                return;
            }
        }

        User updatedUser = new User();
        updatedUser.setId(sessionUser.getId());
        updatedUser.setName(name.trim());
        updatedUser.setPassword((newPassword != null && !newPassword.trim().isEmpty()) ? newPassword.trim() : null);

        boolean isSuccess = userDAO.updateUserProfile(updatedUser);

        if (isSuccess) {
            // Update session user name
            sessionUser.setName(name.trim());
            session.setAttribute("user", sessionUser);
            response.sendRedirect(request.getContextPath() + "/profile?success=Profile+updated+successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?error=Database+error+updating+profile.");
        }
    }
}
