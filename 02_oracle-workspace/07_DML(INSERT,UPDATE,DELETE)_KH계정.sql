/*
--2/10

    < DML : DATA MANIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ���ο� �����͸� ����(INSERT)�ϰų� ������ �����͸� ����(UPDATE)�ϰų� ����(DELETE)�ϴ� ����

*/


/*
    1. INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ǥ����]
    1) INSERT INTO ���̺�� VALUES(��, ��, ��, ...);
    �ش� ���̺� ��� �÷��� �߰��ϰ��� �ϴ� ���� ���� ���� �����ؼ� �� �� INSERT�ϰ��� �Ҷ� ���
    
    �������� : �ķ� ������ ���Ѽ� VALUES�� ���� �����ؾߵ�!
    
*/

INSERT INTO EMPLOYEE
VALUES(900, '��ä��', '980914-2456744', 'jang_ch@kh.or.kr', '01011112222',
       'D1', 'J7', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE;       
/*
    2) INSERT INTO ���̺�� (�÷���, �÷���, �÷��� ) VALUES(��, ��, ��);
    �ش� ���̺� Ư�� �÷��� �����ؼ� �� �÷��� �߰��� ���� �����ϰ��� �Ҷ� ��� 
    
   �׷��� �� �� ������ �߰��Ǳ� ������ ���þȵ� �÷��� �⺻������ NULL���� ��
   (��, �⺻��(DEFAULT)�� �����Ǿ��ִٸ� �⺻���� ��)
    
    �������� : NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� �����ؾߵ�!
            �ƹ��� NOT NULL ���������� �ɷ��ִ� �÷��̶�� �ص� �⺻���� �����Ǿ� �ִ� �÷��� ���þ��ص� ��
    
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(901, '������', '801231-2345789', 'D1', 'J2', SYSDATE);

SELECT * FROM EMPLOYEE; 


/*
    3) INSERT INTO ���̺�� (��������);
       VALUES�� ���� �����ϴ� �� ��ſ� ���������� ��ȸ�� ������� ��°�� INSERT�ϴ� ����
       (������ INSERT ��ų�� �ִ�)
*/


-- ���ο� ���̺� ���� ������!!
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ���(�μ���ġ�� �ȵ� ����� ����)���� ���, �̸� , �μ����� ��ȸ�� ����� EMP_01 ���̺� ��°�� �߰�!
INSERT INTO EMP_01
    (
        SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    );    

SELECT * FROM EMP_01;

-------------------------------------------------------------------------------

/*
    2. INSERT ALL
       �ΰ� �̻��� ���̺� ���� INSERT �� �� ���
       �׶� ���Ǵ� ���������� ������ ���

*/

-->> �켱 ���̺� �����!!

-->> ù��° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, ���޸� ���� ������ ���̺�
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    JOB_NAME VARCHAR2(20)
);

-->> �ι�° ���̺� : �޿��� 300���� �̻��� �������  ���, �����, �μ��� ���� ������ ���̺�
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
); 

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

--  �޿��� 300���� �̻��� ������� ���, �̸�, ���޸�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;

/*
    1)
      INSERT ALL
      INTO ���̺��1 VALUES(�÷���, �÷���,...)
      INTO ���̺��2 VALUES(�÷���, �÷���,...)
            ��������;


*/

-- EMP_JOB ���̺�  �޿��� 300���� �̻��� �������  EMP_ID, EMP_NAME, JOB_NAME �� ����
-- EMP_DEPT ���̺�  �޿��� 300���� �̻��� �������  EMP_ID, EMP_NAME, DEPT_TITLE �� ����

INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE SALARY >= 3000000;

-- INSERT ALL ������ ����ص� �� ���̺� �� INSERT ����

-- ���, �����, �Ի���, �޿� (EMP_ODL) => 2000�⵵ ���� �Ի��� ���
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
-- ���, �����, �Ի���, �޿� (EMP_NEW) => 2000�⵵ ���� �Ի��� ���
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE <'2000/01/01'; --> 2000��� ���� �Ի��� 8�� (EMP_ODL)
WHERE HIRE_DATE >='2000/01/01'; --> 2000��� ���� �Ի��� 17�� (EMP_NEW)

/*
    2) 
      INSERT ALL
      WHEN ����1 THEN
        INTO ���̺��1  VALUES(�÷���, �÷���, �÷���, ...)
      WHEN ����2 THEN  
        INTO ���̺��2  VALUES(�÷���, �÷���, �÷���, ...)        
      ��������

*/

