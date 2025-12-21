// mongo-init/init-mongo.js
// This script runs when MongoDB container starts for the first time

// Switch to feedback_db and create it
db = db.getSiblingDB('feedback_db');

// Create user for feedback_db
db.createUser({
    user: 'feedback_user',
    pwd: 'feedback_pass',
    roles: [
        {
            role: 'readWrite',
            db: 'feedback_db'
        }
    ]
});

// Create indexes for feedback_db
db.forms.createIndex({ formId: 1 }, { unique: true });
db.forms.createIndex({ orgId: 1, status: 1 });
db.forms.createIndex({ serviceId: 1, status: 1 });
db.forms.createIndex({ formName: 'text', formDescription: 'text' });

db.form_templates.createIndex({ templateId: 1 }, { unique: true });
db.form_templates.createIndex({ category: 1, isActive: 1 });

print('✅ feedback_db initialized');

// Switch to response_db and create it
db = db.getSiblingDB('response_db');

// Create user for response_db
db.createUser({
    user: 'response_user',
    pwd: 'response_pass',
    roles: [
        {
            role: 'readWrite',
            db: 'response_db'
        }
    ]
});

// Create indexes for response_db
db.responses.createIndex({ responseId: 1 }, { unique: true });
db.responses.createIndex({ formId: 1, submittedAt: -1 });
db.responses.createIndex({ orgId: 1, status: 1 });
db.responses.createIndex({ qrCodeId: 1 });
db.responses.createIndex({ citizenId: 1 });

db.response_analytics.createIndex({ formId: 1, date: -1 });
db.response_analytics.createIndex({ orgId: 1, date: -1 });

print('✅ response_db initialized');

print('🎉 MongoDB initialization complete!');
