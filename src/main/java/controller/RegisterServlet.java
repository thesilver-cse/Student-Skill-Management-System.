package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

/**
 * RegisterServlet - Handles student account registration.
 * 
 * Flow:
 * 1. Validates form inputs.
 * 2. Checks if email already exists via UserDAO.
 * 3. Saves new User record using UserDAO.registerUser().
 * 4. Redirects to login.jsp with success message.
 */
public class RegisterServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward GET requests to the registration view
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Server-side validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required. Please fill in all details.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (confirmPassword != null && !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match. Please verify.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 2. Check duplicate email
        if (userDAO.isEmailExists(email.trim())) {
            request.setAttribute("error", "An account with email '" + email + "' already exists. Please login.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Create User JavaBean and insert via DAO
        User newUser = new User(name.trim(), email.trim(), password);
        boolean isSuccess = userDAO.registerUser(newUser);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed due to a database error. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
