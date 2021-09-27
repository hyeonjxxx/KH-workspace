/*
    < JOIN >
    
    �� �� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ���� (�ߺ��� �ּ�ȭ�ϱ� ���ؼ�)
    => ��, JOIN������ �̿��ؼ� �������� ���̺� "����"�� �ξ ���� ��ȸ�ؾߵ�
    => ��, ������ JOIN�� �ؼ� ��ȸ�ϴ� ���� �ƴ϶� 
           ���̺� "�����"�� �ش��ϴ� �÷��� "��Ī"���Ѽ� ��ȸ�ؾߵ�!! 


                         ---- [ JOIN ��� ���� ] ----
               JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI(�̱�����ǥ����ȸ)����"
               
             ����Ŭ ���뱸��(����Ŭ)             |             ANSI(����Ŭ+�ٸ�DBMS)
==================================================================================================
                � ����                      |          ���� ����(INNER JOIN)       -> JOIN USING/ON
              (EQUAL JOIN)                    |          �ڿ� ����(NATURAL JOIN)     -> JOIN USING
--------------------------------------------------------------------------------------------------- 
                 ���� ����                     |       ���� �ܺ� ����(LEFT OUTER JOIN)       
               (LEFT OUTER)                   |       ������ ����(RIGHT OUTER JOIN)           
               (RIGHT OUTER)                  |      ��ü �ܺ� ����(FULL OUTER JOIN) => ����Ŭ������ �Ұ�
----------------------------------------------------------------------------------------------------
        ī���þ� ��(CARTEDIAN PRODUCT)          |            ���� ����(CROSS JOIN)          
-----------------------------------------------------------------------------------------------------
��ü ����(SELF JOIN), ������(NON EQUAL JOIN) |              JOIN ON          
 
*/-- ��ü ������� ���, �����,�μ��ڵ�, �μ������ �˾Ƴ����� �Ѵٸ�?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;                     --> EMPLOYEE���̺��� DEPT_CODE

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;                   --> DEPARTMENT���̺��� DEPT_ID

-- ��ü ������� ���, �����, �����ڵ�, ���޸���� �˾Ƴ����� �Ѵٸ�?
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;                     --> EMPLOYEE���̺��� JOB_CODE

SELECT JOB_CODE, JOB_NAME
FROM JOB;                          --> JOB���̺��� JOB_CODE

--> ������ ���ؼ� ������� �ش��ϴ� �÷��� ����� ��Ī��Ű�� ��ġ �ϳ��� ������� ��ȸ����!

/*
    1. � ����(EQUAL JOIN) / ���� ����(INTER JOIN)
       �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ (== ��ġ���� �ʴ� ������ ��ȸ���� ����) 

*/
-- >> ����Ŭ ���� ����
--    FROM ���� ��ȸ�ϰ��ϴ�  ���̺���� ����(,��)
--    WHERE ���� ��Ī��ų �÷���(�����)�� ���� ������ ������

-- ��ü����� ���, �����, �μ��ڵ�, �μ��� ���� ��ȸ
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE-"DEPT_CODE" / DEPARTMENT-"DEPT_ID")
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ���� �ʴ� ���� ��ȸ���� ���ܵȰ� Ȯ�� ����
-- (DEPT_CODE�� NULL�̿��� 2���� ��������� ��ȸ�ȵ�, DEPT_ID�� D3,D4,D7�� �μ������� ��ȸ�ȵ�)

-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE-"JOB_CODE" / JOB-"JOB_CODE")
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE = JOB_CODE;  --> ���� (ambiguously : �ָ��ϴ�, ��ȣ�ϴ�)
*/
-- ���1) ���̺�� �̿�
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ���2) ���̺��� ��Ī ���(�� ���̺��� ��Ī �ο�����)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-- >> ANSI����
--    FROM���� ��� ���̺��� �ϳ� ��� �� ��
--    �� �ڿ� JOIN������ ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� (���� ��Ƽ��ų �÷��� ���� ���ǵ� ���� ���)
--    USING ���� / ON ����

-- ���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE-"DEPT_CODE" / DEPARTMENT-"DEPT_ID")
--    => ������ ON ������ ����!! (USING ���� �Ұ���)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER*/JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE-"JOB_CODE" / JOB-"JOB_CODE")
--    ON ����,  USING ����

