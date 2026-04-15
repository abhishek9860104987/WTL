@echo off
echo Starting Tomcat...
set CATALINA_HOME=C:\tomcot\apache-tomcat-11.0.21
set JAVA_HOME=C:\Program Files\Java\jdk-22
C:\tomcot\apache-tomcat-11.0.21\bin\startup.bat
echo Tomcat should be starting...
echo Access application at: http://localhost:8080/login-app/
pause
