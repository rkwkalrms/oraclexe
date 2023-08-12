-- 1. 각 직원의 성(last_name)과 해당 직원의 매니저인 직원의 성(last_name) 조회하기
SELECT e.last_name, m.last_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

-- 2. 각 직원의 성(last_name)과 해당 직원의 부서 이름(department_name) 조회하기
SELECT e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 3. 각 부서의 이름(department_name)과 해당 부서의 평균 급여(avg_salary) 조회하기
SELECT d.department_name, AVG(e.salary) AS Avg_Salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;


-- 4. 각 부서의 이름(department_name)과 해당 부서의 최대 급여(max_salary) 조회하기
SELECT d.department_name, MAX(e.salary) AS Max_Salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 5. 각 직원의 성(last_name)과 해당 직원이 속한 부서의 최소 급여(min_salary) 조회하기
SELECT oe.last_name, od.Min_Salary
FROM employees oe
JOIN (
    SELECT d.department_id, MIN(e.salary) AS Min_Salary
    FROM departments d
    JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_id
    )  od
ON oe.department_id = od.department_id;

-- 6. 각 부서의 이름(department_name)과 해당 부서에 속한 직원 중 가장 높은 급여(highest_salary) 조회하기
SELECT d.department_name, MAX(e.salary) AS higgst_Salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;



-- 7. 각 직원의 성(last_name)과 해당 직원의 매니저의 성(last_name) 및 부서 이름(department_name) 조회하기
SELECT e.last_name AS WORKER_LAST_NAME, m.last_name AS MANAGER_LAST_NAME, d.department_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 8. 각 직원의 성(last_name)과 해당 직원이 속한 부서의 매니저의 성(last_name) 조회하기
SELECT oe.last_name AS W_LAST_NAME, om.last_name AS M_LAST_NAME
FROM ( 
    SELECT e.last_name, d.department_id, d.manager_id
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN employees m ON d.manager_id = m.manager_id
) oe
JOIN employees om ON oe.manager_id = om.employee_id;

-- 10. 직원들 중에서 급여(salary)가 10000 이상인 직원들의 성(last_name)과 해당 직원의 부서 이름(department_name) 조회하기
SELECT e.last_name, d.department_name, salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary >= 10000
ORDER BY e.salary DESC;

/*
11.
각 부서의 이름(department_name), 해당 부서의 매니저의 ID(manager_id)와 매니저의 성(last_name),
직원의 ID(employee_id), 직원의 성(last_name), 그리고 해당 직원의 급여(salary) 조회하기.
직원들의 급여(salary)가 해당 부서의 평균 급여보다 높은 직원들을 조회합니다.
결과는 부서 이름과 직원의 급여가 높은 순으로 정렬됩니다.- 직원을 조회하는게 맞다
*/

SELECT d.department_id, d.department_name, d.manager_id, m.last_name AS M_LAST_NAME,
    e.employee_id, e.last_name AS W_LAST_NAME, e.salary
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON d.department_id = e.department_id
WHERE 1 = 1
--AND d.department_id > 100
AND e.salary > (
            -- 각 부서의 평균 급여 
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