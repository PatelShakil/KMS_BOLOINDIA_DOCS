@echo off
SET KONG_ADMIN=http://localhost:8001

echo =========================================
echo Creating Kong Routes
echo =========================================

REM ------------------------------------------------
REM auth-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/auth-service/routes ^
 --data "name=auth-service-auth" ^
 --data "paths[]=/auth" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

REM ------------------------------------------------
REM org-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/org-service/routes ^
 --data "name=org-service-org" ^
 --data "paths[]=/org" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

REM ------------------------------------------------
REM qr-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/qr-service/routes ^
 --data "name=qr-service-qr" ^
 --data "paths[]=/qr" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

REM ------------------------------------------------
REM service-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/service-service/routes ^
 --data "name=service-service-services" ^
 --data "paths[]=/services" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

REM ------------------------------------------------
REM notification-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/notification-service/routes ^
 --data "name=notification-service-notifications" ^
 --data "paths[]=/notifications" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

curl -i -X POST %KONG_ADMIN%/services/notification-service/routes ^
 --data "name=notification-service-preferences" ^
 --data "paths[]=/preferences" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

curl -i -X POST %KONG_ADMIN%/services/notification-service/routes ^
 --data "name=notification-service-webhook" ^
 --data "paths[]=/webhook" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

REM ------------------------------------------------
REM response-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/response-service/routes ^
 --data "name=response-service-analytics" ^
 --data "paths[]=/analytics" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

curl -i -X POST %KONG_ADMIN%/services/response-service/routes ^
 --data "name=response-service-responses" ^
 --data "paths[]=/responses" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

curl -i -X POST %KONG_ADMIN%/services/response-service/routes ^
 --data "name=response-service-export" ^
 --data "paths[]=/export" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

REM ------------------------------------------------
REM feedback-service
REM ------------------------------------------------
curl -i -X POST %KONG_ADMIN%/services/feedback-service/routes ^
 --data "name=feedback-service-forms" ^
 --data "paths[]=/forms" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

curl -i -X POST %KONG_ADMIN%/services/feedback-service/routes ^
 --data "name=feedback-service-templates" ^
 --data "paths[]=/templates" ^
 --data "protocols[]=http" ^
 --data "protocols[]=https" ^
 --data "strip_path=false"

echo =========================================
echo All Routes Created Successfully
echo =========================================
pause
