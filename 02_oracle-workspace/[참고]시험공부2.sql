-- 2/17 ������
-- �����ű�/ ����� ���� �ο�

-- �� �μ��� �ְ�޿��� �޴� ����� ���, �����, �μ��ڵ�, �޿�

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE);
                             -- DEPT_CODE = NULL AND SALARY = 2890000
--=> �μ��� ���� ����� ��ȸ���� ����!

-->NVL �Լ��� �̿��ؼ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '����'),SALARY) IN (SELECT NVL(DEPT_CODE,'����'), MAX(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE);


-- BOARD ���̺� �����ϴ� ����
CREATE TABLE BOARD(
    BOARDNO NUMBER CONSTRAINT B_PK PRIMARY KEY,
    BOARDTITLE VARCHAR2(50),
    BOARDDATE DATE,
    BOARDWRITER VARCHAR2(15),
    BOARDCONTENT VARCHAR2(2000),
    ORGINAL_FILEPATH VARCHAR2(100),
    RENAME_FILEPATH VARCHAR2(100)
    
);

COMMENT ON COLUMN BOARD.BOARDNO IS '�Խñ۹�ȣ';
COMMENT ON COLUMN BOARD.BOARDTITLE IS '�Խñ�����';
COMMENT ON COLUMN BOARD.BOARDDATE IS '�Խñ۵�ϳ�¥';
COMMENT ON COLUMN BOARD.BOARDWRITER IS '�Խñ��ۼ��ھ��̵�';
COMMENT ON COLUMN BOARD.BOARDCONTENT IS '�Խñ۳���';
COMMENT ON COLUMN BOARD.ORGINAL_FILEPATH IS '÷�����Ͽ�����';
COMMENT ON COLUMN BOARD.RENAME_FILEPATH IS '÷�����ϼ�����';

-- INSERT �� ���� ����
INSERT INTO BOARD
VALUES(1,'�ȳ��ϼ���!',SYSDATE,'ABCD','�ȳ��ϼ���. �����λ��մϴ�.','123','123_����');

INSERT INTO BOARD
VALUES(2,'�ȳ�!',SYSDATE,'EFG','�ȳ�~�����λ��մϴ�.','555','55_����');

SELECT * FROM BOARD;

-- BOARD���̺� �ֱٿ� ��ϵ� �Խñ� 5���� ��ȸ(����÷���ȸ)�ϴ� TOP-N �м� ������ �ۼ��غ��ÿ�
-->> 1. ROWNUM �̿��� ���
SELECT *
FROM (SELECT BOARDNO, BOARDTITLE,  BOARDDATE, BOARDWRITER,  BOARDCONTENT, 
             ORGINAL_FILEPATH, RENAME_FILEPATH, RANK() OVER(ORDER BY SYSDATE) "����"
      FROM BOARD
      ORDER BY BOARDDATE DESC)
WHERE ROWNUM <= 5;

-->> 2. RANK() �Լ��� �̿��� ���
SELECT * 
FROM (SELECT BOARDNO, BOARDTITLE,  BOARDDATE, BOARDWRITER,  BOARDCONTENT, 
             ORGINAL_FILEPATH, RENAME_FILEPATH, RANK() OVER(ORDER BY SYSDATE) "����"
      FROM BOARD)
WHERE ���� <= 5;



-->> RANK() OVER() / DENSE_RANK() OVER() Ư¡ ������
-->> JOIN����
-->> ���̺� ���� => DDL �ǽ�����(�����������α׷�)
-->> INSERT