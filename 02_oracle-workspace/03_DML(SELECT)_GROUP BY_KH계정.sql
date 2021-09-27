/*
    < GROUOP BY절 >
    그룹을 묶어줄 기준을 제시할 수 있는 구문
    => 해당 제시된 기분별 그룹을 묶을 수 있음!

    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용

*/
-- 전체사원의 총 급여 합계{
SELECT SUM(SALARY)
FROM EMPLOYEE;  --> 현재 조회된 전체사원들을 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여 함
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 전제사원 수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 각 부서별 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별 오름차순으로 정렬해서 조회
SELECT DEPT_CODE,SUM(SALARY)    -- 3. SELECT절
FROM EMPLOYEE                   -- 1. FROM절
GROUP BY DEPT_CODE              -- 2. GROUP BY절
ORDER BY DEPT_CODE;             -- 4. ORDER BY절

-- 각 직급병 직급코드, 총급여합, 사원수
SELECT JOB_CODE "직급", SUM(SALARY) "급여합" , COUNT(*) "사원 수", COUNT(BONUS) "보너스를받는사원수",
    ROUND(AVG(SALARY)) "평균급여", MAX(SALARY) "최고급여", MIN(SALARY) "최소급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;


-- 각 부서별 부서코드, 총사원수, 보너스를 받는 사원수, 사수가 있는 사원수, 평균급여
SELECT DEPT_CODE, COUNT(*), COUNT(BONUS), COUNT(MANAGER_ID), ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 성별별 사원수
SELECT COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '여')  "성별", COUNT(*) "사원수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

---------------------------------------------------------------------------

/*
    < HAVING 절 >
    그룹에 대한 조건을 제시하고자 할 때 사용되는 구문
    (주로 그룹함수를 가지고 조건 제시)  
*/
-- 각 부서별 평균 급여
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- 각 직급별 총 급여합이 1000만원 이상이 직급코드, 급여합을 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 각 부서별 보너스르 받는 사원이 없는 부서만의 조회
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

------------------------------------------------------------------------------

/*

    < 실행순서 >
    
    5: SELECT절 *|조회하고자하는컬럼명|산술연산자|함수식 [AS] "별 칭!"|별칭
    1: FROM 조회하고자하는 테이블명
    2: WHERE 조건식
    3: GROUP BY 그룹기준에해당하는컬럼명|함수식
    4: HAVING 그룹함수식에 대한 조건식
    6: ORDER BY 정렬기준에해당하는컬럼명|별칭|컬럼순번 [ASC|DESC] [NULLS DIRST|NULLS LAST]

*/

------------------------------------------------------------------------------
--2/3

/*
     <  집합 연산자 == SET OPERTOR >
     
     여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
     
     - UNION : 합집합 ( 두 쿼리문 수행한 결과값을 더한 후 중복되는 부분은 한번 뺀거) OR
     - INTERSECT : 교집합 ( 두 쿼리문 수행한 결과값의 중복된 결과값) AND
     - UNION ALL : 합집합 결과에 교집합이 더해진 개념 ( 두 쿼리문 수행한 결과값을 무조건 더함) => 중복된 결과가 두번 조회 될 수 있음
     - MINUS : 차집합 ( 선행 쿼리문 결과 빼기 후행 쿼리문 결과값의 결과)

*/
-- 1. UNION (합집합-두쿼리문 수행한 결과값을 더하지만 단, 중복되는 결과는 한번만 조회)
-- 부서코드가 D5이거나 또는 급여가 300만원 초과인 사원들 조회(사번, 사원명, 부서코드, 급여)

--부서 코드가 D5인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--급여가 300만원 초과인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;  --> 12명 조회(6명+8명-2명)
-- 두 쿼리문에 조회하는 컬럼이 동일해야 한다

-- 위의 UNION 구문 대신 하나의 SELECT문으로 조회해보기
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;
-- OR연산자로 두개의 조건을 엮어서 조회하면 결과는 동일



-- 각 부서별 급여합 조회 (부서코드, 부서별 급여합)

--UNIOM 이용해서
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D2'
UNION
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- GROUP BY절 이용해서 쉽게 해결
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


--------------------------------------------------------------------------

-- 2. UNION ALL: 여러개의 쿼리 결과를 무조건 더하는 연산자 (중복값이 여러개 들어갈 수 있음)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'  -->6명
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -->8명

-- 3. INTERSECT (교집합-여러 쿼리 결과의 중복된 결과만을 조회)
-- 부서코드가 D5이면서 뿐만아니라 급여까지도 300만원 초과인 사원
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 아래처럼도 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

--------------------------------------------------------------------------

-- 4. MINUS(차집합-선행 쿼리 결과에 후행 쿼리 결과를 뺀 나머지)
-- 부서코드가 D5인 사원들 중 급여가 300만원 초과인 사원들 제외해서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' 
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 아래처럼 가능
-- 부서코드가 D5이면서 뿐만아니라 급여가 300만원 이하인 사원들 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;






