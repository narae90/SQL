-- ORACLE Database 답안지
-- 수강생 이름:  김나래

-- A11. 
select 
     last_name, 
     salary, 
     department_name  
from employees e full join departments d on e.department_id = d.department_id
where commission_pct is not null;


-- A12.
select
    last_name,
    salary,
    job_id
from employees 
WHERE manager_id in (select employee_id from employees where last_name ='King');



-- A13.

select  
    e.last_name, 
    e.salary
from employees e inner join employees m on e.manager_id = m.employee_id
where e.salary > m.salary;



-- A14.
select * 
from(select min(salary) MIN, max(salary) MAX, sum(salary) SUM, round(avg(salary), 0 ) AVG from employees);


-- A15.


select 
    e.last_name,
    e.salary
from employees e, 
        (select department_id, avg(salary) salary
from employees group by department_id) t
where e.department_id = t.department_id and
e.salary < t.salary;

