package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GoalDAO;
import model.Goal;
import model.User;

/**
 * GoalServlet - Displays list of learning goals (READ).
 */
public class GoalServlet extends HttpServlet {

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

        List<Goal> goals = goalDAO.getGoalsByUserId(user.getId());
        request.setAttribute("goals", goals);
        request.getRequestDispatcher("goals.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
