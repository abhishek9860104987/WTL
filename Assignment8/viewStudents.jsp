<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.db.DBConnection, java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>View All Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1000px;
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
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
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
        .stats {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .stat-item {
            text-align: center;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
        .stat-label {
            color: #666;
            font-size: 14px;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>All Students</h1>
        
        <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        boolean hasError = false;
        String errorMessage = "";
        
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM students ORDER BY id";
            rs = stmt.executeQuery(sql);
            
            // Calculate statistics
            ResultSet statsRs = conn.createStatement().executeQuery(
                "SELECT COUNT(*) as total, AVG(marks) as avg_marks, MAX(marks) as max_marks, MIN(marks) as min_marks FROM students");
            
            int totalStudents = 0;
            double avgMarks = 0;
            double maxMarks = 0;
            double minMarks = 0;
            
            if (statsRs.next()) {
                totalStudents = statsRs.getInt("total");
                avgMarks = statsRs.getDouble("avg_marks");
                maxMarks = statsRs.getDouble("max_marks");
                minMarks = statsRs.getDouble("min_marks");
            }
            statsRs.close();
        %>
        
        <% if (totalStudents > 0) { %>
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-value"><%= totalStudents %></div>
                    <div class="stat-label">Total Students</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><%= String.format("%.2f", avgMarks) %></div>
                    <div class="stat-label">Average Marks</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><%= String.format("%.2f", maxMarks) %></div>
                    <div class="stat-label">Highest Marks</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><%= String.format("%.2f", minMarks) %></div>
                    <div class="stat-label">Lowest Marks</div>
                </div>
            </div>
        <% } %>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Course</th>
                        <th>Marks</th>
                        <th>Added Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String course = rs.getString("course");
                        double marks = rs.getDouble("marks");
                        Timestamp createdDate = rs.getTimestamp("created_at");
                    %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= course %></td>
                            <td><%= String.format("%.2f", marks) %></td>
                            <td><%= createdDate != null ? createdDate.toString() : "N/A" %></td>
                        </tr>
                    <%
                    }
                    
                    if (!hasData) {
                    %>
                        <tr>
                            <td colspan="5" class="no-data">
                                No students found in the database. <a href="addStudent.jsp">Add a student</a> to get started.
                            </td>
                        </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <%
        } catch (SQLException e) {
            hasError = true;
            errorMessage = "Database error: " + e.getMessage();
        } catch (Exception e) {
            hasError = true;
            errorMessage = "Error: " + e.getMessage();
        } finally {
            DBConnection.closeResultSet(rs);
            DBConnection.closeStatement(stmt);
            DBConnection.closeConnection(conn);
        }
        
        if (hasError) {
        %>
            <div class="error">
                <%= errorMessage %>
            </div>
        <% }
        %>
        
        <div class="button-group">
            <a href="addStudent.jsp" class="btn btn-primary">Add New Student</a>
            <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
