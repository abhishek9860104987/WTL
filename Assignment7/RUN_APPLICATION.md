# How to Run the Book Management Application

## Step 1: Setup Database

### Option A: Using MySQL Command Line
```bash
mysql -u root -p < database_setup.sql
```

### Option B: Using MySQL Workbench
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Open SQL editor
4. Copy contents of `database_setup.sql`
5. Execute all commands

## Step 2: Compile and Build Application

### Option A: Using Maven (Recommended)
```bash
cd "c:\Users\ABHISHEK\Downloads\study material\6th sem\WTL lab\Assignment7"
mvn clean package
```

### Option B: Manual Compilation
```bash
# Set classpath (adjust paths as needed)
set CLASSPATH="C:\path\to\servlet-api.jar;C:\path\to\mysql-connector-java.jar"

# Compile Java files
javac -cp %CLASSPATH% src\main\java\com\example\*.java

# Create WAR file
jar -cvf login-app.war -C src\main\webapp .
```

## Step 3: Deploy to Tomcat

### Option A: Copy WAR file
```bash
# Copy the generated WAR file to Tomcat webapps directory
copy target\login-app.war "C:\path\to\apache-tomcat-9.0\webapps\"
```

### Option B: Copy expanded directory
```bash
# Copy the entire webapp directory
xcopy src\main\webapp "C:\path\to\apache-tomcat-9.0\webapps\login-app\" /E /I
copy src\main\java\com\example\*.class "C:\path\to\apache-tomcat-9.0\webapps\login-app\WEB-INF\classes\com\example\"
```

## Step 4: Start Tomcat

```bash
# Navigate to Tomcat bin directory
cd "C:\path\to\apache-tomcat-9.0\bin"

# Start Tomcat
startup.bat
```

## Step 5: Access Application

Open your web browser and go to:
```
http://localhost:8080/login-app/
```

## Default Login Credentials (from sample data):
- Username: `admin`, Password: `admin123`
- Username: `john_doe`, Password: `password123`
- Username: `jane_smith`, Password: `password123`

## Troubleshooting

### Database Connection Issues:
- Verify MySQL is running on port 3307
- Check username: `root` and password: `Abhishek@123`
- Ensure database `wtlass7` exists

### Compilation Issues:
- Ensure Maven is installed and in PATH
- Or manually add servlet-api.jar and mysql-connector-java.jar to classpath

### Tomcat Issues:
- Check if port 8080 is available
- Verify Tomcat installation
- Check Tomcat logs in `logs/catalina.out`

### Application Not Loading:
- Verify WAR file is deployed correctly
- Check web.xml configuration
- Ensure all JSP files are in correct locations
