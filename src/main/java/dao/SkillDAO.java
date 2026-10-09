package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Skill;

/**
 * SkillDAO - Data Access Object for Skill operations
 * 
 * Implements complete CRUD (Create, Read, Update, Delete) and statistical 
 * calculations for the 'skills' table.
 */
public class SkillDAO {

    /**
     * CREATE: Adds a new skill for the student.
     * @param skill Skill object
     * @return boolean true if inserted successfully, false otherwise
     */
    public boolean addSkill(Skill skill) {
        String sql = "INSERT INTO skills (user_id, skill_name, category, level, progress, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, skill.getUserId());
            ps.setString(2, skill.getSkillName());
            ps.setString(3, skill.getCategory());
            ps.setString(4, skill.getLevel());
            ps.setInt(5, skill.getProgress());
            ps.setString(6, skill.getStatus());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("SkillDAO.addSkill Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * READ: Retrieves all skills belonging to a student.
     * @param userId Logged-in user's ID
     * @return List of Skill objects
     */
    public List<Skill> getSkillsByUserId(int userId) {
        List<Skill> list = new ArrayList<>();
        String sql = "SELECT id, user_id, skill_name, category, level, progress, status, created_at FROM skills WHERE user_id = ? ORDER BY id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Skill s = new Skill();
                    s.setId(rs.getInt("id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setSkillName(rs.getString("skill_name"));
                    s.setCategory(rs.getString("category"));
                    s.setLevel(rs.getString("level"));
                    s.setProgress(rs.getInt("progress"));
                    s.setStatus(rs.getString("status"));
                    s.setCreatedAt(rs.getString("created_at"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            System.err.println("SkillDAO.getSkillsByUserId Error: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * READ: Retrieves a specific skill by skill ID and user ID.
     * @param skillId Skill ID
     * @param userId User ID (for ownership verification)
     * @return Skill object or null
     */
    public Skill getSkillById(int skillId, int userId) {
        String sql = "SELECT id, user_id, skill_name, category, level, progress, status, created_at FROM skills WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, skillId);
            ps.setInt(2, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Skill s = new Skill();
                    s.setId(rs.getInt("id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setSkillName(rs.getString("skill_name"));
                    s.setCategory(rs.getString("category"));
                    s.setLevel(rs.getString("level"));
                    s.setProgress(rs.getInt("progress"));
                    s.setStatus(rs.getString("status"));
                    s.setCreatedAt(rs.getString("created_at"));
                    return s;
                }
            }
        } catch (SQLException e) {
            System.err.println("SkillDAO.getSkillById Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * UPDATE: Modifies existing skill details.
     * @param skill Skill object with updated fields
     * @return boolean true if update was successful, false otherwise
     */
    public boolean updateSkill(Skill skill) {
        String sql = "UPDATE skills SET skill_name = ?, category = ?, level = ?, progress = ?, status = ? WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, skill.getSkillName());
            ps.setString(2, skill.getCategory());
            ps.setString(3, skill.getLevel());
            ps.setInt(4, skill.getProgress());
            ps.setString(5, skill.getStatus());
            ps.setInt(6, skill.getId());
            ps.setInt(7, skill.getUserId());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("SkillDAO.updateSkill Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * DELETE: Removes a skill by its ID.
     * @param skillId ID of the skill to delete
     * @param userId ID of the user (ensures user can only delete their own skill)
     * @return boolean true if deleted, false otherwise
     */
    public boolean deleteSkill(int skillId, int userId) {
        String sql = "DELETE FROM skills WHERE id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, skillId);
            ps.setInt(2, userId);
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("SkillDAO.deleteSkill Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * STATS: Returns total count of skills for a student.
     */
    public int getTotalSkillsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM skills WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("SkillDAO.getTotalSkillsCount Error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * STATS: Returns count of completed skills.
     */
    public int getCompletedSkillsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM skills WHERE user_id = ? AND (status = 'Completed' OR progress = 100)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("SkillDAO.getCompletedSkillsCount Error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * STATS: Returns count of in-progress skills.
     */
    public int getInProgressSkillsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM skills WHERE user_id = ? AND status = 'In Progress' AND progress < 100";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("SkillDAO.getInProgressSkillsCount Error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * STATS: Returns average progress percentage across all skills.
     */
    public int getAverageProgress(int userId) {
        String sql = "SELECT IFNULL(ROUND(AVG(progress)), 0) FROM skills WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("SkillDAO.getAverageProgress Error: " + e.getMessage());
        }
        return 0;
    }
}
