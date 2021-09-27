/*
    < JOIN >
    
    두 개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물(RESULT SET)로 나옴
    
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음 (중복을 최소화하기 위해서)
    => 즉, JOIN구문을 이용해서 여러개의 테이블간 "관계"를 맺어서 같이 조회해야됨
    => 단, 무작정 JOIN을 해서 조회하는 것이 아니라 
           테이블간 "연결고리"에 해당하는 컬럼을 "매칭"시켜서 조회해야됨!! 


                         ---- [ JOIN 용어 정리 ] ----
               JOIN은 크게 "오라클 전용구문"과 "ANSI(미국국립표준협회)구문"
               
             오라클 전용구문(오라클)             |             ANSI(오라클+다른DBMS)
==================================================================================================
                등가 조인                      |          내부 조인(INNER JOIN)       -> JOIN USING/ON
              (EQUAL JOIN)                    |          자연 조인(NATURAL JOIN)     -> JOIN USING
--------------------------------------------------------------------------------------------------- 
                 포괄 조인                     |       왼쪽 외부 조인(LEFT OUTER JOIN)       
               (LEFT OUTER)                   |       오른쪽 조인(RIGHT OUTER JOIN)           
               (RIGHT OUTER)                  |      전체 외부 조인(FULL OUTER JOIN) => 오라클에서는 불가
----------------------------------------------------------------------------------------------------
        카데시안 곱(CARTEDIAN PRODUCT)          |            교차 조인(CROSS JOIN)          
-----------------------------------------------------------------------------------------------------
자체 조인(SELF JOIN), 비등가조인(NON EQUAL JOIN) |              JOIN ON          
 
*/-- 전체 사원들의 사번, 사원명,부서코드, 부서명까지 알아내고자 한다면?
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;                     --> EMPLOYEE테이블의 DEPT_CODE

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;                   --> DEPARTMENT테이블의 DEPT_ID

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명까지 알아내고자 한다면?
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;                     --> EMPLOYEE테이블의 JOB_CODE

SELECT JOB_CODE, JOB_NAME
FROM JOB;                          --> JOB테이블의 JOB_CODE

--> 조인을 통해서 연결고리에 해당하는 컬럼만 제대로 매칭시키면 마치 하나의 결과물로 조회가능!

/*
    1. 등가 조인(EQUAL JOIN) / 내부 조인(INTER JOIN)
       연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회 (== 일치하지 않는 값들은 조회에서 제외) 

*/
-- >> 오라클 전용 구문
--    FROM 절에 조회하고하는  테이블들으 나열(,로)
--    WHERE 절에 매칭시킬 컬럼명(연결고리)에 대한 조건을 제시함

-- 전체사원의 사번, 사원명, 부서코드, 부서명 같이 조회
-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE-"DEPT_CODE" / DEPARTMENT-"DEPT_ID")
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하지 않는 값은 조회에서 제외된거 확인 가능
-- (DEPT_CODE가 NULL이였던 2명의 사원데이터 조회안됨, DEPT_ID가 D3,D4,D7인 부서데이터 조회안됨)

-- 사번, 사원명, 직급코드, 직급명
-- 2) 연결한 두 컬럼명이 같을 경우 (EMPLOYEE-"JOB_CODE" / JOB-"JOB_CODE")
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE = JOB_CODE;  --> 에러 (ambiguously : 애매하다, 모호하다)
*/
-- 방법1) 테이블명 이용
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법2) 테이블의 별칭 사용(각 테이블마다 별칭 부여가능)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-- >> ANSI구문
--    FROM절에 기분 테이블을 하나 기술 한 뒤
--    그 뒤에 JOIN절에서 같이 조회하고자 하는 테이블 기술 (또한 매티시킬 컬럼에 대한 조건도 같이 기술)
--    USING 구문 / ON 구문

-- 사번, 사원명, 부서코드, 부서명
-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE-"DEPT_CODE" / DEPARTMENT-"DEPT_ID")
--    => 무조건 ON 구문만 가능!! (USING 구문 불가능)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/*INNER*/JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 사번, 사원명, 직급코드, 직급명
-- 2) 연결한 두 컬럼명이 같을 경우 (EMPLOYEE-"JOB_CODE" / JOB-"JOB_CODE")
--    ON 구문,  USING 구문

