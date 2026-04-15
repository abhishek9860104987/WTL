package com.example;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/books")
public class SimpleBookServlet extends HttpServlet {
    
    private static List<String> books = new ArrayList<>();
    
    static {
        // Add some sample books
        books.add("The Great Gatsby - F. Scott Fitzgerald - 1925 - $12.99");
        books.add("1984 - George Orwell - 1949 - $13.99");
        books.add("To Kill a Mockingbird - Harper Lee - 1960 - $14.99");
        books.add("Pride and Prejudice - Jane Austen - 1813 - $11.99");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("books", books);
        request.getRequestDispatcher("books.jsp").forward(request, response);
    }
}
