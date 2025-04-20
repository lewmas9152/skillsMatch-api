-- User related tables
CREATE TABLE user_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_type_id INTEGER NOT NULL REFERENCES user_types(type_id),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(50),
    profile_picture_url TEXT,
    bio TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    remember_me_token TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE password_resets (
    reset_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    token TEXT NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE social_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    provider VARCHAR(50) NOT NULL,
    provider_id VARCHAR(255) NOT NULL,
    profile_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, provider)
);

-- Skills related tables
CREATE TABLE skill_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE skills (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(255) NOT NULL UNIQUE,
    category_id INTEGER REFERENCES skill_categories(category_id),
    description TEXT,
    is_technical BOOLEAN DEFAULT TRUE
);

CREATE TABLE user_skills (
    user_skill_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    proficiency_level INTEGER CHECK (proficiency_level BETWEEN 1 AND 5),
    years_experience NUMERIC(4,1),
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, skill_id)
);

CREATE TABLE skill_endorsements (
    endorsement_id SERIAL PRIMARY KEY,
    user_skill_id INTEGER NOT NULL REFERENCES user_skills(user_skill_id),
    endorsed_by_user_id INTEGER NOT NULL REFERENCES users(user_id),
    endorsement_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_skill_id, endorsed_by_user_id)
);

