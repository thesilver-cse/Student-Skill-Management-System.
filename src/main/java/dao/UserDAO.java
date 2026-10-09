package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 * UserDAO - Data Access Object for User operations
 * 
 * Implements CRUD operations for the 'users' table using JDBC PreparedStatement.
 */
public class UserDAO {

    /**
     * Registers a new student user in the database.
     * @param user User object containing registration details
     * @return boolean true if registration succeeded, false otherwise
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("UserDAO.registerUser Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Authenticates user login credentials.
     * @param email User email
     * @param password User plain password
     * @return User object if valid credentials, null otherwise
     */
    public User loginUser(String email, String password) {
        String sql = "SELECT id, name, email, password, created_at FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setCreatedAt(rs.getString("created_at"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.loginUser Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Checks if an email is already registered.
     * @param email Email address to verify
     * @return boolean true if email already exists, false otherwise
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.isEmailExists Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Fetches a User by unique ID.
     * @param userId ID of the user
     * @return User object or null
     */
    public User getUserById(int userId) {
        String sql = "SELECT id, name, email, password, created_at FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setCreatedAt(rs.getString("created_at"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.getUserById Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates profile details (Name and/or Password) for a student.
     * @param user User object containing updated details
     * @return boolean true if update succeeded, false otherwise
     */
    public boolean updateUserProfile(User user) {
        String sql;
        boolean hasPassword = user.getPassword() != null && !user.getPassword().trim().isEmpty();
        
        if (hasPassword) {
            sql = "UPDATE users SET name = ?, password = ? WHERE id = ?";
        } else {
            sql = "UPDATE users SET name = ? WHERE id = ?";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getName());
            if (hasPassword) {
                ps.setString(2, user.getPassword());
                ps.setInt(3, user.getId());
            } else {
                ps.setInt(2, user.getId());
            }
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("UserDAO.updateUserProfile Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
