SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL
;
-- 문자를 '20230328' 시간속성으로 변경

SELECT TO_DATE('2023-03-28' , 'YYYY-MM-DD')
FROM DUAL
;

-- 날짜도 크기를 비교할수있다
SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('19810328' , 'YYYYMMDD')
AND
    HIREDATE <  TO_DATE('19830328' , 'YYYYMMDD')
;

--

SELECT *
FROM EMP
WHERE HIREDATE > (
                SELECT HIREDATE
                FROM EMP
                WHERE ENAME = 'JONES'
                )
;
-------------------------문제풀이-----------------------
-- 1. 각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해 사원번호, 사원명, 부서번호, 입사일을 출력하라.
SELECT MAX(TO_CHAR(HIREDATE, 'YYYYMMDD')) , DEPTNO
FROM EMP
GROUP BY DEPTNO
;

-- 2. 1981년 5월 31일 이후 입사자 중 커미션이 NULL이거나 0인 사원의 커미션은 500으로 그렇지 않으면 기존 커미션을 출력하라.
SELECT ENAME , COMM , DECODE(COMM , NULL , 500 ,COMM)
FROM EMP
WHERE HIREDATE > TO_DATE('19810531')
;

-- 3. 1981년 6월 1일 ~ 1981년 12월 31일 입사자 중 부서명이 SALES인 사원의 부서번호, 사원명, 직업, 입사일을 출력하라.
SELECT *
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE HIREDATE > TO_DATE('19810601', 'YYYYMMDD')        -- yyyymmdd 생략가능
AND
        HIREDATE < TO_DATE('19811231')                   -- 이렇게
AND
        D.DNAME = 'SALES'
;

-- 4. 각 부서별로 1981년 5월 31일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
SELECT D.DEPTNO , D.DNAME , E.EMPNO , E.ENAME , E.HIREDATE
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE HIREDATE > TO_DATE('19810531')
ORDER BY DNAME , HIREDATE
;

-----------------문제풀이-----------------

-- 1. 각 부서별 급여 등급 평균 구하기

SELECT ROUND(AVG(GRADE), 2) , DEPTNO
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY DEPTNO
;

-- 2. 각 부서별 급여 등급이 3등급 이상인 사람의 수 구하기
SELECT COUNT(*) , DEPTNO
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL >= S.LOSAL AND E.SAL <= S.HISAL
WHERE GRADE >= 3
GROUP BY DEPTNO
;

-- 3. 평균급여 등급이 가장 높은 부서와 낮은 부서와의 차이 구하기
SELECT DISTINCT ( 
                SELECT  AVG_S
                FROM 
                    (
                    SELECT AVG(SAL) AVG_S , DEPTNO
                    FROM EMP
                    GROUP BY DEPTNO
                    ORDER BY AVG_S DESC
                    )
                WHERE ROWNUM = 1
                ) -
                (
                SELECT  AVG_S
                FROM 
                    (
                    SELECT AVG(SAL) AVG_S , DEPTNO
                    FROM EMP
                    GROUP BY DEPTNO
                    ORDER BY AVG_S ASC
                    )
                WHERE ROWNUM = 1
                ) AS 차이

FROM EMP
;


SELECT MAX(AVG_DEPT) - MIN(AVG_DEPT)
FROM
    (
    SELECT ROUND(AVG(GRADE), 2) AS AVG_DEPT , DEPTNO
    FROM EMP E
    INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
    GROUP BY DEPTNO
    )
;


-- 4. 평균급여 등급이 가장 낮은 부서의 급여 평균 구하기

SELECT *
FROM EMP E
INNER JOIN(
            SELECT *
            FROM 
                (
                SELECT AVG(SAL) AVG_S , DEPTNO 
                FROM EMP
                GROUP BY DEPTNO 
                ORDER BY AVG_S ASC
                )
            WHERE ROWNUM = 1
            ) A ON E.DEPTNO = A.DEPTNO
;

SELECT *
FROM
        (
        SELECT ROUND(AVG(GRADE), 2) AS AVG_DEPT, ROUND(AVG(SAL), 2) , DEPTNO
        FROM EMP E
        INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
        GROUP BY DEPTNO
        ORDER BY AVG_DEPT
        )
WHERE ROWNUM = 1
;

-- 5. 평균급여 등급이 가장 낮은 부서에서 가장 먼저 입사한 사람 구하기
SELECT MIN(TO_CHAR(HIREDATE, 'YYYYMMDD'))
FROM EMP E
INNER JOIN(
            SELECT *
            FROM 
                (
                SELECT AVG(SAL) AVG_S , DEPTNO 
                FROM EMP
                GROUP BY DEPTNO 
                ORDER BY AVG_S ASC
                )
            WHERE ROWNUM = 1
            ) A ON E.DEPTNO = A.DEPTNO
;


SELECT *
FROM EMP E
INNER JOIN (
        SELECT ROUND(AVG(GRADE), 2) AS AVG_DEPT, ROUND(AVG(SAL), 2) , DEPTNO
        FROM EMP E
        INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
        GROUP BY DEPTNO
        ORDER BY AVG_DEPT
        ) A ON E.DEPTNO = A.DEPTNO
WHERE ROWNUM = 1
ORDER BY AVG_DEPT ASC, HIREDATE ASC
;