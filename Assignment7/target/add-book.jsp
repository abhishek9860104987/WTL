<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Book</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .add-book-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .required::after {
            content: " *";
            color: #e74c3c;
        }
        
        .form-hint {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .add-book-container {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="add-book-container">
            <h2>Add New Book</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="books" method="post" class="auth-form">
                <div class="form-row">
                    <div class="form-group">
                        <label for="title" class="required">Book Title:</label>
                        <input type="text" id="title" name="title" required 
                               placeholder="Enter book title" maxlength="255">
                    </div>
                    
                    <div class="form-group">
                        <label for="author" class="required">Author:</label>
                        <input type="text" id="author" name="author" required 
                               placeholder="Enter author name" maxlength="100">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="isbn">ISBN:</label>
                        <input type="text" id="isbn" name="isbn" 
                               placeholder="Enter ISBN (optional)" maxlength="20">
                        <div class="form-hint">ISBN should be unique if provided</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="publisher">Publisher:</label>
                        <input type="text" id="publisher" name="publisher" 
                               placeholder="Enter publisher name" maxlength="100">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="genre">Genre:</label>
                        <select id="genre" name="genre">
                            <option value="">Select Genre</option>
                            <option value="Fiction">Fiction</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Science Fiction">Science Fiction</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="Mystery">Mystery</option>
                            <option value="Thriller">Thriller</option>
                            <option value="Romance">Romance</option>
                            <option value="Biography">Biography</option>
                            <option value="History">History</option>
                            <option value="Self-Help">Self-Help</option>
                            <option value="Technical">Technical</option>
                            <option value="Educational">Educational</option>
                            <option value="Children">Children</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="publicationYear">Publication Year:</label>
                        <input type="number" id="publicationYear" name="publicationYear" 
                               placeholder="e.g., 2023" min="1000" max="2100">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" 
                           placeholder="Enter price (optional)" step="0.01" min="0">
                    <div class="form-hint">Enter price in your currency</div>
                </div>
                
                <div class="form-actions" style="display: flex; gap: 15px; margin-top: 25px;">
                    <button type="submit" class="btn btn-primary">Add Book</button>
                    <a href="books" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        document.querySelector('.auth-form').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const author = document.getElementById('author').value.trim();
            
            if (title === '' || author === '') {
                e.preventDefault();
                alert('Title and Author are required fields!');
                return false;
            }
            
            const year = document.getElementById('publicationYear').value;
            if (year && (year < 1000 || year > 2100)) {
                e.preventDefault();
                alert('Please enter a valid publication year between 1000 and 2100!');
                return false;
            }
            
            const price = document.getElementById('price').value;
            if (price && parseFloat(price) < 0) {
                e.preventDefault();
                alert('Price cannot be negative!');
                return false;
            }
        });
    </script>
</body>
</html>
