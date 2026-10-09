package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SkillDAO;
import model.Skill;
import model.User;

/**
 * AddSkillServlet - Handles creation (INSERT) of a new skill for the student.
 * 
 * Flow:
 * 1. Verifies session authentication.
 * 2. Parses form fields: skillName, category, level, progress, status.
 * 3. Validates inputs (progress between 0-100, non-empty skill name).
 * 4. Inserts into database via SkillDAO.addSkill().
 * 5. Redirects to /skills with success flash parameter.
 */
public class AddSkillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SkillDAO skillDAO;

    @Override
    public void init() {
        skillDAO = new SkillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        request.getRequestDispatcher("add-skill.jsp").forward(request, response);
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

        String skillName = request.getParameter("skillName");
        String category = request.getParameter("category");
        String level = request.getParameter("level");
        String progressStr = request.getParameter("progress");
        String status = request.getParameter("status");

        // 1. Validation
        if (skillName == null || skillName.trim().isEmpty() ||
            category == null || category.trim().isEmpty() ||
            level == null || level.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all mandatory fields.");
            request.getRequestDispatcher("add-skill.jsp").forward(request, response);
            return;
        }

        int progress = 0;
        try {
            progress = Integer.parseInt(progressStr);
            if (progress < 0) progress = 0;
            if (progress > 100) progress = 100;
        } catch (NumberFormatException e) {
            progress = 0;
        }

        if (status == null || status.trim().isEmpty()) {
            status = (progress == 100) ? "Completed" : (progress > 0 ? "In Progress" : "Not Started");
        }

        // 2. Instantiate Skill JavaBean
        Skill skill = new Skill(user.getId(), skillName.trim(), category.trim(), level.trim(), progress, status.trim());

        // 3. Save to database via DAO
        boolean isSuccess = skillDAO.addSkill(skill);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/skills?success=Skill+%27" + java.net.URLEncoder.encode(skillName.trim(), "UTF-8") + "%27+added+successfully!");
        } else {
            request.setAttribute("error", "Database error occurred while adding skill. Please try again.");
            request.getRequestDispatcher("add-skill.jsp").forward(request, response);
        }
    }
}