-- Education and Experience tables
CREATE TABLE education (
    education_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    institution_name VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    field_of_study VARCHAR(255),
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE experience (
    experience_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    company_name VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    is_remote BOOLEAN DEFAULT FALSE,
    start_date DATE NOT NULL,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Portfolio and CV tables
CREATE TABLE portfolio_items (
    portfolio_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    project_url TEXT,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_cvs (
    cv_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    file_name VARCHAR(255) NOT NULL,
    file_url TEXT NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Company related tables
CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    website_url TEXT,
    logo_url TEXT,
    size VARCHAR(50),
    industry VARCHAR(100),
    founded_year INTEGER,
    headquarters_location VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE company_users (
    company_user_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    role VARCHAR(100) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(company_id, user_id)
);

-- Job related tables
CREATE TABLE job_types (
    job_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE work_locations (
    location_id SERIAL PRIMARY KEY,
    location_type VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE experience_levels (
    level_id SERIAL PRIMARY KEY,
    level_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL REFERENCES companies(company_id),
    created_by_user_id INTEGER NOT NULL REFERENCES users(user_id),
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    job_type_id INTEGER REFERENCES job_types(job_type_id),
    location_id INTEGER REFERENCES work_locations(location_id),
    location_description VARCHAR(255),
    experience_level_id INTEGER REFERENCES experience_levels(level_id),
    salary_min NUMERIC(12,2),
    salary_max NUMERIC(12,2),
    salary_currency VARCHAR(3) DEFAULT 'USD',
    is_salary_visible BOOLEAN DEFAULT TRUE,
    application_deadline TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE job_skills (
    job_skill_id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES jobs(job_id),
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    importance_level INTEGER CHECK (importance_level BETWEEN 1 AND 5),
    is_required BOOLEAN DEFAULT FALSE,
    UNIQUE(job_id, skill_id)
);

CREATE TABLE screening_questions (
    question_id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES jobs(job_id),
    question_text TEXT NOT NULL,
    is_required BOOLEAN DEFAULT TRUE,
    question_order INTEGER NOT NULL
);

-- Application related tables
CREATE TABLE application_statuses (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE job_applications (
    application_id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES jobs(job_id),
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    cv_id INTEGER REFERENCES user_cvs(cv_id),
    cover_letter TEXT,
    status_id INTEGER NOT NULL REFERENCES application_statuses(status_id),
    match_percentage NUMERIC(5,2),
    applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(job_id, user_id)
);

CREATE TABLE application_answers (
    answer_id SERIAL PRIMARY KEY,
    application_id INTEGER NOT NULL REFERENCES job_applications(application_id),
    question_id INTEGER NOT NULL REFERENCES screening_questions(question_id),
    answer_text TEXT NOT NULL,
    UNIQUE(application_id, question_id)
);

-- Interview related tables
CREATE TABLE interview_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE interviews (
    interview_id SERIAL PRIMARY KEY,
    application_id INTEGER NOT NULL REFERENCES job_applications(application_id),
    scheduled_by_user_id INTEGER NOT NULL REFERENCES users(user_id),
    interview_type_id INTEGER NOT NULL REFERENCES interview_types(type_id),
    scheduled_at TIMESTAMP WITH TIME ZONE NOT NULL,
    duration_minutes INTEGER NOT NULL,
    location_or_link TEXT,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE interview_feedback (
    feedback_id SERIAL PRIMARY KEY,
    interview_id INTEGER NOT NULL REFERENCES interviews(interview_id),
    given_by_user_id INTEGER NOT NULL REFERENCES users(user_id),
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    strengths TEXT,
    weaknesses TEXT,
    recommendation VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Career path related tables
CREATE TABLE career_paths (
    path_id SERIAL PRIMARY KEY,
    path_name VARCHAR(255) NOT NULL,
    description TEXT,
    industry VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE career_positions (
    position_id SERIAL PRIMARY KEY,
    path_id INTEGER NOT NULL REFERENCES career_paths(path_id),
    position_name VARCHAR(255) NOT NULL,
    level INTEGER NOT NULL,
    avg_salary_min NUMERIC(12,2),
    avg_salary_max NUMERIC(12,2),
    salary_currency VARCHAR(3) DEFAULT 'USD',
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE position_required_skills (
    position_skill_id SERIAL PRIMARY KEY,
    position_id INTEGER NOT NULL REFERENCES career_positions(position_id),
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    importance_level INTEGER CHECK (importance_level BETWEEN 1 AND 5),
    UNIQUE(position_id, skill_id)
);

CREATE TABLE user_career_paths (
    user_path_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    position_id INTEGER NOT NULL REFERENCES career_positions(position_id),
    is_current BOOLEAN DEFAULT FALSE,
    is_goal BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, position_id)
);

-- Messaging and notification tables
CREATE TABLE conversation_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE conversations (
    conversation_id SERIAL PRIMARY KEY,
    type_id INTEGER NOT NULL REFERENCES conversation_types(type_id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conversation_participants (
    participant_id SERIAL PRIMARY KEY,
    conversation_id INTEGER NOT NULL REFERENCES conversations(conversation_id),
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    left_at TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE(conversation_id, user_id)
);

CREATE TABLE messages (
    message_id SERIAL PRIMARY KEY,
    conversation_id INTEGER NOT NULL REFERENCES conversations(conversation_id),
    sender_id INTEGER NOT NULL REFERENCES users(user_id),
    message_text TEXT NOT NULL,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE
);

CREATE TABLE notification_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL UNIQUE,
    template TEXT NOT NULL
);

CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    type_id INTEGER NOT NULL REFERENCES notification_types(type_id),
    related_id INTEGER,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- AI and analytics related tables
CREATE TABLE user_activities (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    activity_type VARCHAR(100) NOT NULL,
    related_id INTEGER,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ai_model_parameters (
    parameter_id SERIAL PRIMARY KEY,
    parameter_name VARCHAR(100) NOT NULL UNIQUE,
    parameter_value JSONB NOT NULL,
    description TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ai_match_feedback (
    feedback_id SERIAL PRIMARY KEY,
    job_id INTEGER REFERENCES jobs(job_id),
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    match_percentage NUMERIC(5,2),
    user_rating INTEGER CHECK (user_rating BETWEEN 1 AND 5),
    feedback_text TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Settings and preferences tables
CREATE TABLE user_preferences (
    preference_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id),
    preference_key VARCHAR(100) NOT NULL,
    preference_value JSONB NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, preference_key)
);

-- Initial data for lookup tables
INSERT INTO user_types (type_name) VALUES 
('Job Seeker'), ('Employer'), ('Recruiter'), ('Admin');

INSERT INTO job_types (type_name) VALUES 
('Full-time'), ('Part-time'), ('Contract'), ('Temporary'), ('Internship'), ('Freelance');

INSERT INTO work_locations (location_type) VALUES 
('Remote'), ('On-site'), ('Hybrid');

INSERT INTO experience_levels (level_name) VALUES 
('Entry-level'), ('Mid-level'), ('Senior'), ('Executive'), ('Internship');

INSERT INTO application_statuses (status_name) VALUES 
('Applied'), ('Screening'), ('Interview'), ('Testing'), ('Offer'), ('Hired'), ('Rejected');

INSERT INTO interview_types (type_name) VALUES 
('Phone'), ('Video'), ('In-person'), ('Technical'), ('Panel');

INSERT INTO conversation_types (type_name) VALUES 
('Direct'), ('Group'), ('System'), ('AI-Assistant');

INSERT INTO notification_types (type_name, template) VALUES 
('New Message', 'You have a new message from {{sender}}'),
('Job Match', 'We found a new job match for you: {{job_title}}'),
('Application Status', 'Your application for {{job_title}} has been updated to {{status}}'),
('Interview Schedule', 'You have an interview scheduled for {{job_title}} on {{datetime}}'),
('Profile View', 'Your profile was viewed by {{company}}');