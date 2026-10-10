# Entity-Relationship Documentation & Normalization Rules

## 1. Entities & Cardinalities

```mermaid
erDiagram
    DEPARTMENTS ||--o{ INSTRUCTORS : employs
    DEPARTMENTS ||--o{ COURSES : offers
    INSTRUCTORS ||--o{ COURSES : teaches
    STUDENTS ||--o{ ENROLLMENTS : registers
    COURSES ||--o{ ENROLLMENTS : includes
    ENROLLMENTS ||--o{ EVALUATIONS : receives

    DEPARTMENTS {
        VARCHAR department_id PK
        VARCHAR name
        VARCHAR building
    }

    INSTRUCTORS {
        VARCHAR instructor_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email
        VARCHAR department_id FK
    }

    STUDENTS {
        VARCHAR student_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email
        DATE birth_date
        VARCHAR status
    }

    COURSES {
        VARCHAR course_code PK
        VARCHAR title
        INT credits
        VARCHAR department_id FK
        VARCHAR instructor_id FK
    }

    ENROLLMENTS {
        SERIAL enrollment_id PK
        VARCHAR student_id FK
        VARCHAR course_code FK
        VARCHAR term
        DATE enrolled_at
    }

    EVALUATIONS {
        SERIAL eval_id PK
        INT enrollment_id FK
        DECIMAL score
        DATE graded_at
    }
```

## 2. Integrity Constraints Enforced
1. **Primary Keys:** Unique identity on every table.
2. **Foreign Keys with Referential Integrity:** `ON DELETE RESTRICT` to prevent orphan academic records.
3. **CHECK Constraints:**
   * Scores must strictly fall between `0.0` and `100.0`.
   * Course credits must be greater than `0`.
   * Email must contain valid `@` structure.
4. **UNIQUE Constraints:** Composite uniqueness on `(student_id, course_code, term)` preventing accidental double-enrollment in the same academic semester.
