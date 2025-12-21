---
id: overview
title: Golden Architecture
sidebar_label: Architecture
slug: /architecture/overview
---

# BoloIndia Microservices Architecture

BoloIndia uses a cloud-native, microservices architecture designed for high availability, multi-tenancy, and horizontal scaling. Each service has clear boundaries and communicates via API Gateway (Kong) and event streaming (Kafka).

## System Architecture Overview

```mermaid
graph TB
subgraph "Citizen Layer"
C[Citizen Mobile<br/>QR Scan + Voice]
end

    subgraph "API Gateway"
        G[Kong Gateway<br/>Rate limiting<br/>Auth]
    end
    
    subgraph "Core Microservices"
        Auth[Auth Service<br/>PostgreSQL]
        Org[Org Service<br/>PostgreSQL]
        Feedback[Feedback Service<br/>MongoDB]
        Response[Response Service<br/>PostgreSQL]
        Notification[Notification Service]
    end
    
    subgraph "Messaging & Storage"
        K[Kafka<br/>Event Bus]
        M[MinIO<br/>QR Images<br/>Audio Files]
    end
    
    subgraph "Dashboards"
        Admin[Admin Dashboards<br/>React + Docusaurus]
    end
    
    C -->|QR + Voice| G
    G --> Auth
    G --> Org
    G --> Feedback
    Feedback --> K
    Response --> K
    K --> Notification
    Notification -->|SMS/Email| C
    Auth -.->|JWT| G
    Org -.->|JWT| G
    Feedback --> M
    Admin --> G
```

## Service Boundaries & Data Flow

| Service | Purpose | Database | Events Published |
|---------|---------|----------|------------------|
| **Auth Service** | JWT tokens, user roles, multi-tenant auth | PostgreSQL | `user.login`, `org.registered` |
| **Org Service** | Organizations, services, locations, QR management | PostgreSQL | `qr.created`, `service.updated`|
| **Feedback Service** | Receive, validate, store citizen feedback | MongoDB | `feedback.received`, `feedback.categorized` |
| **Response Service** | Admin responses, workflows, status updates | PostgreSQL | `response.created`, `feedback.resolved` |
| **Notification Service** | SMS/Email delivery, citizen updates | None (Kafka consumer) | None |

## Key Architecture Decisions

- **Multi-tenancy**: Tenant ID in every request; database schemas partitioned by organization
- **Event-driven**: Kafka decouples services; feedback → categorization → response → notification
- **Voice storage**: Audio files in MinIO; transcribed text in MongoDB for search/analytics
- **Gateway-first**: Kong handles auth, rate limiting, circuit breaking for all services
- **Dashboards**: React SPA served via Docusaurus; role-based views auto-filter by tenant

## Deployment Stack

```mermaid
graph LR
Docker[Docker Containers] --> Compose[Docker Compose<br/>docker-compose.yml]
Compose --> K8s[Kubernetes<br/>Optional]
K8s --> Cloud[AWS/GCP/Azure]

    subgraph "Shared Infra"
        PG[PostgreSQL] 
        Mongo[MongoDB]
        Kafka[Kafka + Zookeeper]
        MinIO[MinIO Object Storage]
        Kong[Kong Gateway]
        Redis[Redis Cache]
    end
```

This architecture supports **10K+ daily feedbacks per organization** with 99.9% uptime through service isolation and horizontal scaling.

