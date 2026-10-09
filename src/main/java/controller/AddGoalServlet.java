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
 * AddGoalServlet - Handles adding a new learning goal (INSERT).
 */
public class AddGoalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private GoalDAO goalDAO;

    @Override
    public void init() {
        goalDAO = new GoalDAO();
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

        String goalName = request.getParameter("goalName");
        String targetDate = request.getParameter("targetDate");
        String status = request.getParameter("status");

        if (goalName == null || goalName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/goals?error=Goal+name+is+required.");
            return;
        }

        if (status == null || status.trim().isEmpty()) {
            status = "In Progress";
        }

        Goal goal = new Goal(user.getId(), goalName.trim(), (targetDate != null && !targetDate.trim().isEmpty()) ? targetDate.trim() : null, status.trim());
        boolean isSuccess = goalDAO.addGoal(goal);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/goals?success=Learning+goal+added+successfully!");
        } else {
            response.sendRedirect(request.getContextPath() + "/goals?error=Failed+to+add+goal.");
        }
    }
}
