-- 한 줄 주석
/*
    여러줄 
    주석

*/


/*
    < SELECT > 
    : 데이터를 조회하거나 검색할 때 사용되는 명령어
    
    * Result Set :  SELECT 구문을 통해 조회된 데이터의 결과물을 뜻함
                    즉, 조회도니 행들의 집합을 의미
                    
    * 표현법
    SELECT 조회하고자하는 컬럼, 컬럼, 컬럼, ...    --> SELECT절
    FROM 테이블명;                              --> FROM절
*/

-- EMPLOYEE 테이블 전체 사원들의 모든 컬럼(*) 조회
-- SELECT EMP_ID, EMP_NAME, EMP_NO,...
SELECT  * FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼만을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

--> 명령어, 키워드, 테이블명, 컬럼명 대소문자를 가리지 않음! (소문자로 해도 무방 단, 대문자로 써버릇하자!)
--> 실제 담겨있는 데이터(값)은 대소문자를 구분함!


----------------------------- 실습문제 ------------------------------

--1. JOB 테이블의 모든 컬럼 조회
SELECT * FROM JOB;

--2. JOB 데이블의 직급명 컬럼만 조회
SELECT JOB_NAME FROM JOB;

--3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT * FROM DEPARTMENT;

--4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 컬럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5.EMPLOYEE 테이블의 입사일 , 직원명, 급여 컬럼만 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;


/*
    < 컬럼값을 통한 산술연산 >
    - 조회하고자 하는 컬러들을 나열하는 SELECT절에 산술연산(+-/*)을 기술해서 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉(월급*12)
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;


-- EMPLOYEE 테이블로 부터 직원명, 월급, 보너스, 보너스가포함된연봉((월급+ 보너스*월급)*12)
SELECT EMP_NAME, SALARY, BONUS, (SALARY + SALARY*BONUS) *12
FROM EMPLOYEE;
--> 산술연산 과정에 NULL값이 존재하는 경우 산술연산 결과도 NULL값으로 조회됨!!



-- EMPLOYEE 테이블로 부터 직원명, 입사일, 근무일수(오늘날짜-입사일) 조회
-- DATE 타입끼리도 연산 가능(DATE => 년, 월, 일, 시, 분, 초)
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
--> 결과 값은 일 수 단위로 출력
--> 값이 지저분한 이유 DATE타입 안에 포함되어 있는 시/분/초에 대한 연산까지 수행되기 때문!
------------------------------------------------------------------------------

/*
    < 컬럼명에 별칭 지정하기 >
    
    [표현법]
    컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 별칭, 컬럼명 "별칭"
    
    AS를 붙이든 안붙이든지간에
    별칭에 특수문자나 띄어쓰기가 포함될 경우 반드시 ""(쌍따옴표)로 묶어서 표기해야됨
    
    
*/

-- EMPLOYEE 테이블로 부터 직원명, 월급, 보너스, 보너스가포함된연봉((월급+ 보너스*월급)*12)
SELECT EMP_NAME AS 이름, SALARY AS "급여(원)", BONUS 보너스, (SALARY + SALARY*BONUS) *12 "총 소득"
FROM EMPLOYEE;


-------------------------------------------------------------------------------


/*
    < 리터럴 >
   :  임의로 지정한 문자열('')을 SELECT절에 기술하면
      실제 그 테이블에 존재하는 데이터처럼 조회가능
    
*/

-- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위('원') 조회하기
SELECT EMP_ID, EMP_NAME, SALARY, '원' 단위
FROM EMPLOYEE;
-- SELECT절에 제시한 리터럴 값은 조회결과인 RESULT SET의 모든 행에 반복적으로 출력됨

/*
    < DISTINCT >
   : 조회하고자 하는 컬럼에 중복된 값을 딱 한번씩만 조회하고자 할 때 사용
     해당 컬럼명 앞에 기술
    
    [표현법] DISTINCT 컬럼명
    
    단, SELECT절에 단 한 개만 기술 가능!
   
*/

