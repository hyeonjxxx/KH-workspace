/* 
    < ������ SEQUENCE >
    �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������

    EX) ȸ����ȣ, ���, �Խñ� ��ȣ ��� ä�� �Ҷ� �ַ� ����� ����
    
    1. ������ ��ü ���� ����
    
    [ǥ����]
    CREATE SEQUENCE ��������
    [START WITH ���ۼ���]          --> ó�� �߻���ų ���۰� ����
    [INCREMENET BY ������]         --> �� �� ������ų���� ����
    [MAXVALUE �ִ밪]              --> �ִ밪 ����
    [MINVALUE �ּҰ�]              --> �ּҰ� ����
    [CYCLE|NOCYCLE]               --> �� ��ȯ ���� ����
    [CACHE ����Ʈ ũ��|NOCACHE]    --> ĳ�ø޸� ���� ����
    
    * ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                 �Ź� ȣ���Ҷ� ���� ������ ��ȣ�� �����ϴ� �� ����
                 ĳ�ø޸� ������ �̸� ������ ������ �����ٰ� ���� �ȸ� �ξ� �ӵ��� ����
                 ��, ������ ������� ������ �� ������ �����Ǿ��� ������ ���󰡰� ����
    
*/

/*
    ���̺�� : TB_
    ��� : VW_
    �������� : SEQ_
    Ʈ���Ÿ� : TRG_

*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;   --> �� ������ �����ϰ� �ִ� �������鿡 ���� ���� ��ȸ�� (������ ��ųʸ�)
-- USER_TABLES, USER_VIEWS

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;


------------------------------------------------------------------------------
/*
    2. ������ ��� ����
    
    ��������.CURRVAL : ���� �������� �� (���������� ���������� �߻��� NEXTVAL ��)
    ��������.NEXTVAL : �������� ������Ű�� ������ �������� ��
                      �⺻������ ������ INCREMENT BY �� ��ŭ ������ ��
                      == ��������.CURRVAL + INCREMENT BY ��
                      
                      => ��, ������ ���� �� ù NEXTVAL�� START WITH�� ������ ���۰����� �߻�
*/


SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL�� �ѹ��̶� �������� ���� �̻� CURRVAL�� ������ �� ����!!
--> ��?  :  CURRVAL�� �������� ���������� ����� NEXTVAL�� ���� �����ؼ� �����ִ� �ӽð�

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 305

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  --> 310


/*
    3. ������ ����   
    
    [ǥ����]
    ALTER SEQUENCE ��������
    CREATE SEQUENCE ��������
    [START WITH ���ۼ���]          --> ó�� �߻���ų ���۰� ����
    [INCREMENET BY ������]         --> �� �� ������ų���� ����
    [MAXVALUE �ִ밪]              --> �ִ밪 ����
    [MINVALUE �ּҰ�]              --> �ּҰ� ����
    [CYCLE|NOCYCLE]               --> �� ��ȯ ���� ����
    [CACHE ����Ʈ ũ��|NOCACHE]    --> ĳ�ø޸� ���� ����
    
    ** START WITH�� ����Ұ�! => �� �ٲٰ� �ʹٸ� �����ߴٰ� �ٽ� ����
    

*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 320

-- SEQUENCE ����
DROP SEQUENCE SEQ_EMPNO;

---------------------------------------------------------------------------------

-- �Ź� ���ο� ���
CREATE SEQUENCE SEQ_EID
START WITH 300;

-- ����߰��� ������ INSERT��
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '111111-1111111', 'J2', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ���', '222222-2222222', 'J3', SYSDATE);

ROLLBACK;

-- ����� ���� �߰� "��û"�� ������ SQL��
INSERT 
  INTO EMPLOYEE
       (
            EMP_ID
          , EMP_NAME
          , EMP_NO
          , JOB_CODE
          , HIRE_DATE
        )
VALUES        
        ( 
           SEQ_EID.NEXTVAL
         , ����ڰ��Է��Ѱ�
         , ����ڰ��Է��Ѱ�
         , ����ڰ��Է��Ѱ�
         , SYSDATE 
        );




