--    2_1) ON 구문 : ambigyously가 발생할 수 있기 때문에 확실히 명시해야됨
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


--    2_2) USING 구문 : ambigyously가 발생x
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE);

-- [참고] 위의 USING 구문의 예시는 NATUAL JOIN(자연조인)으로도 가능
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
NATURAL JOIN JOB;
-- 두개의 테이블만 제시한 상태, 운좋게도 두개의 테이블에 일치하는 컬럼이 유일하게 한개 존재 (JOB_CODE) => 알아서 매칭되서 조회


-- 추가적인 조건도 제시가능!!
-- 직급이 대리인 사원들의 사번, 사원명, 급여, 직급명

-- >> 오라클전용구문
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
  AND JOB_NAME = '대리';

-- 2) ANSI 구문
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
--JOIN JOB USING(JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME = '대리';

--------------------------------- < 실습 문제 > ---------------------------------
-- 1. 부서가 '인사관리부'인 사원들의 사번, 사원명, 보너스를 조회
-- >> 오라클전용구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
  AND DEPT_TITLE = '인사관리부';
-- >> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';


-- 2. 부서가 '총무부'가 아닌 사원들의 사원명, 급여, 입사일 조회
-- >> 오라클전용구문
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
  AND DEPT_TITLE NOT LIKE '총무부';
-- >> ANSI구문
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) AND DEPT_TITLE != '총무부';
--WHERE DEPT_TITLE != '총무부';


-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- >> 오라클전용구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID
  AND BONUS IS NOT NULL;
-- >> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;


-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME) 조회 
SELECT * FROM DEPARTMENT;       -- LOCATION_ID
SELECT * FROM LOCATION;         -- LOCAL_CODE
-- >> 오라클전용구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;
-- >> ANSI구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 추가. 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
-- >> 오라클전용구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM  EMPLOYEE E, JOB J, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
  AND E.JOB_CODE = J.JOB_CODE;
-- >> ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-- 등가조인/내부조인 : 일치하지 않는 행들은 애초에 조회되지 않음

----------------------------------------------------------------------------

/*
    2. 포괄조인 / 외부조인 (OUTER JOIN)
    
    테이블간의 JOIN시 일치하지 않은 행도 포함시켜서 조회 가능
    단, 반드시 LEFT/RIGHT를 지정해야됨! (기준이 되는 테이블을 지정해야됨!)
    
*/

-- "전체" 사원들의 사원명, 급여, 부서명 조회
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- DEPT_CODE가 NULL인 두명의 사원 조회X
-- 부서에 배전된 사원이 없는 부서(D3, D4, D7) 같은 경우 조회X

-- 1) LEFT [OUTER] JOIN : 두 테이블 중에 왼편에 기술된 테이블 기준으로 JOIN
--                        즉, 뭐가됐든 간에 왼편에 기술된 테이블의 테이더틑 무조건 조회되게 (일치하는걸 찾지 못한다해도)
-- >> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> EMPLOYEE 테이블을 기준으로 조회했기 때문에 EMPLOYEE에 존재하는 데이터는 뭐가 됐든 조회되게끔!

-- >> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); --> 내가 기준으로 삼을 테이블의 컬럼명이 아닌 반대 테이블의 컬럼명에(+)
 
-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술되 테이블을 기준으로 JOIN
--                        즉, 오른쪽 테이블에 있는 건 무조건 조회하겠따 (일치하는걸 찾지 못한다해도)
-- >> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-- >> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든행을 조회할 수있도록 (단 오라클전용구문에서는 불가)
-- >> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- >> 오라클 전용구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);  --> 에러

/*
        3. 카테시안곱(CARTESIAN PRODUCT) / 교차조인 (CROSS JOIN)
           모든 테이블의 각 행들이 서로서로 매핑된 데이터가 조회됨 (곱집합)
           
        두 테이블의 행들이 모두 곱해진 핸들의 조합 출력 --> 방대한 데이터 출력 => 과부화의 위험   

*/
-- 사원명, 부서명
-- >> 오라클전용구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; --> 23 * 9 => 207개 행 조회

-- >> ANSI구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

---------------------------------------------------------------------------

