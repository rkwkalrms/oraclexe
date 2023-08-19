/*


데이터 베이스 객체
    테이블 : 기본 저장단위이며 행으로 구성되어 있습니다.
    뷰 : 하나 이상의 테이블에 있는 데이터의 부분 집합을 논리적으로 나타냅니다.(가상 테이블)
    시퀸스 : 일련의 숫자를 자동으로 생성해주는 객체입니다.
    인덱스 : 테이블의 데이터에 대한 빠른검색을 지원해주는 색인 객체
    동의어 : 객체에 다른 이름을 부여합니다.
*/

-- 뷰 생성
CREATE VIEW empvu80
<<<<<<< HEAD
AS SELECT employee_id, last_name, salary -- 뷰를 
=======
AS SELECT employee_id, last_name, salary
>>>>>>> bcca17c5401e4b21c032d7d2c5ec14f5662234d1
    FROM employees
    WHERE department_id = 80;
    
DESC empvu80;

SELECT * FROM empvu80;

-- alias 사용 뷰 생성
CREATE VIEW salvu50
AS SELECT employee_id AS OD_NUMBER, last_name name, salary*12 ANN_SALARY
    FROM employees
    WHERE department_id = 50;
    
SELECT * FROM salvu50
WHERE ANN_SALARY >= 50000;
<<<<<<< HEAD


CREATE VIEW salvu_hangle
AS SELECT employee_id AS 아이디, last_name 이름, salary*12연봉
    FROM employees
    WHERE department_id = 50;


SELECT * FROM salvu_hangle;


-- 뷰 수정
CREATE OR REPLACE VIEW empvu80
    (id_number, name, sal, department_id)
    AS SELECT employee_id, first_name || ' ' || last_name,
                salary, department_id
            FROM employees
            WHERE department_id = 80;
            
SELECT * FROM empvu80;

ROLLBACK;

UPDATE empvu80 SET
department_id = 90
WHERE id_number = 145;

SELECT * FROM employee_id = 145;


/*
복합 뷰 생성
    두 개 이상 기본 테이블에 의해 정의된 뷰
*/
CREATE OR REPLACE VIEW dept_sum_vu
    (name, minsal, maxsal, avgsal)
AS SELECT d.department_name, MIN(e.salary),
            MAX(e.salary), AVG(e.salary)
        FROM employees e JOIN departments d
        ON e.department_id = d.department_id
        GROUP BY d.department_name;
        
SELECT * FROM dept_sum_vu;

/*
뷰 DML 작업 수행 규칙
    1. 행 제거할 수 없는 경우
        - 그룹 함수
        - GROUP BY 절
        - DISTINCT 키워드
        - Pseudocolumn ROWNUM 키워드
    2. 뷰의 데이터를 수정할 수 없는 경우
        - 그룹 함수
        - GROUP BY 절
        - DISTINCT 키워드
        - Pseudocolumn ROWNUM 키워드
    3. 뷰를 통해 데이터를 추가할 수 없는 경우
        - 그룹 함수
        - GROUP BY 절
        - DISTINCT 키워드
        - Pseudocolumn ROWNUM 키워드---- Pseudocolumn은 가상의 커럼
        - 표현식으로 정의되는 열
        - 뷰에서 선택되지 않은 기본 테이블의 NOT NULL 열
        
*/

-- ROWNUM : 퀴리의 결과의 각 행에 순차적인 번호를 할당해준다.
SELECT ROWNUM, employee_id, last_name
FROM employees
WHERE department_id = 80;

-- DML 작업거부
CREATE OR REPLACE VIEW empvu10
    (employee_number, employee_name, job_title)
AS SELECT employee_id, last_name, job_id
    FROM employees
    WHERE department_id = 10
    WITH READ ONLY;

SELECT * FROM empvu10;

UPDATE empvu10 SET
employee_name = 'Whalenl'
WHERE employee_number = 200;

/*
WITH CHECK OPTION
    뷰에 대한 데이터 변경작업 제한
*/

