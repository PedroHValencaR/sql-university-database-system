-- ============================================================================
-- ANALYTICAL REPORTING & COMPLEX QUERIES
-- Multi-table JOINs, Window Functions, Aggregations & Subqueries
-- Author: Pedro Henrique Valença Ramos
-- ============================================================================

-- Query 1: Comprehensive Academic Report per Student (Multi-table JOIN)
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name AS full_name,
    c.course_code,
    c.title AS course_title,
    d.name AS department,
    i.first_name || ' ' || i.last_name AS instructor_name,
    e.term,
    ev.score,
    CASE 
        WHEN ev.score >= 90.0 THEN 'HONORS (A)'
        WHEN ev.score >= 80.0 THEN 'PROFICIENT (B)'
        WHEN ev.score >= 70.0 THEN 'SATISFACTORY (C)'
        ELSE 'NEEDS IMPROVEMENT (F)'
    END AS academic_standing
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_code = c.course_code
INNER JOIN departments d ON c.department_id = d.department_id
LEFT JOIN instructors i ON c.instructor_id = i.instructor_id
LEFT JOIN evaluations ev ON e.enrollment_id = ev.enrollment_id
ORDER BY s.student_id, ev.score DESC;


-- Query 2: Department Performance Analytics (Aggregation with GROUP BY & HAVING)
SELECT 
    d.department_id,
    d.name AS department_name,
    COUNT(DISTINCT c.course_code) AS active_courses,
    COUNT(DISTINCT e.enrollment_id) AS total_enrollments,
    ROUND(AVG(ev.score), 2) AS average_student_score,
    MAX(ev.score) AS highest_score
FROM departments d
JOIN courses c ON d.department_id = c.department_id
JOIN enrollments e ON c.course_code = e.course_code
JOIN evaluations ev ON e.enrollment_id = ev.enrollment_id
GROUP BY d.department_id, d.name
HAVING AVG(ev.score) > 80.0
ORDER BY average_student_score DESC;


-- Query 3: Top Performing Students Ranked by Grade Point Average (GPA)
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    s.email,
    COUNT(e.enrollment_id) AS courses_completed,
    ROUND(AVG(ev.score), 2) AS overall_gpa,
    DENSE_RANK() OVER (ORDER BY AVG(ev.score) DESC) AS class_rank
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN evaluations ev ON e.enrollment_id = ev.enrollment_id
GROUP BY s.student_id, s.first_name, s.last_name, s.email
ORDER BY class_rank;