--    2_1) ON ���� : ambigyously�� �߻��� �� �ֱ� ������ Ȯ���� ����ؾߵ�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


--    2_2) USING ���� : ambigyously�� �߻�x
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE);

-- [����] ���� USING ������ ���ô� NATUAL JOIN(�ڿ�����)���ε� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
NATURAL JOIN JOB;
-- �ΰ��� ���̺� ������ ����, �����Ե� �ΰ��� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �Ѱ� ���� (JOB_CODE) => �˾Ƽ� ��Ī�Ǽ� ��ȸ


-- �߰����� ���ǵ� ���ð���!!
-- ������ �븮�� ������� ���, �����, �޿�, ���޸�

-- >> ����Ŭ���뱸��
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
  AND JOB_NAME = '�븮';

-- 2) ANSI ����
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
--JOIN JOB USING(JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '�븮';

--------------------------------- < �ǽ� ���� > ---------------------------------
-- 1. �μ��� '�λ������'�� ������� ���, �����, ���ʽ��� ��ȸ
-- >> ����Ŭ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
  AND DEPT_TITLE = '�λ������';
-- >> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';


-- 2. �μ��� '�ѹ���'�� �ƴ� ������� �����, �޿�, �Ի��� ��ȸ
-- >> ����Ŭ���뱸��
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
  AND DEPT_TITLE NOT LIKE '�ѹ���';
-- >> ANSI����
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) AND DEPT_TITLE != '�ѹ���';
--WHERE DEPT_TITLE != '�ѹ���';


-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-- >> ����Ŭ���뱸��
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
  AND BONUS IS NOT NULL;
-- >> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;


-- 4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME) ��ȸ 
SELECT * FROM DEPARTMENT;       -- LOCATION_ID
SELECT * FROM LOCATION;         -- LOCAL_CODE
-- >> ����Ŭ���뱸��
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;
-- >> ANSI����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- �߰�. ���, �����, �μ���, ���޸�
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
-- >> ����Ŭ���뱸��
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM  EMPLOYEE E, JOB J, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
  AND E.JOB_CODE = J.JOB_CODE;
-- >> ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-- �����/�������� : ��ġ���� �ʴ� ����� ���ʿ� ��ȸ���� ����

----------------------------------------------------------------------------

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    
    ���̺��� JOIN�� ��ġ���� ���� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT/RIGHT�� �����ؾߵ�! (������ �Ǵ� ���̺��� �����ؾߵ�!)
    
*/

-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL�� �θ��� ��� ��ȸX
-- �μ��� ������ ����� ���� �μ�(D3, D4, D7) ���� ��� ��ȸX

-- 1) LEFT [OUTER] JOIN : �� ���̺� �߿� ���� ����� ���̺� �������� JOIN
--                        ��, �����Ƶ� ���� ���� ����� ���̺��� ���̴��z ������ ��ȸ�ǰ� (��ġ�ϴ°� ã�� ���Ѵ��ص�)
-- >> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> EMPLOYEE ���̺��� �������� ��ȸ�߱� ������ EMPLOYEE�� �����ϴ� �����ʹ� ���� �Ƶ� ��ȸ�ǰԲ�!

-- >> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); --> ���� �������� ���� ���̺��� �÷����� �ƴ� �ݴ� ���̺��� �÷���(+)
 
-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
--                        ��, ������ ���̺� �ִ� �� ������ ��ȸ�ϰڵ� (��ġ�ϴ°� ã�� ���Ѵ��ص�)
-- >> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-- >> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ������� ��ȸ�� ���ֵ��� (�� ����Ŭ���뱸�������� �Ұ�)
-- >> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- >> ����Ŭ ���뱸��
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);  --> ����

/*
        3. ī�׽þȰ�(CARTESIAN PRODUCT) / �������� (CROSS JOIN)
           ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ�� (������)
           
        �� ���̺��� ����� ��� ������ �ڵ��� ���� ��� --> ����� ������ ��� => ����ȭ�� ����   

*/
-- �����, �μ���
-- >> ����Ŭ���뱸��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; --> 23 * 9 => 207�� �� ��ȸ

