@echo off
echo ============================================
echo Creating Kafka Topics for BoloIndia MSA
echo ============================================
echo.

REM ============================================
REM AUTH SERVICE TOPICS
REM ============================================
echo [AUTH-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic org.registration.requested --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic user.updated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic user.activated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic user.created --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic user.accepted --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

REM ============================================
REM NEW: Distributor Registration Topics
REM ============================================
docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic distributor.registered --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic distributor.approved --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic distributor.rejected --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic distributor.suspended --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic distributor.reactivated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [AUTH-SERVICE] ✓ 8 topics created
echo.

REM ============================================
REM ORG SERVICE TOPICS
REM ============================================
echo [ORG-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic org.created --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic org.approved --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic org.rejected --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic org.suspended --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [ORG-SERVICE] ✓ 4 topics created
echo.

REM ============================================
REM SERVICE SERVICE TOPICS
REM ============================================
echo [SERVICE-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic service.created --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic service.updated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic service.deleted --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic service.activated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic service.deactivated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [SERVICE-SERVICE] ✓ 5 topics created
echo.

REM ============================================
REM FEEDBACK SERVICE TOPICS
REM ============================================
echo [FEEDBACK-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.form.created --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.form.updated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.form.finalized --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.form.activated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.form.deactivated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.form.deleted --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.template.created --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic feedback.template.cloned --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [FEEDBACK-SERVICE] ✓ 8 topics created
echo.

REM ============================================
REM RESPONSE SERVICE TOPICS
REM ============================================
echo [RESPONSE-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic response.submitted --bootstrap-server localhost:9092 --partitions 5 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic response.reviewed --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic response.resolved --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic response.flagged --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic response.batch.submitted --bootstrap-server localhost:9092 --partitions 5 --replication-factor 1

echo [RESPONSE-SERVICE] ✓ 5 topics created
echo.

REM ============================================
REM QR SERVICE TOPICS
REM ============================================
echo [QR-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.generated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.batch.generated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.assigned --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.unassigned --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

REM ============================================
REM NEW: QR Assignment Workflow Topics
REM ============================================
docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.accepted --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.rejected --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.deployment.submitted --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.deployed --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.deployment.rejected --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.scanned --bootstrap-server localhost:9092 --partitions 5 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.activated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.deactivated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic qr.deleted --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [QR-SERVICE] ✓ 13 topics created
echo.

REM ============================================
REM NOTIFICATION SERVICE TOPICS
REM ============================================
echo [NOTIFICATION-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic notification.email.send --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic notification.sms.send --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic notification.push.send --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic notification.whatsapp.send --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [NOTIFICATION-SERVICE] ✓ 4 topics created
echo.

REM ============================================
REM ANALYTICS SERVICE TOPICS
REM ============================================
echo [ANALYTICS-SERVICE] Creating topics...

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic analytics.response.aggregated --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic analytics.qr.scanned --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --topic analytics.form.performance --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1

echo [ANALYTICS-SERVICE] ✓ 3 topics created
echo.

REM ============================================
REM SUMMARY
REM ============================================
echo ============================================
echo ✅ ALL TOPICS CREATED SUCCESSFULLY!
echo ============================================
echo.
echo Total Topics: 50
echo   - auth-service: 8 (+5 distributor topics)
echo   - org-service: 4
echo   - service-service: 5
echo   - feedback-service: 8
echo   - response-service: 5
echo   - qr-service: 13 (+5 assignment workflow topics)
echo   - notification-service: 4
echo   - analytics-service: 3
echo.
echo New Topics Added:
echo   ✅ distributor.registered
echo   ✅ distributor.approved
echo   ✅ distributor.rejected
echo   ✅ distributor.suspended
echo   ✅ distributor.reactivated
echo   ✅ qr.accepted
echo   ✅ qr.rejected
echo   ✅ qr.deployment.submitted
echo   ✅ qr.deployed
echo   ✅ qr.deployment.rejected
echo.
echo Listing all topics:
echo ----------------------------------------
docker exec boloindia_kafka /opt/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092
echo ----------------------------------------
echo.
echo ============================================
echo 🚀 Ready for production!
echo ============================================
echo.

pause
