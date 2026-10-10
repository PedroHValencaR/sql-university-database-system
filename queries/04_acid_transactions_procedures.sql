-- ============================================================================
-- ACID TRANSACTIONS & INTEGRITY PROCEDURES
-- Author: Pedro Henrique Valença Ramos
-- ============================================================================

-- 1. ACID Transaction with Safe Enroll Workflow & Rollback on Error
BEGIN;

-- Attempt to enroll student STU-1003 in course CS-101 for 2026-FALL
INSERT INTO enrollments (student_id, course_code, term, enrolled_at)
VALUES ('STU-1003', 'CS-101', '2026-FALL', CURRENT_DATE);

-- Assign initial orientation grade placeholder
INSERT INTO evaluations (enrollment_id, score, notes)
VALUES (
    currval(pg_get_serial_sequence('enrollments', 'enrollment_id')), 
    100.0, 
    'Automatic onboarding credit credit.'
);

-- Commit transaction atomically
COMMIT;


-- 2. Demonstration of Rollback on Constraint Violation
-- If a student is already enrolled in the same course for the same term,
-- the composite UNIQUE constraint trips and triggers a clean rollback.
BEGIN;

SAVEPOINT before_duplicate_enroll;

-- This will raise a unique constraint error if duplicate:
-- INSERT INTO enrollments (student_id, course_code, term) VALUES ('STU-1001', 'CS-101', '2026-FALL');
-- In case of failure:
-- ROLLBACK TO SAVEPOINT before_duplicate_enroll;

COMMIT;


-- 3. Stored Trigger: Audit Log for Grade Modifications
CREATE TABLE IF NOT EXISTS evaluation_audit_log (
    log_id SERIAL PRIMARY KEY,
    eval_id INT NOT NULL,
    old_score NUMERIC(5, 2),
    new_score NUMERIC(5, 2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(50) DEFAULT CURRENT_USER
);

CREATE OR REPLACE FUNCTION audit_evaluation_update()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.score <> NEW.score THEN
        INSERT INTO evaluation_audit_log (eval_id, old_score, new_score)
        VALUES (OLD.eval_id, OLD.score, NEW.score);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_audit_eval_update ON evaluations;
CREATE TRIGGER trg_audit_eval_update
AFTER UPDATE ON evaluations
FOR EACH ROW
EXECUTE FUNCTION audit_evaluation_update();
