/*
PL/SQL (Procedual) Language extenison to SQL)
    SQL을 확장한 절차적 언어입니다.
    여러 SQL을 하나의 블록(block)으로 구성하여 SQL 제어할 수 있습니다.
    
프로시저 (Procedure)
    데이터베이스에서 실행가능한 하나이상의 SQL문을 묶어서 하나의
    논리적 작업단위로 만든 데이터베이스 객체입니다.
*/


/*
익명 프로시저 - 일회용 프로시저 DB에 저장되지 않습니다.
[기본구조]
    DECLARE -- 변수정의
    BEGIN -- 처리 로직 시작
    EXCEPTION -- 예외처리
    END -- 처리 로직 종료

*/
-- 실행결과를 출력하도록 설정
SET SERVEROUTPUT ON;

-- 스크립트 경과 시간을 출력하도록 설정
SET TIMING ON;

DECLARE -- 변수 정의
    V_STRD_DT          VARCHAR2(8);
    V_STRD_DEPTNO      NUMBER;
    V_DEPTNO           NUMBER;
    V_DANME            VARCHAR2(50);
    V_LOC              VARCHAR(500);
    V_RESULT           VARCHAR(500) DEFAULT 'SUCCESS';
BEGIN  -- 로직 시작
    V_STRD_DT := TO_CAHR(SYSDATE, 'YYYYMMDD'); 
    V_STRD_DEPTNO := 10;
    

    SELECT T1.department_id
         , T1.department_name
         , T1.location_id
      INTO V_DEPTNO
         , V_DNAME
         , V_LOC
      FROM departments T1
     WHERE T1.department_id = V_STRD_DEPTNO; -- 부서번호가 10번인 부서 조회

    --조회 결과 변수 설정
    V_RESULT_MSG := 'RESULT > DEPTNO='||V_DEPTNO||', DNAME='||V_DNAME||', LOC='||V_LOC;
    --조회 결과 출력
    DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
EXCEPTION --예외 처리
    WHEN VALUE_ERROR THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], VALUE_ERROR_MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
    WHEN OTHERS THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
END;
/
-- 작업종료




/*
프로시저
[기본구조]
CREATE OR REPLACE PROCEDURE 프로시저 이름 (파라미터1, 파라미터2...)
    IS [AS]
        [선언부]
    BEGIN
        [실행부]
    [EXCEPTION]
        [EXCEPTION 처리]
    END;
    /
*/

CREATE OR REPLACE PROCEDURE  print_hello_proc --매개변수 없으면 () 생략가능
    IS -- 프로시저 시작
        msg VARCHAR2(20) := 'hello world'; -- 변수 초기값 선언
    BEGIN
        DBMS_OUTPUT.PUT_LINE(msg);
    END;
/

EXEC print_hello_proc;

/*
IN 매개변수
    값이 프로시저 안으로 들어감
*/
CREATE TABLE emp2 AS
SELECT employee_id empno, last_name name, salary, department_id depno
FROM employees;

CREATE OR REPLACE PROCEDURE update_emp_salary_proc(eno IN NUMBER)--eno에 값이 들어감
    IS
    BEGIN
        UPDATE emp2 SET
        salary = salary * 1.1
        WHERE empno = eno;
        COMMIT;
    END;
/

SELECT * FROM emp2
WHERE empno = 115;

EXEC update_emp_salary_proc(115);


/*
OUT 매개변수 - 실행하고 끝
    프로시저의 반환값이 없으므로 OUT 매개변수로 값을 받을 수 있다.
    참조형 매개변수와 비슷
*/
CREATE OR REPLACE PROCEDURE find_emp_proc(v_eno IN NUMBER,
        v_FNAME OUT NVARCHAR2, v_lname OUT NVARCHAR2, v_sal OUT NUMBER)
IS
    BEGIN
        SELECT first_name, last_name, salary
        INTO v_fname, v_lname, v_sal
        FROM employees WHERE employee_id = v_eno;
    END;
/
-- VARCHAR(바이트) NVARCHAR2(문자길이) 차이
VARIABLE v_fname NVARCHAR2(25);
VARIABLE v_lname NVARCHAR2(25);
VARIABLE v_sal NUMBER;

EXECUTE find_emp_proc(115, :v_fname, :v_lname, :v_sal);
PRINT v_fname;
PRINT v_lname;
PRINT v_sal;

/*
IN OUT 매개변수
    IN OUT 동시에 사용할 수 있는 매개변수입니다.
*/

CREATE OR REPLACE PROCEDURE find_sal(v_io IN OUT NUMBER)
IS
    BEGIN
    SELECT salary --salary 값이 들어감
    INTO v_io
    FROM employees WHERE employee_id = v_io; -- 115가됌
    END;
/

DECLARE
    v_io NUMBER:= 115;
    BEGIN
    DBMS_OUTPUT.PUT_LINE('eno='||v_io);
    find_sal(v_io);
    DBMS_OUTPUT.PUT_LINE('salary='||v_io);
    END;
/

VAR v_io NUMBER;
EXEC :v_io := 115;
PRINT v_io;
EXEC find_sal(:v_io);
PRINT v_io;

/*
함수(Function)
    특정 기능들을 모듈화, 재사용할 수 있게 복잡한 쿼리문을 간결하게 만들 수 있습니다.
    
[기본구조]
CREATE OR REPLACE FUNCTION function_name (파라미터1, 파라미터2...)
RETURN datatype -- 반환되는 값의 유형
    IS[AS] -- 선언부
    BEGIN
        [실행부 - PL/SQL 블럭]
    [EXCEPTION 처리]
        [EXCEPTION 처리]
    RETURN 변수;
    END;
/
*/
CREATE OR REPLACE FUNCTION fn_get_dept_name(p_dept_no NUMBER)
RETURN VARCHAR2
    IS
        V_TEST_NAME VARCHAR2(30);
    BEGIN
        SELECT department_name
        INTO   V_TEST_NAME
        FROM   departments
        WHERE  department_id = p_dept_no;
        
    RETURN V_TEST_NAME;
    END;
/

SELECT fn_get_dept_name(10) FROM dual;