-- >> ANSI����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

---------------------------------------------------------------------------

/*
    4. �� ���� (NON EQUAL JOIN)
        '='�� ������� �ʴ� ���ι�
        
        ������ �÷����� ��ġ�ϴ� ��찡 �ƴ�, "����"�� ���ԵǴ� ��� ��Ī
        
*/
-- �����, �޿�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT * 
FROM SAL_GRADE;

-- �����, �޿�, �޿����(SAL_LEVEL)
-- >> ����Ŭ���뱸��
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
-- >> ANSI���� ( ON ������!!)
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);


---------------------------------------------------------------------------
--2/4
/*
        5. ��ü ����(SELF JOIN)
           ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
           ��, �ٽ� �ڽ��� ���̺�� �ٽ� ������ �δ� ���
        
*/
SELECT EMP_ID "������", EMP_NAME "�����", SALARY "����޿�", MANAGER_ID "������"
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE E;  -- ����� ���� ���� �����  ���̺�          MANAGER_ID
SELECT * FROM EMPLOYEE M;  -- ����� ���� ���� �����  ���̺�          EMP_ID          --> �����, ����޿�
-- ������, �����, ����μ��ڵ�, ����޿�
-- ������, �����, ����μ��ڵ�, ����޿�
-- >> ����Ŭ���뱸��
SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ�", E.SALARY "����޿�"
     , M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����μ�", M.SALARY "����޿�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;
-- >> ANSI����
SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ�", ED.DEPT_TITLE, E.SALARY "����޿�"
     , M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����μ�", MD.DEPT_TITLE, M.SALARY "����޿�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
JOIN DEPARTMENT ED ON(E.DEPT_CODE = ED.DEPT_ID)
JOIN DEPARTMENT MD ON(M.DEPT_CODE = MD.DEPT_ID);


---------------------------------------------------------------------------

/*
        < ���� JOIN >
        
*/
-- ���, �����, �μ���, ���޸�, ������(LOCAL_NAME)
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE

-- >> ����Ŭ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND E.JOB_CODE = J.JOB_CODE;
-- >> ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);
--> ���� JOIN�Ҷ� ���� �߿�
  
-- �����, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE            SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE
SELECT * FROM NATIONAL;     --                              NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                  MIN_SAL,MAX_SAL

SELECT E.EMP_NAME "�����"
     , D.DEPT_TITLE "�μ���"
     , J.JOB_NAME "���޸�"
     , L.LOCAL_NAME "�ٹ�������"
     , N.NATIONAL_NAME "�ٹ�������"
     , S.SAL_LEVEL "�޿����"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);



------------------------------- < JOIN ���� �ǽ� ����_2/4 > -------------------------------------

-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-- >> ����Ŭ����
SELECT E.EMP_ID "���", E.EMP_NAME "�����", 
       J.JOB_NAME "���޸�", D.DEPT_TITLE "�μ���", 
       LOCAL_NAME "�ٹ�������", E.SALARY "�޿�"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE 
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND J.JOB_NAME = '�븮'
  AND LOCAL_NAME LIKE 'ASIA%';
-->> ANSI����
SELECT E.EMP_ID "���", E.EMP_NAME "�����", 
       J.JOB_NAME "���޸�", D.DEPT_TITLE "�μ���",
       LOCAL_NAME "�ٹ�������", E.SALARY "�޿�"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '�븮'
  AND LOCAL_NAME LIKE 'ASIA%';


-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-- >> ����Ŭ����  
SELECT E.EMP_NAME "�����", E.EMP_NO "�ֹι�ȣ",  D.DEPT_TITLE "�μ���", J.JOB_NAME "���޸�"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE SUBSTR(E.EMP_NO, 1, 1) = '7'
  AND SUBSTR(E.EMP_NO, 8, 1) = '2'
  AND E.EMP_NAME LIKE '��%'
  AND E.JOB_CODE = J.JOB_CODE 
  AND E.DEPT_CODE = D.DEPT_ID;
