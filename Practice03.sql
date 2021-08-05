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

-- 풀이 1.
select 
    employee_id 사번,
    first_name 이름,
    last_name 성,
    department_name 부서명
from employees e, departments d
where e.department_id = d.department_id
order by department_name, 
    employee_id desc;


-- 문제 2. Inner join
-- employees 테이블의 job_id 는 현재의 업무아이디를 가지고 있습니다 
-- 직원들의 사번 (employee_id), 이름 (first_name), 급여 (salary), 부서명 (department_name), 현재업무 (job_title)를 사번(employee_id) 오름차순 으로 정렬하세요
-- 부서가 없는 Kimberely( 사번 178) 은 표시하지 않습니다 (106건)
select 
    employee_id, 
    first_name, 
    salary, 
    department_name, 
    job_title
from employees emp, departments dept, jobs 
order by dept.department_id;

-- 풀이 2.
select
    employee_id 사번, 
    first_name 이름, 
    salary 급여, 
    department_name 부서명, 
    job_title 업무명
    
from employees e, departments d, jobs j
where e.department_id = d.department_id 
             and
      e.job_id = j.job_id
order by employee_id;








-- 문제 2-1. (left outer join)
-- 문제 2 에서 부서가 없는 Kimberely( 사번 178) 까지 표시해 보세요
-- (107건)
select emp.employee_id, first_name, salary, department_name, job_title
from employees emp, departments dept, jobs 
where dept.department_id is not null
order by dept.department_id;

--풀이 2-1.
select
    employee_id 사번, 
    first_name 이름, 
    salary 급여, 
    department_name 부서명, 
    job_title 업무명
    
from employees e, departments d, jobs j
where e.department_id = d.department_id (+)
             and
      e.job_id = j.job_id
order by employee_id;

-- 풀이 2-1. ANSI SQL 풀이
select
    employee_id 사번, 
    first_name 이름, 
    salary 급여, 
    department_name 부서명, 
    job_title 업무명
FROM employees e left outer join departments d
        on e.department_id = d.department_id,
    jobs j
where e.job_id = j.job_id;

-- 문제 3.
-- 도시별로 위치한 부서들을 파악하려고 합니다
-- 도시아이디, 도시명 , 부서명 , 부서아이디를 도시아이디 오름차순 로 정렬하여 출력하세요
-- 부서가없는 도시는 표시하지 않습니다 (27건)
select 
    lc.location_id, 
    lc.city, 
    dept.department_name, 
    dept.department_id
from locations lc, departments dept
WHERE dept.department_id IS not NULL
order by lc.location_id;

-- 풀이 3. 
select
    loc.location_id,
    city,
    department_name, 
    department_id
from departments d join locations loc 
    on d.location_id = loc.location_id
order by loc.location_id;

    


-- 문제3-1.
-- 문제3 에서 부서가 없는 도시도 표시합니다 (43건)

-- 풀이 3-1.
select
    loc.location_id,
    city,
    department_name, 
    department_id
from locations loc left outer join departments d
     on loc.location_id = d.location_id
order by loc.location_id;



-- 문제 4.
-- 지역(regions)에 속한 나라들을 지역이름 (region_name), 나라이름 (country_name) 으로 출력하되 지역이름 오름차순 ), 나라이름 내림차순 ) 으로 정렬하세요 (25건)

-- 풀이 4.
select
    region_name 지역이름,
    country_name 나라이름
from regions r, countries c
where r.region_id = c.region_id
order by r.region_name, country_name desc;


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


-- 풀이 5. self join
SELECT
    e. employee_id, 
    e.first_name, 
    e.hire_date,
    
    m.first_name, 
    m.hire_date
    
FROM employees e, employees m

WHERE e.manager_id = m.employee_id and e.hire_date < m.hire_date;





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

-- 풀이 6.

select 
    country_name, 
    c.country_id, 
    city, 
    l.location_id, 
    department_name, 
    department_id
    
from departments d,  locations l, countries c 
where c.country_id = l.country_id 
     and l.location_id = d.location_id
order by c.country_name;


