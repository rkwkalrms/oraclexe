/*


������ ���̽� ��ü
    ���̺� : �⺻ ��������̸� ������ �����Ǿ� �ֽ��ϴ�.
    �� : �ϳ� �̻��� ���̺� �ִ� �������� �κ� ������ �������� ��Ÿ���ϴ�.(���� ���̺�)
    ������ : �Ϸ��� ���ڸ� �ڵ����� �������ִ� ��ü�Դϴ�.
    �ε��� : ���̺��� �����Ϳ� ���� �����˻��� �������ִ� ���� ��ü
    ���Ǿ� : ��ü�� �ٸ� �̸��� �ο��մϴ�.
*/

-- �� ����
CREATE VIEW empvu80
<<<<<<< HEAD
AS SELECT employee_id, last_name, salary -- �並 
=======
AS SELECT employee_id, last_name, salary
>>>>>>> bcca17c5401e4b21c032d7d2c5ec14f5662234d1
    FROM employees
    WHERE department_id = 80;
    
DESC empvu80;

SELECT * FROM empvu80;

-- alias ��� �� ����
CREATE VIEW salvu50
AS SELECT employee_id AS OD_NUMBER, last_name name, salary*12 ANN_SALARY
    FROM employees
    WHERE department_id = 50;
    
SELECT * FROM salvu50
WHERE ANN_SALARY >= 50000;
<<<<<<< HEAD


CREATE VIEW salvu_hangle
AS SELECT employee_id AS ���̵�, last_name �̸�, salary*12����
    FROM employees
    WHERE department_id = 50;


SELECT * FROM salvu_hangle;


-- �� ����
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
���� �� ����
    �� �� �̻� �⺻ ���̺� ���� ���ǵ� ��
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
�� DML �۾� ���� ��Ģ
    1. �� ������ �� ���� ���
        - �׷� �Լ�
        - GROUP BY ��
        - DISTINCT Ű����
        - Pseudocolumn ROWNUM Ű����
    2. ���� �����͸� ������ �� ���� ���
        - �׷� �Լ�
        - GROUP BY ��
        - DISTINCT Ű����
        - Pseudocolumn ROWNUM Ű����
    3. �並 ���� �����͸� �߰��� �� ���� ���
        - �׷� �Լ�
        - GROUP BY ��
        - DISTINCT Ű����
        - Pseudocolumn ROWNUM Ű����---- Pseudocolumn�� ������ Ŀ��
        - ǥ�������� ���ǵǴ� ��
        - �信�� ���õ��� ���� �⺻ ���̺��� NOT NULL ��
        
*/

-- ROWNUM : ������ ����� �� �࿡ �������� ��ȣ�� �Ҵ����ش�.
SELECT ROWNUM, employee_id, last_name
FROM employees
WHERE department_id = 80;

-- DML �۾��ź�
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
    �信 ���� ������ �����۾� ����
*/

CREATE OR REPLACE view high_salary_employee_vu
AS SELECT * FRom employees WHERE salary > 10000 -- �� ���ǿ��� �������� 
WITH CHECK OPTION CONSTRAINT high_salary_employee_ck;

SELECT * FROM high_salary_employee_vu;

-- ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�.
UPDATE high_salary_employee_vu SET
salary = 2400
WHERE employee_id = 100;
-- WITH CHECK OPTION�� ���ǿ� ���� ���� �ʾ� ���� �����մϴ�.
UPDATE high_salary_employee_vu SET
salary = 26000
WHERE employee_id = 100;

-- �� ����
DROP VIEW high_salary_employee_vu;


/*
������(sequece)
    �������� ���� ���� �ڵ����� ���� ���Ѽ� ���� �����ϴ� ��ü�Դϴ�.
    ä���Ҷ� ���� ����Ѵ�.    
*/

CREATE SEQUENCE my_seq
        INCREMENT BY 1               -- ������ (1������) 
        START WITH 1                 -- ���۰�
        MINVALUE 1                   -- �ּҰ�
        MAXVALUE 99999999            -- �ִ밪
        NOCYCLE                      -- �ִ밪 ���޽� ���ۺ��� �ݺ� ����
        CACHE 20                     -- �̸� ��ȣ�� �޸𸮿� ���� ������ ������ ������ ���� 20�� ���ڰ� ����
        ORDER;                       -- ��û �������  ���� ����

SELECT my_seq.NEXTVAL FROM dual;

-- ���� ������ �� Ȯ��
SELECT my_seq.CURRVAL FROM dual;



-- ������ ����
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
�ε��� (INDEX)
    �����ͺ��̽����� �����͸� ������ �˻��ϱ� ���� Ư�� ��(�Ǵ� ���� ����)��
    �����Ͽ� �����ϴ� ������, ������ ��ȸ ������ ����Ű�µ� ���˴ϴ�.
    
    PK - ���̺� ������ �ڵ����� �ε��� ������ �˴ϴ�.
*/

SELECT * FROM employees
WHERE last_name = 'King';

SELECT last_name, ROWID FROM employees -- �ڷᰡ ������ ��Ʈ���� ŷ�� ã�µ� �ش� ���� �̸� ������ �װ��� ������. �ݴ�� �����;��� ������ �׳� Ǯ��ȸ�� ����.
ORDER BY last_name;

-- EMPLOYEES ���̺��� LAST_NAME ���� ���� �ε��� ����
CREATE INDEX emp_last_name_idx
    ON employees(last_name);
    
    
-- �ε��� ����
DROP INDEX emp_last_name_idx;


/*
���Ǿ�(SYNONYM)
    ���Ǿ �����Ͽ� ��ü�� ���� �̸��� �ο��� �� �ֽ��ϴ�.

*/

-- ���Ǿ� ����
CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT * FROM dept_sum_vu;

SELECT * FROM d_sum;

-- ���Ǿ� ���� 
DROP SYNONYM d_sum;

/*
ROWID : ROW ������ ���̵�
        ������ ���̽� ���ο��� ���� ������ ��ġ�� ��Ÿ���ϴ�.
ROWNUM : ������ ����� �� �࿡ �������� ��ȣ�� �Ҵ����ش�.
*/
SELECT ROWNUM, ROWID, employee_id, last_name, salary
FROM employees;
=======
>>>>>>> bcca17c5401e4b21c032d7d2c5ec14f5662234d1
