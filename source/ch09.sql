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
    
-- 확인
SELECT * FROM students;

-- 평균 점수보다 더 높은 점수를 받은 학생 조회
SELECT *
FROM students
WHERE score > (평균_점수); -- () 괄호 안이 서브쿼리로 작성할 부분

-- 평균 점수 계산
SELECT AVG(score)
FROM students;

-- 위 쿼리를 서브쿼리로 사용
-- 메인쿼리
SELECT *
FROM students
WHERE score > (
	-- 서브쿼리: 평균 점수 계산
	SELECT AVG(score)
	FROM students
);

-- 서브쿼리의 특징 5가지
-- 1) 중첩 구조
-- 메인쿼리 내부에 중첩하여 작성
SELECT 컬럼명1, 컬럼명2, ...
FROM 테이블명
WHERE 컬럼명 연산자 (
	서브쿼리
);

-- 2) 메인쿼리와는 독립적으로 실행됨
-- 서브쿼리 우선 실행 후
-- 그 결과를 받아 메인쿼리가 수행됨

-- 3) 다양한 위치에서 사용 가능
-- SELECT
-- FROM/JOIN
-- WHERE/HAVING 등

-- 4) 단일 값 또는 다중 값을 반환
-- 단일 값 서브쿼리: 특정 값을 반환하는 서브쿼리(1행 1열)
-- 다중 값 서브쿼리: 여러 레코드를 반환하는 서브쿼리(N행 M열) - IN, ANY, ALL, EXISTS 연산자와 함께 사용됨

-- 5) 복잡하고 정교한 데이터 분석에 유용
-- 필터링 조건 추출
-- 데이터 집계 결과 추출
-- => 이를 기준으로 메인쿼리를 수행

-- Quiz
-- 1. 다음 설명이 맞으면 O, 틀리면 X를 표시하세요.
-- ① 서브쿼리는 메인쿼리 내부에 중첩해 작성한다. (  )
-- ② 서브쿼리는 다양한 위치에서 사용할 수 있다. (  )
-- ③ 서브쿼리는 단일 값만 반환한다. (  )

-- 정답: O, O, X


/*
9.2 다양한 위치에서의 서브쿼리
*/
-- 8장에서 다루었던 마켓 DB를 기반으로 다양한 서브쿼리를 연습!
USE market;

-- 1. SELECT 절에서의 서브쿼리
-- 1x1 단일값만 반환하는 서브쿼리만 사용 가능
-- 여러 행 또는 여러 컬럼을 반환하면 SQL이 어떤 값을 선택해야 할 지 몰라 에러 발생

-- 모든 결제 정보에 대한 평균 결제 금액과의 차이는?
SELECT 
	payment_type AS '결제 유형',
    amount AS '결제 금액',
    amount - (평균결제금액) AS '평균 결제 금액과의 차이'
FROM payments;

-- Quiz: 평균 결제 금액
SELECT AVG(amount)
FROM payments;

-- () 괄호 안에 넣기
SELECT 
	payment_type AS '결제 유형',
    amount AS '결제 금액',
    amount - (SELECT AVG(amount) FROM payments) AS '평균 결제 금액과의 차이'
FROM payments;

-- 잘못된 사용 예
SELECT 
	payment_type AS '결제 유형',
    amount AS '결제 금액',
    amount - (SELECT AVG(amount), '123' FROM payments) AS '평균 결제 금액과의 차이'
FROM payments;


-- 2. FROM 절에서의 서브쿼리
-- NxM 반환하는 행과 컬럼의 개수에 제한이 없음
-- 단, 서브쿼리에 별칭 지정 필수

-- 1회 주문 시 평균 상품 개수는? (장바구니 상품 포함)
-- 주문별(order_id)로 그룹화 -> count 집계: SUM() -> 재집계: AVG()
-- 일단 먼저 주문 당 상품 개수 집계 구하기
SELECT
	order_id,
    SUM(count) AS total_count
