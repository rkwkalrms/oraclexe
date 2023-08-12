/*


���� ����
    Ʈ�� ������ ������ �����Ϳ��� �θ�-�ڽ� ���踦 ���� �����ϴµ� ���Ǵ� SQL
    �ַ� ������, ������ ������, ������ �ּ� � Ȱ��˴ϴ�.
    
���� Ű����
    START WITH : ���� ������ ���� ������ �����մϴ�. �ֻ��� �θ� ��带 �����մϴ�.
    CONNECT BY : �θ� - �ڽ� ���踦 �����ϴ� Ű�����, PRIOR Ű����� �Բ� ���˴ϴ�.
    PRIOR : �θ�-�ڽ� ���踦 ǥ���ϴ� Ű����� �ڽ� �÷��տ� ���˴ϴ�.
    NOCYCLB : ����Ŭ�� ������� �ʵ��� �����ϴ� �ɼ��Դϴ�.
    LEVEL : �� ������ ���̸� ��Ÿ���� �ǻ� �÷����� ���˴ϴ�.
    SYS_CONNECT_BY_PATH : ���� ������ ��θ� ���ڿ��� ǥ�����ִ� �Լ��Դϴ�.
    ORDER SIBILING BY : ���� ������ �����ϴµ� ���˴ϴ�.
        
*/

-- id, name, manager_id, depth
SELECT
    e.employee_id,
    e.last_name,
    e.manager_id,
    LEVEL AS depth,
    LPAD(' ', LEVEL*2-2) || SYS_CONNECT_BY_PATH(e.last_name, '/') AS hierarchy_path
FROM
    employees e
START WITH
    e.manager_id = 100
CONNECT BY
    NOCYCLE PRIOR e.employee_id = e.manager_id
ORDER SIBLINGS BY e.employee_id
;

-- NOCYCLE ����Ŭ�� ������� �ʵ��� ����(���ѷ�������)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE smployee_id = 100;


UPDATE employees SET
manager_id = null
WHERE employee_id = 100;

commit;










