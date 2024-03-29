/*
    * DDL(DATE DEFINITION LANGUAGE) : 데이터 정의 언어
     
     오라클에서 제공하는 객체(OBJECT)를 
     새로이 만들고(CREATE), 구조를 변경(ALTER)하고, 구조 자체를 삭제(DROP)하는
     즉, 구조 자체를 정의하는 언어로 주로

    오라클에서 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
                        인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                        프로시져(PROCEURE), 함수(FUNCTION)
                        동의어(SYNONYM), 사용자(USER)
*/
/*
    < CREATE TABLE >
    
    * 테이블이란: 행(ROW)과 열(COULUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                모든 데이터는 테이블을 통해 저장됨 (== 데이터를 보관하고자 한다면 테이블을 만들어야됨)
                
                
    * 표현식 
      CREATE TABLE 테이블명 (
          컬럼명, 자료형,
          컬럼명, 자료형,
          컬럼명, 자료형,
          ...
      );

    * 자료형
      - 문자 (CHAR(크기) / VARCHAR2(크기))
        > CHAR(바이트수) : 최대 2000BYTE까지 지정가능 / 고정길이 (아무리 적은 값이 들어와도 처음 할당한 크기 유지, 공백으로채워서)
        > VARCHAR2(바이트수) : 최대 4000BYTE까지 지정가능 / 가변길이 (적은 값이 그 담긴 값에 맞춰 크기가 줄어듦)
      
      - 숫자 (NUMBER)
      
      - 날짜 (DATE)
    
*/
-->> 회원들의 데이터(아이디,비밀번호, 이름, 회원가입일)를 담기위한 테이블 MEMBER 테이블 생성하기
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAEM VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

/*
    * 컬럼에 주석 달기
     COMMENT ON COLUMN 컬럼명 IS '주석내용';


*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAEM IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';


-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- USER TABLES : 현재 이 계저잉 가지고 있느 테이블들의 전반적이 구조를 확인할 수 있는 데이터 딕셔너리
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 계정이 가지고 있는 테이블의 모든 컬럼의 정보를 조회할 수 있는 데이터 딕셔너리

SELECT * FROM MEMBER;


-- 데이터 추가할 수 있는 구문 (INSERT == 한 행으로 추가)
-- INSERT INTO 테이블명 VALUES(값, 값, 값, 값, ...);
INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동','2021-02-01');
INSERT INTO MEMBER VALUES('user02', 'pass02', '김말동','21/02/02');
INSERT INTO MEMBER VALUES('user03', 'pass03', '강개순',SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, SYSDATE);    --> 아이디 비번,이름에 NULL이 존재하면 안됨
INSERT INTO MEMBER VALUES('user03', 'pass03', '김개동',SYSDATE);   --> 중복된 아이디 존재하면 안됨

---------------------------------------------------------------------

/*
    < 제약조건 CONSTRACTINS >
     - 원하는 데이터값만 유지하기 위해서 (보관하기 위해서) 특정 컬럼마다 설정하는 제약 (데이터 무결정 보장을 목적으로)
     - 제약조건이 부여된 컬럼에 들어올 데이터에 문제가 없는지 자동으로 검사할 목적
     
     * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
     
     * 컬럼에 제약 조건을 부여하는 방식 : 컬럼레벨 / 테이블레벨
     
*/

/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 존재해야할 경우 (NULL값이 절대 들어와서는 안되는 컬럼에 부여)
      삽입/ 수정시 NULL값을 허용하지 않도록 제한
      
      단, NOT NULL 제약조건은 컬럼레벨 방식 방식 밖에 안됨!
      
*/

-- NOT NULL 제약조건만 설정한 테이블 만들기
-- 컬럼레벨 방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자하는 컬럼 뒤에 곧바로 기술
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDRT CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL
VALUES(1,'user01',' pass01', '김말똥', '남', '010-1234-5678', 'aaa@naver.com');

