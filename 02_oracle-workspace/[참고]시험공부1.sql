-- ������̺��� �����, �����ڵ�, ���ʽ��� �޴� ������� ��ȸ�� �� �����ڵ庰 �������� ����
SELECT 
        EMP_NAME, 
        JOB_CODE, 
        COUNT(*) AS "�����"
FROM EMPLOYEE
WHERE BONUS != NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;
--> ������1. BONUS�� NULL�� �ƴ� �̶�� ������ ����� ������� ��������
--> ������2. SELECT ������ �׷��Լ��� ������ ��� �÷��� GROUP BY���� ����ؾ��ϴµ� �ȵǾ�����

--> ��ġ1. BONUS IS NOT NULL�� ������ �����ؾ� ��
SELECT 
        EMP_NAME, 
        JOB_CODE, 
        COUNT(*) AS "�����"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--> ��ġ2. GROUP BY���� EMP_NAME, JOB_CODE�� ����
SELECT 
        EMP_NAME, 
        JOB_CODE, 
        COUNT(*) AS "�����"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE ASC;

---------------------------------------------------------------------------------


-- �� �μ��� �׷��� ���
-- �μ��ڵ�, �μ��� �޿���, �μ�����ձ޿�(����ó��), �μ�������� ��ȸ �� �μ��ڵ庰 �������� ����
-- ��, �μ��� ��ձ޿��� 2800000�ʰ��� �μ����� ��ȸ

SELECT
    DEPT_CODE
    , SUM(SALARY) �հ�
    , ROUND(AVG(SALARY)) ���
    , COUNT(*) �����
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) > 2800000
ORDER BY DEPT_CODE;

-----------------------------------------------------------------------------

-- �μ��� �޿����� 1000���� �̻��� �μ��� ��ȸ (�μ��ڵ�, �μ��� �޿���)
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) "�μ��� �޿���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) >= 10000000; 

-- '800918-2*****' �ֹι�ȣ ��ȸ => SUBSTR, RPAD
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14, '*')
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ����� �޿��� 10%�� �λ��ؼ� ��ȸ     SALARY *1.1
--          'J6'�� ����� �޿��� 15%�� �λ��ؼ� ��ȸ     SALARY *1.15
--          'J5'�� ����� �޿��� 20%�� �λ��ؼ� ��ȸ     SALARY *1.2
--    �׿��� ������ ����� �޿��� 5%�� �λ��ؼ� ��ȸ       SALARY *1.05
SELECT EMP_NAME �����, SALARY �޿�
    , DECODE(
FROM EMPLOYEE;