FROM order_details
GROUP BY order_id; -- 서브쿼리로 사용

-- 메인쿼리: 1회 주문 시 평균 상품 개수 집계
SELECT AVG(total_count) AS '1회 주문 시 평균 상품 개수'
FROM (
	-- 서브쿼리
    SELECT
		order_id,
		SUM(count) AS total_count -- 집계 함수 결과에 별칭 필수(컬럼명이 아니라 계산된 값을 반환하기 때문에)
	FROM order_details
	GROUP BY order_id
) AS sub; -- 별칭 필수(AS는 생략 가능)

-- 3. JOIN 절에서의 서브쿼리
-- NxM 반환하는 행과 컬럼의 개수에 제한이 없음
-- 단, 서브쿼리에 별칭 지정 필수

-- 상품별 주문 개수를 '배송 완료'와 '장바구니'에 상관없이 상품명과 주문 개수를 조회한다면?
-- 매인쿼리: 상품별 주문 개수 집계
SELECT
	name AS 상품명,
    sub.total_count AS '주문 개수'
FROM products p
JOIN (
	-- 서브쿼리: 상품 아이디별 주문 개수 집계
    SELECT
		product_id,
        SUM(count) AS total_count
    FROM order_details
    GROUP BY product_id -- 번개 버튼으로 실행 결과 확인!
) AS sub ON sub.product_id = p.id;

-- (참고) 다른 방법: 일단 붙여놓고 그룹화 및 집계
SELECT 
	name AS 상품명,
    SUM(count) AS '주문 개수'
FROM order_details od
JOIN products p ON od.product_id = p.id
GROUP BY name;


-- 4. WHERE 절에서의 서브쿼리
-- 1x1, Nx1 반환하는 서브쿼리만 사용 가능
-- (필터링의 조건으로 값 또는 값의 목록을 사용하기 때문)

-- 평균 가격보다 비싼 상품을 조회하려면?
SELECT *
FROM products
WHERE price > (평균가격);
-- 평균 가격을 서브쿼리로 구해서 넣으면 됨

SELECT *
FROM products
WHERE price > (
	-- 서브쿼리: 평균 가격
    SELECT AVG(price)
    FROM products
);


-- 5. HAVING 절에서의 서브쿼리
-- 1x1, Nx1 반환하는 서브쿼리만 사용 가능
-- (필터링의 조건으로 값 또는 값의 목록을 사용하기 때문)

-- 크림 치즈보다 매출이 높은 상품은? (장바구니 상품 포함)
-- 상품x주문상세 조인해서 -> 상품명으로 그룹화 -> 상품별로 매출을 집계
-- 메인쿼리: 전체 상품의 매출을 조회 => 크림 치즈보다 매출이 높은 상품 조회로 변경
SELECT 
	name AS 상품명,
    SUM(price * count) AS 매출
FROM products p
JOIN order_details od ON od.product_id = p.id
GROUP BY name;

-- 크림 치즈보다 매출이 높은 상품 조회로 변경
SELECT 
	name AS 상품명,
    SUM(price * count) AS 매출
FROM products p
JOIN order_details od ON od.product_id = p.id
GROUP BY name
HAVING SUM(price * count) > (
	-- 서브쿼리: 크림 치즈의 매출(=8720)
    SELECT SUM(price * count)
    FROM products p
	JOIN order_details od ON od.product_id = p.id
    WHERE name = '크림 치즈'
);

-- Quiz
-- 2. 다음 설명이 맞으면 O, 틀리면 X를 표시하세요.
-- ① SELECT 절의 서브쿼리는 단일 값만 반환해야 한다. (  )
-- ② FROM 절과 J0IN 절의 서브쿼리는 별칭을 지정해야 한다. (  )
-- ③ WHERE 절과 HAVING 절의 서브쿼리는 단일 값 또는 다중 행의 단일 칼럼을 반환할 수 있다. (  )

-- 정답: 



























