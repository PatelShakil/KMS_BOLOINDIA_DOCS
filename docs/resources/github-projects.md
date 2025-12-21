---
id: github-projects
title: GitHub Repositories & Downloads
sidebar_label: GitHub Projects
slug: /resources/github-projects
---

# BoloIndia GitHub Repositories

All BoloIndia microservices, frontends, and mobile apps are open source and available on GitHub. Clone any repository to contribute or deploy locally.

## 🔧 Backend Microservices (7 Services)

### 1. Auth Service
Authentication, JWT, multi-tenant user management.

```
git clone https://github.com/PatelShakil/FMS_AUTH_SERVICE.git
cd FMS_AUTH_SERVICE
```

**Tech Stack:** Jakarta EE, PostgreSQL, Payara Micro  
**Port:** 6001

---

### 2. Organization Service
Organization registration, approval workflows, tenant management.

```
git clone https://github.com/PatelShakil/FMS_ORG_SERVICE.git
cd FMS_ORG_SERVICE
```

**Tech Stack:** Jakarta EE, PostgreSQL, Kafka  
**Port:** 6002

---

### 3. QR Service
QR code generation, deployment tracking, analytics.

```
git clone https://github.com/PatelShakil/FMS_QR_SERVICE.git
cd FMS_QR_SERVICE
```

**Tech Stack:** Jakarta EE, PostgreSQL, MinIO  
**Port:** 6003

---

### 4. Service Management Service
Hierarchical service creation, location mapping.

```
git clone https://github.com/PatelShakil/KMS_SERVICE_SERVICE.git
cd KMS_SERVICE_SERVICE
```

**Tech Stack:** Jakarta EE, PostgreSQL  
**Port:** 6004

---

### 5. Feedback Service
Citizen feedback submission, voice storage, MongoDB.

```
git clone https://github.com/PatelShakil/FMS_FEEDBACK_SERVICE.git
cd FMS_FEEDBACK_SERVICE
```

**Tech Stack:** Node.js, Express, MongoDB, MinIO  
**Port:** 6005

---

### 6. Response Service
Admin responses, workflow automation, status updates.

```
git clone https://github.com/PatelShakil/FMS_RESPONSE_SERVICE.git
cd FMS_RESPONSE_SERVICE
```

**Tech Stack:** Node.js, PostgreSQL, Kafka  
**Port:** 6006

---

### 7. Notification Service
SMS/Email delivery, Kafka consumer, citizen notifications.

```
git clone https://github.com/PatelShakil/FMS_NOTIFICATION_SERVICE.git
cd FMS_NOTIFICATION_SERVICE
```

**Tech Stack:** Node.js, Kafka, Twilio/SendGrid  
**Port:** 6007

---

## 🎨 Frontend Applications (2 React Apps)

### 1. Admin Panel
Org Admin dashboard, feedback management, analytics.

```
git clone https://github.com/PatelShakil/FMS_ADMIN_PANEL.git
cd FMS_ADMIN_PANEL
npm install
npm start
```

**Tech Stack:** React.js, Material-UI, Redux  
**Port:** 3002

---

### 2. Citizen Portal
QR scanning, voice feedback, tracking.

```
git clone https://github.com/PatelShakil/FMS_CITIZEN_PORTAL.git
cd FMS_CITIZEN_PORTAL
```

**Tech Stack:** ReactJs, Zustand, Vite

---

## 📱 Mobile Application

### Distributor App (Android)
QR code distributor app, deployment tracking.
```
git clone https://github.com/PatelShakil/FMS_DISTRIBUTOR_APP.git
cd FMS_DISTRIBUTOR_APP
```

**Tech Stack:** Jetpack Compose, Kotlin

---

## 📦 Quick Clone All Repositories

Clone all 10 repositories in one go:

```
# Create project directory
mkdir boloindia-full-stack
cd boloindia-full-stack

# Clone backend services
git clone https://github.com/PatelShakil/FMS_AUTH_SERVICE.git
git clone https://github.com/PatelShakil/FMS_ORG_SERVICE.git
git clone https://github.com/PatelShakil/FMS_QR_SERVICE.git
git clone https://github.com/PatelShakil/KMS_SERVICE_SERVICE.git
git clone https://github.com/PatelShakil/FMS_FEEDBACK_SERVICE.git
git clone https://github.com/PatelShakil/FMS_RESPONSE_SERVICE.git
git clone https://github.com/PatelShakil/FMS_NOTIFICATION_SERVICE.git

# Clone frontends
git clone https://github.com/PatelShakil/FMS_ADMIN_PANEL.git
git clone https://github.com/PatelShakil/FMS_CITIZEN_PORTAL.git

# Clone mobile app
git clone https://github.com/PatelShakil/FMS_DISTRIBUTOR_APP.git

echo "✅ All repositories cloned!"
```

---

## 🔗 Repository Quick Links

| Component | Repository | Tech            | Port   |
|-----------|-----------|-----------------|--------|
| Auth Service | [FMS_AUTH_SERVICE](https://github.com/PatelShakil/FMS_AUTH_SERVICE) | Jakarta EE      | 6001   |
| Org Service | [FMS_ORG_SERVICE](https://github.com/PatelShakil/FMS_ORG_SERVICE) | Jakarta EE      | 6002   |
| QR Service | [FMS_QR_SERVICE](https://github.com/PatelShakil/FMS_QR_SERVICE) | Jakarta EE      | 6003   |
| Service Service | [KMS_SERVICE_SERVICE](https://github.com/PatelShakil/KMS_SERVICE_SERVICE) | Jakarta EE      | 6004   |
| Feedback Service | [FMS_FEEDBACK_SERVICE](https://github.com/PatelShakil/FMS_FEEDBACK_SERVICE) | Node.js         | 6005   |
| Response Service | [FMS_RESPONSE_SERVICE](https://github.com/PatelShakil/FMS_RESPONSE_SERVICE) | Node.js         | 6006   |
| Notification Service | [FMS_NOTIFICATION_SERVICE](https://github.com/PatelShakil/FMS_NOTIFICATION_SERVICE) | Node.js         | 6007   |
| Admin Panel | [FMS_ADMIN_PANEL](https://github.com/PatelShakil/FMS_ADMIN_PANEL) | React.js        | 5173   |
| Distributor App | [FMS_DISTRIBUTOR_APP](https://github.com/PatelShakil/FMS_DISTRIBUTOR_APP) | Jetpack Compose | Mobile |
| Citizen Portal | [FMS_CITIZEN_PORTAL](https://github.com/PatelShakil/FMS_CITIZEN_PORTAL) | React.js | 5174   |

---

## 📋 Next Steps

After cloning repositories:

1. Follow [Installation Guide](../installation/quickstart) to setup infrastructure
2. Configure Docker Compose for all services
3. Initialize databases using init scripts
4. Start services and verify health endpoints

**Need help?** Check [Usage Guide](../usage/qr-citizen) for complete workflows.