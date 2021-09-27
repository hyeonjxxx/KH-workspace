/*
--2/10

    < DML : DATA MANIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입(INSERT)하거나 기존의 데이터를 수정(UPDATE)하거나 삭제(DELETE)하는 구문

*/


/*
    1. INSERT : 테이블에 새로운 행을 추가하는 구문
    
    [표현식]
    1) INSERT INTO 테이블명 VALUES(값, 값, 값, ...);
    해당 테이블에 모든 컬럼에 추가하고자 하는 값을 내가 직접 제시해서 한 행 INSERT하고자 할때 사용
    
    주의할점 : 컴럼 순번을 지켜서 VALUES에 값을 나열해야됨!
    
*/

INSERT INTO EMPLOYEE
VALUES(900, '장채현', '980914-2456744', 'jang_ch@kh.or.kr', '01011112222',
       'D1', 'J7', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
       
SELECT * FROM EMPLOYEE;       
/*
    2) INSERT INTO 테이블명 (컬럼명, 컬럼명, 컬럼명 ) VALUES(값, 값, 값);
    해당 테이블에 특정 컬럼만 선택해서 그 컬럼에 추가할 값만 제시하고자 할때 사용 
    
   그래도 한 행 단위로 추가되기 때문에 선택안된 컬럼은 기본적으로 NULL값이 들어감
   (단, 기본값(DEFAULT)이 지정되어있다면 기본값이 들어감)
    
    주의할점 : NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시해야됨!
            아무리 NOT NULL 제약조건이 걸려있는 컬럼이라고 해도 기본값이 지정되어 있는 컬럼은 선택안해도 됨
    
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(901, '강람보', '801231-2345789', 'D1', 'J2', SYSDATE);

SELECT * FROM EMPLOYEE; 


/*
    3) INSERT INTO 테이블명 (서브쿼리);
       VALUES로 값을 기입하는 거 대신에 서브쿼리로 조회한 결과값을 통째로 INSERT하는 구문
       (여러행 INSERT 시킬수 있다)
*/


-- 새로운 테이블 먼저 만들자!!
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- 전체 사원(부서배치가 안된 사원들 포함)들의 사번, 이름 , 부서명을 조회한 결과를 EMP_01 테이블에 통째로 추가!
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
       두개 이상의 테이블에 각각 INSERT 할 때 사용
       그때 사용되는 서브쿼리가 동일할 경우

*/

-->> 우선 테이블 만들기!!

-->> 첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명에 대해 보관할 테이블
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    JOB_NAME VARCHAR2(20)
);

-->> 두번째 테이블 : 급여가 300만원 이상인 사원들의  사번, 사원명, 부서명에 대해 보관할 테이블
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
); 

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

--  급여가 300만원 이상인 사원들의 사번, 이름, 직급명, 부서명 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;

/*
    1)
      INSERT ALL
      INTO 테이블명1 VALUES(컬럼명, 컬럼명,...)
      INTO 테이블명2 VALUES(컬럼명, 컬럼명,...)
            서브쿼리;


*/

-- EMP_JOB 테이블에  급여가 300만원 이상인 사원들의  EMP_ID, EMP_NAME, JOB_NAME 을 삽입
-- EMP_DEPT 테이블에  급여가 300만원 이상인 사원들의  EMP_ID, EMP_NAME, DEPT_TITLE 을 삽입

INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE SALARY >= 3000000;

-- INSERT ALL 조건을 사용해도 각 테이블에 값 INSERT 가능

-- 사번, 사원명, 입사일, 급여 (EMP_ODL) => 2000년도 이전 입사한 사원
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
-- 사번, 사원명, 입사일, 급여 (EMP_NEW) => 2000년도 이후 입사한 사원
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1=0;
   
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE <'2000/01/01'; --> 2000년더 이전 입사자 8명 (EMP_ODL)
WHERE HIRE_DATE >='2000/01/01'; --> 2000년더 이후 입사자 17명 (EMP_NEW)

