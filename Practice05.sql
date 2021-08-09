-- 문제 1.
-- 담당 매니저가 배정되어있으나 커미션비율이 없고 , 월급이 3000 초과인 직원의 이름, 
-- 매니저아이디 , 커미션 비율 , 월급 을 출력하세요(45건)

select 
    first_name,
    manager_id,
    commission_pct,
    salary
from employees
where commission_pct is null and salary >3000 and manager_id is not null
order by salary;

-- 문제 2.
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호 (employee_id), 이름 (first_name),
-- 급여 (salary), 입사일 (hire_date), 전화번호 (phone_number), 부서번호 (department_id) 를 조회하세요
-- 조건절비교 방법으 로 작성하세요
-- 급여의 내림차순으로 정렬하세요
-- 입사일은 2001-01-13 토요일 형식으로 출력합니다
-- 전화번호는 515-123-4567 형식으로 출력합니다 (11건)

select 
    employee_id,
    first_name,
    e.salary,
    hire_date,
    phone_number,
    e.department_id
from employees e, (select department_id, max(salary) 
        salary from employees group by department_id) sal
        where e.department_id = sal.department_id and
        e.salary = sal.salary
order by salary desc;


-- 문제 3.
-- 매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다
-- 통계대상 직원 은 2005 년 이후의 입사자 입니다
-- 매니저별 평균급여가 5000 이상만 출력합니다
-- 매니저별 평균급여의 내림차순으로 출력합니다
-- 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다
-- 출력내용은 매니저아이디 , 매니저이름 (first_name), 매니저별 평균급여 , 
-- 매니저별최소급여 , 매니저별최대급여 입니다 (9 건)
select
    manager_id,
    round(avg(salary)),
    min(salary),
    max(salary)
from employees
where hire_date >= '05/01/01'
group by manager_id
    having avg(salary) > 5000
order by avg(salary) desc;



-- 문제 4.
-- 각 사원 (employee) 에 대해서 사번 (employee_id), 이름 (first_name), 부서명(department_name), 
-- 매니저 (manager) 의 이름 (first_name) 을 조회하세요
-- 부서가 없는 직원 (kimberely) 도 표시합니다 (106명)

select
    e.employee_id,
    e.first_name,
    department_name,
    m.first_name
from employees e left outer join departments d
    on e.department_id = d.department_id,
    employees m
where e.manager_id = m.employee_id;


-- 문제 5. 다시 풀기
-- 2005년 이후 입사한 직원중에 입사일이 11 번째에서 20 번째의 
-- 직원의 사번, 이름 , 부서명 , 급여 , 입사일을 입사일 순서로 출력하세요

SELECT rn,
    employee_id,
    first_name,
    salary,
    hire_date
from (select rownum rn,
        employee_id,
        first_name,
        salary,
        hire_date 
            from (select 
                      employee_id,
                      first_name,
                      salary,
                      hire_date
                           from employees
                            order by hire_date asc))

where rn BETWEEN 11 and 15;


-- 문제 6.
-- 가장 늦게 입사한 직원의 이름 (first_name last_name) 과
-- 연봉 (salary)과 근무하는 부서 이름(department_name) 은?

select
    first_name || ' ' || last_name 이름, 
    salary 연봉,
    d.department_name 부서,
    hire_date
from employees e,departments d
where hire_date in(select max(hire_date) from employees e)
    and e.department_id = d.department_id;

-- 문제 7.
-- 평균연봉(salary)이 가장 높은 부서 직원 들의 직원번호 (employee_id), 이름 (firt_name), 성(last_name)과
-- 업무 (job _title ), 연봉 (salary) 을 조회하시오


-- 문제 8. 다시
-- 평균급여 (salary) 가 가장 높은 부서는 ?
select 
    d.department_name 부서,
    round(avg(salary))
from employees e,departments d
group by d.department_name
having avg(salary) >= all(select max(avg(salary)) from employees group by department_name);


select 
    d.department_name 부서,
    round(avg(salary))
from employees e,departments d
group by d.department_name
order by avg(salary) desc;

-- 문제 9.
-- 평균 급여 (salary) 가 가장 높은 지역은 ?