-->> ANSI����
SELECT E.EMP_NAME "�����", E.EMP_NO "�ֹι�ȣ", D.DEPT_TITLE "�μ���", J.JOB_NAME "���޸�"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(E.EMP_NO, 1, 1) = '7'
  AND SUBSTR(E.EMP_NO, 8, 1) = '2'
  AND E.EMP_NAME LIKE '��%';

-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
-- >> ����Ŭ���� 
SELECT E.EMP_ID ���, E.EMP_NAME �����, J.JOB_NAME ���޸�
FROM EMPLOYEE E, JOB J
WHERE EMP_NAME LIKE '%��%'
  AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI����
SELECT E.EMP_ID ���, E.EMP_NAME �����, J.JOB_NAME ���޸�
FROM EMPLOYEE E 
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-- >> ����Ŭ���� 
SELECT E.EMP_NAME �����, J.JOB_NAME ���޸�, DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_TITLE LIKE '�ؿܿ���%'
  AND E.DEPT_CODE = D.DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI����
SELECT E.EMP_NAME �����, J.JOB_NAME ���޸�, DEPT_CODE �μ��ڵ�, DEPT_TITLE �μ���
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID) 
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- >> ����Ŭ����
SELECT E.EMP_NAME "�����", E.BONUS "���ʽ�", E.SALARY*12 "����",
       D.DEPT_TITLE "�μ���", L.LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E , DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND E.BONUS IS NOT NULL;
-->> ANSI����
SELECT E.EMP_NAME "�����", E.BONUS "���ʽ�", E.SALARY*12 "����",
       D.DEPT_TITLE "�μ���", L.LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E  
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (L.LOCAL_CODE = D.LOCATION_ID)
WHERE E.BONUS IS NOT NULL;

-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-- >> ����Ŭ����
SELECT E.EMP_NAME �����, J.JOB_NAME ���޸�, D.DEPT_TITLE �μ���, L.LOCAL_NAME �ٹ�������
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE  E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE;
-->> ANSI����
SELECT E.EMP_NAME �����, J.JOB_NAME ���޸�, D.DEPT_TITLE �μ���, L.LOCAL_NAME �ٹ�������
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
-- >> ����Ŭ����
SELECT E.EMP_NAME �����, D.DEPT_TITLE �μ���, L.LOCAL_NAME �ٹ�������, N.NATIONAL_NAME �ٹ�������
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�')
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE;
-->> ANSI����
SELECT E.EMP_NAME �����, D.DEPT_TITLE �μ���, L.LOCAL_NAME �ٹ�������, N.NATIONAL_NAME �ٹ�������
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-- >> ����Ŭ����
SELECT E.EMP_NAME �����, J.JOB_NAME ���޸�, E.SALARY �޿�
FROM EMPLOYEE E, JOB J
WHERE BONUS IS NULL
  AND J.JOB_CODE IN ('J4', 'J7')
  AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI����
SELECT E.EMP_NAME �����, J.JOB_NAME ���޸�, E.SALARY �޿�
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE BONUS IS NULL
  AND J.JOB_CODE IN ('J4', 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�.
-- >> ����Ŭ����
SELECT E.EMP_ID ���, E.EMP_NAME �����, J.JOB_NAME ���޸�, S.SAL_LEVEL �޿����
     , CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '���'
            WHEN SAL_LEVEL IN ('S3','S4') THEN '�߱�'
            WHEN SAL_LEVEL IN ('S5','S6') THEN '�ʱ�'
      END "����"
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE;
-->> ANSI����
SELECT E.EMP_ID ���, E.EMP_NAME �����, J.JOB_NAME ���޸�, S.SAL_LEVEL �޿����
     , CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '���'
            WHEN SAL_LEVEL IN ('S3','S4') THEN '�߱�'
            WHEN SAL_LEVEL IN ('S5','S6') THEN '�ʱ�'
      END "����"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-- >> ����Ŭ����
SELECT D.DEPT_TITLE �μ���, SUM(E.SALARY) �޿���
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000;

-->> ANSI����
SELECT D.DEPT_TITLE �μ���, SUM(E.SALARY) �޿���
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.
-- >> ����Ŭ����
SELECT DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE;
-->> ANSI����
SELECT DEPT_TITLE �μ���, FLOOR(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE;

