@echo off
SET KONG_ADMIN=http://localhost:8001

echo =========================================
echo Creating Kong Services
echo =========================================

REM ---------------------------------
REM auth-service (6001:8080)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=auth-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6001" ^
 --data "path=/auth-service/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

REM ---------------------------------
REM org-service (6002:8080)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=org-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6002" ^
 --data "path=/org-service/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

REM ---------------------------------
REM qr-service (6003:8080)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=qr-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6003" ^
 --data "path=/qr-service/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

REM ---------------------------------
REM service-service (6004:8080)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=service-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6004" ^
 --data "path=/service-service/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

REM ---------------------------------
REM feedback-service (6005:6005)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=feedback-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6005" ^
 --data "path=/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

REM ---------------------------------
REM response-service (6006:6006)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=response-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6006" ^
 --data "path=/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

REM ---------------------------------
REM notification-service (6007:6007)
REM ---------------------------------
curl -i -X POST %KONG_ADMIN%/services ^
 --data "name=notification-service" ^
 --data "protocol=http" ^
 --data "host=host.docker.internal" ^
 --data "port=6007" ^
 --data "path=/api" ^
 --data "connect_timeout=60000" ^
 --data "read_timeout=60000" ^
 --data "write_timeout=60000" ^
 --data "retries=5"

echo =========================================
echo All Kong Services Created
echo =========================================
pause
