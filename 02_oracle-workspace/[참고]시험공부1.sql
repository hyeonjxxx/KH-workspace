-- 사원테이블에서 사원명, 직급코드, 보너스를 받는 사원수를 조회한 후 직급코드별 오름차순 정렬
SELECT 
        EMP_NAME, 
        JOB_CODE, 
        COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS != NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;
--> 문제점1. BONUS가 NULL이 아닌 이라는 조건이 제대로 수행되지 않을꺼임
--> 문제점2. SELECT 절에서 그룹함수를 제외한 모든 컬럼을 GROUP BY절애 기술해야하는데 안되어있음

--> 조치1. BONUS IS NOT NULL로 조건을 수정해야 됨
SELECT 
        EMP_NAME, 
        JOB_CODE, 
        COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE
ORDER BY JOB_CODE ASC;

--> 조치2. GROUP BY절을 EMP_NAME, JOB_CODE로 수정
SELECT 
        EMP_NAME, 
        JOB_CODE, 
        COUNT(*) AS "사원수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE ASC;

---------------------------------------------------------------------------------


-- 각 부서별 그룹을 지어서
-- 부서코드, 부서별 급여합, 부서병평균급여(정수처리), 부서별사원수 조회 후 부서코드별 오름차순 정렬
-- 단, 부서별 평균급여가 2800000초과인 부서만을 조회

SELECT
    DEPT_CODE
    , SUM(SALARY) 합계
    , ROUND(AVG(SALARY)) 평균
    , COUNT(*) 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) > 2800000
ORDER BY DEPT_CODE;

-----------------------------------------------------------------------------

-- 부서별 급여합이 1000만원 이상인 부서만 조회 (부서코드, 부서별 급여합)
SELECT DEPT_CODE 부서코드, SUM(SALARY) "부서별 급여함"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) >= 10000000; 

-- '800918-2*****' 주민번호 조회 => SUBSTR, RPAD
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14, '*')
FROM EMPLOYEE;

-- 직원들의 급여를 인상시켜서 조회
-- 직급코드가 'J7'인 사원은 급여를 10%로 인상해서 조회     SALARY *1.1
--          'J6'인 사원은 급여를 15%로 인상해서 조회     SALARY *1.15
--          'J5'인 사원은 급여를 20%로 인상해서 조회     SALARY *1.2
--    그외의 직급인 사원은 급여를 5%로 인상해서 조회       SALARY *1.05
SELECT EMP_NAME 사원명, SALARY 급여
    , DECODE(
FROM EMPLOYEE;