-- 문제 7.
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

-- 풀이 7.

select 
    e.employee_id 사번,
    first_name || ' ' || last_name 이름, 
    j.job_id 업무아이디,
    start_date 시작일,
    end_date 종료일
    
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id 
        and j.job_id = 'AC_ACCOUNT';
    

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

-- 풀이 8.
select 
    d.department_id,
    department_name,
    first_name 매니저이름,
    city 도시명,
    country_name 나라이름,
    region_name 지역명
    
from 
    employees e, 
    departments d, 
    countries c, 
    regions r, 
    locations l
    
where d.manager_id = e.employee_id 
        and d.location_id = l.location_id 
        and l.country_id = c.country_id
        and c.region_id = r.region_id
order by d.department_id;
    
    
    

-- 문제 9.
-- 각 사원 (employee)에 대해서 사번 (employee_id), 이름 (first_name), 부서명(department_name), 
-- 매니저 (manager) 의 이름 (first_name) 을 조회하세요
-- 부서가 없는 직원 Kimberely) 도 표시합니다 (106명)

-- 풀이 9. : outer join + self join
select
    e.employee_id,
    e.first_name,
    department_name,
    m.first_name
from employees e left outer join departments d
    on e.department_id = d.department_id,
    employees m
where e.manager_id = m.employee_id;



--------------
-- SUBQUERY
--------------
-- 하나의 질의문 안에 다른 질의문을 포함하는 형태
-- 전체 사원 중, 급여의 중앙값보다 많이 받는 사워

-- 1. 급여의 중앙값 ?
SELECT median (salary) from employees; -- 6200

-- 2. 6200보다 많이 받는 사원 퀄;
select 
    first_name , 
    salary 
from employees 
where salary > 6200;
    
-- 3. 두 쿼리를 합친다.
select first_name, salary
from employees
where salary > (select median(salary) from employees);


-- Den 보다 늦게 입사한 사원들
-- 1. Den 입사일 쿼리
select
 hire_date from employees where first_name = 'Den'; -- 02/12/07
 
-- 2. 특정 날짜 이후에 입사한 사원 쿼리
select 
 first_name,hire_date
from employees
where hire_date >= '02/12/07';

-- 3. 두 쿼리를 합친다.
select 
 first_name,hire_date
from employees
where hire_date >= 
(select hire_date from employees where first_name = 'Den');
 
 
 
 -- 다중행 서브 쿼리 
 -- 서브 쿼리의 결과 레코드가 둘 이상이 나올 때 단일행 연산자를 사용할 수 없다
 -- in, ANY, ALLM EXISTS 등 집합 연산자를 활용
 select salary from employees where department_id = 110;
 
 select first_name, salary from employees 
 where salary = (select salary from employees where department_id = 110); -- ERROR
 
 -- 결과가 다중행이면 집합 연산자를 활용
 -- salary = 12008 or salary = 8300
select first_name, salary from employees 
where salary in (select salary from employees where department_id = 110); 

-- ALL(AND)
-- salary > 12008 and salary > 8300
select first_name, salary from employees 
where salary > all (select salary from employees where department_id = 110); 

-- ANY(OR)
-- salary > 12008 or salary > 8300
select first_name, salary from employees 
where salary > any (select salary from employees where department_id = 110); 

-- 각 부서별로 최고 급여를 받는 사원을 출력
-- 1. 각 부서의 최고 급여를 확인하는 쿼리
select department_id, max(salary) from employees
group by department_id;


-- 2. 서브 쿼리의 결과 (department_id, max(salary))
select 
    department_id, 
    employee_id, 
    first_name, salary
    
from employees

where 
    (department_id, salary) in 
    (select department_id, max(salary) 
    from employees group by department_id);
    
-- 서브쿼리와 조인(JOIN)
select 
    e.department_id,
    e.employee_id, 
    e.first_name, 
    e.salary
    
from employees e, (select department_id, max(salary) 
        salary from employees group by department_id) sal
where e.department_id = sal.department_id and
    e.salary = sal.salary
order by e.department_id;