INSERT 
WHEN HIRE_DATE <'2000/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) 
WHEN HIRE_DATE >='2000/01/01' THEN  
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) 
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;



----------------------------------------------------------------------------------
/*
    3. UPDATE
       ���̺� ��ϵ� �⺻�� �����͸� �����ϴ� ����
       
       [ǥ����]
       UPDATE ���̺��
       SET �÷��� = �ٲܰ�
         , �÷��� = �ٲܰ�
         , ...             => �������� �÷��� ���ú��� ����(, �� �����ؾߵ�!! AND �ƴ�!!!)
       [WHERE ����];        => �����ϸ� ��ü ��� ���� �����Ͱ� �� ����ǹ���!!
   
*/

-- ���纻 ���̺��� �� �۾�
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺� D9�μ��� �μ����� ������ȹ�� ���� �����ϰ��� ��

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'; --> ������ �������� �ʾ� ��ü ���� ��� DEPT_TITLE���� �� '������ȹ��'���� ����ǹ���!!

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';  --> DEPT_ID�� D9�� �μ��� ã�Ƽ� �����ϰڴ�

-- ���纻 ���̺�
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;

-- EMP_SALARY ���̺� ���ö ����� �޿��� 1000�������� ����
UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '���ö';

-- EMP_SALARY ���̺� ������ ����� �޿��� 700����, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = 7000000
  , BONUS = 0.2
WHERE EMP_NAME = '������';

-- ��ü��� �޿��� ������ �޿��� 20% �λ��� �ݾ����� ���� (�����޿�*1.2)
UPDATE EMP_SALARY
SET SALARY = SALARY*1.2;


/*
    * UPDATE �ÿ� ���������� ���
      
      UPDATE ���̺��
      SET �÷��� = (��������)
      [WHERE ����];

*/

-- EMP_SALARY ���̺� ������ ����� �μ��ڵ带 �����ϻ���� �μ��ڵ�� ����
UPDATE EMP_SALARY 
SET DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
WHERE EMP_NAME = '������';

-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ������� ����
UPDATE EMP_SALARY 
SET ( SALARY, BONUS) = (SELECT SALARY, BONUS
                FROM EMP_SALARY
                WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

--------------------------------------------------------------------------------

-- UPDATE�ÿ��� ������ ���� �־ �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�!

-- ���ö ����� �μ��ڵ带 D0���� ����
UPDATE EMPLOYEE
SET DEPT_CODE = 'D0'
WHERE EMP_NAME = '���ö'; --> �ܷ�Ű �������ǿ� ����

-- ����� 200���� ����� �̸��� NULL�� ����
UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;  --> NOT NULL �������ǿ� ����

COMMIT;  --> ��� ������׵��� Ȯ����Ű�ڴ�. �Ƚ��ϰڵ�.

--------------------------------------------------------------------------------


/*
    4. DELETE
       ���̺� ��ϵ� �����͸� �����ϴ� ����
    
       [ǥ����]
       DELETE FROM ���̺��
       [WHERE ����];  --> WHERE�� ������ �ش� ���̺��� ��ü �� ����   
*/
DELETE FROM EMPLOYEE;
ROLLBACK; --> ������ Ŀ�Խ������� ���ư���!

-- ��ä�� ������ ��� ������ �����
DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('��ä��', '������');

SELECT * FROM EMPLOYEE;

COMMIT;

-- DEPAERTMENT ���̺�κ��� DEPT_ID�� D1�� �μ� ����
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D1';
--> �����ȵ�(D1�� ������ ���� �ִ� �ڽĵ����Ͱ� �ֱ� ������)

-- DEPAERTMENT ���̺�κ��� DEPT_ID�� D3�� �μ� ����
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D3';
--> �����ȵ�(D3�� ������ ���� �ִ� �ڽĵ����Ͱ� ���� ������)

ROLLBACK;

/*
    * TRUNCATE : ���̺��� ��ü ���� ������ �� ����ϴ� ���� (����)
                 DELETE ���� ����ӵ��� �� ����
                 ������ ���� ���� �Ұ�, ROLLBACK�� �Ұ���!!
     [ǥ����]
     TRAUNCATE TABLE ���̺��;       |    DELETE FROM ���̺��;
     ===================================================================
       ���� ���� ���� �Ұ�             |     Ư�� ���� ���� ����
         ����ӵ� ����                |        ����ӵ� ����
         ROLLBACK �Ұ�              |        ROLLBACK ����
*/
SELECT * FROM DEMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;

ROLLBACK;






















