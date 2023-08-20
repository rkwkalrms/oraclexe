/*
PL/SQL (Procedual) Language extenison to SQL)
    SQL�� Ȯ���� ������ ����Դϴ�.
    ���� SQL�� �ϳ��� ���(block)���� �����Ͽ� SQL ������ �� �ֽ��ϴ�.
    
���ν��� (Procedure)
    �����ͺ��̽����� ���డ���� �ϳ��̻��� SQL���� ��� �ϳ���
    ���� �۾������� ���� �����ͺ��̽� ��ü�Դϴ�.
*/


/*
�͸� ���ν��� - ��ȸ�� ���ν��� DB�� ������� �ʽ��ϴ�.
[�⺻����]
    DECLARE -- ��������
    BEGIN -- ó�� ���� ����
    EXCEPTION -- ����ó��
    END -- ó�� ���� ����

*/
-- �������� ����ϵ��� ����
SET SERVEROUTPUT ON;

-- ��ũ��Ʈ ��� �ð��� ����ϵ��� ����
SET TIMING ON;

DECLARE -- ���� ����
    V_STRD_DT          VARCHAR2(8);
    V_STRD_DEPTNO      NUMBER;
    V_DEPTNO           NUMBER;
    V_DANME            VARCHAR2(50);
    V_LOC              VARCHAR(500);
    V_RESULT           VARCHAR(500) DEFAULT 'SUCCESS';
BEGIN  -- ���� ����
    V_STRD_DT := TO_CAHR(SYSDATE, 'YYYYMMDD'); 
    V_STRD_DEPTNO := 10;
    

    SELECT T1.department_id
         , T1.department_name
         , T1.location_id
      INTO V_DEPTNO
         , V_DNAME
         , V_LOC
      FROM departments T1
     WHERE T1.department_id = V_STRD_DEPTNO; -- �μ���ȣ�� 10���� �μ� ��ȸ

    --��ȸ ��� ���� ����
    V_RESULT_MSG := 'RESULT > DEPTNO='||V_DEPTNO||', DNAME='||V_DNAME||', LOC='||V_LOC;
    --��ȸ ��� ���
    DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
EXCEPTION --���� ó��
    WHEN VALUE_ERROR THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], VALUE_ERROR_MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
    WHEN OTHERS THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
END;
/
-- �۾�����




/*
���ν���
[�⺻����]
CREATE OR REPLACE PROCEDURE ���ν��� �̸� (�Ķ����1, �Ķ����2...)
    IS [AS]
        [�����]
    BEGIN
        [�����]
    [EXCEPTION]
        [EXCEPTION ó��]
    END;
    /
*/

CREATE OR REPLACE PROCEDURE  print_hello_proc --�Ű����� ������ () ��������
    IS -- ���ν��� ����
        msg VARCHAR2(20) := 'hello world'; -- ���� �ʱⰪ ����
    BEGIN
        DBMS_OUTPUT.PUT_LINE(msg);
    END;
/

EXEC print_hello_proc;

/*
IN �Ű�����
    ���� ���ν��� ������ ��
*/
CREATE TABLE emp2 AS
SELECT employee_id empno, last_name name, salary, department_id depno
FROM employees;

CREATE OR REPLACE PROCEDURE update_emp_salary_proc(eno IN NUMBER)--eno�� ���� ��
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
OUT �Ű����� - �����ϰ� ��
    ���ν����� ��ȯ���� �����Ƿ� OUT �Ű������� ���� ���� �� �ִ�.
    ������ �Ű������� ���
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
-- VARCHAR(����Ʈ) NVARCHAR2(���ڱ���) ����
VARIABLE v_fname NVARCHAR2(25);
VARIABLE v_lname NVARCHAR2(25);
VARIABLE v_sal NUMBER;

EXECUTE find_emp_proc(115, :v_fname, :v_lname, :v_sal);
PRINT v_fname;
PRINT v_lname;
PRINT v_sal;

/*
IN OUT �Ű�����
    IN OUT ���ÿ� ����� �� �ִ� �Ű������Դϴ�.
*/

CREATE OR REPLACE PROCEDURE find_sal(v_io IN OUT NUMBER)
IS
    BEGIN
    SELECT salary --salary ���� ��
    INTO v_io
    FROM employees WHERE employee_id = v_io; -- 115����
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
�Լ�(Function)
    Ư�� ��ɵ��� ���ȭ, ������ �� �ְ� ������ �������� �����ϰ� ���� �� �ֽ��ϴ�.
    
[�⺻����]
CREATE OR REPLACE FUNCTION function_name (�Ķ����1, �Ķ����2...)
RETURN datatype -- ��ȯ�Ǵ� ���� ����
    IS[AS] -- �����
    BEGIN
        [����� - PL/SQL ��]
    [EXCEPTION ó��]
        [EXCEPTION ó��]
    RETURN ����;
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



