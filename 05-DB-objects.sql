-------------
--DB OBJECTS
------------


--VIEW
--System 계정으로 수행
-- create view 권한 필요
grant create view To c##bituser;


--c##bituser 전환
-- HR.employees 테이블로부터 department_id = 10 사원의 view 생성
create table emp_123
    as select * from hr.employees
        where department_id in (10, 20, 30);



-- simple view 생성
create or replace view emp_20
    as select employee_id, first_name, last_name, salary
        from emp_123
        where department_id = 20;
desc emp_20;


-- 마치 일반 테이블처럼 select 할 수 있다.
select employee_id, first_name, salary from emp_20;


-- simple view는 제약 사항에 위배되지 않으면 내용 갱신 가능
update emp_20 set salary = salary * 2;
select first_name, salary from emp_123 where department_id = 20;


-- 가급적 view는 조회 전용으로 사용하기를 권장
-- whit read only 옵션
create or replace view emp_10
    as select employee_id, first_name, last_name, salary
    from emp_123
    where department_id = 10
    with read only;

select*from emp_10;
update emp_10 set salary = salary * 2;


-- complex view
create or replace view book_detail
    (book_id, title, author_name, pub_date)
    as select book_id, title, author_name, pub_date
        from book b, author a
        where b.author_id = a.author_id;
        
select * from book_detail;
select * from author;

desc book;
insert into book (book_id, title, author_id)
values(1, '토지', 1);

insert into book (book_id, title, author_id)
values(2, '살인자의 기억법', 2);

commit;

-- complex view로 조회
select * from book_detail;
select * from author;

-- complex view는 갱신이 불가
update book_detail set author_name = '소설가'; -- ERROR

-- view의 삭제
-- book_detail은 book, author 테이블을 기반으로 함
drop view book_detail; -- view 삭제

select * from tab;


-- view 확인을 위한 dictionary
select * from user_views;
select * from user_OBJECTS;


select object_name, object_type, status from user_objects
where object_type = 'VIEW';


-- INDEX : 검색 속도 증가
-- INDEX, UPDATE, DELETE -> 인덱스의 갱신 발생
-- hr.employees 테이블 복사 -> s_emp 테이블 생성
create table s_emp
    as select * from HR.employees;
    
select * from s_emp;

-- s_emp.employee_id에 UNIQUE_INDEX 부여
create UNIQUE INDEX s_emp_id
    on s_emp (employee_id);
    
-- INDEX 위한 DICTIONARY
select * from USER_INDEXES; 
select * from USER_IND_COLUMNS;

-- 어느 테이블에 어느 컬럼에 s_emp_id가 부여되었는가?
select t.index_name, t.table_name, c.column_name, c.column_position
from user_indexes t, user_ind_columns c
where t.index_name = c.index_name and
    t.table_name = 'S_EMP';  -- S_EMP 대문자로 쓰기

SELECT * FROM S_EMP;


-- 인덱스 삭제
DROP INDEX s_emp_id;
select * from user_indexes;

-- 인덱스는 테이블과 독립적 : 인덱스 삭제해도 테이블 데이터는 남아 있다.

-- SEQUENCE
-- author 테이블 정보 확인(PK)
select max(author_id) from author;

insert into author(author_id, author_name)
values((select max(author_id) + 1 from author), 'Unknown'); 
select * from author;
-- 안전하지 않을 수 있다.
-- 시퀀스 생성, 안전하게 중복 처리 

rollback;

select max(author_id) from author; -- 3부터 시작 pk 중복 x

create SEQUENCE seq_author_id
    start with 3
    INCREMENT by 1
    MAXVALUE 1000000;
    
insert into author (author_id, author_name)
values(seq_author_id.nextval, 'Steven King');

select * from author;

-- 새 시퀀스 만들기
create sequence my_seq
    start with 1
    INCREMENT by 2
    MAXVALUE 10;
    
-- 수도 컬럼 : currval (현재 시퀀스 값), nextval(값을 증가 새값)
select my_seq.nextval from dual;
select my_seq.currval from dual;

-- 시퀀스 변경
alter SEQUENCE my_seq
    INCREMENT by 3
    MAXVALUE 1000000;
    
select my_seq.currval from dual;
select my_seq.nextval from dual;

-- sequence를 위한 dictionary
select * from user_sequences;
select * from user_objects
where object_type = 'SEQUENCE';

-- 시퀀스 삭제
DROP SEQUENCE my_seq;
select * from user_sequences;

-- book.book_id를 위한 시퀀스 생성
select max(book_id) from book;
create sequence seq_book_id
    start with 3
    INCREMENT by 1;

select * from user_sequences;    