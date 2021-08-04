----------
--JOIN
----------

-- 먼저 employees와 departments를 확인
desc employees;
desc departments;

-- 두 테이블로부터 모든 레코드를 추출 : Cartision Product or Cross Join
select first_name, emp.department_id, dept.department_id, department_name
from employees emp, departments dept
order by first_name;

-- 테이블 조인을 위한 조건을 부여할 수 있다. : Simple Join
select first_name, emp.department_id, dept.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- 총 몇 명의 사원이 있는가?
select count(*) from employees;  -- 107명

select first_name, emp.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id; --106명

--department_id가 null인 사원
select * from employees
where department_id is null;

-- USING : 조인할 컬럼을 명시
select first_name, department_name
from employees join departments using(department_id);

-- ON : JOIN의 조건절
select first_name, department_name
from employees emp join departments dept
                    on (emp.department_id = dept.department_id); -- JOIN의 조건
                    

-- Natural Join
-- 조건 명시 하지 않고, 같은 이름을 가진 컬럼으로 Join을 수행
select first_name, department_name
from employees natural join departments;
-- 잘목된 쿼리 : natural join은 조건을 잘 확인!


-------------
--OUTER JOIN
-------------

-- 조건이 만족하는 짝이 없는 튜플도 null을 포함하여 결과를 출력
-- 모든 레코드를 출력할 테이블의 위치에 따라 LEFT, RIGHT, FULL OUTER JOIN으로 구분
-- ORACLE의 경우 NULL을 출력할 조건 쪽에 (+)를 명시

--left join 
select first_name,
    emp.department_id,
    dept.department_id,
    department_name
from employees emp, departments dept
where emp.department_id = dept.department_id (+);


-- ANSI SQL
select emp.first_name,
    emp.department_id,
    dept.department_id,
    dept.department_name
from employees emp left outer join departments dept
                    on emp.department_id = dept.department_id;
                    
-- RIGTH OUTER JOIN : 짝이 없는 오른쪽 레코드도 NULL을 포함하여 출력 
-- ORACLE SQL
select first_name, emp.department_id, 
    dept.department_id, dept.department_name
FROM employees emp, departments dept
where emp.department_id (+) = dept.department_id;
                

-- ANSI SQL
select first_name, emp.department_id, 
    dept.department_id, dept.department_name
from employees emp right outer join departments dept
                    on emp.department_id = dept.department_id;

-- FULL OUTER JOIN
-- 양쪽 테이블 레코드 전부를 짝이 없어도 출력에 참여

-- ORACLE SQL 에서는 불가
--select first_name, emp.department_id, 
--   dept.department_id, dept.department_name
--FROM employees emp, departments dept
--WHERE emp.department_id (+) = dept.department_id (+);

-- ANSI SQL
select first_name, emp.department_id, 
    dept.department_id, dept.department_name
from employees emp full outer join departments dept
                    on emp.department_id = dept.department_id;
                    
                    
--------------
-- SELF JOIN
--------------
-- 자기 자신과 JOIN
-- 자기 자신을 두번이상 호출 -> alias를 사용할 수 밖에 없는 join
select * from employees; -- 107명

-- 사원 정보, 매니저 이름을 함께 출력
-- 방법 1. 
select emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name
from employees emp join employees man
                    on emp.manager_id = man.employee_id
order by emp.employee_id;


-- 방법 2.
select emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.employee_id,
    man.first_name     
from employees emp, employees man
where emp.manager_id = man.employee_id (+) -- lefr outer join
order by emp.employee_id;



--실습3 JOIN
--문제 1.
--직원들의 사번 (employee_id), 이름 (firt_name), 성 (last_ name)과 부서명 (department_name) 을 조회하여 부서이름 (department_name) 오름차순 , 사번 (employee_id) 내림차순 으로 정렬하세요
--(106건)
select 
    emp.employee_id, 
    first_name,
    last_name, 
    dept.department_name
    
from employees emp, departments dept
order by dept.department_name,
    employee_id DESC;

    

-- 문제 2. (오류!!!!!!!!!)
-- employees 테이블의 job_id 는 현재의 업무아이디를 가지고 있습니다 
-- 직원들의 사번 (employee_id), 이름 (first_name), 급여 (salary), 부서명 (department_name), 현재업무 (job_title)를 사번(employee_id) 오름차순 으로 정렬하세요
-- 부서가 없는 Kimberely( 사번 178) 은 표시하지 않습니다 (106건)
select employee_id, first_name, salary, department_name, job_title
from employees emp, departments dept, jobs 
order by dept.department_id;







