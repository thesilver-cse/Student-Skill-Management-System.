package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GoalDAO;
import model.Goal;
import model.User;

/**
 * UpdateGoalServlet - Handles updating goal status or details (UPDATE).
 */
public class UpdateGoalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private GoalDAO goalDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        // Quick status toggle via GET (e.g., Mark as Completed)
        String idStr = request.getParameter("id");
        String status = request.getParameter("status");

        if (idStr != null && status != null) {
            try {
                int goalId = Integer.parseInt(idStr);
                Goal existing = goalDAO.getGoalById(goalId, user.getId());
                if (existing != null) {
                    existing.setStatus(status);
                    goalDAO.updateGoal(existing);
                    response.sendRedirect(request.getContextPath() + "/goals?success=Goal+status+updated+successfully!");
                    return;
                }
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        response.sendRedirect(request.getContextPath() + "/goals");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        String idStr = request.getParameter("id");
        String goalName = request.getParameter("goalName");
        String targetDate = request.getParameter("targetDate");
        String status = request.getParameter("status");

        try {
            int goalId = Integer.parseInt(idStr);
            Goal goal = new Goal(goalId, user.getId(), goalName.trim(), targetDate, status, null);
            boolean isUpdated = goalDAO.updateGoal(goal);

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/goals?success=Goal+updated+successfully!");
            } else {
                response.sendRedirect(request.getContextPath() + "/goals?error=Failed+to+update+goal.");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/goals?error=Invalid+input.");
        }
    }
}
