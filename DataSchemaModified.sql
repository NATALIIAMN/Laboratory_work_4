CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    user_role VARCHAR(30) NOT NULL,
    CONSTRAINT users_full_name_check
    CHECK (full_name ~ '^[A-Z][a-z]+\s[A-Z][a-z]+$')
);

CREATE TABLE workplaces (
    workplace_id SERIAL PRIMARY KEY,
    description TEXT
);

CREATE TABLE workplace_assessments (
    assessment_id SERIAL PRIMARY KEY,
    assessment_date DATE NOT NULL,
    assessment_result TEXT,
    user_id INT NOT NULL,
    workplace_id INT NOT NULL,
    CONSTRAINT fk_workplace_assessments_user_id FOREIGN KEY (user_id)
    REFERENCES users (user_id),
    CONSTRAINT fk_workplace_assessments_workplace_id FOREIGN KEY (workplace_id)
    REFERENCES workplaces (workplace_id)
);

CREATE TABLE lighting_levels (
    lighting_level_id SERIAL PRIMARY KEY,
    light_level TEXT NOT NULL,
    assessment_id INT UNIQUE NOT NULL,
    CONSTRAINT fk_lighting_levels_assessment_id FOREIGN KEY (assessment_id)
    REFERENCES workplace_assessments (assessment_id)
);

CREATE TABLE safety_risks (
    risk_id SERIAL PRIMARY KEY,
    risk_type VARCHAR(50) DEFAULT 'No risks',
    risk_details TEXT,
    assessment_id INT NOT NULL,
    CONSTRAINT fk_safety_risks_assessment_id FOREIGN KEY (assessment_id)
    REFERENCES workplace_assessments (assessment_id),
    CONSTRAINT safety_risks_type_check
    CHECK (risk_type ~ '^[A-Z][a-z]+(\s[A-Z][a-z]+)*$')
);

CREATE TABLE recommendations (
    recommendation_id SERIAL PRIMARY KEY,
    recommendations_text TEXT,
    assessment_id INT NOT NULL,
    CONSTRAINT fk_recommendations_assessment_id FOREIGN KEY (assessment_id)
    REFERENCES workplace_assessments (assessment_id)
);

CREATE TABLE video_conferences (
    conference_id SERIAL PRIMARY KEY,
    topic VARCHAR(100) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT fk_video_conferences_user_id FOREIGN KEY (user_id)
    REFERENCES users (user_id)
);

CREATE TABLE participants (
    participant_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    conference_id INT NOT NULL,
    CONSTRAINT fk_participants_conference_id FOREIGN KEY (conference_id)
    REFERENCES video_conferences (conference_id),
    CONSTRAINT participants_full_name_check
    CHECK (full_name ~ '^[A-Z][a-z]+\s[A-Z][a-z]+$')
);
