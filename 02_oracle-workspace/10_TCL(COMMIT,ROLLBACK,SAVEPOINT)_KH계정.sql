
/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    Ʈ������� �����ϴ� ���

    * Ʈ����� (TRANSACTION)
    - �����ͺ��̽��� ���� �������
    - �������� �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
      COMMI(Ȯ��)�ϱ� �������� ������׵��� �ϳ��� Ʈ����ǿ� ��� ��
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML)
    
    COMMIT(Ʈ����� ����ó�� �� Ȯ��), ROLLBACK(Ʈ����� ���), SAVEPOINT(�ӽ������� ���)
    
    COMMIT; ����  : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ��ϰڴٴ� �� �ǹ� (���� DB�� �ݿ���Ų �� Ʈ������� �����)
    ROLLBACK; ����  : �ϳ��� Ʈ����ǿ� ����ִ� ������׵��� ������ �� ������ COMMIT �������� ���ư�
    
    SAVEPOINT ����Ʈ��; ����  : ���� �� ������ �ӽ��������� �����صδ� ��
    ROLLBACK ����Ʈ��; ����  : ��ü ������׵��� �����ϴ� ���� �ƴ϶� �ش� ���ε� ���������� Ʈ����Ǹ� �ѹ���
        
*/
SELECT * FROM EMP_01;

-- ����� 901�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 901;
-- ����� 900�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 900;

ROLLBACK;

--------------------------------------

-- 200�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 800, ȫ�浿, �ѹ��� ��� �߰�
INSERT INTO EMP_01
VALUES(800, 'ȫ�浿', '�ѹ���');

COMMIT;

SELECT * FROM EMP_01;
ROLLBACK;

----------------------------------------------

-- 217, 216, 214 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN( 217, 216, 214);

-- 3���� ���� ������ ������ SAVEPOINT ����
SAVEPOINT SP1;

-- 801, '�踻��', '�λ��'
INSERT INTO EMP_01
VALUES(801, '�踻��', '�λ��');

-- 218 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 218;

ROLLBACK TO SP1;

SELECT * FROM EMP_01;

----------------------------------------------------


-- 900, 910 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN(900, 910);

-- 218 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- ���̺� ���� (DDL)
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

/*
    DDL����(CREATE, ALTER, DROP)�� �����ϴ� ����
    ������ Ʈ����ǿ� �ִ� ��� ������׵��� ������ ���� DB�� �ݿ�(COMMIT)��Ų �Ŀ� DDL�� �����
    => ��, DDL ������ ������׵��� �־��ٸ� ��Ȯ�ϰ� �Ƚ�(COMMIT, ROLLBACK)�ϰ� ����

*/

SELECT * FROM EMP_01;

/*
    ����ڰ� �Խñ�(÷�������� �����ϴ�) �߰��ϴ� ��û�� (�Ѱ��� ��û�� �ΰ� �̻��� DML�� ������ ���)
    
    => INSERT INTO ÷���������̺�
    => INSERT INTO �Խñ����̺� 
    
    �� �� �� INSERT�� �� �� ���� => COMMIT (Ȯ��)
    �� �� �ϳ��� �� �� INSERT �� ���� => ROLLBACK(������ �� INSERT�ƴ� �͵� ��������)
    
*/














