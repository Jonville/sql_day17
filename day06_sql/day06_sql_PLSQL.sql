                            --PLSQL-- 			
                            
	--SQL 안에서 프로그래밍을 한다. (절차적 프로그래밍 , C 언어 처럼)
	--1.DECLARE - 선언 (옵션)
			-- 변수나 상수를 선언
	---2.BEGIN - 실행	(필수)
			-- 실질적으로 실행시켜주는 부분 (조건문, 반복문 등등)
	--3.EXCEPTION - 예외처리	(옵션)
	--4.END - 종료	(필수)

                        ----PLSQL 기본세팅----
                        SET SERVEROUTPUT ON;    
                        --------------------
DECLARE                                     -- 컬럼명 타입;
    NAME VARCHAR2(10) := '홍길동';           -- 컬럼명 타입 := 값;
BEGIN
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);         --자바의 프린트문 같은거; -- || 는 + 
END;
/       -- 이게 없으면 중첩 될수있으니 마침표처럼 쓴다.

--------------------------------------------------------------------------------

DECLARE                                     
    V_ENAME EMP.ENAME%TYPE;          --변수명  테이블명.컬럼명%TYPE;     EMP 안에 같은 타입으로 선언해준다는 의미  
    V_DEPTNO DEPT.DEPTNO%TYPE;
BEGIN
    SELECT ENAME , DEPTNO INTO V_ENAME , V_DEPTNO       -- INTO 로 각 순서대로 컬럼을 지정해준다
    FROM EMP
    WHERE EMPNO = '7499'
    ;
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || V_DEPTNO);   
END;
/   

--------------------------------------------------------------------------------

                        --PROCEDURE --      -- !!!정말중요함!!!
                        
               --자바에서 메소드 호출해서 쓰는것처럼 쓰는친구--
               
--EMP 테이블에서 EMPNO를 입력받아서 받은 요소의 SAL 값을 100 추가
CREATE OR REPLACE PROCEDURE UPDATE_PRO      -- 자바 메소드랑 똑같다 그냥
    (V_EMPNO IN NUMBER)         -- 매개변수로 하나의 값을 받는다
IS 
BEGIN 
    UPDATE EMP 
    SET SAL = SAL + 100
    WHERE EMPNO = V_EMPNO;
    COMMIT;         -- 수정하자마자 커밋할수있도록
END UPDATE_PRO ; 
/

EXECUTE UPDATE_PRO(7369);      -- 프로시저 호출

--------------------------------------------------------------------------------

-- 프로시저 이름 : INSERT_PRO
-- INSERT_PRO(1234, 'HONG', 'SALESMAN' , '7698' , SYSDATE , 3000 , 100 , 30)
CREATE OR REPLACE PROCEDURE INSERT_PRO
    ( V_EMPNO IN EMP.EMPNO%TYPE 
                 ,V_ENAME IN EMP.ENAME%TYPE 
                 ,V_JOB IN EMP.JOB%TYPE
                 ,V_MGR IN EMP.MGR%TYPE 
                 ,V_HIREDATE IN EMP.HIREDATE%TYPE 
                 ,V_SAL IN EMP.SAL%TYPE 
                 ,V_COMM IN EMP.COMM%TYPE
                 ,V_DEPTNO IN EMP.DEPTNO%TYPE )
IS
BEGIN
        INSERT INTO EMP( EMPNO ,ENAME ,JOB ,MGR ,HIREDATE ,SAL ,COMM ,DEPTNO)
        VALUES ( V_EMPNO ,V_ENAME ,V_JOB ,V_MGR ,V_HIREDATE ,V_SAL ,V_COMM ,V_DEPTNO);
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || V_EMPNO);
        DBMS_OUTPUT.PUT_LINE('사원이름 : ' || V_ENAME);
        DBMS_OUTPUT.PUT_LINE('사원부서 : ' || V_JOB);
        DBMS_OUTPUT.PUT_LINE('데이터 입력 성공');
        
END INSERT_PRO ;
/

EXECUTE INSERT_PRO(1234 , 'HONG', 'SALESMAN' , '7698' , SYSDATE , 3000 , 100 , 30);

--------------------------------------------------------------------------------

-- 프로시저 이름 : DELETE_PRO
-- DELETE_PRO(1234)

CREATE OR REPLACE PROCEDURE DELETE_PRO
    (V_EMPNO EMP.EMPNO%TYPE)        -- IN 생략가능
IS
BEGIN
    DELETE
    FROM EMP
    WHERE EMPNO = V_EMPNO;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('데이터를 삭제했습니다.');

END DELETE_PRO ;
/

EXECUTE DELETE_PRO(1234);

SELECT * FROM EMP;

--------------------------------------------------------------------------------

