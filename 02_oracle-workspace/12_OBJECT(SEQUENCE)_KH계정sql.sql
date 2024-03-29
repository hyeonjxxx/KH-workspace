/* 
    < 시퀀스 SEQUENCE >
    자동으로 번호 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 생성해줌

    EX) 회원번호, 사번, 게시글 번호 등등 채번 할때 주로 사용할 예정
    
    1. 시퀀스 객체 생성 구문
    
    [표현법]
    CREATE SEQUENCE 시퀀스명
    [START WITH 시작숫자]          --> 처음 발생시킬 시작값 지정
    [INCREMENET BY 증가값]         --> 몇 씩 증가시킬건지 지정
    [MAXVALUE 최대값]              --> 최대값 지정
    [MINVALUE 최소값]              --> 최소값 지정
    [CYCLE|NOCYCLE]               --> 값 순환 여부 지정
    [CACHE 바이트 크기|NOCACHE]    --> 캐시메모리 여부 지정
    
    * 캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
                 매번 호출할때 마다 새로이 번호를 생성하는 것 보다
                 캐시메모리 공간에 미리 생성된 값들을 가져다가 쓰게 된며 훨씬 속도가 빠름
                 단, 접속이 끊기고나서 재접속 후 기존에 생성되었던 값들은 날라가고 없음
    
*/

/*
    테이블명 : TB_
    뷰명 : VW_
    시퀀스명 : SEQ_
    트리거명 : TRG_

*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;   --> 이 계정이 소유하고 있는 시퀀스들에 대한 정보 조회용 (데이터 딕셔너리)
-- USER_TABLES, USER_VIEWS

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;


------------------------------------------------------------------------------
/*
    2. 시퀀스 사용 구문
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값 (마지막으로 성공적으로 발생된 NEXTVAL 값)
    시퀀스명.NEXTVAL : 시퀀스를 증가시키고 증가된 시퀀스의 값
                      기본시퀀스 값에서 INCREMENT BY 값 만큼 증가된 값
                      == 시퀀스명.CURRVAL + INCREMENT BY 값
                      
                      => 단, 시퀀스 생성 후 첫 NEXTVAL는 START WITH로 지정된 시작값으로 발생
*/


SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL을 한번이라도 수행하지 않은 이상 CURRVAL를 수행할 수 없음!!
--> 왜?  :  CURRVAL은 마지막에 성공적으로 수행된 NEXTVAL의 값을 저장해서 보여주는 임시값

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 305

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  --> 310


/*
    3. 시퀀스 변경   
    
    [표현법]
    ALTER SEQUENCE 시퀀스명
    CREATE SEQUENCE 시퀀스명
    [START WITH 시작숫자]          --> 처음 발생시킬 시작값 지정
    [INCREMENET BY 증가값]         --> 몇 씩 증가시킬건지 지정
    [MAXVALUE 최대값]              --> 최대값 지정
    [MINVALUE 최소값]              --> 최소값 지정
    [CYCLE|NOCYCLE]               --> 값 순환 여부 지정
    [CACHE 바이트 크기|NOCACHE]    --> 캐시메모리 여부 지정
    
    ** START WITH는 변경불가! => 정 바꾸고 싶다면 삭제했다가 다시 생성
    

*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --> 320

-- SEQUENCE 삭제
DROP SEQUENCE SEQ_EMPNO;

---------------------------------------------------------------------------------

-- 매번 새로운 사번
CREATE SEQUENCE SEQ_EID
START WITH 300;

-- 사원추가될 실행항 INSERT문
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길동', '111111-1111111', 'J2', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO,JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길녀', '222222-2222222', 'J3', SYSDATE);

ROLLBACK;

-- 사원에 대한 추가 "요청"시 실행할 SQL문
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
         , 사용자가입력한값
         , 사용자가입력한값
         , 사용자가입력한값
         , SYSDATE 
        );




























