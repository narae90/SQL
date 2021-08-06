--------
-- DCL
--------
-- CREATE : 데이터베이스 객체 생성
-- ALTER : 데이터베이스 객체 수정
-- DROP : 데이터베이스 객체 삭제

-- System 계정으로 수행


-- 사용자 생성 : CREATE USER
create user c##bituser identified by bituser;

-- Sqlplus에서 사용자로 접속
-- 사용자 삭제 : drop user

drop user c##bituser cascade;  -- cscade 연결된 모든 것을 함께 삭제

-- 다시 생성
create user c##bituser identified by bituser;

-- 사용자 정보 확인
-- user_ : 현재 사용자 관련
-- all_ : 시스템 전체의 객체
-- dba_ : dba 전용, 객체의 모든 정보
select * from user_users;
select * from all_users;
select * from dba_users; --db내의 모든 user

-- 새로 만든 사용자 확인
select * from dba_users where username = 'C##BITUSER';

-- 권한(privivlege) 과 역할 (role)
-- 특정 작업 수행을 위해 적절한 권한을 가져야 한다.
-- create session

-- 시스템 권한의 부여 : Grant 권한 to 사용자
-- C##BITUSER에게 create session 권한을 부여
grant create session to c##bituser;

-- 일반적으로 connect, resource 롤을 부여하면 일반사용자의 역할 수행 가능
grant connect, resource to c##bituser;

--oracle 12 이후로는 임의로 tablespace를 할당 해 줘야 한다
alter user c##bituser -- 사용자 정보 수정
    default TABLESPACE users    -- 기본 테이블 스페이스를 users에 지정
    QUOTA UNLIMITED on users;   -- 사용 용량 지정

-- 객체 권한 부여
-- c##bituser 사용자에게 hr.employees를 select 할 수 있는 권한 부여
grant select on hr.employees to c##bituser;

-- 객체 권한 회수
revoke select on hr.employees from c##bituser;

grant select on hr.employees to c##bituser;

-- 전체 권한 부여시
-- grant all privileges... -- 나중에 ~


-----------
--DDL
-----------
-- 이후 C##BITUSER로 진행

-- 현재 내가 소유한 테이블 목록 확인
select * from tab;
-- 현재 나에게 주어진 ROLE을 조회
select * from user_role_privs;


-- CREATE TABLE : 테이블 생성
CREATE TABLE book (
    book_id number(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date date DEFAULT sysdate
);

select * from tab;
-- 테이블 정의 정보 확인
desc book; 

-- 서브쿼리를 이용한 테이블 생성
-- HR스키마의 EMPLOYEES 테이블의 일부 데이터를 추출, 새 테이블 생성
select * from hr.employees;

-- job_id가 it_ 관련 직원들만 뽑아내어 새 테이블 생성 -- 왜 오류나지
create table it_emps as(
    select * from hr.employees
    where job_id like 'it_%');
desc it_emps;
select * from it_emps;

drop table it_emps; -- 삭제

-- author 테이블 추가
create table author(
    author_id number(10),
    author_name varchar2(50) not null,
    author_desc varchar2(500),
    PRIMARY key (author_id) -- 테이블 제약
);

-- book 테이블의 author 칼럼 지우기
-- 나중에 author 테이블과 FK 연결
desc book;
alter table book drop COLUMN author;

-- author 테이블 참조를 위한 컬럼 author_id 추가
alter table book add (author_id number(10));

-- book 테이블의 book_id도 number(10)으로 변경
alter table book
MODIFY (book_id number(10));

desc book;
desc author;


-- book.book_id에 PK 제약조건 부여
alter table book
add CONSTRAINT pk_book_id PRIMARY key (book_id);

-- book.author_id를 author.author_id를 참조하도록 제약
alter table book
add CONSTRAINT fk_author_id FOREIGN key (author_id)
                            REFERENCES author(author_id)
                            on delete cascade;


