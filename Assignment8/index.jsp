<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .nav-menu {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .nav-button {
            background-color: #007bff;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .nav-button:hover {
            background-color: #0056b3;
        }
        .info {
            text-align: center;
            color: #666;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Management System</h1>
        
        <div class="info">
            <p>Manage student records with ease</p>
            <p>Add student information and view all records</p>
        </div>
        
        <div class="nav-menu">
            <a href="addStudent.jsp" class="nav-button">Add Student</a>
            <a href="viewStudents.jsp" class="nav-button">View All Students</a>
        </div>
        
        <div class="info">
            <p>Current Date & Time: <%= new java.util.Date() %></p>
        </div>
    </div>
</body>
</html>
