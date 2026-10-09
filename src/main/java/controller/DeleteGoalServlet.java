package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GoalDAO;
import model.User;

/**
 * DeleteGoalServlet - Handles learning goal deletion (DELETE).
 */
public class DeleteGoalServlet extends HttpServlet {

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

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int goalId = Integer.parseInt(idStr);
                boolean isDeleted = goalDAO.deleteGoal(goalId, user.getId());

                if (isDeleted) {
                    response.sendRedirect(request.getContextPath() + "/goals?success=Goal+deleted+successfully.");
                } else {
                    response.sendRedirect(request.getContextPath() + "/goals?error=Unable+to+delete+goal.");
                }
                return;
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        response.sendRedirect(request.getContextPath() + "/goals");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
