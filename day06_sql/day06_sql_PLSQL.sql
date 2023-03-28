                            --PLSQL-- 			
                            
	--SQL �ȿ��� ���α׷����� �Ѵ�. (������ ���α׷��� , C ��� ó��)
	--1.DECLARE - ���� (�ɼ�)
			-- ������ ����� ����
	---2.BEGIN - ����	(�ʼ�)
			-- ���������� ��������ִ� �κ� (���ǹ�, �ݺ��� ���)
	--3.EXCEPTION - ����ó��	(�ɼ�)
	--4.END - ����	(�ʼ�)

                        ----PLSQL �⺻����----
                        SET SERVEROUTPUT ON;    
                        --------------------
DECLARE                                     -- �÷��� Ÿ��;
    NAME VARCHAR2(10) := 'ȫ�浿';           -- �÷��� Ÿ�� := ��;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);         --�ڹ��� ����Ʈ�� ������; -- || �� + 
END;
/       -- �̰� ������ ��ø �ɼ������� ��ħǥó�� ����.

--------------------------------------------------------------------------------

DECLARE                                     
    V_ENAME EMP.ENAME%TYPE;          --������  ���̺��.�÷���%TYPE;     EMP �ȿ� ���� Ÿ������ �������شٴ� �ǹ�  
    V_DEPTNO DEPT.DEPTNO%TYPE;
BEGIN
    SELECT ENAME , DEPTNO INTO V_ENAME , V_DEPTNO       -- INTO �� �� ������� �÷��� �������ش�
    FROM EMP
    WHERE EMPNO = '7499'
    ;
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || V_DEPTNO);   
END;
/   

--------------------------------------------------------------------------------

                        --PROCEDURE --      -- !!!�����߿���!!!
                        
               --�ڹٿ��� �޼ҵ� ȣ���ؼ� ���°�ó�� ����ģ��--
               
--EMP ���̺��� EMPNO�� �Է¹޾Ƽ� ���� ����� SAL ���� 100 �߰�
CREATE OR REPLACE PROCEDURE UPDATE_PRO      -- �ڹ� �޼ҵ�� �Ȱ��� �׳�
    (V_EMPNO IN NUMBER)         -- �Ű������� �ϳ��� ���� �޴´�
IS 
BEGIN 
    UPDATE EMP 
    SET SAL = SAL + 100
    WHERE EMPNO = V_EMPNO;
    COMMIT;         -- �������ڸ��� Ŀ���Ҽ��ֵ���
END UPDATE_PRO ; 
/

EXECUTE UPDATE_PRO(7369);      -- ���ν��� ȣ��

--------------------------------------------------------------------------------

-- ���ν��� �̸� : INSERT_PRO
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
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || V_EMPNO);
        DBMS_OUTPUT.PUT_LINE('����̸� : ' || V_ENAME);
        DBMS_OUTPUT.PUT_LINE('����μ� : ' || V_JOB);
        DBMS_OUTPUT.PUT_LINE('������ �Է� ����');
        
END INSERT_PRO ;
/

EXECUTE INSERT_PRO(1234 , 'HONG', 'SALESMAN' , '7698' , SYSDATE , 3000 , 100 , 30);

--------------------------------------------------------------------------------

-- ���ν��� �̸� : DELETE_PRO
-- DELETE_PRO(1234)

CREATE OR REPLACE PROCEDURE DELETE_PRO
    (V_EMPNO EMP.EMPNO%TYPE)        -- IN ��������
IS
BEGIN
    DELETE
    FROM EMP
    WHERE EMPNO = V_EMPNO;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('�����͸� �����߽��ϴ�.');

END DELETE_PRO ;
/

EXECUTE DELETE_PRO(1234);

SELECT * FROM EMP;

--------------------------------------------------------------------------------

--SELECT_STUDENT
--EXECUTE SELECT_STUDENT(170,50);
--Ű�� 170 �����԰� 50�̻� �л��� �й�, �̸�, �а�, ���� ���

CREATE OR REPLACE PROCEDURE SELECT_PRO      -- OR REPLACE �� ������ �ִ� ���ν����� ��ü�Ѵٴ� �ǹ�
    (V_HEIGHT IN STUDENT.STU_HEIGHT%TYPE ,    -- �Է� �޴� ���
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
    DBMS_OUTPUT.PUT_LINE('�й� : ' || V_STU.STU_NO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_STU.STU_NAME);
    DBMS_OUTPUT.PUT_LINE('�а� : ' || V_STU.STU_DEPT);
    DBMS_OUTPUT.PUT_LINE('���� : ' || V_STU.STU_GENDER);
    DBMS_OUTPUT.PUT_LINE('Ű : ' || V_STU.STU_HEIGHT);
    DBMS_OUTPUT.PUT_LINE('ü�� : ' || V_STU.STU_WEIGHT);
END SELECT_PRO;
/

EXECUTE SELECT_PRO(170, 50);

--------------------------------------------------------------------------------

                --%ROWTYPE �ش� ���̺��� ��� ������ ���������ģ��--
                -- ����ģ��--

--SELECT_ROW
--EMP ���̺��� ���, �̸�, �μ���ȣ ���
CREATE OR REPLACE PROCEDURE SELECT_ROW
    (P_EMPNO IN EMP.EMPNO%TYPE)
IS
    V_EMP EMP%ROWTYPE;      -- EMP �� �÷����� V_EMP �� ���    
BEGIN
    SELECT EMPNO, ENAME, DEPTNO
    INTO V_EMP.EMPNO , V_EMP.ENAME , V_EMP.DEPTNO   -- �̷��� ����
    FROM EMP
    WHERE EMPNO = P_EMPNO;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || V_EMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_EMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || V_EMP.DEPTNO);
    
END SELECT_ROW;
/

EXECUTE SELECT_ROW(7369);

--------------------------------------------------------------------------------

                        -- IF �� --
    -- ����Է� => �ش� ����� ���� �μ��� �̸� ���
    -- �μ��̸� ����� ����(X), DECODE(X) , IF �����θ�
    
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
        DBMS_OUTPUT.PUT_LINE('�μ��� ACC');
    ELSIF V_DEPTNO = 20 THEN               -- ELSE IF �� ����
        DBMS_OUTPUT.PUT_LINE('�μ��� RES');
    ELSIF V_DEPTNO = 30 THEN               
        DBMS_OUTPUT.PUT_LINE('�μ��� SALES');
    ELSE
        DBMS_OUTPUT.PUT_LINE('����');
    END IF;        -- �������
END ;
/

EXECUTE TEST_IF(7369);

--------------------------------------------------------------------------------

-- STUDENT ���̺� ���ν��� ����
-- ȣ���� �й�����
-- �ش� �л��� 1�̸� '���Ի�' , 2�ϰ�� '2�г�' , 3�̸� '��������' ���


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
        DBMS_OUTPUT.PUT_LINE('���Ի�');
    ELSIF P_STU.STU_GRADE = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2�г�');
    ELSIF P_STU.STU_GRADE = 3 THEN
        DBMS_OUTPUT.PUT_LINE('��������');
    END IF;

END;
/

EXECUTE TEST_TEST(20132003);

SELECT * FROM STUDENT