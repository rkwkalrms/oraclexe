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
AS SELECT employee_id, last_name, salary
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
