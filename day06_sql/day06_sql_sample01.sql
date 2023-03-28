SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL
;
-- ���ڸ� '20230328' �ð��Ӽ����� ����

SELECT TO_DATE('2023-03-28' , 'YYYY-MM-DD')
FROM DUAL
;

-- ��¥�� ũ�⸦ ���Ҽ��ִ�
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
-------------------------����Ǯ��-----------------------
-- 1. �� �μ� �� �Ի����� ���� ������ ����� �� �� ������ �����ȣ, �����, �μ���ȣ, �Ի����� ����϶�.
SELECT MAX(TO_CHAR(HIREDATE, 'YYYYMMDD')) , DEPTNO
FROM EMP
GROUP BY DEPTNO
;

-- 2. 1981�� 5�� 31�� ���� �Ի��� �� Ŀ�̼��� NULL�̰ų� 0�� ����� Ŀ�̼��� 500���� �׷��� ������ ���� Ŀ�̼��� ����϶�.
SELECT ENAME , COMM , DECODE(COMM , NULL , 500 ,COMM)
FROM EMP
WHERE HIREDATE > TO_DATE('19810531')
;

-- 3. 1981�� 6�� 1�� ~ 1981�� 12�� 31�� �Ի��� �� �μ����� SALES�� ����� �μ���ȣ, �����, ����, �Ի����� ����϶�.
SELECT *
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE HIREDATE > TO_DATE('19810601', 'YYYYMMDD')        -- yyyymmdd ��������
AND
        HIREDATE < TO_DATE('19811231')                   -- �̷���
AND
        D.DNAME = 'SALES'
;

-- 4. �� �μ����� 1981�� 5�� 31�� ���� �Ի����� �μ���ȣ, �μ���, �����ȣ, �����, �Ի����� ����Ͻÿ�.
SELECT D.DEPTNO , D.DNAME , E.EMPNO , E.ENAME , E.HIREDATE
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE HIREDATE > TO_DATE('19810531')
ORDER BY DNAME , HIREDATE
;

-----------------����Ǯ��-----------------

-- 1. �� �μ��� �޿� ��� ��� ���ϱ�

SELECT ROUND(AVG(GRADE), 2) , DEPTNO
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
GROUP BY DEPTNO
;

-- 2. �� �μ��� �޿� ����� 3��� �̻��� ����� �� ���ϱ�
SELECT COUNT(*) , DEPTNO
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL >= S.LOSAL AND E.SAL <= S.HISAL
WHERE GRADE >= 3
GROUP BY DEPTNO
;

-- 3. ��ձ޿� ����� ���� ���� �μ��� ���� �μ����� ���� ���ϱ�
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
                ) AS ����

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


-- 4. ��ձ޿� ����� ���� ���� �μ��� �޿� ��� ���ϱ�

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

-- 5. ��ձ޿� ����� ���� ���� �μ����� ���� ���� �Ի��� ��� ���ϱ�
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