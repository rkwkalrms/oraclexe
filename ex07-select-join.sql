/*


JOIN
    SQL에서 두 개 이상의 테이블에서 관련된 행들을 결합하기 위한 연산입니다.

*/

/*
Natural Join
    두 테이블에서 데이터 유형과 이름이 일치하는 열을 기반으로 자동으로
    테이블을 조인할 수 있습니다.
*/
SELECT department_id, department_name,
        location_id, city
FROM departments
NATURAL JOIN locations;

/*
USING 절로 조인
    명시적으로 결합을 수행하고자하는 열을 정해줍니다.
*/
SELECT employee_id, last_name,
        location_id, department_id
FROM employees JOIN departments
USING (department_id);

/*
ON 절로 조인
    ON 절을 사용하여 조인 조건을 지정합니다.
*/
SELECT e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
FROM employees e JOIN departments d
ON (e. department_id = d.department_id);

SELECT e.employee_id, e.last_name, 
    e.department_id, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;



-- ON 절을 사용하여 3-Way 조인
SELECT e.employee_id, e.last_name, e.first_name, l.city, d.department_name
FROM employees e 
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id;

-- 조인에 추가 조건 적용
SELECT e.employee_id, e.last_name, e.manager_id, e.department_id,
    d.department_id, d.location_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = 149;

/*
테이블 자체 조인
    ON 절을 사용하는 Self Join
*/
SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker JOIN employees manager
ON worker.manager_id = manager.employee_id;


/*
Nonequijoin
    등호 연산자 외의 다른 연산자를 포함하는 조인 조건입니다.

CREATE TABLE job_grades (
grade_level CHAR(1),
lowest_sal NUMBER(8,2) NOT NULL,
highest_sal NUMBER(8,2) NOT NULL
);

ALTER TABLE job_grades
ADD CONSTRAINT jobgrades_grade_pk PRIMARY KEY (grade_level);

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 24999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);

COMMIT;

SELECT * FROM job_grades;
*/





SELECT e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

/*
INNER JOIN과 OUTER JOIN
    
    INNER JOIN
        일치하지 않는 행은 출력에 표시되지 않습니다. (교집합 해당 행 출력)
        
    OUTER JOIN
        한 테이블의 행을 기반으로 다른 테이블과의 연결이 없는 행까지 포함하여 반환합니다.

*/

/*
LEFT OUTER JOIN
    DEPARTMENTS 테이블에 대응되는 행이 없어도
    왼쪽 테이블인 EMLPOYEES 테이블의 모든행을 검색합니다.
*/
SELECT e.last_name, e.department_id, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

/*
RIGHT OUTER JOIN
    EMPLOYEES 테이블에 대응되는 행이 없어도
    오른쪽 테이블인 DEPARTMENTS 테이블의 모든 행을 검색합니다.
*/
SELECT e.last_name, e.department_id, d.department_name
FROM employees e
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

/*
FULL OUTER JOIN
    DEPARTMENTS, EMPLOYEES 대응되는 행이 없어도
    테이블의 모든 행을 검색합니다.
*/
SELECT e.last_name, d.department_id, d.department_name
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

/*
Cartesian Product
    조인 조건이 잘못되거나 완전히 생략된 경우 결과가 모든 행의 조합이 표시되는
    Cartesian Product로 나타냅니다.
*/

/*
CROSS JOIN
    두 테이블의 교차 곱을 생성합니다.
*/
SELECT last_name, department_name
FROM employees
CROSS JOIN departments;