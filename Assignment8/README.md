# Student Management System - JSP Project

A simple JSP web application for managing student records with database integration.

## Features

- Add new students with ID, name, course, and marks
- View all students with statistics
- Modern, responsive UI
- Database connectivity with MySQL

## Prerequisites

1. Apache Tomcat 11.0.21 or later
2. MySQL Server
3. MySQL Connector/J driver
4. JDK 11 or later

## Database Setup

1. Create a MySQL database named `student_db`
2. Execute the SQL script `create_database.sql` to create the students table
3. Update database credentials in `DBConnection.java` if needed:

```java
private static final String JDBC_URL = "jdbc:mysql://localhost:3306/student_db";
private static final String JDBC_USER = "root";
private static final String JDBC_PASSWORD = "your_password";
```

## Installation Steps

1. **Compile the Java utility class:**
   ```bash
   javac -cp "path_to_mysql_connector.jar" DBConnection.java
   ```

2. **Place the MySQL Connector/J JAR file** in the `WEB-INF/lib` directory

3. **Deploy the application** to Tomcat's webapps directory

4. **Create WEB-INF structure** (if not exists):
   ```
   WEB-INF/
   |-- lib/
   |-- web.xml
   ```

5. **Create web.xml** in WEB-INF directory:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee 
         https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">
    
    <display-name>Student Management System</display-name>
    <description>A JSP application for managing student records</description>
    
</web-app>
```

## Usage

1. Start Tomcat server
2. Open browser and navigate to: `http://localhost:8080/demo/`
3. Use the navigation to:
   - Add new students
   - View all students with statistics

## Project Structure

```
demo/
|-- index.jsp              # Main navigation page
|-- addStudent.jsp         # Form to add students
|-- viewStudents.jsp       # Display all students
|-- DBConnection.java      # Database utility class
|-- create_database.sql    # SQL script for database setup
|-- README.md             # This file
```

## Database Schema

```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    course VARCHAR(50) NOT NULL,
    marks DECIMAL(5,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Notes

- The application uses MySQL as the database
- Student ID must be unique
- Marks should be between 0 and 100
- All pages include navigation back to home

## Troubleshooting

1. **Database Connection Error**: Check MySQL service and credentials
2. **Class Not Found**: Ensure MySQL Connector/J JAR is in WEB-INF/lib
3. **Compilation Error**: Make sure JDK is properly configured
