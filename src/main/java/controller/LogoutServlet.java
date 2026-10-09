package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * LogoutServlet - Handles logging out the student.
 * 
 * Flow:
 * 1. Retrieves current session if exists.
 * 2. Invalidates the session (removes all attributes).
 * 3. Redirects to login.jsp with logged_out status.
 */
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("user");
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/login.jsp?msg=logged_out");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
