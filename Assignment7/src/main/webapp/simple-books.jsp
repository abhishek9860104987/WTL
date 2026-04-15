<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books Management</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .books-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        
        .books-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .books-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .books-table th,
        .books-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e1e1e1;
        }
        
        .books-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        
        .books-table tr:hover {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="books-container">
            <div class="books-header">
                <h2>Books Management</h2>
                <a href="login.jsp" class="btn btn-secondary">Back to Login</a>
            </div>
            
            <table class="books-table">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Publication Year</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<String> books = (List<String>) request.getAttribute("books");
                    if (books != null && !books.isEmpty()) { 
                        for (String book : books) { 
                            String[] parts = book.split(" - ");
                    %>
                    <tr>
                        <td><%= parts[0] %></td>
                        <td><%= parts.length > 1 ? parts[1] : "" %></td>
                        <td><%= parts.length > 2 ? parts[2] : "" %></td>
                        <td><%= parts.length > 3 ? parts[3] : "" %></td>
                    </tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
            
            <% if (books == null || books.isEmpty()) { %>
                <div style="text-align: center; padding: 40px; color: #666;">
                    <h3>No Books Found</h3>
                    <p>Sample books will be displayed here.</p>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