/*
    2) 
      INSERT ALL
      WHEN 조건1 THEN
        INTO 테이블명1  VALUES(컬럼명, 컬럼명, 컬럼명, ...)
      WHEN 조건2 THEN  
        INTO 테이블명2  VALUES(컬럼명, 컬럼명, 컬럼명, ...)        
      서브쿼리

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
       테이블에 기록된 기본의 데이터를 수정하는 구문
       
       [표현식]
       UPDATE 테이블명
       SET 컬럼명 = 바꿀값
         , 컬럼명 = 바꿀값
         , ...             => 여러개의 컬럼값 동시변경 가능(, 로 나열해야됨!! AND 아님!!!)
       [WHERE 조건];        => 생략하면 전체 모든 행의 데이터가 다 변경되버림!!
   
*/

-- 복사본 테이블만든 후 작업
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에 D9부서의 부서명을 전략기획팀 으로 수정하고자 함

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'; --> 조건을 제시하지 않아 전체 행의 모든 DEPT_TITLE값이 다 '전략기획팀'으로 변경되버림!!

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';  --> DEPT_ID가 D9인 부서만 찾아서 변경하겠다

-- 복사본 테이블
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;

-- EMP_SALARY 테이블에 노옹철 사원듸 급여를 1000만원으로 변경
UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '노옹철';

-- EMP_SALARY 테이블에 선동일 사원의 급여를 700만원, 보너스를 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = 7000000
  , BONUS = 0.2
WHERE EMP_NAME = '선동일';

-- 전체사원 급여를 기존의 급여에 20% 인상한 금액으로 변경 (기존급여*1.2)
UPDATE EMP_SALARY
SET SALARY = SALARY*1.2;


/*
    * UPDATE 시에 서브쿼리를 사용
      
      UPDATE 테이블명
      SET 컬럼명 = (서브쿼리)
      [WHERE 조건];

*/

-- EMP_SALARY 테이블에 강람보 사원의 부서코드를 선동일사원의 부서코드로 변경
UPDATE EMP_SALARY 
SET DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '선동일')
WHERE EMP_NAME = '강람보';

-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스값으로 변경
UPDATE EMP_SALARY 
SET ( SALARY, BONUS) = (SELECT SALARY, BONUS
                FROM EMP_SALARY
                WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

--------------------------------------------------------------------------------

-- UPDATE시에도 변경할 값에 있어서 해당 컬럼에 대한 제약조건에 위배되면 안됨!

-- 노옹철 사원의 부서코드를 D0으로 변경
UPDATE EMPLOYEE
SET DEPT_CODE = 'D0'
WHERE EMP_NAME = '노옹철'; --> 외래키 제약조건에 위배

-- 사번이 200번인 사원의 이름을 NULL로 변경
UPDATE EMPLOYEE
SET EMP_NAME = NULL
WHERE EMP_ID = 200;  --> NOT NULL 제약조건에 위배

COMMIT;  --> 모든 변경사항들을 확정시키겠다. 픽스하겠따.

--------------------------------------------------------------------------------


/*
    4. DELETE
       테이블에 기록된 데이터를 삭제하는 구문
    
       [표현식]
       DELETE FROM 테이블명
       [WHERE 조건];  --> WHERE절 생략시 해당 테이블의 전체 행 삭제   
*/
DELETE FROM EMPLOYEE;
ROLLBACK; --> 마지막 커밋시점으로 돌아간다!

-- 장채현 강람보 사원 데이터 지우기
DELETE FROM EMPLOYEE
WHERE EMP_NAME IN ('장채현', '강람보');

SELECT * FROM EMPLOYEE;

COMMIT;

-- DEPAERTMENT 테이블로부터 DEPT_ID가 D1인 부서 삭제
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D1';
--> 삭제안됨(D1을 가져다 쓰고 있는 자식데이터가 있기 때문에)

-- DEPAERTMENT 테이블로부터 DEPT_ID가 D3인 부서 삭제
DELETE FROM DEPARTMENT 
WHERE DEPT_ID = 'D3';
--> 삭제안됨(D3을 가져다 쓰고 있는 자식데이터가 없기 때문에)

ROLLBACK;

/*
    * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용하는 구문 (절삭)
                 DELETE 보다 수행속도가 더 빠름
                 별도의 조건 제시 불가, ROLLBACK이 불가함!!
     [표현식]
     TRAUNCATE TABLE 테이블명;       |    DELETE FROM 테이블명;
     ===================================================================
       별도 조건 제시 불가             |     특정 조건 제시 가능
         수행속도 빠름                |        수행속도 느림
         ROLLBACK 불가              |        ROLLBACK 가능
*/
SELECT * FROM DEMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;

ROLLBACK;






















