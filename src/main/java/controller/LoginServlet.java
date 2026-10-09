package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

/**
 * LoginServlet - Handles student authentication and HTTP session creation.
 * 
 * Flow:
 * 1. Reads login credentials.
 * 2. Authenticates against database via UserDAO.loginUser().
 * 3. On success: sets "user" attribute in HttpSession and redirects to /dashboard.
 * 4. On failure: forwards back to login.jsp with error message.
 */
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward GET requests directly to login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 1. Validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 2. Authenticate against MySQL
        User user = userDAO.loginUser(email.trim(), password);

        if (user != null) {
            // 3. Create Session and store User object
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            
            // Redirect to Dashboard controller
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            // 4. Invalid credentials
            request.setAttribute("error", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
