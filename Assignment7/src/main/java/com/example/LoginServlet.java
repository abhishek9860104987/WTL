package com.example;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        super.init();
        DatabaseUtil.createUserTable();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                
                request.setAttribute("error", "Username and password are required!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            User user = DatabaseUtil.validateUser(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("email", user.getEmail());
                
                response.sendRedirect("welcome.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during login. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
