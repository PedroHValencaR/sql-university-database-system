-- ============================================================================
-- UNIVERSITY DATABASE SEED DATA (DML)
-- Author: Pedro Henrique Valença Ramos
-- ============================================================================

-- 1. Seed Departments
INSERT INTO departments (department_id, name, building) VALUES
('CS', 'Computer Science & Software Engineering', 'Turing Hall'),
('MECH', 'Mechatronics & Robotics Engineering', 'Tesla Complex'),
('BUS', 'Business Administration & Management', 'Drucker Center');

-- 2. Seed Instructors
INSERT INTO instructors (instructor_id, first_name, last_name, email, department_id, hired_date) VALUES
('INS-01', 'Linus', 'Torvalds', 'linus.t@university.edu', 'CS', '2020-03-15'),
('INS-02', 'Ada', 'Lovelace', 'ada.l@university.edu', 'CS', '2019-08-01'),
('INS-03', 'Nikola', 'Tesla', 'nikola.t@university.edu', 'MECH', '2021-02-10'),
('INS-04', 'Peter', 'Drucker', 'peter.d@university.edu', 'BUS', '2018-05-20');

-- 3. Seed Students
INSERT INTO students (student_id, first_name, last_name, email, birth_date, status) VALUES
('STU-1001', 'Pedro Henrique', 'Valenca Ramos', 'pedro.ramos@university.edu', '2002-05-14', 'ACTIVE'),
('STU-1002', 'Lucas', 'Silva', 'lucas.silva@university.edu', '2001-11-20', 'ACTIVE'),
('STU-1003', 'Mariana', 'Costa', 'mariana.costa@university.edu', '2003-01-09', 'ACTIVE'),
('STU-1004', 'Gabriel', 'Oliveira', 'gabriel.o@university.edu', '2000-07-28', 'ACTIVE'),
('STU-1005', 'Beatriz', 'Santos', 'beatriz.s@university.edu', '2002-09-17', 'ACTIVE');

-- 4. Seed Courses
INSERT INTO courses (course_code, title, credits, department_id, instructor_id) VALUES
('CS-101', 'Data Structures & Algorithms in C++', 4, 'CS', 'INS-01'),
('CS-202', 'Relational Databases & SQL Modeling', 4, 'CS', 'INS-02'),
('CS-303', 'Object-Oriented Design Patterns in Java', 4, 'CS', 'INS-02'),
('MECH-101', 'Microcontrollers & Cyber-Physical Systems', 3, 'MECH', 'INS-03'),
('BUS-201', 'Agile Product Management & Scrum', 3, 'BUS', 'INS-04');

-- 5. Seed Enrollments
INSERT INTO enrollments (student_id, course_code, term, enrolled_at) VALUES
('STU-1001', 'CS-101', '2026-FALL', '2026-08-10'),
('STU-1001', 'CS-202', '2026-FALL', '2026-08-10'),
('STU-1001', 'MECH-101', '2026-FALL', '2026-08-12'),
('STU-1002', 'CS-101', '2026-FALL', '2026-08-11'),
('STU-1002', 'BUS-201', '2026-FALL', '2026-08-11'),
('STU-1003', 'CS-202', '2026-FALL', '2026-08-12'),
('STU-1004', 'CS-303', '2026-FALL', '2026-08-14'),
('STU-1005', 'MECH-101', '2026-FALL', '2026-08-15');

-- 6. Seed Evaluations
INSERT INTO evaluations (enrollment_id, score, graded_at, notes) VALUES
(1, 98.50, '2026-10-01', 'Outstanding performance in C++ pointer and memory assignments.'),
(2, 95.00, '2026-10-03', 'Flawless 3NF relational normalization modeling.'),
(3, 92.00, '2026-10-05', 'High competence in microcontroller circuit assembly.'),
(4, 82.50, '2026-10-01', 'Good grasp of algorithm complexity.'),
(5, 88.00, '2026-10-04', 'Strong active participation in agile backlog grooming.'),
(6, 91.00, '2026-10-03', 'Solid execution of SQL JOINs.');
