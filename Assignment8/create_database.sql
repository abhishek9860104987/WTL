-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

-- Create students table
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    course VARCHAR(50) NOT NULL,
    marks DECIMAL(5,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data (optional)
INSERT INTO students (id, name, course, marks) VALUES 
(1, 'John Doe', 'Computer Science', 85.50),
(2, 'Jane Smith', 'Mathematics', 92.00),
(3, 'Mike Johnson', 'Physics', 78.75)
ON DUPLICATE KEY UPDATE name=name;
