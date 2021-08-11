

-- 테이블 정보 확인
select * from tab;

-- 미니 프로젝트 테이블 만들기
create table PHONE_BOOK (
    id number(10),
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20),
    PRIMARY key (id)
);

CREATE SEQUENCE seq_phone_book;


--확인
DESC PHONE_BOOK;

SELECT id, name, hp, tel  FROM PHONE_BOOK;

INSERT into PHONE_BOOK (id, name, hp, tel)
values(1, '김나래', '010-2375-9999', '02-334-4871');

select * from PHONE_BOOK;

commit;

INSERT into PHONE_BOOK (id, name, hp, tel)
values(2, '김비트', '010-8413-3266', '032-1964-2744');

select * from PHONE_BOOK;

commit;


create table PhoneBook (
    id number(10),
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20),
    PRIMARY key (id)
);

CREATE SEQUENCE seq_phonebook;
DESC PhoneBook;


INSERT into PhoneBook (id, name, hp, tel)
values(1, '강비트', '010-1178-6877', '02-1587-5817');

select * from PhoneBook;

commit;

INSERT into PhoneBook (id, name, hp, tel)
values(2, '윤비트', '010-8879-3266', '032-4487-2777');
