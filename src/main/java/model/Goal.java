package model;

import java.io.Serializable;

/**
 * Goal - JavaBean Model
 * 
 * Represents a learning goal set by a student.
 * Adheres to standard JavaBean specifications:
 * 1. Implements Serializable
 * 2. Private member variables
 * 3. Public no-argument constructor
 * 4. Public getter and setter methods
 */
public class Goal implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int userId;
    private String goalName;
    private String targetDate;
    private String status;
    private String createdAt;

    // No-argument constructor
    public Goal() {
    }

    // Constructor for creating new goal
    public Goal(int userId, String goalName, String targetDate, String status) {
        this.userId = userId;
        this.goalName = goalName;
        this.targetDate = targetDate;
        this.status = status;
    }

    // Full constructor
    public Goal(int id, int userId, String goalName, String targetDate, String status, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.goalName = goalName;
        this.targetDate = targetDate;
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

    public String getGoalName() {
        return goalName;
    }

    public void setGoalName(String goalName) {
        this.goalName = goalName;
    }

    public String getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(String targetDate) {
        this.targetDate = targetDate;
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
        return "Goal [id=" + id + ", userId=" + userId + ", goalName=" + goalName 
                + ", targetDate=" + targetDate + ", status=" + status + "]";
    }
}
