--! VIEW => 필요한 정보 (일부분만) 들만 모아놓고 제공해줄수있음 !
            -- 민감한 정보는 뺄때 주로 사용
            -- 데이터 제공이 목적임
            -- 수정을 막게 해야함

CREATE VIEW VI_EMP
AS          -- QUERY 문
    SELECT EMPNO , ENAME, JOB, MGR, HIREDATE
    FROM EMP
;

UPDATE VI_EMP       -- 뷰에서 이렇게 바로 업데이트 하는건 지양하라
SET ENAME = 'ZZZ'
WHERE EMPNO = '7369'
;

-- 사번, 이름 , 직책, 사수번호, 급여, 입사일, 부서번호, 부서명, 부서위치, 급여 등급

CREATE VIEW VI_EMP2
AS
    SELECT E.EMPNO , E.ENAME , E.JOB , E.MGR , E.SAL , E.HIREDATE , 
            E.DEPTNO , D.DNAME , D.LOC , S.GRADE
    FROM EMP E
    INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
;

---
CREATE VIEW VI_EMP3
AS          
    SELECT EMPNO , ENAME, JOB, MGR, HIREDATE
    FROM EMP
    WITH READ ONLY          -- 읽기 권한만 줌. 쓰기X 삭제X
;

UPDATE VI_EMP3      
SET ENAME = '홍길동'
WHERE EMPNO = '7369'
;