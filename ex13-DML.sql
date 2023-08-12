/*

DML(Data Manipulation Language)
    DB에서 데이터를 조작하고 처리하는 SQL
    
    INSERT문 : 테이블에 새로운 레코드 삽입
    UPDATE문 : 테이블에 기존 레코드를 갱신(업데이트) 하는데 사용
    DELETE문 : 테이블에서 특정 레코드를 삭제
    
    
    SELECT는 DML 포함될 수 있지만, 보통 DQL(Data Query Language) 분류한다.
    
*/

/*
INSERT문
[기본형식]
    INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
    VALUES(값1, 값2, ...);
    
    또는
    
    INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...) subquery;   유니온과 같이 맞춰줘야함
    
*/
SELECT * FROM departments;

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Public RElations', 100, 1700);

commit; -- DML 결과를 영구적으로 DB에 반영

-- null 값을 가진 행 삽입
-- 열 생략
INSERT INTO departments (department_id, department_name)
VALUES (290, 'Purchasing');

SELECT *FROM departments;

ROLLBACK; -- DML문의 실행결과를 취소할 때

-- NULL 키워드 지정
INSERT INTO departments
VALUES (300, 'Finance', NULL, NULL);

/* INSERT subquery

*/

DROP TABLE sales_reps;

CREATE TABLE sales_reps
AS (
    SELECT employee_id id, last_name name, salary, commission_pct
    FROM employees
    WHERE 1 = 2
    )
;

SELECT * FROM sales_reps;

--job_id REP 포함된 사원
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%'
;

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%'
;


commit;

SELECT * FROM sales_reps;