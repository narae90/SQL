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
SELECT first_name, manager_id
from employees
WHERE commission_pct IS NULL and manager_id IS NULL;


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
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '_a_';

-- ORDER BY : 정렬
-- 오름차순 : 작은 값 -> 큰 값 ASC(default)
-- 내림차순 : 큰 값 -> 작은 값 DESC
-- 부서번호 오름차순 -> 부서번호, 급여, 이름
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id; -- 오름차순 정렬


-- 급여 10000 이상 직원
-- 정렬 : 급여 내림차순
SELECT first_name, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary DESC; 

--부서번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력
--정렬 : 1차 정렬 부서번호 오름차순, 2차정렬 급여 내림차순
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id, -- 1차 정렬
    salary DESC;  -- 2차 정렬
    

-----단일행 함수---
-- 한 개의 레코드를 입력으로 받는 함수
-- 문자열 단일행 함수 연습
select first_name, last_name, 
concat(first_name, concat('',last_name)), -- 연결
initcap(first_name || '' || last_name), -- 각 단어의 첫글자만 대문자
lower(first_name), -- 모두 소문자
upper(first_name), -- 모두 대문자
lpad(first_name, 10, '*'), -- 왼쪽 채우기
rpad(first_name, 10, '*') -- 오른쪽 채우기
from employees;

select ltrim('            Oracle            '),  -- 왼쪽 공백제거
rtrim('                  Oracle            '), -- 오른쪽 공백 제거
trim('*' from '******Database******'), -- 양쪽의 * 제거
substr('Oracle Database', 8, 4), -- 부분 문자열
substr('Oracle Database', -8, 8) -- 부분 문자열
from dual;


--수치형 단일행 함수
select abs(-3.14), --절대값
    ceil(3.14),     -- 소수점 올림(천장)
    floor(3.14),    -- 소수점 내림(바닥)
    mod(7,3),       -- 나머지
    power(2,4),     --제곱: 2의 4제곱
    round(3.5),     --소수점 반올림 (중요)
    round(3.14159, 3),  --소수점 3자리까지 반올림으로 표현 (중요)
    trunc(3.5),     -- 소수점 버림 (중요)
    trunc(3.14149, 3), --소수점 3자리까지 버림으로 표현 (중요)
    sign(-10)       --부호함수 혹은 0
From dual;



-------------
-- DATE FORMAT
-------------

-- 현재 날짜와 시간
SELECT sysdate from dual; -- 1행
select sysdate from employees; -- employees의 레코드 개수 만큼

-- 날짜 관련 단일행 함수

select sysdate,
    add_months(sysdate, 2), -- 2개월 후
    last_day(sysdate),      -- 이번 달의 마지막 날
    months_between(sysdate, '99/12/31'), -- 99년 마지막날 이 후 몇달이 지났는지
    next_day(sysdate, 7),    --
    round(sysdate, 'month'),
    round(sysdate, 'year'),
    trunc(sysdate, 'month'),
    trunc(sysdate, 'year')
from dual;
    
    
    
-------------
-- 변환 함수
-------------

-- TO_NUMBER(s, fmt) : 문자열을 포맷에 맞게 수치형으로 변환
-- TO_DATE(s, fmt) : 문자열을 포맷에 맞게 날짜형으로 변환
-- TO_CHAR(o, fmt) : 숫자 or 날짜를 포맷에 맞게 문자형으로 변환


--TO_CHAR
select first_name, hire_date,
    to_char(hire_date, 'YYYY-MM-DD HH24:MI:SS'),
    to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;

select to_char(3000000, 'L999,999,999') from dual;

select first_name, to_char(salary * 12, '$999,999.00') SAL
from employees;

-- TO_NUMBER : 문자형 -> 숫자형
select to_number('2021'),
    to_number('$1,450.13', '$999,999.99')
from dual;


