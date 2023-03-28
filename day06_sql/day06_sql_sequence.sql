                        -- SEQUENCE 시퀀스 --

--! 시퀀스 => 숫자를 (특정패턴을 가지고) 자동적으로 증가시켜줌 !
        -- PK 에 순차적으로 증가시켜 넣기위해 사용
SELECT *
FROM TEST_BOARD
;
DELETE FROM TEST_BOARD;

--INSERT INTO TEST_BOARD VALUES(2 , '안녕');

CREATE SEQUENCE T_SEQ   -- T_SEQ 라고 시퀀스 지정
INCREMENT BY 1   -- 한번 실행 할때마다 N씩증가
START WITH 1    -- N부터 시작한다는 의미 / 시작값
MINVALUE 1      --최소값
MAXVALUE 1000   -- 최대값
--CYCLE           -- 1 부터 1000 까지 한바퀴 돌고 또 돌건지
NOCYCLE         --  말건지
;

CREATE SEQUENCE T_SEQ2   -- T_SEQ 라고 시퀀스 지정
INCREMENT BY 1   -- 한번 실행 할때마다 N씩증가
START WITH 1    -- N부터 시작한다는 의미 / 시작값
MINVALUE 1      --최소값
MAXVALUE 1000   -- 최대값
--CYCLE           -- 1 부터 1000 까지 한바퀴 돌고 또 돌건지
NOCYCLE         --  말건지
;

--------------시퀀스 실행-------------

SELECT T_SEQ2.NEXTVAL       --NEXTVAL 값을 올려준다는 의미
FROM DUAL;

INSERT INTO TEST_BOARD VALUES(T_SEQ.NEXTVAL , '안녕하세요');
            -- 중간에 8을 삭제해도 8을 메꾸는게 아니고 끝난곳 부터 채워짐

SELECT T_SEQ2.CURRVAL           -- 현재 시퀀스의 값을 알려줌
FROM DUAL
;