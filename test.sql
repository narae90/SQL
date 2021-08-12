

-- 테이블 정보 확인
select * from tab;

-- 테이블 만들기
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

commit;



select max(id) from PhoneBook; -- 3부터 시작 pk 중복 x

create SEQUENCE seq_id
    start with 3
    INCREMENT by 1
    MAXVALUE 1000000;

commit;
