-- ============================================
-- Create auth_service schema
-- ============================================
CREATE SCHEMA IF NOT EXISTS auth_service;

-- ============================================
-- Table: roles
-- ============================================
CREATE TABLE auth_service.roles (
                                    id BIGSERIAL PRIMARY KEY,
                                    role_name VARCHAR(50) UNIQUE NOT NULL,
                                    description TEXT,
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: users
-- ============================================
CREATE TABLE auth_service.users (
                                    id BIGSERIAL PRIMARY KEY,
                                    email VARCHAR(255) UNIQUE NOT NULL,
                                    password_hash VARCHAR(255),
                                    full_name VARCHAR(150) NOT NULL,
                                    phone VARCHAR(20),
                                    profile_url TEXT,
                                    org_id BIGINT,
                                    is_active BOOLEAN DEFAULT FALSE,
                                    email_verified BOOLEAN DEFAULT FALSE,
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                    updated_at TIMESTAMP
);

-- ============================================
-- Table: user_roles (Many-to-Many)
-- ============================================
CREATE TABLE auth_service.user_roles (
                                         id BIGSERIAL PRIMARY KEY,
                                         user_id BIGINT NOT NULL REFERENCES auth_service.users(id) ON DELETE CASCADE,
                                         role_id BIGINT NOT NULL REFERENCES auth_service.roles(id) ON DELETE CASCADE,
                                         assigned_by BIGINT,
                                         assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                         UNIQUE(user_id, role_id)
);

-- ============================================
-- Table: refresh_tokens
-- ============================================
CREATE TABLE auth_service.refresh_tokens (
                                             id BIGSERIAL PRIMARY KEY,
                                             user_id BIGINT NOT NULL REFERENCES auth_service.users(id) ON DELETE CASCADE,
                                             token_hash VARCHAR(255) UNIQUE NOT NULL,
                                             expires_at TIMESTAMP NOT NULL,
                                             device_info VARCHAR(255),
                                             ip_address VARCHAR(45),
                                             revoked BOOLEAN DEFAULT FALSE,
                                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: login_audit
-- ============================================
CREATE TABLE auth_service.login_audit (
                                          id BIGSERIAL PRIMARY KEY,
                                          user_id BIGINT NOT NULL,
                                          login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          ip_address VARCHAR(45),
                                          user_agent TEXT,
                                          status VARCHAR(20) NOT NULL,
                                          failure_reason TEXT
);

-- ============================================
-- Indexes for performance
-- ============================================
CREATE INDEX idx_users_email ON auth_service.users(email);
CREATE INDEX idx_users_org ON auth_service.users(org_id);
CREATE INDEX idx_user_roles_user ON auth_service.user_roles(user_id);
CREATE INDEX idx_user_roles_role ON auth_service.user_roles(role_id);
CREATE INDEX idx_refresh_tokens_user ON auth_service.refresh_tokens(user_id);
CREATE INDEX idx_refresh_tokens_hash ON auth_service.refresh_tokens(token_hash);
CREATE INDEX idx_login_audit_user ON auth_service.login_audit(user_id);
CREATE INDEX idx_login_audit_time ON auth_service.login_audit(login_time DESC);

-- ============================================
-- Insert default roles
-- ============================================
INSERT INTO auth_service.roles (role_name, description) VALUES
                                                            ('PLATFORM_ADMIN', 'BoloIndia HQ administrator'),
                                                            ('ORG_OWNER', 'Organization owner - manages admins & billing'),
                                                            ('ORG_ADMIN', 'Organization admin - manages services & feedback'),
                                                            ('DISTRIBUTOR', 'QR code distributor'),
                                                            ('CITIZEN', 'General public user');

-- ============================================
-- Create default Platform Admin user
-- password: Admin@123 (BCrypt hashed)
-- ============================================
INSERT INTO auth_service.users (
    email, password_hash, full_name, org_id, is_active, email_verified
) VALUES (
             'admin@boloindia.in',
             '$2a$10$N9qo8uLOickgx2ZMRZoMye8J8W93l.HQmzBEGz7S5xYzIjJKLg1YG',
             'Platform Administrator',
             NULL,
             TRUE,
             TRUE
         );

-- Assign PLATFORM_ADMIN role to user id=1
INSERT INTO auth_service.user_roles (user_id, role_id, assigned_by)
VALUES (1, 1, 1);

-- ============================================
-- Verify setup
-- ============================================
SELECT
    u.id, u.email, u.full_name, r.role_name
FROM auth_service.users u
         JOIN auth_service.user_roles ur ON u.id = ur.user_id
         JOIN auth_service.roles r ON ur.role_id = r.id;



-- ============================================
-- ORG SERVICE SCHEMA
-- ============================================
CREATE SCHEMA IF NOT EXISTS org_service;

SET search_path TO org_service;

-- Organization types enum
CREATE TYPE org_type AS ENUM (
    'MUNICIPALITY',
    'NGO',
    'HOSPITAL',
    'SCHOOL',
    'COLLEGE',
    'GOVERNMENT_DEPT',
    'CORPORATION',
    'OTHER'
);

-- Approval status enum
CREATE TYPE approval_status AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED',
    'SUSPENDED'
);

-- Organizations table
CREATE TABLE organizations (
                               id BIGSERIAL PRIMARY KEY,
                               org_name VARCHAR(200) NOT NULL,
                               org_email VARCHAR(150) UNIQUE NOT NULL,
                               org_type org_type NOT NULL,
                               sector VARCHAR(100),
                               registration_no VARCHAR(100),
                               phone VARCHAR(20),
                               address TEXT,
                               city VARCHAR(100),
                               state VARCHAR(100),
                               pincode VARCHAR(10),
                               website VARCHAR(200),

    -- Status and approval
                               status approval_status DEFAULT 'PENDING',
                               approved_by BIGINT,  -- User ID from auth-service
                               approved_at TIMESTAMP,
                               rejection_reason TEXT,

    -- Audit fields
                               created_by BIGINT NOT NULL,  -- User ID from auth-service
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               is_active BOOLEAN DEFAULT true,

    -- Metadata
                               metadata JSONB
);

-- Approval workflow history
CREATE TABLE approval_workflow (
                                   id BIGSERIAL PRIMARY KEY,
                                   org_id BIGINT NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
                                   previous_status approval_status,
                                   new_status approval_status NOT NULL,
                                   action_by BIGINT NOT NULL,  -- User ID from auth-service
                                   action_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                   comments TEXT
);

-- Organization audit log
CREATE TABLE organization_audit (
                                    id BIGSERIAL PRIMARY KEY,
                                    org_id BIGINT NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
                                    action VARCHAR(50) NOT NULL,  -- CREATE, UPDATE, APPROVE, REJECT, SUSPEND
                                    changed_by BIGINT NOT NULL,
                                    changes JSONB,  -- Store before/after values
                                    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                    ip_address INET,
                                    user_agent TEXT
);

-- Indexes for performance
CREATE INDEX idx_org_email ON organizations(org_email);
CREATE INDEX idx_org_status ON organizations(status);
CREATE INDEX idx_org_type ON organizations(org_type);
CREATE INDEX idx_org_created_by ON organizations(created_by);
CREATE INDEX idx_approval_workflow_org ON approval_workflow(org_id);
CREATE INDEX idx_audit_org ON organization_audit(org_id);
CREATE INDEX idx_audit_timestamp ON organization_audit(timestamp DESC);

-- Update trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_organizations_updated_at
    BEFORE UPDATE ON organizations
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Grant permissions
GRANT ALL PRIVILEGES ON SCHEMA org_service TO boloindia;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA org_service TO boloindia;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA org_service TO boloindia;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA org_service TO boloindia;

-- ============================================
-- QR SERVICE SCHEMA
-- ============================================
DROP SCHEMA IF EXISTS qr_service CASCADE;
CREATE SCHEMA qr_service;
SET search_path TO qr_service;

-- ============================================
-- QR CODES TABLE (Final Version)
-- ============================================
CREATE TABLE qr_codes (
                          qr_code_id BIGSERIAL PRIMARY KEY,

    -- Immutable Fields (NEVER change after creation)
                          qr_code_slug VARCHAR(50) UNIQUE NOT NULL,  -- QR_ABC123
                          qr_code_url TEXT NOT NULL,  -- https://bolo.in/QR_ABC123
                          form_id VARCHAR(50) NOT NULL,  -- Locked to form

    -- Editable Fields
                          qr_code_name VARCHAR(255) NOT NULL,
                          payment_amount DECIMAL(10,2) DEFAULT 0,

    -- Relationships
                          service_id BIGINT NOT NULL,
                          org_id BIGINT NOT NULL,
                          created_by BIGINT NOT NULL,

    -- Assignment
                          assigned_to BIGINT,
                          assignment_status VARCHAR(20) DEFAULT 'UNASSIGNED',
    -- UNASSIGNED, PENDING, ACCEPTED, REJECTED
                          assigned_at TIMESTAMP,
                          accepted_at TIMESTAMP,
                          rejected_at TIMESTAMP,
                          rejection_reason TEXT,

    -- Deployment
                          is_deployed BOOLEAN DEFAULT FALSE,
                          deployment_status VARCHAR(20) DEFAULT NULL,
    -- NULL, PENDING_APPROVAL, APPROVED, REJECTED
                          deployed_at TIMESTAMP,
                          deployment_location_name TEXT,
                          deployment_latitude DECIMAL(10, 8),
                          deployment_longitude DECIMAL(11, 8),
                          deployment_notes TEXT,
                          deployment_photo_url TEXT,  -- MinIO URL

                          finalized_by BIGINT,  -- Org Admin who approved
                          finalized_at TIMESTAMP,

    -- Status (Can be changed to stop scanning)
                          status VARCHAR(20) DEFAULT 'ACTIVE',
    -- ACTIVE, INACTIVE, ARCHIVED

    -- Analytics (Auto-updated)
                          total_scans INTEGER DEFAULT 0,
                          total_responses INTEGER DEFAULT 0,
                          last_scanned_at TIMESTAMP,

                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                          CONSTRAINT immutable_slug_check CHECK (qr_code_slug IS NOT NULL),
                          CONSTRAINT immutable_url_check CHECK (qr_code_url IS NOT NULL)
);

-- Indexes for performance
CREATE INDEX idx_qr_slug ON qr_codes(qr_code_slug);
CREATE INDEX idx_qr_form_id ON qr_codes(form_id);
CREATE INDEX idx_qr_org_id ON qr_codes(org_id);
CREATE INDEX idx_qr_assigned_to ON qr_codes(assigned_to);
CREATE INDEX idx_qr_status ON qr_codes(status);
CREATE INDEX idx_qr_deployment_status ON qr_codes(deployment_status);

-- ============================================
-- QR SCANS (Detailed Analytics)
-- ============================================
CREATE TABLE qr_scans (
                          scan_id BIGSERIAL PRIMARY KEY,
                          qr_code_id BIGINT NOT NULL REFERENCES qr_codes(qr_code_id) ON DELETE CASCADE,

                          scanned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- User Info (if logged in)
                          scanned_by BIGINT,  -- NULL if anonymous

    -- Device Info
                          device_type VARCHAR(50),  -- MOBILE, TABLET, DESKTOP
                          user_agent TEXT,
                          ip_address VARCHAR(45),

    -- Location (from mobile GPS)
                          scan_latitude DECIMAL(10, 8),
                          scan_longitude DECIMAL(11, 8),

    -- Did they submit feedback?
                          did_submit_response BOOLEAN DEFAULT FALSE,
                          response_id VARCHAR(50),  -- From response-service
                          response_submitted_at TIMESTAMP
);

CREATE INDEX idx_scans_qr_id ON qr_scans(qr_code_id);
CREATE INDEX idx_scans_date ON qr_scans(scanned_at DESC);
CREATE INDEX idx_scans_location ON qr_scans(scan_latitude, scan_longitude);

-- ============================================
-- QR MESSAGES (Simple Chat)
-- ============================================
CREATE TABLE qr_messages (
                             message_id BIGSERIAL PRIMARY KEY,
                             qr_code_id BIGINT NOT NULL REFERENCES qr_codes(qr_code_id) ON DELETE CASCADE,

                             sender_id BIGINT NOT NULL,
                             sender_type VARCHAR(20) NOT NULL,  -- ORG_ADMIN or DISTRIBUTOR

                             message_text TEXT NOT NULL,

                             is_read BOOLEAN DEFAULT FALSE,
                             read_at TIMESTAMP,

                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_messages_qr_id ON qr_messages(qr_code_id);
CREATE INDEX idx_messages_created ON qr_messages(created_at DESC);
CREATE INDEX idx_messages_unread ON qr_messages(qr_code_id, is_read) WHERE is_read = FALSE;

-- ============================================
-- QR ANALYTICS AGGREGATES (Pre-computed for dashboards)
-- ============================================
CREATE TABLE qr_analytics_daily (
                                    analytics_id BIGSERIAL PRIMARY KEY,
                                    qr_code_id BIGINT NOT NULL REFERENCES qr_codes(qr_code_id) ON DELETE CASCADE,
                                    date DATE NOT NULL,

                                    total_scans INTEGER DEFAULT 0,
                                    total_responses INTEGER DEFAULT 0,
                                    unique_users INTEGER DEFAULT 0,

    -- Device breakdown
                                    mobile_scans INTEGER DEFAULT 0,
                                    tablet_scans INTEGER DEFAULT 0,
                                    desktop_scans INTEGER DEFAULT 0,

    -- Time distribution (hourly)
                                    scans_by_hour INTEGER[24],  -- Array [0..23]

                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                                    UNIQUE(qr_code_id, date)
);

CREATE INDEX idx_analytics_qr_date ON qr_analytics_daily(qr_code_id, date DESC);

-- ============================================
-- SERVICE SERVICE SCHEMA
-- ============================================
DROP SCHEMA IF EXISTS service_service CASCADE;
CREATE SCHEMA service_service;
SET search_path TO service_service;

-- Service types enum
CREATE TYPE service_type AS ENUM (
    'DEPARTMENT',
    'DIVISION',
    'BRANCH',
    'LOCATION',
    'FACILITY',
    'EQUIPMENT',
    'OTHER'
);

-- Service status enum
CREATE TYPE service_status AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'UNDER_MAINTENANCE',
    'TEMPORARILY_CLOSED'
);

-- Services table
CREATE TABLE services (
                          id BIGSERIAL PRIMARY KEY,

    -- Identifiers
                          service_code VARCHAR(100) UNIQUE NOT NULL,
                          display_code VARCHAR(100),
                          service_name VARCHAR(200) NOT NULL,
                          slug VARCHAR(250) UNIQUE NOT NULL,

    -- Hierarchy
                          org_id BIGINT NOT NULL,
                          parent_service_id BIGINT,
                          level INT NOT NULL DEFAULT 1,
                          path TEXT,
                          full_path TEXT,

    -- Service details
                          service_type service_type NOT NULL DEFAULT 'DEPARTMENT',
                          description TEXT,
                          short_description VARCHAR(500),

    -- Media
                          icon_url VARCHAR(500),
                          cover_image_url VARCHAR(500),

    -- Contact
                          contact_person_name VARCHAR(100),
                          contact_phone VARCHAR(20),
                          contact_email VARCHAR(150),
                          contact_address TEXT,

    -- Location
                          latitude DECIMAL(10, 8),
                          longitude DECIMAL(11, 8),
                          address TEXT,
                          city VARCHAR(100),
                          state VARCHAR(100),
                          pincode VARCHAR(10),

    -- Operating hours
                          operating_hours JSONB,

    -- Status
                          status service_status DEFAULT 'ACTIVE',
                          is_public BOOLEAN DEFAULT true,
                          is_feedback_enabled BOOLEAN DEFAULT true,

    -- Metrics
                          total_feedback_forms INT DEFAULT 0,
                          total_qr_codes INT DEFAULT 0,
                          total_feedback_received INT DEFAULT 0,

    -- Audit
                          created_by BIGINT NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          deleted_at TIMESTAMP,

    -- Metadata
                          metadata JSONB,

                          CONSTRAINT fk_parent_service FOREIGN KEY (parent_service_id)
                              REFERENCES services(id) ON DELETE CASCADE
);

-- Service audit log
CREATE TABLE service_audit (
                               id BIGSERIAL PRIMARY KEY,
                               service_id BIGINT NOT NULL REFERENCES services(id) ON DELETE CASCADE,
                               action VARCHAR(50) NOT NULL,
                               changed_by BIGINT NOT NULL,
                               changes JSONB,
                               timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               ip_address INET,
                               user_agent TEXT
);

-- Service hierarchy cache
CREATE TABLE service_hierarchy_cache (
                                         ancestor_id BIGINT NOT NULL REFERENCES services(id) ON DELETE CASCADE,
                                         descendant_id BIGINT NOT NULL REFERENCES services(id) ON DELETE CASCADE,
                                         depth INT NOT NULL,
                                         PRIMARY KEY (ancestor_id, descendant_id)
);

-- Indexes
CREATE INDEX idx_services_org ON services(org_id);
CREATE INDEX idx_services_parent ON services(parent_service_id);
CREATE INDEX idx_services_code ON services(service_code);
CREATE INDEX idx_services_slug ON services(slug);
CREATE INDEX idx_services_path ON services(path);
CREATE INDEX idx_services_status ON services(status);
CREATE INDEX idx_services_type ON services(service_type);
CREATE INDEX idx_services_location ON services(latitude, longitude);
CREATE INDEX idx_service_audit_service ON service_audit(service_id);
CREATE INDEX idx_service_audit_timestamp ON service_audit(timestamp DESC);
CREATE INDEX idx_hierarchy_cache_ancestor ON service_hierarchy_cache(ancestor_id);
CREATE INDEX idx_hierarchy_cache_descendant ON service_hierarchy_cache(descendant_id);

-- Update trigger
CREATE OR REPLACE FUNCTION update_service_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_service_timestamp
    BEFORE UPDATE ON services
    FOR EACH ROW
    EXECUTE FUNCTION update_service_timestamp();

-- Path trigger
CREATE OR REPLACE FUNCTION update_service_path()
RETURNS TRIGGER AS $$
DECLARE
parent_path TEXT;
    parent_full_path TEXT;
    parent_level INT;
BEGIN
    IF NEW.parent_service_id IS NULL THEN
        NEW.level := 1;
        NEW.path := '/' || NEW.id::TEXT;
        NEW.full_path := NEW.service_name;
ELSE
SELECT level, path, full_path
INTO parent_level, parent_path, parent_full_path
FROM services
WHERE id = NEW.parent_service_id;

NEW.level := parent_level + 1;
        NEW.path := parent_path || '/' || NEW.id::TEXT;
        NEW.full_path := parent_full_path || ' > ' || NEW.service_name;
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_service_path
    BEFORE INSERT OR UPDATE OF parent_service_id ON services
    FOR EACH ROW
    EXECUTE FUNCTION update_service_path();

-- Permissions
GRANT ALL PRIVILEGES ON SCHEMA service_service TO boloindia;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA service_service TO boloindia;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA service_service TO boloindia;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA service_service TO boloindia;
