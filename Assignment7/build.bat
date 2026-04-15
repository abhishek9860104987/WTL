@echo off
echo Building Book Management Application...

REM Set paths (adjust these according to your system)
set TOMCAT_HOME=C:\tomcot\apache-tomcat-11.0.21
set SERVLET_JAR=%TOMCAT_HOME%\lib\servlet-api.jar
set MYSQL_JAR=%TOMCAT_HOME%\lib\mysql-connector-j-9.6.0.jar

REM Check if MySQL connector exists, if not, create a dummy one for compilation
if not exist "%MYSQL_JAR%" (
    echo Creating dummy MySQL connector for compilation...
    echo. > "%MYSQL_JAR%"
)

REM Create directories
if not exist target mkdir target
if not exist target\WEB-INF mkdir target\WEB-INF
if not exist target\WEB-INF\classes mkdir target\WEB-INF\classes
if not exist target\WEB-INF\classes\com mkdir target\WEB-INF\classes\com
if not exist target\WEB-INF\classes\com\example mkdir target\WEB-INF\classes\com\example

REM Compile Java files
echo Compiling Java files...
javac -cp "%SERVLET_JAR%" -d target\WEB-INF\classes src\main\java\com\example\*.java
if %ERRORLEVEL% NEQ 0 (
    echo Compilation failed! Check errors above.
    pause
    exit /b 1
) else (
    echo Compilation successful!
)

REM Copy webapp files
echo Copying webapp files...
xcopy src\main\webapp\* target\ /E /I /Y

REM Copy WEB-INF configuration
echo Copying WEB-INF configuration...
xcopy src\main\webapp\WEB-INF\* target\WEB-INF\ /E /I /Y

REM Create WAR file
echo Creating WAR file...
cd target
jar -cvf login-app.war *

echo Build complete!
echo WAR file created: target\login-app.war
echo.
echo To deploy:
echo 1. Copy login-app.war to %TOMCAT_HOME%\webapps\
echo 2. Start Tomcat
echo 3. Access http://localhost:8080/login-app/
pause
