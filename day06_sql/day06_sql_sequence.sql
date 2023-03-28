                        -- SEQUENCE ������ --

--! ������ => ���ڸ� (Ư�������� ������) �ڵ������� ���������� !
        -- PK �� ���������� �������� �ֱ����� ���
SELECT *
FROM TEST_BOARD
;
DELETE FROM TEST_BOARD;

--INSERT INTO TEST_BOARD VALUES(2 , '�ȳ�');

CREATE SEQUENCE T_SEQ   -- T_SEQ ��� ������ ����
INCREMENT BY 1   -- �ѹ� ���� �Ҷ����� N������
START WITH 1    -- N���� �����Ѵٴ� �ǹ� / ���۰�
MINVALUE 1      --�ּҰ�
MAXVALUE 1000   -- �ִ밪
--CYCLE           -- 1 ���� 1000 ���� �ѹ��� ���� �� ������
NOCYCLE         --  ������
;

CREATE SEQUENCE T_SEQ2   -- T_SEQ ��� ������ ����
INCREMENT BY 1   -- �ѹ� ���� �Ҷ����� N������
START WITH 1    -- N���� �����Ѵٴ� �ǹ� / ���۰�
MINVALUE 1      --�ּҰ�
MAXVALUE 1000   -- �ִ밪
--CYCLE           -- 1 ���� 1000 ���� �ѹ��� ���� �� ������
NOCYCLE         --  ������
;

--------------������ ����-------------

SELECT T_SEQ2.NEXTVAL       --NEXTVAL ���� �÷��شٴ� �ǹ�
FROM DUAL;

INSERT INTO TEST_BOARD VALUES(T_SEQ.NEXTVAL , '�ȳ��ϼ���');
            -- �߰��� 8�� �����ص� 8�� �޲ٴ°� �ƴϰ� ������ ���� ä����

SELECT T_SEQ2.CURRVAL           -- ���� �������� ���� �˷���
FROM DUAL
;