/*
    4. 비등가 조인 (NON EQUAL JOIN)
        '='를 사용하지 않는 조인문
        
        지정한 컬럼값이 일치하는 경우가 아닌, "범위"에 포함되는 경우 매칭
        
*/
-- 사원명, 급여
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT * 
FROM SAL_GRADE;

-- 사원명, 급여, 급여등급(SAL_LEVEL)
-- >> 오라클전용구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
-- >> ANSI구문 ( ON 구문만!!)
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);


---------------------------------------------------------------------------
--2/4
/*
        5. 자체 조인(SELF JOIN)
           같은 테이블을 다시 한번 조인하는 경우
           즉, 다시 자신의 테이블과 다시 조인을 맺는 경우
        
*/
SELECT EMP_ID "사원사번", EMP_NAME "사원명", SALARY "사원급여", MANAGER_ID "사수사번"
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE E;  -- 사원에 대한 정보 도출용  테이블          MANAGER_ID
SELECT * FROM EMPLOYEE M;  -- 사수에 대한 정보 도출용  테이블          EMP_ID          --> 사수명, 사수급여
-- 사원사번, 사원명, 사원부서코드, 사원급여
-- 사수사번, 사수명, 사수부서코드, 사수급여
-- >> 오라클전용구문
SELECT E.EMP_ID "사원사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원부서", E.SALARY "사원급여"
     , M.EMP_ID "사수사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수부서", M.SALARY "사수급여"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;
-- >> ANSI구문
SELECT E.EMP_ID "사원사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원부서", ED.DEPT_TITLE, E.SALARY "사원급여"
     , M.EMP_ID "사수사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수부서", MD.DEPT_TITLE, M.SALARY "사수급여"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
JOIN DEPARTMENT ED ON(E.DEPT_CODE = ED.DEPT_ID)
JOIN DEPARTMENT MD ON(M.DEPT_CODE = MD.DEPT_ID);


---------------------------------------------------------------------------

/*
        < 다중 JOIN >
        
*/
-- 사번, 사원명, 부서명, 직급명, 지역명(LOCAL_NAME)
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE

-- >> 오라클구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND E.JOB_CODE = J.JOB_CODE;
-- >> ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);
--> 다중 JOIN할때 순서 중요
  
-- 사원명, 부서명, 직급명, 근무지역명, 근무국가명, 급여등급
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                    JOB_CODE            SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE
SELECT * FROM JOB;          --                              JOB_CODE
SELECT * FROM NATIONAL;     --                              NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                  MIN_SAL,MAX_SAL

SELECT E.EMP_NAME "사원명"
     , D.DEPT_TITLE "부서명"
     , J.JOB_NAME "직급명"
     , L.LOCAL_NAME "근무지역명"
     , N.NATIONAL_NAME "근무국가명"
     , S.SAL_LEVEL "급여등급"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);



------------------------------- < JOIN 종합 실습 문제_2/4 > -------------------------------------

-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
-- >> 오라클구문
SELECT E.EMP_ID "사번", E.EMP_NAME "사원명", 
       J.JOB_NAME "직급명", D.DEPT_TITLE "부서명", 
       LOCAL_NAME "근무지역명", E.SALARY "급여"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE 
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND J.JOB_NAME = '대리'
  AND LOCAL_NAME LIKE 'ASIA%';
-->> ANSI구문
SELECT E.EMP_ID "사번", E.EMP_NAME "사원명", 
       J.JOB_NAME "직급명", D.DEPT_TITLE "부서명",
       LOCAL_NAME "근무지역명", E.SALARY "급여"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '대리'
  AND LOCAL_NAME LIKE 'ASIA%';


-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오
-- >> 오라클구문  
SELECT E.EMP_NAME "사원명", E.EMP_NO "주민번호",  D.DEPT_TITLE "부서명", J.JOB_NAME "직급명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE SUBSTR(E.EMP_NO, 1, 1) = '7'
  AND SUBSTR(E.EMP_NO, 8, 1) = '2'
  AND E.EMP_NAME LIKE '전%'
  AND E.JOB_CODE = J.JOB_CODE 
  AND E.DEPT_CODE = D.DEPT_ID;
-->> ANSI구문
SELECT E.EMP_NAME "사원명", E.EMP_NO "주민번호", D.DEPT_TITLE "부서명", J.JOB_NAME "직급명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(E.EMP_NO, 1, 1) = '7'
  AND SUBSTR(E.EMP_NO, 8, 1) = '2'
  AND E.EMP_NAME LIKE '전%';

