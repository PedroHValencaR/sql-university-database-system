-- ============================================================================
-- UNIVERSITY DATABASE SCHEMA (DDL)
-- Compliant with 3NF (Third Normal Form) and PostgreSQL syntax
-- Author: Pedro Henrique Valença Ramos
-- ============================================================================

DROP TABLE IF EXISTS evaluations CASCADE;
DROP TABLE IF EXISTS enrollments CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS instructors CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- 1. Departments Table
CREATE TABLE departments (
    department_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    building VARCHAR(50) NOT NULL
);

-- 2. Instructors / Faculty Table
CREATE TABLE instructors (
    instructor_id VARCHAR(15) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id VARCHAR(10) NOT NULL,
    hired_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_instructor_dept FOREIGN KEY (department_id) 
        REFERENCES departments(department_id) ON DELETE RESTRICT,
    CONSTRAINT chk_instructor_email CHECK (email LIKE '%_@__%.__%')
);

-- 3. Students Table
CREATE TABLE students (
    student_id VARCHAR(15) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birth_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT chk_student_status CHECK (status IN ('ACTIVE', 'SUSPENDED', 'GRADUATED', 'INACTIVE')),
    CONSTRAINT chk_student_email CHECK (email LIKE '%_@__%.__%')
);

-- 4. Courses Table
CREATE TABLE courses (
    course_code VARCHAR(15) PRIMARY KEY,
    title VARCHAR(120) NOT NULL,
    credits INT NOT NULL DEFAULT 4,
    department_id VARCHAR(10) NOT NULL,
    instructor_id VARCHAR(15),
    CONSTRAINT fk_course_dept FOREIGN KEY (department_id) 
        REFERENCES departments(department_id) ON DELETE RESTRICT,
    CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id) 
        REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    CONSTRAINT chk_course_credits CHECK (credits > 0)
);

-- 5. Enrollments Junction Table (Composite Unique Constraint)
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id VARCHAR(15) NOT NULL,
    course_code VARCHAR(15) NOT NULL,
    term VARCHAR(20) NOT NULL, -- e.g., '2026-FALL', '2027-SPRING'
    enrolled_at DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) 
        REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_code) 
        REFERENCES courses(course_code) ON DELETE RESTRICT,
    CONSTRAINT uq_student_term_course UNIQUE (student_id, course_code, term)
);

-- 6. Evaluations / Grades Table
CREATE TABLE evaluations (
    eval_id SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL,
    score NUMERIC(5, 2) NOT NULL,
    graded_at DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    CONSTRAINT fk_eval_enrollment FOREIGN KEY (enrollment_id) 
        REFERENCES enrollments(enrollment_id) ON DELETE CASCADE,
    CONSTRAINT chk_eval_score CHECK (score >= 0.0 AND score <= 100.0)
);

-- Indexes for performance on frequently joined foreign keys
CREATE INDEX idx_instructors_dept ON instructors(department_id);
CREATE INDEX idx_courses_dept ON courses(department_id);
CREATE INDEX idx_enrollments_student ON enrollments(student_id);
CREATE INDEX idx_enrollments_course ON enrollments(course_code);
CREATE INDEX idx_evaluations_enrollment ON evaluations(enrollment_id);
