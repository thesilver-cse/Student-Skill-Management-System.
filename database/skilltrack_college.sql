-- ==========================================================
-- SkillTrack - Student Skill Management System
-- Academic Database Schema
-- Target Database: skilltrack_college
-- Compatible with: MySQL 8.0 / MySQL Workbench
-- ==========================================================

-- 1. Create Database if not exists
CREATE DATABASE IF NOT EXISTS skilltrack_college;
USE skilltrack_college;

-- 2. Drop existing tables if re-running (safe initialization)
DROP TABLE IF EXISTS goals;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS users;

-- 3. Users Table (Stores Student Registration & Login Info)
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Skills Table (Stores Student Skills and Learning Progress)
CREATE TABLE skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    level VARCHAR(50) NOT NULL,
    progress INT NOT NULL DEFAULT 0,
    status VARCHAR(50) NOT NULL DEFAULT 'In Progress',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 5. Goals Table (Stores Student Learning Goals & Target Dates)
CREATE TABLE goals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    goal_name VARCHAR(200) NOT NULL,
    target_date DATE,
    status VARCHAR(50) NOT NULL DEFAULT 'In Progress',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Verification Queries
SELECT * FROM users;
SELECT * FROM skills;
SELECT * FROM goals;
