@echo off
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.504.1-hotspot"
set "JRE_HOME=C:\Program Files\Eclipse Adoptium\jdk-8.0.504.1-hotspot"
set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Apache Tomcat 8.0.27"
set "CATALINA_BASE=%~dp0tomcat-instance"

echo ========================================================
echo Starting Student Skill Management System on Port 8085...
echo ========================================================
echo URL: http://localhost:8085
echo.

"%CATALINA_HOME%\bin\catalina.bat" run
