package model;

import java.io.Serializable;

/**
 * Skill - JavaBean Model
 * 
 * Represents a skill record associated with a student.
 * Adheres to standard JavaBean specifications:
 * 1. Implements Serializable
 * 2. Private member variables
 * 3. Public no-argument constructor
 * 4. Public getter and setter methods
 */
public class Skill implements Serializable {
    
    private static final long serialVersionUID = 1L;

    private int id;
    private int userId;
    private String skillName;
    private String category;
    private String level;
    private int progress;
    private String status;
    private String createdAt;

    // No-argument constructor
    public Skill() {
    }

    // Constructor for creating new skill
    public Skill(int userId, String skillName, String category, String level, int progress, String status) {
        this.userId = userId;
        this.skillName = skillName;
        this.category = category;
        this.level = level;
        this.progress = progress;
        this.status = status;
    }

    // Full constructor
    public Skill(int id, int userId, String skillName, String category, String level, int progress, String status, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.skillName = skillName;
        this.category = category;
        this.level = level;
        this.progress = progress;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Skill [id=" + id + ", userId=" + userId + ", skillName=" + skillName 
                + ", category=" + category + ", level=" + level + ", progress=" + progress + "%]";
    }
}
