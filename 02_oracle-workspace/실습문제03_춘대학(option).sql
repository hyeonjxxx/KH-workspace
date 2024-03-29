-- 21.02.14 실습문제


-- 1.
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY 1;


-- 2.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC; 


-- 3. 
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS AS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '99%'
  AND (STUDENT_ADDRESS LIKE '강원%' OR STUDENT_ADDRESS LIKE '경기%')
ORDER BY 1;


-- 4. 
--ANSI
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY 2;
--ORCLE
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D 
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = '법학과'
ORDER BY 2;


-- 5. 
SELECT STUDENT_NO, TO_CHAR(POINT,'99.99') "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402'
  AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;


-- 6.
--ANSI
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);
--ORACLE
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO =  D.DEPARTMENT_NO;


-- 7.
--ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);
--ORCLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO =  D.DEPARTMENT_NO;


-- 8.@@
--ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);
--ORCLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P 
WHERE C.CLASS_NO = CP.CLASS_NO
  AND CP.PROFESSOR_NO = P.PROFESSOR_NO;

-- 9.
--ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';
--ORCLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
  AND CP.PROFESSOR_NO = P.PROFESSOR_NO
  AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND CATEGORY = '인문사회';

-- 10.
--ANSI
SELECT STUDENT_NO "학번",  STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1)  "전체 평점"
FROM TB_GRADE
JOIN TB_STUDENT S USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;
--ORACLE
SELECT S.STUDENT_NO "학번", STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_GRADE G, TB_STUDENT S, TB_DEPARTMENT D 
WHERE G.STUDENT_NO = S.STUDENT_NO
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME='음악학과'
GROUP BY S.STUDENT_NO, STUDENT_NAME
ORDER BY 1;


-- 11.
SELECT * FROM TB_STUDENT; -- 학생이름 
SELECT * FROM TB_DEPARTMENT; --학과이름 
SELECT * FROM TB_PROFESSOR; -- 지도교수이름 
--ANSI
SELECT DEPARTMENT_NAME "학과이름", STUDENT_NAME "학생이름", PROFESSOR_NAME "지도교수이름"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.STUDENT_NO = 'A313047';
--ORACLE
SELECT DEPARTMENT_NAME "학과이름", STUDENT_NAME "학생이름", PROFESSOR_NAME "지도교수이름"
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P 
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
  AND S.STUDENT_NO = 'A313047';


-- 12.
--ANSI
SELECT DISTINCT STUDENT_NAME, TERM_NO
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE TERM_NO LIKE '2007%'
  AND CLASS_NAME = '인간관계론';

--ORACLE


-- 13.
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_CLASS;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB
WHERE CATEGORY = '예체능';

-- 14. 

-- 15.

-- 16. 



















