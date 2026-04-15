package com.example;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        super.init();
        DatabaseUtil.createBookTable();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            request.getRequestDispatcher("add-book.jsp").forward(request, response);
        } else {
            List<Book> books = DatabaseUtil.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("books.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        String genre = request.getParameter("genre");
        String publicationYearStr = request.getParameter("publicationYear");
        String priceStr = request.getParameter("price");
        
        try {
            if (title == null || title.trim().isEmpty() ||
                author == null || author.trim().isEmpty()) {
                
                request.setAttribute("error", "Title and Author are required!");
                request.getRequestDispatcher("add-book.jsp").forward(request, response);
                return;
            }
            
            int publicationYear = 0;
            if (publicationYearStr != null && !publicationYearStr.trim().isEmpty()) {
                try {
                    publicationYear = Integer.parseInt(publicationYearStr);
                    if (publicationYear < 1000 || publicationYear > 2100) {
                        request.setAttribute("error", "Please enter a valid publication year!");
                        request.getRequestDispatcher("add-book.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Publication year must be a valid number!");
                    request.getRequestDispatcher("add-book.jsp").forward(request, response);
                    return;
                }
            }
            
            double price = 0.0;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                try {
                    price = Double.parseDouble(priceStr);
                    if (price < 0) {
                        request.setAttribute("error", "Price cannot be negative!");
                        request.getRequestDispatcher("add-book.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Price must be a valid number!");
                    request.getRequestDispatcher("add-book.jsp").forward(request, response);
                    return;
                }
            }
            
            if (isbn != null && !isbn.trim().isEmpty() && DatabaseUtil.isbnExists(isbn)) {
                request.setAttribute("error", "ISBN already exists! Please use a different ISBN.");
                request.getRequestDispatcher("add-book.jsp").forward(request, response);
                return;
            }
            
            Book book = new Book(title.trim(), author.trim(), 
                               isbn != null ? isbn.trim() : "", 
                               publisher != null ? publisher.trim() : "", 
                               genre != null ? genre.trim() : "", 
                               publicationYear, price);
            
            if (DatabaseUtil.insertBook(book)) {
                request.setAttribute("success", "Book added successfully!");
                List<Book> books = DatabaseUtil.getAllBooks();
                request.setAttribute("books", books);
                request.getRequestDispatcher("books.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to add book! Please try again.");
                request.getRequestDispatcher("add-book.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while adding the book. Please try again.");
            request.getRequestDispatcher("add-book.jsp").forward(request, response);
        }
    }
}
