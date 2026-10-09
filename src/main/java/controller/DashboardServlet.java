package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GoalDAO;
import dao.SkillDAO;
import model.Goal;
import model.Skill;
import model.User;

/**
 * DashboardServlet - Handles student dashboard metrics and views.
 * 
 * Flow:
 * 1. Verifies student is logged in (session check).
 * 2. Fetches real-time statistical counts from SkillDAO.
 * 3. Fetches student's skill list and active goals.
 * 4. Forwards aggregated data to dashboard.jsp.
 */
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SkillDAO skillDAO;
    private GoalDAO goalDAO;

    @Override
    public void init() {
        skillDAO = new SkillDAO();
        goalDAO = new GoalDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Session check
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        int userId = user.getId();

        // 2. Fetch metrics & calculations
        int totalSkills = skillDAO.getTotalSkillsCount(userId);
        int completedSkills = skillDAO.getCompletedSkillsCount(userId);
        int inProgressSkills = skillDAO.getInProgressSkillsCount(userId);
        int avgProgress = skillDAO.getAverageProgress(userId);

        // 3. Fetch skills and goals lists
        List<Skill> skillList = skillDAO.getSkillsByUserId(userId);
        List<Goal> goalList = goalDAO.getGoalsByUserId(userId);

        // 4. Attach data to request scope
        request.setAttribute("totalSkills", totalSkills);
        request.setAttribute("completedSkills", completedSkills);
        request.setAttribute("inProgressSkills", inProgressSkills);
        request.setAttribute("avgProgress", avgProgress);
        request.setAttribute("skillList", skillList);
        request.setAttribute("goalList", goalList);

        // 5. Forward to dashboard view
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
