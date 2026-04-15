-- Database Setup Commands for Book Management System
-- Run these commands in MySQL to create the database and tables

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS wtlass7 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Use the database
USE wtlass7;

-- 3. Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Create books table
CREATE TABLE IF NOT EXISTS books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publisher VARCHAR(100),
    genre VARCHAR(50),
    publication_year INT,
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_title (title),
    INDEX idx_author (author),
    INDEX idx_isbn (isbn),
    INDEX idx_genre (genre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Insert sample data (optional)
INSERT INTO users (username, email, password) VALUES 
('admin', 'admin@example.com', 'admin123'),
('john_doe', 'john@example.com', 'password123'),
('jane_smith', 'jane@example.com', 'password123');

INSERT INTO books (title, author, isbn, publisher, genre, publication_year, price) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0-7432-7356-5', 'Scribner', 'Fiction', 1925, 12.99),
('To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4', 'J.B. Lippincott & Co.', 'Fiction', 1960, 14.99),
('1984', 'George Orwell', '978-0-452-28423-4', 'Secker & Warburg', 'Science Fiction', 1949, 13.99),
('Pride and Prejudice', 'Jane Austen', '978-0-14-143951-8', 'T. Egerton', 'Romance', 1813, 11.99),
('The Catcher in the Rye', 'J.D. Salinger', '978-0-316-76948-0', 'Little, Brown and Company', 'Fiction', 1951, 13.50);

-- 6. Show table structures
DESCRIBE users;
DESCRIBE books;

-- 7. Show sample data
SELECT * FROM users;
SELECT * FROM books;
