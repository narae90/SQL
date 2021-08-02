-- 실습용 계정 활성화 : System으로 수행
-- 오라클 12 이상에서는 사용자 계정에 C##을 붙여야 한다
-- C## 사용하지 않기
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

-- HR 계정 스크립트 수행

--  C:\app\BIT\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main.sql

@?\demo\schema\human_resources\hr_main.sql

-- 파라미터 1: HR계정 비밀번호 - hr
-- 파라미터 2: 기본 테이블스페이스 - users
-- 파라미터 3: 임시 테이블스페이스 - temp
-- 파라미터 4: 로그 파일 위치 - %ORACLE_HOME%demo\schema\log


-- HR 계정으로 진행