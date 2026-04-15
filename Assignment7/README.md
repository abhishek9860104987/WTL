# Login and Signup Application using Java Servlets

This is a complete web application that demonstrates user authentication functionality using Java Servlets, JSP, and MySQL database.

## Features

- User Registration (Signup)
- User Login (Authentication)
- Session Management
- Password Confirmation
- Input Validation
- Responsive Design
- Error Handling

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── example/
│   │           ├── User.java              # User model class
│   │           ├── DatabaseUtil.java      # Database utility class
│   │           ├── LoginServlet.java      # Login servlet
│   │           ├── SignupServlet.java     # Signup servlet
│   │           └── LogoutServlet.java     # Logout servlet
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml                   # Deployment descriptor
│       ├── css/
│       │   └── style.css                 # Stylesheet
│       ├── login.html                     # Login page
│       ├── signup.html                    # Signup page
│       └── welcome.html                   # Welcome page
```

## Prerequisites

1. **Java Development Kit (JDK)** - Version 8 or higher
2. **Apache Tomcat** - Version 9 or higher
3. **MySQL Database** - Version 5.7 or higher
4. **MySQL Connector/J** - JDBC driver

## Database Setup

1. **Create Database:**
   ```sql
   CREATE DATABASE userdb;
   ```

2. **Update Database Configuration:**
   - Open `src/main/java/com/example/DatabaseUtil.java`
   - Update the database URL, username, and password:
   ```java
   private static final String JDBC_URL = "jdbc:mysql://localhost:3306/userdb";
   private static final String JDBC_USERNAME = "root";
   private static final String JDBC_PASSWORD = "your_password";
   ```

## Dependencies

Add the following dependencies to your project (if using Maven):

```xml
<dependencies>
    <!-- Servlet API -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>4.0.1</version>
        <scope>provided</scope>
    </dependency>
    
    <!-- MySQL Connector -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.33</version>
    </dependency>
    
    <!-- JSP API -->
    <dependency>
        <groupId>javax.servlet.jsp</groupId>
        <artifactId>javax.servlet.jsp-api</artifactId>
        <version>2.3.3</version>
        <scope>provided</scope>
    </dependency>
</dependencies>
```

## Deployment Instructions

### Option 1: Using Command Line

1. **Compile the Java files:**
   ```bash
   javac -cp "servlet-api.jar:mysql-connector-java.jar" src/main/java/com/example/*.java
   ```

2. **Create WAR file:**
   ```bash
   jar -cvf login-app.war -C src/main/webapp .
   ```

3. **Deploy to Tomcat:**
   - Copy `login-app.war` to Tomcat's `webapps` directory
   - Start Tomcat server

### Option 2: Using IDE (Eclipse/IntelliJ)

1. **Create a Dynamic Web Project**
2. **Copy the source files** to the appropriate directories
3. **Add the MySQL connector JAR** to the project's lib folder
4. **Run the project** on the server

## Accessing the Application

Once deployed, access the application at:
```
http://localhost:8080/login-app/
```

## Usage

1. **Signup:**
   - Navigate to the signup page
   - Fill in username, email, password, and confirm password
   - Click "Sign Up"

2. **Login:**
   - Navigate to the login page
   - Enter your username and password
   - Click "Login"

3. **Logout:**
   - After successful login, click "Logout" to end the session

## Security Notes

- **Password Storage:** In a production environment, passwords should be hashed using algorithms like BCrypt or Argon2
- **Input Validation:** The application includes basic validation, but additional security measures should be implemented
- **Session Management:** Sessions are properly invalidated on logout
- **SQL Injection:** Prepared statements are used to prevent SQL injection

## File Descriptions

### Java Classes

- **User.java:** Model class representing a user with id, username, email, and password
- **DatabaseUtil.java:** Utility class for database operations including connection management and CRUD operations
- **LoginServlet.java:** Handles user authentication and session creation
- **SignupServlet.java:** Handles user registration with validation
- **LogoutServlet.java:** Handles session invalidation and logout

### Web Pages

- **login.html:** Login form with validation and error display
- **signup.html:** Registration form with password confirmation
- **welcome.html:** Dashboard page displayed after successful login

### Configuration

- **web.xml:** Deployment descriptor defining servlet mappings and application configuration
- **style.css:** Responsive CSS styling for all pages

## Troubleshooting

1. **Database Connection Error:**
   - Verify MySQL is running
   - Check database credentials in DatabaseUtil.java
   - Ensure MySQL connector JAR is in the classpath

2. **Servlet Not Found Error:**
   - Verify web.xml configuration
   - Check servlet annotations
   - Ensure proper deployment structure

3. **404 Error:**
   - Verify the application context path
   - Check if WAR file is properly deployed

## Enhancements

Possible improvements for production use:

- Password hashing (BCrypt)
- Email verification
- Password reset functionality
- Remember me feature
- Account lockout after failed attempts
- CSRF protection
- HTTPS enforcement
- Logging and monitoring