CREATE OR REPLACE view high_salary_employee_vu
AS SELECT * FRom employees WHERE salary > 10000 -- 이 조건에만 수정가능 
WITH CHECK OPTION CONSTRAINT high_salary_employee_ck;

SELECT * FROM high_salary_employee_vu;

-- 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다.
UPDATE high_salary_employee_vu SET
salary = 2400
WHERE employee_id = 100;
-- WITH CHECK OPTION의 조건에 위배 되지 않아 변경 가능합니다.
UPDATE high_salary_employee_vu SET
salary = 26000
WHERE employee_id = 100;

-- 뷰 제거
DROP VIEW high_salary_employee_vu;


/*
시퀀스(sequece)
    연속적인 숫자 값을 자동으로 증강 시켜서 값을 리턴하는 객체입니다.
    채번할때 많이 사용한다.    
*/

CREATE SEQUENCE my_seq
        INCREMENT BY 1               -- 증가값 (1씩증가) 
        START WITH 1                 -- 시작값
        MINVALUE 1                   -- 최소값
        MAXVALUE 99999999            -- 최대값
        NOCYCLE                      -- 최대값 도달시 시작부터 반복 안함
        CACHE 20                     -- 미리 번호를 메모리에 생성 단점은 서버가 뻗으면 받은 20개 숫자가 날라감
        ORDER;                       -- 요청 순서대로  값을 생성

SELECT my_seq.NEXTVAL FROM dual;

-- 현재 시퀀스 값 확인
SELECT my_seq.CURRVAL FROM dual;



-- 시퀀스 삭제
DROP SEQUENCE my_seq;

DROP TABLE dept3;

CREATE TABLE dept (
    deptno NUMBER(6),
    dname VARCHAR2(200),
    loc VARCHAR2(200),
    create_date DATE DEFAULT SYSDATE
    );



CREATE TABLE dept3 AS
SELECT * FROM dept WHERE 1 = 2;


SELECT * FROM dept3;

INSERT INTO dept3 VALUES(my_seq.NEXTVAL, 'A', 1, SYSDATE);
INSERT INTO dept3 VALUES(my_seq.NEXTVAL, 'B', 2, SYSDATE);
INSERT INTO dept3 VALUES(my_seq.NEXTVAL, 'C', 3, SYSDATE);

/*
인덱스 (INDEX)
    데이터베이스에서 데이터를 빠르게 검색하기 위해 특정 열(또는 열의 조합)을
    정렬하여 저장하는 구조로, 데이터 조회 성능을 향상시키는데 사용됩니다.
    
    PK - 테이블 생성시 자동으로 인덱스 생성이 됩니다.
*/

SELECT * FROM employees
WHERE last_name = 'King';

SELECT last_name, ROWID FROM employees -- 자료가 많으면 라스트네임 킹을 찾는데 해당 값을 미리 빼놓고 그값을 보여줌. 반대로 데이터양이 적으면 그냥 풀조회가 빠름.
ORDER BY last_name;

-- EMPLOYEES 테이블의 LAST_NAME 열에 대한 인덱스 생성
CREATE INDEX emp_last_name_idx
    ON employees(last_name);
    
    
-- 인덱스 제거
DROP INDEX emp_last_name_idx;


/*
동의어(SYNONYM)
    동의어를 생성하여 객체에 대해 이름을 부여할 수 있습니다.

*/

-- 동의어 생성
CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT * FROM dept_sum_vu;

SELECT * FROM d_sum;

-- 동의어 제거 
DROP SYNONYM d_sum;

/*
ROWID : ROW 고유의 아이디
        데이터 베이스 내부에서 행의 물리적 위치를 나타냅니다.
ROWNUM : 쿼리의 결과의 각 행에 순차적인 번호를 할당해준다.
*/
SELECT ROWNUM, ROWID, employee_id, last_name, salary
FROM employees;
=======
>>>>>>> bcca17c5401e4b21c032d7d2c5ec14f5662234d1