--SELECT_STUDENT
--EXECUTE SELECT_STUDENT(170,50);
--키가 170 몸무게가 50이상 학생의 학번, 이름, 학과, 성별 출력

CREATE OR REPLACE PROCEDURE SELECT_PRO      -- OR REPLACE 는 기존에 있는 프로시저를 대체한다는 의미
    (V_HEIGHT IN STUDENT.STU_HEIGHT%TYPE ,    -- 입력 받는 요소
    V_WEIGHT IN STUDENT.STU_WEIGHT%TYPE)
IS
    V_STU STUDENT%ROWTYPE;
BEGIN
    SELECT STU_NO , STU_NAME , STU_DEPT , STU_GENDER , STU_HEIGHT , STU_WEIGHT
    INTO V_STU.STU_NO , V_STU.STU_NAME , V_STU.STU_DEPT , V_STU.STU_GENDER ,
            V_STU.STU_HEIGHT , V_STU.STU_WEIGHT
           
    FROM STUDENT
    WHERE STU_HEIGHT >= V_HEIGHT AND STU_WEIGHT >= V_WEIGHT AND ROWNUM = 1;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('학번 : ' || V_STU.STU_NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_STU.STU_NAME);
    DBMS_OUTPUT.PUT_LINE('학과 : ' || V_STU.STU_DEPT);
    DBMS_OUTPUT.PUT_LINE('성별 : ' || V_STU.STU_GENDER);
    DBMS_OUTPUT.PUT_LINE('키 : ' || V_STU.STU_HEIGHT);
    DBMS_OUTPUT.PUT_LINE('체중 : ' || V_STU.STU_WEIGHT);
END SELECT_PRO;
/

EXECUTE SELECT_PRO(170, 50);

--------------------------------------------------------------------------------

                --%ROWTYPE 해당 테이블의 모든 정보를 가지고오는친구--
                -- 개꿀친구--

--SELECT_ROW
--EMP 테이블에서 사번, 이름, 부서번호 출력
CREATE OR REPLACE PROCEDURE SELECT_ROW
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS
    V_EMP EMP%ROWTYPE;      -- EMP 의 컬럼들이 V_EMP 에 담김    
BEGIN
    SELECT EMPNO, ENAME, DEPTNO
    INTO V_EMP.EMPNO , V_EMP.ENAME , V_EMP.DEPTNO   -- 이렇게 접근
    FROM EMP
    WHERE EMPNO = P_EMPNO;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_EMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || V_EMP.DEPTNO);
    
END SELECT_ROW;
/

EXECUTE SELECT_ROW(7369);

--------------------------------------------------------------------------------

                        -- IF 문 --
    -- 사번입력 => 해당 사번에 속한 부서의 이름 출력
    -- 부서이름 출력은 조인(X), DECODE(X) , IF 문으로만
    
    -- IF ~ THEN ~ END IF
CREATE OR REPLACE PROCEDURE TEST_IF
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS
    V_DEPTNO EMP.DEPTNO%TYPE;
BEGIN
    SELECT DEPTNO
    INTO V_DEPTNO
    FROM EMP
    WHERE EMPNO = P_EMPNO;
    IF V_DEPTNO = 10 THEN 
        DBMS_OUTPUT.PUT_LINE('부서는 ACC');
    ELSIF V_DEPTNO = 20 THEN               -- ELSE IF 랑 같음
        DBMS_OUTPUT.PUT_LINE('부서는 RES');
    ELSIF V_DEPTNO = 30 THEN               
        DBMS_OUTPUT.PUT_LINE('부서는 SALES');
    ELSE
        DBMS_OUTPUT.PUT_LINE('몰라');
    END IF;        -- 종료시점
END ;
/

EXECUTE TEST_IF(7369);

--------------------------------------------------------------------------------

-- STUDENT 테이블 프로시저 생성
-- 호출은 학번으로
-- 해당 학생이 1이면 '신입생' , 2일경우 '2학년' , 3이면 '졸업예정' 출력


CREATE OR REPLACE PROCEDURE TEST_TEST
    (V_STU IN STUDENT.STU_NO%TYPE)
    
IS
    P_STU STUDENT%ROWTYPE;
BEGIN
    SELECT STU_GRADE
    INTO P_STU.STU_GRADE
    FROM STUDENT
    WHERE STU_NO = V_STU;
    IF P_STU.STU_GRADE = 1 THEN
        DBMS_OUTPUT.PUT_LINE('신입생');
    ELSIF P_STU.STU_GRADE = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2학년');
    ELSIF P_STU.STU_GRADE = 3 THEN
        DBMS_OUTPUT.PUT_LINE('졸업예정');
    END IF;

END;
/

EXECUTE TEST_TEST(20132003);

SELECT * FROM STUDENT