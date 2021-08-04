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



--실습3
--문제 1.
--직원들의 사번 (employee_id), 이름 (firt_name), 성 (last_ 과 부서명 (department_ 을 조회하여 부서이름 (department_name) 오름차순 , 사번 (employee_id) 내림차순 으로 정렬하세요
--(106건)

-- 문제 2.
-- employees 테이블의 job_id 는 현재의 업무아이디를 가지고 있습니다
-- 직원들의 사번 (employee_id), 이름 (fir t_name), 급여 (salary), 부서명 (department_name), 현재업무 (job_ 를 사번 (employee_id) 오름차순 으로 정렬하세요
-- 부서가 없는 Kimberely( 사번 178) 은 표시하지 않습니다 (106건)


-- 문제 2-1.
-- 문제 2 에서 부서가 없는 Kimberely( 사번 178) 까지 표시해 보세요
-- (107건)



-- 문제 3.
-- 도시별로 위치한 부서들을 파악하려고 합니다
-- 도시아이디, 도시명 , 부서명 , 부서아이디를 도시아이디 오름차순 로 정렬하여 출력하세요
-- 부서가없는 도시는 표시하지 않습니다 (27건)


-- 문제3-1.
-- 문제3 에서 부서가 없는 도시도 표시합니다 (43건)


-- 문제 4.
-- 지역(regions)에 속한 나라들을 지역이름 (region_name), 나라이름 (country_ 으로 출력하되 지역이름 오름차순 ), 나라이름 내림차순 ) 으로 정렬하세요 (25건)

-- 문제 5.
-- 자신의 매니저보다 채용일 (hire_ 이 빠른 사원의 사번 (employee_id ), 이름 (first_name)과 채용일 (hire_date), 매니저이름 (first_name), 매니저입사일 (hire_date)을 조회하세요 (37건)


-- 문제 6.
-- 나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다
-- 나라명, 나라아이디 , 도시명 , 도시아이디 , 부서명 , 부서아이디를 나라명 오름차순 로 정렬하여 출력하세요
-- 값이 없는 경우 표시하지 않습니다 (27건)


-- 문제 7.
-- job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다
-- 과거의 업무아이디 (job_ 가 AC_ACCOUNT ’로 근무한 사원의 사번 , 이름 풀네임 ), 업무아이디 , 시작일 , 종료일을 출력하세요
-- 이름은 first_name 과 last_name 을 합쳐 출력합니다 (2건)


-- 문제 8.
-- 각 부서 ( 에 대해서 부서번호 (department_id), 부서이름 (department_name), 매니저(manager)의 이름 (fi rst_name), 위치 (location) 한 도시 (city),
-- 나라 (countries)의 이름(countries_name) 그리고 지역구분 (regions) 의 이름 (resion_name) 까지 전부 출력해 보세요. (11건)



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
-- avg 함수는 null 값은 집계에서 제회

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