-- 문제 2-1. (오류!!!!!!!!)
-- 문제 2 에서 부서가 없는 Kimberely( 사번 178) 까지 표시해 보세요
-- (107건)
select emp.employee_id, first_name, salary, department_name, job_title
from employees emp, departments dept, jobs 
where dept.department_id is not null
order by dept.department_id;




-- 문제 3.
-- 도시별로 위치한 부서들을 파악하려고 합니다
-- 도시아이디, 도시명 , 부서명 , 부서아이디를 도시아이디 오름차순 로 정렬하여 출력하세요
-- 부서가없는 도시는 표시하지 않습니다 (27건)
select lc.location_id, lc.city, dept.department_name, dept.department_id
from locations lc, departments dept
WHERE dept.department_id IS not NULL
order by lc.location_id;

-- 문제3-1.
-- 문제3 에서 부서가 없는 도시도 표시합니다 (43건)




-- 문제 4.
-- 지역(regions)에 속한 나라들을 지역이름 (region_name), 나라이름 (country_name) 으로 출력하되 지역이름 오름차순 ), 나라이름 내림차순 ) 으로 정렬하세요 (25건)






-- 문제 5.
-- 자신의 매니저보다 채용일 (hire_date) 이 빠른 사원의 사번 (employee_id ), 
-- 이름 (first_name)과 채용일 (hire_date), 매니저이름 (first_name), 매니저입사일 (hire_date)을 조회하세요 (37건)

SELECT
    e. employee_id, 
    e.first_name, 
    e.hire_date,
    
    m.first_name, 
    m.hire_date
    
FROM employees e, employees m

WHERE e.department_id = m.manager_id and e.hire_date < m.hire_date;




-- 문제 6.
-- 나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다
-- 나라명, 나라아이디 , 도시명 , 도시아이디 , 부서명 , 부서아이디를 나라명 오름차순 로 정렬하여 출력하세요
-- 값이 없는 경우 표시하지 않습니다 (27건)
select 
    ct.country_name, 
    ct.country_id, 
    lc.city, 
    dept.location_id, 
    dept.department_name, 
    dept.department_id
    
from departments dept,  locations lc, countries ct
order by ct.country_name;



-- 문제 7. (오류)
-- job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다
-- 과거의 업무아이디 (job_id)가 'AC_ACCOUNT’ 로 근무한 사원의 사번 , 이름 (풀네임), 업무아이디 , 시작일 , 종료일을 출력하세요
-- 이름은 first_name 과 last_name 을 합쳐 출력합니다 (2건)
select 
    first_name || ' ' || last_name, 
    jh.employee_id,
    jh.job_id,
    jh.start_date,
    jh.end_date

from employees, job_history jh
WHERE jh.job_id = 'AC_ACCOUNT';
    
    
    




-- 문제 8.
-- 각 부서(department) 에 대해서 부서번호 (department_id), 부서이름 (department_name), 매니저(manager)의 이름 (first_name), 위치 (location) 한 도시 (city),
-- 나라 (countries)의 이름(countries_name) 그리고 지역구분 (regions) 의 이름 (resion_name) 까지 전부 출력해 보세요. (11건)
select 
    dept.department_id,
    dept.department_name,
    first_name,
    emp.manager_id,
    city,
    country_name,
    region_name
    
from employees emp,departments dept, countries, regions, locations;



-- 문제 9.
-- 각 사원 (employee)에 대해서 사번 (employee_id), 이름 (first_name), 부서명(department_name), 
-- 매니저 (manager) 의 이름 (first_name) 을 조회하세요
-- 부서가 없는 직원 Kimberely) 도 표시합니다 (106명)



------------
--집계 함수
------------
-- 여러 레코드로부터 데이터를 수집, 하나의 결과 행을 반환

--count : 갯수 세기
select count(*) from employees; -- 특절 컬럼이 아닌 레코드의 갯수 센다.

select count (commission_pct) from employees; -- 해당 컬럼이 null이 아닌 갯수
select count (*) from employees
where commission_pct is not null; -- 위랑 같은 의미

--sum : 합계
-- 급여의 합계
select sum(salary) from employees;

