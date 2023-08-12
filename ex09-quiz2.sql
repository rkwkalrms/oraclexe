-- 1. �� ������ ��(last_name)�� �ش� ������ �Ŵ����� ������ ��(last_name) ��ȸ�ϱ�
SELECT e.last_name, m.last_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

-- 2. �� ������ ��(last_name)�� �ش� ������ �μ� �̸�(department_name) ��ȸ�ϱ�
SELECT e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 3. �� �μ��� �̸�(department_name)�� �ش� �μ��� ��� �޿�(avg_salary) ��ȸ�ϱ�
SELECT d.department_name, AVG(e.salary) AS Avg_Salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;


-- 4. �� �μ��� �̸�(department_name)�� �ش� �μ��� �ִ� �޿�(max_salary) ��ȸ�ϱ�
SELECT d.department_name, MAX(e.salary) AS Max_Salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 5. �� ������ ��(last_name)�� �ش� ������ ���� �μ��� �ּ� �޿�(min_salary) ��ȸ�ϱ�
SELECT oe.last_name, od.Min_Salary
FROM employees oe
JOIN (
    SELECT d.department_id, MIN(e.salary) AS Min_Salary
    FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_id
    )  od
ON oe.department_id = od.department_id;

-- 6. �� �μ��� �̸�(department_name)�� �ش� �μ��� ���� ���� �� ���� ���� �޿�(highest_salary) ��ȸ�ϱ�
SELECT d.department_name, MAX(e.salary) AS higgst_Salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;



-- 7. �� ������ ��(last_name)�� �ش� ������ �Ŵ����� ��(last_name) �� �μ� �̸�(department_name) ��ȸ�ϱ�
SELECT e.last_name AS WORKER_LAST_NAME, m.last_name AS MANAGER_LAST_NAME, d.department_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 8. �� ������ ��(last_name)�� �ش� ������ ���� �μ��� �Ŵ����� ��(last_name) ��ȸ�ϱ�
SELECT oe.last_name AS W_LAST_NAME, om.last_name AS M_LAST_NAME
FROM ( 
    SELECT e.last_name, d.department_id, d.manager_id
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN employees m ON d.manager_id = m.manager_id
) oe
JOIN employees om ON oe.manager_id = om.employee_id;

-- 10. ������ �߿��� �޿�(salary)�� 10000 �̻��� �������� ��(last_name)�� �ش� ������ �μ� �̸�(department_name) ��ȸ�ϱ�
SELECT e.last_name, d.department_name, salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary >= 10000
ORDER BY e.salary DESC;

/*
11.
�� �μ��� �̸�(department_name), �ش� �μ��� �Ŵ����� ID(manager_id)�� �Ŵ����� ��(last_name),
������ ID(employee_id), ������ ��(last_name), �׸��� �ش� ������ �޿�(salary) ��ȸ�ϱ�.
�������� �޿�(salary)�� �ش� �μ��� ��� �޿����� ���� �������� ��ȸ�մϴ�.
����� �μ� �̸��� ������ �޿��� ���� ������ ���ĵ˴ϴ�.- ������ ��ȸ�ϴ°� �´�
*/

SELECT d.department_id, d.department_name, d.manager_id, m.last_name AS M_LAST_NAME,
    e.employee_id, e.last_name AS W_LAST_NAME, e.salary
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON d.department_id = e.department_id
WHERE 1 = 1
--AND d.department_id > 100
AND e.salary > (
            -- �� �μ��� ��� �޿� 
            SELECT AVG(e1.salary)
            FROM employees e1
            WHERE e1.department_id = d.department_id
            )
ORDER BY d.department_name, e.salary DESC
;

SELECT d.department_id, d.department_name, d.manager_id, m.last_name AS M_LAST_NAME,
    e.employee_id, e.last_name AS W_LAST_NAME, e.salary
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON d.department_id = e.department_id
JOIN (
    SELECT department_id, AVG(salary) AS Avg_Salary
    FROM employees 
    GROUP BY department_id
    ) da
ON d.department_id = da.department_id
WHERE e.salary > da.Avg_Salary
ORDER BY d.department_name, e.salary DESC
;