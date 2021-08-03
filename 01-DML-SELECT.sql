--DML: SELECT

---------------------
-- SELECT ~ FROM
---------------------
-- 전체 데이터의 모든 컬럼 조회
-- 컬럼의 출력 순서는 정의에 따른다
SELECT * FROM employees;
select * from departments;

-- 특정 컬럼만 선별 Projection
-- 사원의 이름, 입사일, 급여 출력
SELECT first_name, hire_date, salary from employees;

-- 산술연산: 기본적인 산술연산 가능
--  dual: 오라클의 가상 테이블
-- 특정 테이블에 속한 데이터가 아닌 오라클 시스템에서 값을 구한다
SELECT 10 * 10 * 3.14159 FROM dual; -- 결과 1개
SELECT 10 * 10 * 3.14159 fROM employees;  -- 결과 테이블의 레코드 수만큼

SELECT first_name, job_id * 12
FROM employees; -- ERROR : 수치데이터가 아니면 산술연산 오류
DESC employees;

SELECT first_name + '' + last_name
FROM employees; -- ERROR: first_name, last_name은 문자열

--문자열 연결은 || 로 연결

SELECT first_name || '' || last_name
FROM employees;

-- NULL
SELECT first_name, salary, salary * 12
FROM employees;


SELECT first_name, salary, commission_pct
FROM employees;

SELECT first_name, 
    salary,
    commission_pct,
    salary + salary * commission_pct
FROM employees;

-- NVL : 중요
SELECT first_name,
    salary,
    commission_pct,
    salary + salary * NVL(commission_pct, 0) 
 -- commission_pct가 null이면 0으로 치환
 FROM employees;
 
 --ALIAS : 별칭
 SELECT first_name || ' ' || last_name 이름, 
        phone_number as 전화번호, 
        salary "급 여 " -- 공백, 특수문자가 포함된 별칭은 "" 묶는다
FROM employees;


-- 연습 : 
SELECT first_name || ' ' || last_name 이름,
        hire_date as 입사일,
        phone_number as 전화번호, 
        salary "급 여 ",
        salary * 12  "연 봉"
FROM employees;

------------
-- WHERE
------------

-- 비교 연산
-- 급여가 15000 이상인 사원의 목록
SELECT first_name, salary
FROM employees
WHERE salary >= 15000;

-- 날짜도 대소 비교 가능
-- 입사일이 07/01/01 이후인 사원의 목록

SELECT first_name, hire_date
FROM employees
WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 사원의 이름, 급여, 입사일 출력
SELECT first_name, salary, hire_date
FROM employees
WHERE first_name = 'Lex';

-- 논리연산자
--급여가 10000 이하이거나 17000이상인 사원의 목록
SELECT first_name, salary
FROM employees
WHERE salary <= 10000 or salary >= 17000;

--급여가 14000 이상, 17000이하인 사원의 목록
SELECT first_name, salary
FROM employees
WHERE salary >= 14000 and salary <= 17000;

--BETWEEN : 위 쿼리와 결과 동일
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 14000 and 17000;


--NULL 체크
-- =NULL, !=NULL은 하면 안됨
-- 반드시 IS NULL, IS NOT NULL 사용
-- 커미션을 받지 않는 사원의 목록
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NULL;


-- 연습문제 : 
-- 담당매니저가 없고, 커미션을 받지 않는 사원의 목록


-- 집합 연산자 : IN
-- 부서번호가 10, 20, 30인 사원들의 목록
SELECT first_name, department_id
FROM employees
WHERE department_id = 10 or department_id = 20 or department_id = 30;

--IN
SELECT first_name, department_id
FROM employees
WHERE department_id IN (10, 20, 30);

-- ANY 연산자 
SELECT first_name, department_id
FROM employees
WHERE department_id = ANY (10, 20, 30);


--ALL : 뒤에 나오는 집합 전부 만족
SELECT first_name, salary
FROM employees
WHERE salary >ALL (12000, 17000);


--LIKE 연산자 : 부분 검색
-- %: 0글자 이상의 정해지지 않은 문자열 
-- _: 1글자(고정) 정해지지 않은 문자
-- 이름애 am을 포함한 사원의 이름과 급여를 출력

SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%am%';


-- 연습문제
-- 이름의 두번째 글자가 a인 사원의 이름과 연봉