-- avg : 평균 
-- 급여의 평균
select avg(salary) from employees;
-- avg 함수는 null 값은 집계에서 제외

--사원들의 평균 커미션 비율
select avg(commission_pct) from employees; -- 0.22%
select avg(nvl(commission_pct, 0)) from employees; -- 0.07%

-- min/max : 최소값, 최대값
select min(salary), max(salary), avg(salary), median(salary)
from employees;


-- 일반적 오류
select department_id, avg(salary)
from employrrs; -- ERROR

-- 수정 : 집계함수
select department_id, avg(salary)
from employees
group by department_id
order by department_id;

-- 집계 함수를 사용한 SELECT 문의 컬럼 목록에는 GROUP BY에 참여한 필드, 집계 함수에만 올 수 있다.

-- 부서별 평균 급여를 출력, 
-- 평균 급여가 7000 이상인 부서만 뽑아봅시다.
select department_id, avg(salary)
from employees
where avg(salary) >= 7000
group by department_id; -- ERROR
-- 집계 함수 실행 이전에 WHERE 절을 검사하기 때문에
-- 집계 함수는 WHERE 절에서 사용할 수 없다.


-- 집계 함수 실행 이후에 조건 검사하려면 
-- HAVING 절을 이용


select department_id, round(avg(salary), 2)
from employees
group by department_id
    having avg(salary) >=7000
    order by department_id;



----------
--분석 함수
----------
--ROLLUP
-- 그룹핑된 결과에 대한 상세 요약을 제공하는 기능
-- 일종의 ITEM Total
select department_id,
    job_id,
    sum(salary)
from employees
group by rollup(department_id, job_id);


-- CUBE 함수
-- Cross Table에 대한 Summary를 함께 추출
-- Rollup 함수에 추출되는 Item Total과 함께
-- Column Total 값을 함께 추출
select department_id, job_id, sum(salary)
from employees
group by cube(department_id, job_id)
order by department_id;



--실습2 집계
-- 문제 1.
select count (*) from employees
where manager_id is not null;

-- 문제 2.
select 
    min(salary) as 최저임금, 
    max(salary) as 최고임금

from employees;


-- 문제 3.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까 ? 다음 형식으로 출력해주세요
--예) 2014 년 07 월 10 일
select 
hire_date
from employees
WHERE hire_date <= last_date;


-- 문제 4.
-- 부서별로 평균임금 , 최고임금 , 최저임금을 부서 아이디 (department_id)와 함께 출력합니다
-- 정렬순서는 부서번호 (department_id 내림차순입니다
select department_id,
    min(salary), 
    max(salary),
    round(avg(salary), 2)

from employees 
group by department_id
order by department_id desc;


-- 문제 5.
-- 업무(job_id) 별로 평균임금 , 최고임금 , 최저임금을 
-- 업무아이디 (job_id) 와 함께 출력하고 
-- 정렬순서는 최저임금 내림차순 평균임금 소수점 반올림 오름 차순 순 입니다
-- (정렬순서는 최소임금 2500 구간일때 확인해볼 것)
select job_id,
    min(salary), 
    max(salary),
    round(avg(salary), 2)

from employees
group by job_id
order by min(salary) desc,
    round(avg(salary), 3.5);
    
-- 문제 6.
-- 가장 오래 근속한 직원의 입사일은 언제인가요 ?  다음 형식으로 출력해주세요 
-- 예) 2001 01 13 토요일


-- 문제 7.
--평균임금과 최저임금의 차이가 2000 미만인 부서 (department_id), 평균임금 , 최저임금 
-- 그리고 (평균임금 - 최저임금)를 (평균임금-최저임금) 의 내림차순으로 정렬해서 출력하세요

-- 문제 8.
-- 업무( 별로 최고임금과 최저임금의 차이를 출력해보세요
-- 차이를 확인할 수 있도록 내림차순으로 정렬하세요 ?

-- 문제 9.
-- 2005 년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다
-- 출력은 관리자별로 평균급여가 5000 이상 중에 평균급여 최소급여 최대급여를 출력합니다
-- 평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다


-- 문제 10. 
-- 아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다 .
-- 입사일이 02/12/31 일 이전이면 창립맴버 , 03 년은 '03 년입사’, 04 년은 04 년입사’
-- 이후입사자는 ‘상장이후입사' optDate 컬럼의 데이터로 출력하세요
-- 정렬은 입사일로 오름차순으로 정렬합니다
