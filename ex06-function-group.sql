



-- ������(�׷�) �Լ�

-- AVG() - ���
-- MAX() - �ִ밪
-- MIN() - �ּҰ�
-- SUM() - �հ�
SELECT AVG(salary) AS avg_salary,
        MAX(salary) AS max_salray,
        MIN(salary) AS min_salary,
        SUM(salary) AS total_salary
FROM employees
WHERE job_id LIKE '%REP%';

-- COUNT() �Լ� - null ���� �ƴ� ��� ���� ������ ��ȯ�մϴ�.
SELECT 3
FROM employees
WHERE department_id = 50;



SELECT COUNT(*) AS total_employees
FROM employees
WHERE department_id = 50;

SELECT COUNT(commission_pct) AS non_null_commission_count
FROM employees
WHERE department_id = 50;

SELECT COUNT(commission_pct) AS non_null_commission_count
FROM employees
WHERE department_id = 80;



