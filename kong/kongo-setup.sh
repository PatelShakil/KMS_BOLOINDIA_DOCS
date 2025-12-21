#!/bin/bash

KONG_ADMIN="http://localhost:8001"
HOST="host.docker.internal"

echo "🚀 BoloIndia Kong Gateway Setup"
echo "================================"
echo ""

# Function to add service
add_service() {
    local name=$1
    local port=$2
    local path=$3
    local route_path=$4
    
    echo "📦 Adding ${name}..."
    
    # Add service
    curl -s -X POST ${KONG_ADMIN}/services \
      --data "name=${name}" \
      --data "url=http://${HOST}:${port}${path}" > /dev/null
    
    # Add route
    curl -s -X POST ${KONG_ADMIN}/services/${name}/routes \
      --data "name=${name}-route" \
      --data "paths[]=${route_path}" \
      --data "strip_path=true" > /dev/null
    
    echo "   ✅ ${name} configured"
}

# Check if Kong is running
if ! curl -s ${KONG_ADMIN}/ > /dev/null; then
    echo "❌ Kong Admin API not accessible at ${KONG_ADMIN}"
    echo "   Make sure Kong is running: docker ps | grep kong"
    exit 1
fi

echo "✅ Kong Admin API is accessible"
echo ""

# Add all services
add_service "auth-service" "8085" "/auth-service/api" "/api/auth"
add_service "org-service" "8086" "/org-service/api" "/api/organizations"
add_service "service-service" "8087" "/service-service/api" "/api/services"
add_service "qr-service" "8090" "/qr-service/api" "/api/qr"
add_service "feedback-service" "8088" "/api" "/api/feedback"
add_service "response-service" "8089" "/api" "/api/responses"
add_service "notification-service" "8092" "/api" "/api/notifications"

echo ""
echo "🔌 Enabling Plugins..."

# Enable CORS globally
curl -s -X POST ${KONG_ADMIN}/plugins \
  --data "name=cors" \
  --data "config.origins=*" \
  --data "config.methods=GET" \
  --data "config.methods=POST" \
  --data "config.methods=PUT" \
  --data "config.methods=DELETE" \
  --data "config.methods=PATCH" \
  --data "config.methods=OPTIONS" \
  --data "config.headers=Accept" \
  --data "config.headers=Authorization" \
  --data "config.headers=Content-Type" \
  --data "config.credentials=true" \
  --data "config.max_age=3600" > /dev/null

echo "   ✅ CORS enabled"

# Enable Rate Limiting
curl -s -X POST ${KONG_ADMIN}/plugins \
  --data "name=rate-limiting" \
  --data "config.minute=100" \
  --data "config.hour=1000" \
  --data "config.policy=local" > /dev/null

echo "   ✅ Rate Limiting enabled (100/min, 1000/hour)"

# Enable Logging
curl -s -X POST ${KONG_ADMIN}/plugins \
  --data "name=file-log" \
  --data "config.path=/tmp/kong.log" > /dev/null

echo "   ✅ File Logging enabled"

echo ""
echo "📊 Current Configuration:"
echo "========================"
curl -s ${KONG_ADMIN}/services | jq -r '.data[] | "   🔹 \(.name) → \(.protocol)://\(.host):\(.port)\(.path)"'

echo ""
echo "✅ Kong Gateway Setup Complete!"
echo ""
echo "🌐 Gateway URL:    http://localhost:8000"
echo "⚙️  Admin API:     http://localhost:8001"
echo "📚 Documentation: http://localhost:8001/routes"
echo ""
echo "🧪 Test Commands:"
echo "   curl http://localhost:8000/api/auth/health"
echo "   curl http://localhost:8000/api/organizations/health"
echo ""
