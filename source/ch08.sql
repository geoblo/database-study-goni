/*
8. 그룹화 분석하기
8.1 그룹화란
*/
-- 그룹화: 데이터를 특정 기준에 따라 나누는 것
-- 그룹화 분석: 그룹별 데이터를 요약하거나 분석하는 것
-- 예: 전체 학생의 평균 키도 의미가 있으나, 성별로 나누어 평균키를 구하면 조금 더 유의미한 정보를 얻음

-- 그룹화 분석 기초 실습
-- 학생의 키 데이터를 성별에 따라 나누어 분석해보기
-- group_analysis DB 생성 및 진입
CREATE DATABASE group_analysis;
USE group_analysis;

-- students 테이블 생성
CREATE TABLE students (
	id INTEGER AUTO_INCREMENT, 	-- 아이디(자동으로 1씩 증가)
	gender VARCHAR(10), 		-- 성별
	height DECIMAL(4, 1), 		-- 키
	PRIMARY KEY (id) 			-- 기본키 지정: id
);

-- students 데이터 삽입
INSERT INTO students (gender, height)
VALUES
	('male', 176.6),
	('female', 165.5),
	('female', 159.3),
	('male', 172.8),
	('female', 160.7),
	('female', 170.2),
	('male', 182.1);

-- 확인
SELECT * FROM students;

-- 전체 집계: 전체 학생의 평균 키 구하기
SELECT AVG(height)
FROM students;

-- 남학생의 평균
SELECT AVG(height)
FROM students
WHERE gender = 'male';

-- 여학생의 평균
SELECT AVG(height)
FROM students
WHERE gender = 'female';

-- 그룹화 분석: 각 성별 평균 키 구하기
SELECT 그룹화_컬럼, 집계_함수(일반_컬럼)
FROM 테이블명
WHERE 조건
GROUP BY 그룹화_컬럼;

SELECT gender, AVG(height)
FROM students
GROUP BY gender; -- 성별을 기준으로 그룹화하겠다.


-- 그룹화의 특징 3가지
-- 1) 집계 함수와 함께 사용해야 함
-- 그룹별 유의미한 분석을 얻기 위해서는 집계 함수 사용
-- 단순 GROUP BY 절만 사용하는 것은 데이터를 그룹으로 묶기만 함(의미 없음)
SELECT gender
FROM students
GROUP BY gender;

-- 2) 여러 컬럼으로 그룹화할 수 있다.
SELECT 그룹화_컬럼1, 그룹화_컬럼2, 집계_함수(일반_컬럼)
FROM 테이블명
WHERE 조건
GROUP BY 그룹화_컬럼1, 그룹화_컬럼2;

-- 예: 특정 도시의 연도별 총매출 집계
-- sales 테이블 생성
CREATE TABLE sales (
	id INTEGER AUTO_INCREMENT,  	-- 아이디(자동으로 1씩 증가)
	city VARCHAR(50) NOT NULL,   	-- 도시명
	sale_date DATE NOT NULL,      	-- 판매 날짜
	amount INTEGER NOT NULL,     	-- 판매 금액
	PRIMARY KEY (id)				-- 기본키 지정: id
);

-- sales 데이터 삽입
INSERT INTO sales (city, sale_date, amount) 
VALUES
	('Seoul', '2023-01-15', 1000),
	('Seoul', '2023-05-10', 2000),
	('Seoul', '2023-08-29', 2500),
	('Seoul', '2024-02-14', 4000),
	('Busan', '2023-03-05', 1500),
	('Busan', '2024-05-10', 1800),
	('Busan', '2024-07-20', 3000),
	('Incheon', '2023-11-25', 1200),
	('Incheon', '2024-03-19', 2200),
	('Incheon', '2024-09-12', 3300);

-- 확인
SELECT * FROM sales;

-- 특정 도시의 연도별 총매출 집계
-- 일단 먼저 특정 도시별 총매출 집계
SELECT city, SUM(amount)
FROM sales
GROUP BY city;

SELECT 
	city AS 도시, 
    YEAR(sale_date) AS '판매 연도', 
    SUM(amount) AS '총 매출' -- 3) 특정 도시의 연도별 총 매출 집계 조회
FROM sales -- 1) sales 테이블을
GROUP BY city, YEAR(sale_date); -- 2) 도시와 연도로 그룹화한 후

-- 3) SELECT 절에 올 수 있는 컬럼이 제한적이다.
-- 사용 가능한 컬럼:
-- - 그룹화 컬럼: GROUP BY 절에서 지정한 컬럼
-- - 집계된 컬럼: 집계 함수에 사용된 컬럼

-- 잘못된 컬럼 사용 예시
SELECT id, gender, AVG(height) -- id 컬럼 사용 못함
FROM students
GROUP BY gender;

-- 이렇게는 가능
SELECT SUM(id), gender, AVG(height)
FROM students
GROUP BY gender;

-- Quiz
-- 1. 다음 설명이 맞으면 O, 틀리면 X를 표시하시오.
-- ① 그룹화 분석이란 데이터를 특정 그룹으로 나누어 분석하는 것이다. (  )
-- ② GROUP BY 절에는 반드시 하나의 칼럼만 지정해야 한다. (  )
-- ③ 그룹화된 쿼리에서 SELECT 절에 포함된 칼럼은 GROUP BY 절에서 지정한 그룹화 칼럼이거나 집계 함수에 사용된 칼럼이어야 한다. (  )

-- 정답: 














































