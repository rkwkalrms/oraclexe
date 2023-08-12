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