-- 문제 1.
-- 평균 급여보다 적은 급여를 받는 직원은 몇명인지 구하시오

select avg(salary) from employees; -- 6461.8317 

select 
    salary 
from employees 
where salary < 6462;
    
-- 두 쿼리를 합친다.
select count(salary) from employees
where salary < (select avg(salary) from employees);


-- 문제 2.
-- 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 
-- 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요(51건)

select
    employee_id,
    first_name,
    salary,
    avg(salary),
    max(salary)

from employees
where salary >= (select avg(salary) from employees) 
    and salary <= (select max(salary) from employees)
group by employee_id, first_name, salary
order by salary;






-- 문제 3.
-- 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
-- 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
-- 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요(1건)

select 
    l.location_id,
    street_address,
    postal_code,
    city,
    state_province,
    l.country_id
from locations l, employees
where first_name || ' ' || last_name = 'Steven King'; 


-- 문제 4.
-- job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 
-- 급여의 내림차순으로 출력하세요 -ANY연산자 사용 (74건)
select 
    department_id,
    first_name,
    salary
from employees
where salary < any (select salary from employees where job_id = 'ST_MAN');


-- 문제 5.
-- 각 부서별로 최고의 급여를 받는 사원의 
-- 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요
-- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
-- 조건절비교, 테이블조인 2가지 방법으로 작성하세요 (11건)

select 
    employee_id,
    first_name,
    e.salary,
    e.department_id
from employees e, (select department_id, max(salary) 
        salary from employees group by department_id) sal
        where e.department_id = sal.department_id and
        e.salary = sal.salary

order by salary desc;


-- 문제 6.
-- 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
-- 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)

select j.job_title, sum(salary*12) 
from jobs j, employees e
group by j.job_title;


-- 문제 7.
-- 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 
-- 이름(first_name)과 급여(salary)을 조회하세요 (38건)



-- 문제 8.
-- 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
select rownum,
    employee_id,
    first_name,
    salary,
    hire_date
from (select * from employees
        order by hire_date)
where rownum BETWEEN 11 and 15;

