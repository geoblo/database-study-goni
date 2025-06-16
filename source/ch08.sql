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