INSERT INTO MEM_NOTNULL
VALUES(2,NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL 제약조건에 위배되어 오류 발생

INSERT INTO MEM_NOTNULL
VALUES(2,'user02', 'pass02', '홍길동', NULL, NULL, NULL);
--> NOT NULL 제약조건이 부여되어 있는 컬럼에는 반드시 값이 존재해야됨

INSERT INTO MEM_NOTNULL
VALUES(1,'user01',' pass01', '강개순', '여', NULL, NULL);


--2/9--------------------------------------------------------------------------
/*
    * UNIQUE 제약조건
      컬럼에 중복값을 제한하는 제약조건
      삽입/ 수정시 기존에 해당 컬럼값 중에 중복값이 있을 경우 추가또는 수정이 안되게끔
      
      컬럼레벨 / 테이블레벨 방식 둘 다 가능
      
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL /*UNIQUE*/,    --> 컬럼레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDRT CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);
    
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL , 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDRT CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE (MEM_ID)     --> 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01' ,'pass01', '홍길동', '남', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_UNIQUE VALUES(1, 'user02' ,'pass02', '김말동', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user02' ,'pass03', '강개순', '남', NULL, NULL, NULL);
--> UNIQUE 제약조건에 위배되었으므로 INSERT 실패!
--> 오류구문으로 제약조건명으로 알려줌 (어떤 컬럼에 문제가 있는지 컬럼명으로 알려주지 않음) => 쉽게 파악하기 어려움
--> 제약조건 부여시 직접 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명  부여해줌 SYS_C~~~

SELECT * FROM MEM_UNIQUE;


/*
    > 컬럼레벨 방식
    CREATE TABLE 테이블명(
    컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건,
    컬럼명 제약조건,
    컬럼명 제약조건,
    ...
    );


    > 테이블레벨 방식
    CREATE TABLE 테이블명(
    컬럼명 자료형 제약조건,
    컬럼명 제약조건,
    컬럼명 제약조건,
    ...,
    [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
    );

*/

CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL , 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NN NOT NULL,
    GENDRT CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UQ UNIQUE (MEM_ID)     --> 테이블 레벨 방식
);

INSERT INTO MEM_CON_NM VALUES(1, 'user01' ,'pass01', '홍길동', '남', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_CON_NM  VALUES(2, 'user02' ,'pass02', '김말동', '가', NULL, NULL);
--> 성별에 해당하는 컬럼에 '남' 또는 '여'만이 들어가야만하는데 그 외의 문구가 들어가버림

SELECT * FROM MEM_CON_NM;


--------------------------------------------------------------------------------

/*
    * CHECK 제약조건
      컬럼에 기록될 수 있는 값에 대한 조건을 설정을 해 둘 수 있음!
      
      CHECK (조건식)

*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_FWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
    );

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', NULL, SYSDATE);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '김말동', NULL, '010-1111-2222', NULL, SYSDATE);
--> NULL값도 INSERT가 가능함!! (만일 NULL값을 못들어오게 하려면 NOT NULL도 같이 부여하면 됨)

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(3, 'user03', 'pass03', '강개순', '가', NULL, NULL, SYSDATE);

SELECT * FROM MEM_CHECK;

-------------------------------------------------------------------------------

/*
        
    >> 특정 컬럼에 들어올 값에 대한 기본값 설정 가능  => 제약조건이 아님!!
       컬럼명 자료형 DEFAULT 기본값

*/
DROP TABLE MEM_CHECK;
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL
);

INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES(1, 'user01', 'pass01', '강개똥');
--> 지정된 컬럼에는 기본적으로 null값이 들어가지만 만일 default값이 부여되어 있다면 null값이 아닌 default값으로 들어감!!

SELECT * FROM MEM_CHECK;

-------------------------------------------------------------------------------

/*

    * PRIMARY KEY (기본키) 제약조건
    테이블에서 각 행들의 정보를 ㅇ일하게 식별할 수 있는 컬럼에 부여하는 제약조건
    -> 각 행들을 구분할수 있는 식별자의 역할(EX. 회원번호, 주문번호, 사번, 학번, 예약번호, ...)
    -> 중복되지 않고 값이 존재해야만 하는 컬럼에 PRIMARY KEY 부여 (NOT NULL + UNIQUE)
    
    단, 한 테이블당 한 개만 설정 가능
*/

CREATE TABLE MEM_PRIMARYKEY1(
 MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, -- 컬럼레벨방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    --, CONSTRAINT MEM_PK PRIMARY KEY(MEM_NO)  -- 테이블레벨방식
);

INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user01', 'pass01', '홍길동', '남', NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY1;

INSERT INTO MEM_PRIMARYKEY1
VALUES(1, 'user02', 'pass02', '이순신', NULL, NULL, NULL);
--> 기본키 컬럼에 중복으로 인한 오류

INSERT INTO MEM_PRIMARYKEY1
VALUES(NULL, 'user02', 'pass02', '이순신', NULL, NULL, NULL);
--> 기본키 컬럼에 NULL값으로 인한 오류

INSERT INTO MEM_PRIMARYKEY1
VALUES(2, 'user02', 'pass02', '이순신', NULL, NULL, NULL);

SELECT * FROM MEM_PRIMARYKEY1;

CREATE TABLE MEM_PRIMARYKEY2(
 MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 컬럼을 묶어서 PRIMARY KEY 하나로 설정하는 건 가능 --> 복합키
);
INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '김말동', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user02', 'pass03', '이순신', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(3, 'NULL', 'pass04', '신사임당', NULL, NULL, NULL);
--> 

SELECT * FROM MEM_PRIMARYKEY2;


--------------------------------------------------------------------------------


-- 회원 등급에 대한 데이터(등급코드, 등급명) 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEM_GRADE VALUES('G1', '일반회원');
INSERT INTO MEM_GRADE VALUES('G2', '우수회원');
INSERT INTO MEM_GRADE VALUES('G3', '특별회원');

SELECT * FROM MEM_GRADE;

/*
    * FOREIGN KEY(외래키) 제약조건
      해당 컬럼에 다름 테이블에 존재하는 값만 들어와야되는 컬럼에 부여하는 제약조건
      --> 다른 테이블을 참조한다고 표현
          즉, 참조된 다른 테이블이 제공하고 있는 값만 들어올 수 있다.
      --> FOREIGN KEY 제약조건으로 다른 테이블 간의 관계를 형성할 수 있음    
      
      > 컬럼레벨방식
        컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(참조할컬럼명)]
      
      > 테이블레벨방식
       [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할컬럼명)]
       
       (참조할컬럼명) 생략시 기본적으로 참조할테이블명의 기본키 컬럼명으로 세팅
*/
-- 자식테이블
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE), -- 컬럼레벨방식
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(30)
    -- ,FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- 테이블레벨방식
);    

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', ' 홍길동', 'G1', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', ' 김말동', 'G2', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', ' 강개순', 'G1', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', ' 강개순', NULL, NULL, NULL,NULL);
--> 외래키 제약조건이 걸려있는 컬럼에는 기본적으로 NULL값들어갈수 있음

INSERT INTO MEM
VALUES(5, 'user05', 'pass05', ' 이순신', 'G4', NULL, NULL,NULL);
--> parent key not found 오류발생
--> G4 등급은 MEM_GRADE 테이블의 GEADE_CODE 컬럼에서 제공하는 값이 아니다 

SELECT * FROM MEM;

--> 문제! 부모테이블(MEM_GRADE)에서 데이터값이 삭제된다면?

-- MEM_GRADE 테이블로부터 GRADE_CODE가 G1인 데이터 지우기
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--> 자식테이블(MEM) 중애 G1을 사용하고 있기 때문에 삭제할 수 없음!
--> 현재 외래키 제약조건 부여시 별도의 삭제옵션을 부여 안했음!
--> 자식테이블에서 사용하고 있는 값이 있을 경우 삭제가 안되는 "삭제제한옵션"이 걸려있음

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';

ROLLBACK;

DROP TABLE MEM;
-------------------------------------------------------------------------------

/*
    * 자식테이블 생성시 *(외래키 제약조건 부여시)
      부모테이블 데이터가 삭제됐을 때 자식테이블에는 어떻게 처리할지 옵션으로 지정할수 있음
      
      * FOREIGN KEY 삭제 옵션
        삭제 옵션을 별도로 제시하지 않으면  ON DELETE RESTRICTED(삭제 제한)으로 기본적으로 지정
*/
-- 1)ON DELETE WET NULL : 부모데이터 삭제시 해당 데이터를 사용하고 있는 자식데이터를 NULL로 변경시킴
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2), 
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(30),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);    

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', ' 홍길동', 'G1', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', ' 김말동', 'G2', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', ' 강개순', 'G1', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', ' 강개순', NULL, NULL, NULL,NULL);