-- EMPLOYEE 테이블로 부터 부서코드 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- DEPT_CODE롸 JOB_CODE을 세트로 묶어서 중복판별
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;





/*
    < WHERE절 >  
    : 조회하고자 하는 테이블에 특정 조건을 제시해서
      그 조건에 만족하는 데이터만을 조회하고자 할때 기술하는 구문
    
    [표현법] 
    SELECT 조회하고자하는 컬럼, 컬럼, ...
    FROM 테이블명
    WHERE 조건식;
    
    => 조건식에 다양한 연산자들 사용 가능
    
    < 비교 연산자 >
    >, <, >=, <=
    동등비교: =
    일치하지않는다 : !=, ^=, <>
    
*/

-- EMPLOYEE 테이블로 부터 급여가 400만원 이상인 사원들만 조회 (모든 칼럼)
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 부서코드 D9가 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
WHERE DEPT_CODE <> 'D9';

------------------------------- 실습문제 -------------------------------------
--1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

--3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

--4. EMPLOYEE 테이블에서 연봉(급여*12)이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT EMP_NAME, SALARY,  SALARY*12 "연봉", HIRE_DATE    -- 실행순서 ③
FROM EMPLOYEE                                           -- 실행순서 ①
WHERE SALARY*12 >= 50000000;                            -- 실행순서 ②
--> SELECT절에 부여한 별칭을 WHERE절에서 활용할 수 없음!


-------------------------------------------------------------------------------


/*
    < 논리연산자 >
    여러개의 조건을 엮을 때 사용
    
    AND(~이면서, 그리고), OR(~이거나, 또는)

*/
-- 부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원이상인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

---------------------------------------------------------------------------------

/*

    < BETWEEN AND >
    몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용
    
    [표현법]
    비교대상컬럼명 BETWEEEN 하한값 AND 상한값   

*/

-- 급여가 350만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 급여가 350만원 이상이고 600만원 이하가 아닌 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000 ;
-- 오라클에서의 NOT은 자바로 따졌을 때 논리부정연산자인 !와 동일한 의미

-- ** BETWEEN AND 연산자 DATE형식간에서도 사용 가능
-- 입사일이 '90/01/01' ~ '01/01/01'인 사원들 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

------------------------------------------------------------------------------

/*
    < LIKE '특정패턴' >
    비교하려는 컬럼값이 내가 지정한 특정패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼명 LIKE '특정패턴'
    
    - 특정패턴에 와일드카드인 '%', '_'가지고 제시할 수 있음
    => '%' : 0글자 이상
    EX) 비교대상컬럼명 LIKE '문자%' => 컬럼값 중에 '문자'로 "시작"되는 걸 조회
        비교대상컬럼명 LIKE '%문자' => 컬럼값 중에 '문자'로 "끝"나는 걸 조회
        비교대상컬럼명 LIKE '%문자%' => 컬럼값 둥에 '문자'가 "포함"되는 걸 조회
        
    => '_' : 1글자
    EX) 비교대상컬럼명 LIKE '_문자' => 컬럼값 중에 '문자' 앞에 무조건 한 글자가 올 경우 조회
        비교대상컬럼명 LIKE '__문자' => 컬럼값 중에 '문자' 앞에 무조건 두 글자가 올 경우 조회
        
*/

-- 성이 전씨인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE,EMAIL
FROM EMPLOYEE
--WHERE PHONE LIKE '0109%' OR PHONE LIKE '0119%' OR PHONE LIKE '0179%';
WHERE PHONE LIKE '___9%';

-- 이름 가운데글자가 '하'인 사원들의 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 그 외인 사원
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '_하_';

-- 어떤 것이 와일드 카드고 어떤것이 데이터값인지 구분이 안됨!
-- 데이터값으로 인식시킬 값 앞에 나만의 와일드 카드로 제시하고 나만의 와일드카드를 ESCAPE로 등록
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

------------------------------- 실습문제 ---------------------------------
-- 1. 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME  LIKE '%연';

-- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

-------------------------------------------------------------------------------