-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오
-- >> 오라클구문 
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명
FROM EMPLOYEE E, JOB J
WHERE EMP_NAME LIKE '%형%'
  AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI구문
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명
FROM EMPLOYEE E 
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%형%';

-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
-- >> 오라클구문 
SELECT E.EMP_NAME 사원명, J.JOB_NAME 직급명, DEPT_CODE 부서코드, DEPT_TITLE 부서명
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_TITLE LIKE '해외영업%'
  AND E.DEPT_CODE = D.DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI구문
SELECT E.EMP_NAME 사원명, J.JOB_NAME 직급명, DEPT_CODE 부서코드, DEPT_TITLE 부서명
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID) 
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE DEPT_TITLE LIKE '해외영업%';

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
-- >> 오라클구문
SELECT E.EMP_NAME "사원명", E.BONUS "보너스", E.SALARY*12 "연봉",
       D.DEPT_TITLE "부서명", L.LOCAL_NAME "근무지역명"
FROM EMPLOYEE E , DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND E.BONUS IS NOT NULL;
-->> ANSI구문
SELECT E.EMP_NAME "사원명", E.BONUS "보너스", E.SALARY*12 "연봉",
       D.DEPT_TITLE "부서명", L.LOCAL_NAME "근무지역명"
FROM EMPLOYEE E  
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (L.LOCAL_CODE = D.LOCATION_ID)
WHERE E.BONUS IS NOT NULL;

-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
-- >> 오라클구문
SELECT E.EMP_NAME 사원명, J.JOB_NAME 직급명, D.DEPT_TITLE 부서명, L.LOCAL_NAME 근무지역명
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE  E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE;
-->> ANSI구문
SELECT E.EMP_NAME 사원명, J.JOB_NAME 직급명, D.DEPT_TITLE 부서명, L.LOCAL_NAME 근무지역명
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
-- >> 오라클구문
SELECT E.EMP_NAME 사원명, D.DEPT_TITLE 부서명, L.LOCAL_NAME 근무지역명, N.NATIONAL_NAME 근무국가명
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE N.NATIONAL_NAME IN ('한국', '일본')
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE;
-->> ANSI구문
SELECT E.EMP_NAME 사원명, D.DEPT_TITLE 부서명, L.LOCAL_NAME 근무지역명, N.NATIONAL_NAME 근무국가명
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('한국', '일본');

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오
-- >> 오라클구문
SELECT E.EMP_NAME 사원명, J.JOB_NAME 직급명, E.SALARY 급여
FROM EMPLOYEE E, JOB J
WHERE BONUS IS NULL
  AND J.JOB_CODE IN ('J4', 'J7')
  AND E.JOB_CODE = J.JOB_CODE;
-->> ANSI구문
SELECT E.EMP_NAME 사원명, J.JOB_NAME 직급명, E.SALARY 급여
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE BONUS IS NULL
  AND J.JOB_CODE IN ('J4', 'J7');

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.
-- >> 오라클구문
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명, S.SAL_LEVEL 급여등급
     , CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '고급'
            WHEN SAL_LEVEL IN ('S3','S4') THEN '중급'
            WHEN SAL_LEVEL IN ('S5','S6') THEN '초급'
      END "구분"
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE;
-->> ANSI구문
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명, S.SAL_LEVEL 급여등급
     , CASE WHEN SAL_LEVEL IN ('S1','S2') THEN '고급'
            WHEN SAL_LEVEL IN ('S3','S4') THEN '중급'
            WHEN SAL_LEVEL IN ('S5','S6') THEN '초급'
      END "구분"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오
-- >> 오라클구문
SELECT D.DEPT_TITLE 부서명, SUM(E.SALARY) 급여합
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000;

-->> ANSI구문
SELECT D.DEPT_TITLE 부서명, SUM(E.SALARY) 급여합
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000;

-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.
-- >> 오라클구문
SELECT DEPT_TITLE 부서명, FLOOR(AVG(SALARY)) 평균급여
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE;
-->> ANSI구문
SELECT DEPT_TITLE 부서명, FLOOR(AVG(SALARY)) 평균급여
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE;

