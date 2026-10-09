package model;

import java.io.Serializable;

/**
 * User - JavaBean Model
 * 
 * Represents a registered student in the Student Skill Management System.
 * Adheres to standard JavaBean specifications:
 * 1. Implements Serializable
 * 2. Private member variables
 * 3. Public no-argument constructor
 * 4. Public getter and setter methods
 */
public class User implements Serializable {
    
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String email;
    private String password;
    private String createdAt;

    // No-argument constructor (Required for JavaBean specification)
    public User() {
    }

    // Parameterized constructor for registration / creation
    public User(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // Full constructor including ID and timestamp
    public User(int id, String name, String email, String password, String createdAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + ", email=" + email + "]";
    }
}