/*

    < IS NULL / IS NOT NULL >
    
    [표현법]
    비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
    비교대상컬럼 ID NOT NULL : 컬럼값이 NULL이 아닌 경우

*/

SELECT * FROM EMPLOYEE;

-- 보너스를 받지 않는 사원들 (BONUS 컬럼값이 NULL인)의 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
FROM EMPLOYEE
--WHERE BONUS = NULL;  --> 제대로 조회 안됨
WHERE  BONUS IS NULL;

-- 보너스를 받는 사원들 조회
SELECT EMP_ID, EMP_NAME, BONUS 
FROM EMPLOYEE
--WHERE BONUS != NULL;  --> 제대로 조회 안됨
WHERE  BONUS IS NOT NULL;

-- 사수 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, EMP_ID, DEPT_CODE 
FROM EMPLOYEE
WHERE  MANAGER_ID IS NULL;

-- 사수도 업고 부서배치도 받지 않은 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID  IS NULL AND DEPT_CODE IS NULL;

-- 부서배치를 받진 않았지만 보너스는 받는 사원 조회 (사원명, 보너스, 부서코드)
SELECT EMP_NAME, BONUS ,DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

------------------------------------------------------------------------------

/*
    < IN >
    비교대상컬럼값에 내가 제시한 목록들 중에 일치하는 값이 있는지
    
    [표현법]
    비교대상컬럼 IN (값, 값, 값,..)


*/

-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

----------------------------------------------------------------------------

/*
    < 연결 연산자 || >
    여러 컬럼값들이 마치 하나의 컬럼인 것 처럼 연결시켜주는 연산자
    컬럼과 리터럴(임의의 문자열)을 연결할 수 있음

    System.out.println("num : " + num); --> 자바에서
*/

SELECT EMP_ID || EMP_NAME || SALARY 연결됨
FROM EMPLOYEE;

-- XXX번 XXX의 월급은 XXXXXX원 입니다.
SELECT EMP_ID || '번 ' || EMP_NAME || '의 월급은' || SALARY || '원 입니다.' 급여정보
FROM EMPLOYEE;


--------------------------------------------------------------------------

/*
    < 연사자 우선순위 >
    0. ()
    1. 산술연산자(+-/*)
    2. 연결연산자(||)
    3. 비교연산자(<><=>=)
    4. ID NULL / LIKE / IN
    5. BETWEEN AND
    6. NOT
    7. AND (논리연산자)
    8. OR (논리연산자)
      
*/
--------------------------------------------------------------------------

/*

    < ORDER BY절 >
    SELECT문 가장 마지막에 기입하는 구문 뿐만아니라 실행 순서 또한 가장 마지막
    
    [표현법]
③   SELECT 조회할컬럼, 컬럼,..
①   FROM 조회할 테이블명
②   WHERE 조건식  
④   ORDER BY 정렬기준으로세우고자하는컬럼명|별칭|컬럼순번        [ASC|DESC] {NULLS FIRST|NULLS LAST] -> [] : 생략가능

    - ASC : 오름차순 정렬 (생략시 기본값)
    - DESC : 내림차순 정렬
    
    - NULLS FRIST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 NULL값들을 앞으로 배치  (내림차순 정렬일 경우 기본값)
    - NULLS LAST : 정렬하고자 하는 칼럼값에 NULL이 있을 경우 해당 NULL값들을 뒤로 배치     (오름차순 정렬일 경우 기본값)

*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;  -- ASC 또는 DESC 생략시 기본값이 ASC(오름차순정렬)
--ORDER BY BONUS ASC;  -- ASC는 기본적으로 NULLS LAST
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- DESC는 기본적으로 NULLS FIRST
--ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC, SALARY ASC ;
--> 첫번째로 제시한 정렬기준의 컬럼값이 일치할 경우 두번째 정렬기준을 가지고 다시 정렬


SELECT EMP_NAME, SALARY*12 "연봉"
FROM EMPLOYEE
--ORDER BY SALARY*12 DESC;
--ORDER BY 연봉 DESC;    -- 별칭 사용 가능
ORDER BY 2 DESC;        -- 조회될컬럼순번 사용가능