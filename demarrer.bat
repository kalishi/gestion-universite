@echo off
REM Deploie UNAF sur Tomcat 10.1 et ouvre l'application dans le navigateur.
REM Prerequis : MySQL demarre + le fichier target\unaf.war construit
REM (dans Eclipse : clic droit sur le projet > Run As > Maven build... > Goals : clean package)
cd /d "%~dp0"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "CATALINA_HOME=C:\apache-tomcat-10.1.53"

if not exist "target\unaf.war" (
    echo [ERREUR] target\unaf.war introuvable.
    echo Dans Eclipse : clic droit sur le projet ^> Run As ^> Maven build... ^> Goals : clean package ^> Run
    pause
    exit /b 1
)

echo Arret de Tomcat s'il tourne deja...
call "%CATALINA_HOME%\bin\shutdown.bat" >nul 2>&1
timeout /t 3 /nobreak >nul

if exist "%CATALINA_HOME%\webapps\unaf" rmdir /s /q "%CATALINA_HOME%\webapps\unaf"
if exist "%CATALINA_HOME%\webapps\inscriptions" rmdir /s /q "%CATALINA_HOME%\webapps\inscriptions"
if exist "%CATALINA_HOME%\webapps\inscriptions.war" del /q "%CATALINA_HOME%\webapps\inscriptions.war"
copy /Y "target\unaf.war" "%CATALINA_HOME%\webapps\" >nul
echo Deploiement de unaf.war...

call "%CATALINA_HOME%\bin\startup.bat"
echo Attente du demarrage...
timeout /t 12 /nobreak >nul
start "" http://localhost:8080/unaf/
