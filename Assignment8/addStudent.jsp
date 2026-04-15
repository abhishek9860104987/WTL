<%@ page import="com.db.DBConnection, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add New Student</h1>
        
        <%
        String message = "";
        String messageType = "";
        
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String studentId = request.getParameter("studentId");
            String name = request.getParameter("name");
            String course = request.getParameter("course");
            String marks = request.getParameter("marks");
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                conn = DBConnection.getConnection();
                String sql = "INSERT INTO students (id, name, course, marks) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(studentId));
                pstmt.setString(2, name);
                pstmt.setString(3, course);
                pstmt.setDouble(4, Double.parseDouble(marks));
                
                int result = pstmt.executeUpdate();
                
                if (result > 0) {
                    message = "Student added successfully!";
                    messageType = "success";
                } else {
                    message = "Failed to add student!";
                    messageType = "error";
                }
                
            } catch (NumberFormatException e) {
                message = "Please enter valid numbers for ID and marks!";
                messageType = "error";
            } catch (SQLException e) {
                if (e.getMessage().contains("Duplicate entry")) {
                    message = "Student ID already exists!";
                    messageType = "error";
                } else {
                    message = "Database error: " + e.getMessage();
                    messageType = "error";
                }
            } finally {
                DBConnection.closeStatement(pstmt);
                DBConnection.closeConnection(conn);
            }
        }
        %>
        
        <% if (!message.isEmpty()) { %>
            <div class="message <%= messageType %>">
                <%= message %>
            </div>
        <% } %>
        
        <form method="post" action="addStudent.jsp">
            <div class="form-group">
                <label for="studentId">Student ID:</label>
                <input type="number" id="studentId" name="studentId" required>
            </div>
            
            <div class="form-group">
                <label for="name">Student Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="course">Course:</label>
                <input type="text" id="course" name="course" required>
            </div>
            
            <div class="form-group">
                <label for="marks">Marks:</label>
                <input type="number" id="marks" name="marks" step="0.01" min="0" max="100" required>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Add Student</button>
                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        </form>
    </div>
</body>
</html>
