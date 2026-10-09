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
 * UpdateSkillServlet - Handles fetching skill for editing (GET) and saving updates (POST).
 * 
 * Flow:
 * GET: Fetches existing Skill from SkillDAO.getSkillById() and forwards to edit-skill.jsp.
 * POST: Reads updated fields, validates, calls SkillDAO.updateSkill(), and redirects to /skills.
 */
public class UpdateSkillServlet extends HttpServlet {

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
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=auth_required");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/skills");
            return;
        }

        try {
            int skillId = Integer.parseInt(idStr);
            Skill skill = skillDAO.getSkillById(skillId, user.getId());

            if (skill != null) {
                request.setAttribute("skill", skill);
                request.getRequestDispatcher("edit-skill.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/skills?error=Skill+not+found+or+access+denied.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/skills");
        }
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
        String skillName = request.getParameter("skillName");
        String category = request.getParameter("category");
        String level = request.getParameter("level");
        String progressStr = request.getParameter("progress");
        String status = request.getParameter("status");

        int skillId = 0;
        try {
            skillId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/skills?error=Invalid+skill+ID.");
            return;
        }

        // Validate
        if (skillName == null || skillName.trim().isEmpty() ||
            category == null || category.trim().isEmpty() ||
            level == null || level.trim().isEmpty()) {
            
            Skill existing = skillDAO.getSkillById(skillId, user.getId());
            request.setAttribute("skill", existing);
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("edit-skill.jsp").forward(request, response);
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

        // Build updated Skill object
        Skill updatedSkill = new Skill(skillId, user.getId(), skillName.trim(), category.trim(), level.trim(), progress, status.trim(), null);

        boolean isSuccess = skillDAO.updateSkill(updatedSkill);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/skills?success=Skill+%27" + java.net.URLEncoder.encode(skillName.trim(), "UTF-8") + "%27+updated+successfully!");
        } else {
            request.setAttribute("skill", updatedSkill);
            request.setAttribute("error", "Database error occurred while updating skill.");
            request.getRequestDispatcher("edit-skill.jsp").forward(request, response);
        }
    }
}