--TO_DATE : 문자형 -> 날짜형
select to_date('1999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
from dual;

-- 날짜 연산
--Date +(-) Number : 날짜에 일수 더하기(빼기)
-- Date - Date : 두 Date 사이의 차이 일수
-- Date +(-) Number / 24 : 특정 날짜에 특정 시간 더하기


select to_char(sysdate, 'YYYY-MM-DD HH24:MI'),
    sysdate + 1, -- 1일 뒤
    sysdate - 1, -- 1일 전
    sysdate - to_date('19991231'),
    to_char(sysdate + 13/24, 'YY/MM/DD HH24:MI') --13시간 후
from dual;


----------
-- NULL 관련
----------

--NVL 함수
select first_name, 
        salary, 
        commission_pct, 
        salary * nvl(commission_pct, 0) commission
from employees;

--NVL2 함수
select first_name, 
        salary, 
        commission_pct, 
        nvl2(commission_pct, salary * commission_pct, 0) commission
from employees;


-- CASE 함수
-- AD 관련 직원에게는 20%, SA 관련 직원에게는 10%,
-- IT 관련 직원에게는 8%, 나머지는 5%
SELECT first_name, job_id, salary, SUBSTR(job_id, 1, 2),
    CASE SUBSTR(job_id, 1, 2) WHEN 'AD' THEN salary * 0.2
                                WHEN 'SA' THEN salary * 0.1
                                WHEN 'IT' THEN salary * 0.08
                                ELSE salary * 0.05
    END bonus
FROM employees;

-- DECODE 함수
SELECT first_name, job_id, salary, SUBSTR(job_id, 1, 2),
    DECODE(SUBSTR(job_id, 1, 2),
            'AD', salary * 0.2,
            'SA', salary * 0.1,
            'IT', salary * 0.08,
            salary * 0.05)   --  ELSE
    bonus
FROM employees;


-- 연습문제 
-- 직원의 이름, 부서, 팀을 출력
-- 팀
-- 부서 코드 : 10~30 -> A-Group
-- 부서 코드 : 40~50 -> B-Group
-- 부서 코드 : 60~100 -> B-Group
-- 나머지 : REMAINDER

SELECT
    *
FROM
    employees;

SELECT
    first_name,
    department_id,
    CASE
        WHEN department_id IN ( 10, 20, 30 ) THEN
            'A-Group'
        WHEN department_id IN ( 40, 50 ) THEN
            'B-Group'
        WHEN department_id IN ( 60, 70, 80, 90, 100 ) THEN
            'C-Group'
        ELSE
            'REMAINDER'
    END team
FROM
    employees;


-- 연습문제 1
--전체직원의 다음 정보를 조회하세요. 정렬은 입사일(hire_date)의 올림차순(ASC)으로 가장 선임부터 출력이 되도록 하세요. 
--이름(first_name last_name), 월급(salary), 전화번호(phone_number), 입사일(hire_date) 순서이고 
-- “이름”, “월급”, “전화번호”, “입사일” 로 컬럼이름을 대체해 보세요

select first_name || ' ' || last_name 이름,
        salary "월 급 ",
        phone_number as 전화번호,
        hire_date as 입사일
FROM employees
ORDER BY hire_date;


-- 연습문제 2
--업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬하세요.

select job_title, max_salary
FROM jobs
ORDER BY max_salary DESC; 


-- 연습문제 3
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 
--월급이 3000초과인 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
SELECT first_name, manager_id, commission_pct, salary
FROM employees
WHERE salary >= 3000;

-- 연습문제 4
--최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 
--최고월급(max_salary)을 최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요.
SELECT job_title, max_salary
FROM jobs
WHERE max_salary >= 10000
ORDER BY max_salary DESC; 


-- 연습문제 5
--월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를 월급순(내림차순) 출력하세오. 
--단 커미션퍼센트 가 null 이면 0 으로 나타내시오
select first_name,
        salary, 
        commission_pct,
        salary + salary * NVL(commission_pct, 0) 
from employees
where salary >=10000 and salary <=14000
ORDER BY salary; 

--연습문제 6
--부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
--입사일은 1977-12 와 같이 표시하시오
select first_name, salary, department_id, to_char(hire_date, 'YYYY-MM')
from employees
WHERE department_id IN (10, 90, 10);



--연습문제 7
--이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 나타내시오
select first_name, salary
from employees
WHERE first_name LIKE '%s%' or first_name LIKE '%S%';



--연습문제 8
--전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세오.
select department_name
from departments
ORDER BY length(department_name) DESC;


--연습문제 9
--정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고 올림차순(ASC)으로 정렬해 보세오.
select 
upper (country_name)
from countries
ORDER BY country_name; 


--연습문제 10
--입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력하세요
--전화번호는 545-343-3433 과 같은 형태로 출력하시오
select first_name, salary, hire_date,
        replace(phone_number, '.','-')
from employees
WHERE hire_date <= '03/12/31';

