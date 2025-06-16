/*
9. 서브쿼리 활용하기
9.1 서브쿼리란
*/
-- 서브쿼리: 쿼리 안에 포함된 또 다른 쿼리
-- 안쪽 서브쿼리의 실행 결과를 받아 바깥쪽 메인쿼리가 실행됨

-- 서브쿼리 예: 다음 학생 중 성적이 평균보다 높은 학생은?
-- students
-- ----------------------
-- id  | name    | score
-- ----------------------
-- 1   | 엘리스    | 85
-- 2   | 밥       | 78
-- 3   | 찰리     | 92
-- 4   | 데이브    | 65
-- 5   | 이브     | 88

-- sub_query DB 생성 및 진입
CREATE DATABASE sub_query;
USE sub_query;

-- students 테이블 생성
CREATE TABLE students (
	id INTEGER AUTO_INCREMENT, 	-- 아이디(자동으로 1씩 증가)
	name VARCHAR(30), 			-- 이름
	score INTEGER, 				-- 성적
	PRIMARY KEY (id) 			-- 기본키 지정: id
);

-- students 데이터 삽입
INSERT INTO students (name, score)
VALUES
	('엘리스', 85),
	('밥', 78),
	('찰리', 92),
	('데이브', 65),
	('이브', 88);






















































