<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Book" %>
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
        
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .empty-state h3 {
            margin-bottom: 10px;
            color: #999;
        }
        
        .book-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn-small {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        @media (max-width: 768px) {
            .books-table {
                font-size: 14px;
            }
            
            .books-table th,
            .books-table td {
                padding: 8px;
            }
            
            .books-header {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="books-container">
            <div class="books-header">
                <h2>Books Management</h2>
                <a href="books?action=add" class="btn btn-primary">Add New Book</a>
            </div>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% 
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) { 
            %>
                <table class="books-table">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>ISBN</th>
                            <th>Publisher</th>
                            <th>Genre</th>
                            <th>Year</th>
                            <th>Price</th>
                            <th>Added</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Book book : books) { %>
                            <tr>
                                <td><%= book.getTitle() %></td>
                                <td><%= book.getAuthor() %></td>
                                <td><%= book.getIsbn().isEmpty() ? "-" : book.getIsbn() %></td>
                                <td><%= book.getPublisher().isEmpty() ? "-" : book.getPublisher() %></td>
                                <td><%= book.getGenre().isEmpty() ? "-" : book.getGenre() %></td>
                                <td><%= book.getPublicationYear() == 0 ? "-" : book.getPublicationYear() %></td>
                                <td><%= book.getPrice() == 0.0 ? "-" : "$" + String.format("%.2f", book.getPrice()) %></td>
                                <td><%= book.getCreatedAt() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <h3>No Books Found</h3>
                    <p>Start by adding your first book to the collection.</p>
                    <a href="books?action=add" class="btn btn-primary">Add Your First Book</a>
                </div>
            <% } %>
            
            <div class="actions" style="margin-top: 30px;">
                <a href="welcome.jsp" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>
