package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Goal;

/**
 * GoalDAO - Data Access Object for Goal operations
 * 
 * Implements CRUD operations for student learning goals in the 'goals' table.
 */
public class GoalDAO {

    /**
     * CREATE: Inserts a new learning goal for the student.
     * @param goal Goal object
     * @return boolean true if inserted successfully, false otherwise
     */
    public boolean addGoal(Goal goal) {
        String sql = "INSERT INTO goals (user_id, goal_name, target_date, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, goal.getUserId());
            ps.setString(2, goal.getGoalName());
            ps.setString(3, goal.getTargetDate());
            ps.setString(4, goal.getStatus());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("GoalDAO.addGoal Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * READ: Retrieves all goals for a given student.
     * @param userId Student user ID
     * @return List of Goal objects
     */
    public List<Goal> getGoalsByUserId(int userId) {
        List<Goal> list = new ArrayList<>();
        String sql = "SELECT id, user_id, goal_name, target_date, status, created_at FROM goals WHERE user_id = ? ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Goal g = new Goal();
                    g.setId(rs.getInt("id"));
                    g.setUserId(rs.getInt("user_id"));
                    g.setGoalName(rs.getString("goal_name"));
                    g.setTargetDate(rs.getString("target_date"));
                    g.setStatus(rs.getString("status"));
                    g.setCreatedAt(rs.getString("created_at"));
                    list.add(g);
                }
            }
        } catch (SQLException e) {
            System.err.println("GoalDAO.getGoalsByUserId Error: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * READ: Retrieves a specific goal by ID and user ID.
     * @param goalId Goal ID
     * @param userId User ID (ownership check)
     * @return Goal object or null
     */
    public Goal getGoalById(int goalId, int userId) {
        String sql = "SELECT id, user_id, goal_name, target_date, status, created_at FROM goals WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, goalId);
            ps.setInt(2, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Goal g = new Goal();
                    g.setId(rs.getInt("id"));
                    g.setUserId(rs.getInt("user_id"));
                    g.setGoalName(rs.getString("goal_name"));
                    g.setTargetDate(rs.getString("target_date"));
                    g.setStatus(rs.getString("status"));
                    g.setCreatedAt(rs.getString("created_at"));
                    return g;
                }
            }
        } catch (SQLException e) {
            System.err.println("GoalDAO.getGoalById Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * UPDATE: Modifies goal name, target date, or status.
     * @param goal Goal object with updated values
     * @return boolean true if update was successful, false otherwise
     */
    public boolean updateGoal(Goal goal) {
        String sql = "UPDATE goals SET goal_name = ?, target_date = ?, status = ? WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, goal.getGoalName());
            ps.setString(2, goal.getTargetDate());
            ps.setString(3, goal.getStatus());
            ps.setInt(4, goal.getId());
            ps.setInt(5, goal.getUserId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("GoalDAO.updateGoal Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * DELETE: Deletes a goal by ID.
     * @param goalId ID of the goal to delete
     * @param userId ID of the user
     * @return boolean true if deleted, false otherwise
     */
    public boolean deleteGoal(int goalId, int userId) {
        String sql = "DELETE FROM goals WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, goalId);
            ps.setInt(2, userId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("GoalDAO.deleteGoal Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