-- 부모테이블(MEM_GRADE)의 GRADE_CODE가 G1인 데이터 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--> 문제없이 잘 삭제됨! (단 G1을 쓰고 있던 자식데이터 값들은 모두 NULL로 변경)

ROLLBACK;

DROP TABLE MEM;

--2) ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고있는 자식데이터도 같이 삭제해버림 
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2), 
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(30),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);    

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', ' 홍길동', 'G1', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', ' 김말동', 'G2', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', ' 강개순', 'G1', NULL, NULL,NULL);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', ' 강개순', NULL, NULL, NULL,NULL);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- 문제없이 잘 삭제됨
-- 단, 해당 부모데이털르 사용하고 있떤 자식데이처가 같이 DELETE가 됨

-- 전체 회원의 회원번호, 아이디, 비밀번호, 이름, 등급명 조회
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE GRADE_ID = GRADE_CODE(+);

SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM
LEFT JOIN MEM_GRADE ON(GRADE_CODE = GRADE_ID);


/*

    ** 굳이 외래키 제약조건이 걸려있지 않더라도 JOIN이 가능함!
       다만 두 컬럼에 동일한 의미의 데이터만 담겨있다면 매칭후 JOIN해서 조회 가능함!!

*/

---------------------------------------------------------------------------------
          

/*

                ---------- 여기서부터 실행은 KH계정에서!! -----------
 
    * SUBQUERY를 이용한 테이블 생성 (테이블 복사 뜨는 개념)               
                
   메인 SQL문(SELECT, CREATE, INSERT, UPDATE, ...)을 보조역할 하는 쿼리문 == 서브쿼리
   
   [표현식]
   CREATE TABLE 테이블명
   AS 서브쿼리;
   
   --> 해당 서브쿼리를 수행한 결과로 새로이 테이블을 생성하는 개념!
   
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성(EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS SELECT * 
   FROM EMPLOYEE;
--> 컬럼들, 조회결과의 데이터값들, 제약조건 같은 경우 NOT NULL만 복사됨!

SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE 테이블에 있는 컬럼의 구조만 복사하고 싶음!! 데이터값은 필요 없음
CREATE TABLE EMPLOYEE_COPY2
AS SELECT * 
   FROM EMPLOYEE
   WHERE 1=0;

SELECT * FROM EMPLOYEE_COPY2;

-- 전체사원들 중 급여가 300만원 이상인 사원들의 사번, 이름, 부서코드, 급여 컬럼 복제
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID 사번, EMP_NAME, DEPT_CODE SALARY
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;

SELECT * FROM EMPLOYEE_COPY3;

-- 전체사원의 사번, 사원명, 급여, 연봉 조회 결과 테이블 생성
CREATE TABLE EMPLOYEE_COPY4
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 연봉
   FROM EMPLOYEE;
--> 서브쿼리의 SELECT절 산술연산 또는 함수식이 기술된 경우 반드시 별칭부여해야됨!

SELECT * FROM EMPLOYEE_COPY4;


-------------------------------------------------------------------------------

/*
    * 테이블 다 생성된 후 뒤늦게 제약조건 추가 (ALTER TABLE 테이블명 XXXXXXX)
    
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블며 [(참조할컬럼명)];
    - UNIQUE : ADD UNIQUE(컬럼명);
    - CHECK : ADD CHECK(컬럼에대한조건);
    - NOT NULL : MODIFY 컬럼명 NOT NULL;

*/
-- EMPLOYEE_COPY 테이블에 없는 PRIMARY KEY 제약조건 추가 EMP_ID컬럼에
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE 테이브레 DEPT_CODE컬럼에 외래키 제약조건 추가 (DEPARTMENT의 DEPT_ID를 참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

-- EMPLOYEE 테이블에 JOB_CODE컬럼에 외래키 제약조건 추가 (JOB의 JOB_CODE를 참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);

-- DEPARTMENT 테이블에 LOCATION_ID에 외래키 제약조건 추가 (LOCATION의 LOCAL_CODE를 참조)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);










































