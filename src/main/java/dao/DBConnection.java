package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Database Connection Utility Class
 * 
 * Centralized JDBC connection management for the Student Skill Management System
 * connecting to 'skilltrack_college' database.
 */
public class DBConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/skilltrack_college?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                System.err.println("MySQL JDBC Driver not found: " + ex.getMessage());
            }
        }
    }

    /**
     * Obtains a new database Connection to 'skilltrack_college'.
     * @return Connection object
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException ex) {
            System.err.println("Database Connection Failed to skilltrack_college: " + ex.getMessage());
            throw ex;
        }
    }

    /**
     * Safely close connection
     * @param conn Connection
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
