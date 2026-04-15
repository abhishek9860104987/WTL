package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        super.init();
        DatabaseUtil.createUserTable();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        try {
            if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                
                request.setAttribute("error", "All fields are required!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if (username.length() < 3) {
                request.setAttribute("error", "Username must be at least 3 characters long!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if (password.length() < 6) {
                request.setAttribute("error", "Password must be at least 6 characters long!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if (DatabaseUtil.userExists(username)) {
                request.setAttribute("error", "Username already exists! Please choose another one.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            if (DatabaseUtil.emailExists(email)) {
                request.setAttribute("error", "Email already registered! Please use another email.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            
            User user = new User(username, email, password);
            
            if (DatabaseUtil.insertUser(user)) {
                request.setAttribute("success", "Registration successful! Please login with your credentials.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed! Please try again.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during registration. Please try again.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
