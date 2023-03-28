--! VIEW => �ʿ��� ���� (�Ϻκи�) �鸸 ��Ƴ��� �������ټ����� !
            -- �ΰ��� ������ ���� �ַ� ���
            -- ������ ������ ������
            -- ������ ���� �ؾ���

CREATE VIEW VI_EMP
AS          -- QUERY ��
    SELECT EMPNO , ENAME, JOB, MGR, HIREDATE
    FROM EMP
;

UPDATE VI_EMP       -- �信�� �̷��� �ٷ� ������Ʈ �ϴ°� �����϶�
SET ENAME = 'ZZZ'
WHERE EMPNO = '7369'
;

-- ���, �̸� , ��å, �����ȣ, �޿�, �Ի���, �μ���ȣ, �μ���, �μ���ġ, �޿� ���

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
    WITH READ ONLY          -- �б� ���Ѹ� ��. ����X ����X
;

UPDATE VI_EMP3      
SET ENAME = 'ȫ�浿'
WHERE EMPNO = '7369'
;