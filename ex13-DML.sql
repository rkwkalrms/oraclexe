/*

DML(Data Manipulation Language)
    DB���� �����͸� �����ϰ� ó���ϴ� SQL
    
    INSERT�� : ���̺� ���ο� ���ڵ� ����
    UPDATE�� : ���̺� ���� ���ڵ带 ����(������Ʈ) �ϴµ� ���
    DELETE�� : ���̺��� Ư�� ���ڵ带 ����
    
    
    SELECT�� DML ���Ե� �� ������, ���� DQL(Data Query Language) �з��Ѵ�.
    
*/

/*
INSERT��
[�⺻����]
    INSERT INTO ���̺�� (�÷���1, �÷���2, ...)
    VALUES(��1, ��2, ...);
    
    �Ǵ�
    
    INSERT INTO ���̺�� (�÷���1, �÷���2, ...) subquery;   ���Ͽ°� ���� ���������
    
*/
SELECT * FROM departments;

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Public RElations', 100, 1700);

commit; -- DML ����� ���������� DB�� �ݿ�

-- null ���� ���� �� ����
-- �� ����
INSERT INTO departments (department_id, department_name)
VALUES (290, 'Purchasing');

SELECT *FROM departments;

ROLLBACK; -- DML���� �������� ����� ��

-- NULL Ű���� ����
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

--job_id REP ���Ե� ���
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

/*
UPDATE��
    ���̺��� ���� ���� �����մϴ�.

[�⺻����]
    UPDATE ���̺��
    SET �÷���1 = ������, �÷���2 = ������
    WHERE ������
*/

CREATE TABLE copy_emp
AS SELECT * FROM employees WHERE 1 = 2;

INSERT INTO copy_emp
SELECT * FROM employees;

commit;

SELECT * FROM copy_emp;


-- �μ���ȣ 50������ ����
UPDATE copy_emp
SET department_id = 50
WHERE employee_id = 113;

rollback;

UPDATE copy_emp
SET department_id = 110;


UPDATE copy_emp
SET department_id = 80
WHERE employee_id = 113;

UPDATE copy_emp
SET department_id = (SELECT department_id
                        FROM employees
                        WHERE employee_id = 100)
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 200);


SELECT * FROM copy_emp WHERE job_id = 'AD_ASST';

/*
DELETE ��
    DELETE ���� ����Ͽ� ���̺��� ���� ���� ������ �� �ֽ��ϴ�.

*/

-- �����ȣ 200�� ��� ����
DELETE FROM copy_emp
WHERE employee_id = 200;

SELECT * FROM copy_emp
WHERE employee_id = 200;

ROLLBACK;

-- ���̺� ��ü ������ ����
DELETE FROM copy_emp;

SELECT * FROM copy_emp;

/*
TRUNCATE ��
    ���̺��� �� ���·�, ���̺� ���� �״�� ���ܵ�ä ���̺��� ��� ���� �����ϴϴ�.
    DML ���� �ƴ϶� DDL(������ ���Ǿ�) ���̹Ƿ� ���� ����� �� �����ϴ�. �����⸸ ����� �����Ѵ�. ����
*/

TRUNCATE TABLE copy_emp;

/*
Ʈ�����(Transaction)     
    ������ ó���� �� �����Դϴ�.
    ����Ŭ���� �߻��ϴ� ���� ���� SQL ��ɹ��� 
    �ϳ��� ������ �۾� ������ ó���ϴµ� �̸� Ʈ������̶�� �մϴ�.
    
    COMMIT : SQL���� ����� ���������� DB�� �ݿ�
    ROLLBACK : SQL���� �������� ����� ��
    SAVEPOINT : Ʈ������� �� ������ ǥ���ϴ� �ӽ� ������
*/

CREATE TABLE member(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    addr VARCHAR2(50)
    );

INSERT INTO member VALUES(1, '��ī��','���ʸ���');
COMMIT;
INSERT INTO member VALUES(2, '������','���ʸ���');
INSERT INTO member VALUES(3, '���̸�','���ʸ���');
INSERT INTO member VALUES(4, '���α�','���ʸ���');

ROLLBACK;

SELECT * FROM member;


-- SAVEPOINT
INSERT INTO member VALUES(5, '������', '���ʸ���');
SAVEPOINT mypoint;
INSERT INTO member VALUES(6, '�ߵ���', '���ʸ���');
INSERT INTO member VALUES(7, '������', '���ʸ���');
INSERT INTO member VALUES(8, '�ǰ���', '���ʸ���');

ROLLBACK TO mypoint;
COMMIT;

/*
SELECT ���� FOR UPDATE  ��
    FOR UPDATE �� Ư�� ���ڵ带 ���(lock) ó���ϴ� SQL�����Դϴ�.
    COMMIT �Ǵ� ROLLBACK ������� �մϴ�.
*/
SELECT employee_id, salary, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE;

commit;