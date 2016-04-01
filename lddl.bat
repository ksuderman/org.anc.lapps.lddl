:: Startup script for LDDL. Change the LDDL installation directory
:: below if needed. This script should be in the same directory as
:: the .jar file.

@ECHO OFF
SET MEMSIZE=4G
SET VERSION=1.3.4
FOR %%F in (lddl-%VERSION%.jar) do set JAR=%%~$PATH:F

java -jar %JAR% %*
