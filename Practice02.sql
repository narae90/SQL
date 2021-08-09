--실습2 집계
-- 문제 1.
select count (*) from employees
where manager_id is not null;

--풀이 1.
select count (manager_id) haveMgrCount 
from employees
where manager_id is not null;

-- 문제 2.
select 
    min(salary) as 최저임금, 
    max(salary) as 최고임금,
    max(salary) - min(salary) "최고임금 - 최저임금"

from employees;

-- 풀이 2.
select 
    min(salary) 최저임금, 
    max(salary) 최고임금,
    max(salary) - min(salary) "최고임금 - 최저임금"

from employees;


-- 문제 3.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까 ? 다음 형식으로 출력해주세요
--예) 2014 년 07 월 10 일
select 
hire_date
from employees;


-- 풀이3
select 
to_char(max(hire_date), 'YYYY"년" MM"월" DD"일"')
from employees;



-- 문제 4.
-- 부서별로 평균임금 , 최고임금 , 최저임금을 부서 아이디 (department_id)와 함께 출력합니다
-- 정렬순서는 부서번호 (department_id 내림차순입니다
select 
    department_id,
    min(salary), 
    max(salary),
    round(avg(salary), 2)

from employees 
group by department_id
order by department_id desc;

-- 풀이 4.
select 
    department_id,
    avg(salary),
    max(salary),
    min(salary)
from employees
group by department_id
order by department_id desc;


-- 문제 5.
-- 업무(job_id) 별로 평균임금 , 최고임금 , 최저임금을 
-- 업무아이디 (job_id) 와 함께 출력하고 
-- 정렬순서는 최저임금 내림차순 평균임금 소수점 반올림 오름 차순 순 입니다
-- (정렬순서는 최소임금 2500 구간일때 확인해볼 것)
select 
    job_id,
    min(salary), 
    max(salary),
    round(avg(salary), 2)

from employees
group by job_id
order by min(salary) desc,
    round(avg(salary), 3.5);
    
-- 풀이5. 
select 
    job_id,
    min(salary), 
    max(salary),
    round(avg(salary))

from employees
group by job_id
order by min(salary) desc,
    avg(salary) asc;

    
-- 문제 6.
-- 가장 오래 근속한 직원의 입사일은 언제인가요 ?  다음 형식으로 출력해주세요 
-- 예) 2001 01 13 토요일

-- 풀이6.
select
    to_char(min(hire_date), 'yyyy-mm-dd day')
from employees;

-- 문제 7.
--평균임금과 최저임금의 차이가 2000 미만인 부서 (department_id), 평균임금 , 최저임금 
-- 그리고 (평균임금 - 최저임금)를 (평균임금-최저임금) 의 내림차순으로 정렬해서 출력하세요

-- 풀이 7.
select
    department_id,
    avg(salary),
    min(salary),
    avg(salary) - min(salary)
from employees
group by department_id
    having avg(salary) - min(salary) < 2000
order by avg(salary) - min(salary) desc;


-- 문제 8.
-- 업무( 별로 최고임금과 최저임금의 차이를 출력해보세요
-- 차이를 확인할 수 있도록 내림차순으로 정렬하세요 

--풀이 8.
select 
    job_id,
    max(salary) - min(salary) as diff
from employees
group by job_id
order by diff desc;





-- 문제 9.
-- 2005 년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다
-- 출력은 관리자별로 평균급여가 5000 이상 중에 평균급여 최소급여 최대급여를 출력합니다
-- 평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다

-- 풀이 9.
select
    manager_id,
    round(avg(salary)),
    min(salary),
    max(salary)
from employees
where hire_date >= '05/01/01'
group by manager_id
    having avg(salary) >= 5000
order by avg(salary) desc;



-- 문제 10. 
-- 아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다 .
-- 입사일이 02/12/31 일 이전이면 창립맴버 , 03 년은 '03 년입사’, 04 년은 04 년입사’
-- 이후입사자는 ‘상장이후입사' optDate 컬럼의 데이터로 출력하세요
-- 정렬은 입사일로 오름차순으로 정렬합니다

-- 풀이 10.
select 
    employee_id,
    salary,
    case when hire_date <= '02/12/31' then '창립멤버'
        when hire_date <= '03/12/31' then '03년 입사'
        when hire_date <= '04/12/31' then '04년 입사'
        else '상장이후 입사'
    end optdate, hire_date
from employees
order by hire_date;

