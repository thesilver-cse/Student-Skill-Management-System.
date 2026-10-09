package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SkillDAO;
import model.User;

/**
 * DeleteSkillServlet - Handles skill record deletion (DELETE).
 * 
 * Flow:
 * 1. Checks user session.
 * 2. Parses skill ID from query parameter.
 * 3. Executes DELETE query in MySQL via SkillDAO.deleteSkill(id, userId).
 * 4. Redirects back to /skills with success confirmation.
 */
public class DeleteSkillServlet extends HttpServlet {

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
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int skillId = Integer.parseInt(idStr);
                boolean isDeleted = skillDAO.deleteSkill(skillId, user.getId());

                if (isDeleted) {
                    response.sendRedirect(request.getContextPath() + "/skills?success=Skill+deleted+successfully.");
                } else {
                    response.sendRedirect(request.getContextPath() + "/skills?error=Unable+to+delete+skill+or+not+found.");
                }
                return;
            } catch (NumberFormatException e) {
                // Invalid ID
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/skills");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
