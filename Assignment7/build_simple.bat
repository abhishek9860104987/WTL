@echo off
echo Building Simple Book Application...

cd target
jar cf simple-book-app.war .

echo Deploying to Tomcat...
copy simple-book-app.war C:\tomcot\apache-tomcat-11.0.21\webapps\

echo Simple Book App deployed!
echo Access at: http://localhost:8080/simple-book-app/
pause
