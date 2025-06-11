/*
4. 데이터 집계하기
4.1 집계 함수(Aggregate Function)란
*/
-- 무엇? 통계적 계산을 간편하게 수행하도록 돕는 기능
-- 종류: MAX(), MIN(), COUNT(), SUM(), AVG()

-- 데이터를 가져와서 개발 코드에서 반복문을 돌면서 직접 계산하는 것이 아니라
-- 데이터를 가져올 때 부터 계산된 값을 가져올 수 있음
-- 사용 예
-- MAX(): 특정 컬럼의 가장 큰 값(최대값) 반환
-- MIN(): 특정 컬럼의 가장 작은 값(최소값) 반환
-- COUNT(): 레코드(튜플)의 개수 반환(예: 학생 테이블에 총 학생이 몇 명이 있는 셀 때)
-- SUM(): 합계 반환(예: 장바구니에 담긴 모든 아이템들의 가격 총합을 계산할 때)
-- AVG(): 평균 반환(예: 학생들의 수학 점수의 평균을 구할 때)

-- 실습 데이터 준비
-- 3장에서 연습한 맵도날드 DB를 활용
USE mapdonalds;

-- 가장 비싼 버거와 가장 싼 버거의 가격?
-- 최대값, 최소값
-- MAX(), MIN()
SELECT MAX(price), MIN(price)
FROM burgers;

-- (참고)
SELECT *, MAX(price), MIN(price)
FROM burgers;
-- 이 둘은 동시에 쓸 수 없음, 왜냐하면 집계는 그룹 단위 연산이고 *는 행 단위 열람이기 때문
-- 집계 함수를 다른 일반 컬럼들과 함께 사용할 때는 GROUP BY가 필요

-- 무게가 240g을 초과하는 버거의 개수?
-- 레코드(튜플)의 개수 세기
-- COUNT()
SELECT *
FROM burgers
WHERE gram > 240;

SELECT COUNT(*)
FROM burgers
WHERE gram > 240;

-- 주의
-- COUNT() 함수는 입력에 따라 다른 결과를 만듦
-- COUNT(*): 전체 레코드의 수를 반환
-- COUNT(컬럼): 해당 컬럼이 null이 아닌 레코드의 수

-- COUNT() 테스트
-- employees 테이블 생성
CREATE TABLE employees (
	id INTEGER,              -- 아이디(정수형 숫자)
	name VARCHAR(50),        -- 직원명(문자형: 최대 50자)
	department VARCHAR(200), -- 소속 부서(문자형: 최대 200자)
	PRIMARY KEY (id)         -- 기본키 지정: id
);

DESC employees;

-- employees 데이터 삽입
INSERT INTO employees (id, name, department)
VALUES
	(1, 'Alice', 'Sales'),
	(2, 'Bob', 'Marketing'),
	(3, 'Carol', NULL),
	(4, 'Dave', 'Marketing'),
	(5, 'Joseph', 'Sales');

-- 잘 들어갔는지 일단 확인
SELECT * FROM employees;







