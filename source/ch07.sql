/*
7. 테이블 조인하기
7.1 조인이란
*/
-- 두 테이블로 나뉜 여러 정보를 하나로 연결하여 가져오는 명령
-- 테이블 간에 일치하는 컬럼을 기준으로 두 테이블을 하나로 합쳐 보여줌

-- 조인 컬럼(기준이 되는 컬럼):
-- 두 테이블이 동시에 가지고 있는 컬럼으로 조인하기 위해 사용하는 컬럼
-- 보통 한 테이블의 외래키(FK)와 다른 테이블의 기본키(PK)를 사용

-- (참고) 외래키를 사용하지 않아도 JOIN은 할 수 있음
-- 그럼 외래키를 왜 쓰는 걸까? 데이터의 무결성을 보장하기 위한 제약 조건
-- 존재하지 않는 ID를 참조하지 못하게 막음
-- 부모 테이블 데이터 삭제 시 자식 처리 정의 가능
-- 실수로 잘못된 참조값을 넣는 것 방지

-- 조인 하기
-- 특정 사진에 달린 모든 댓글의 닉네임과 본문을 조회하는 법?

USE stargram;

-- 1번 사진 댓글 정보 조회
SELECT *
FROM comments
WHERE photo_id = 1;

-- 테이블 조인 형식
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;
-- JOIN만 명시하면 기본적으로 INNER JOIN으로 해석

-- 댓글 본문과 사용자 닉네임을 합쳐서 가져오기
SELECT *
FROM comments
JOIN users ON comments.user_id = users.id;
-- JOIN users: 사용자 테이블을 붙일건데
-- ON: 댓글 테이블의 외래키 = 사용자 테이블의 기본키가 같은 것끼리

-- 1번 사진에 달린 모든 댓글 본문과 작성자 닉네임 가져오기
SELECT nickname, body -- 4) 닉네임과 본문을 조회한다.
FROM comments -- 1) 댓글 테이블에
JOIN users -- 2) 사용자 테이블 조인한다.
	ON comments.user_id = users.id -- 해당 조건으로
WHERE photo_id = 1; -- 3) 1번 사진과 관련된 것만 남긴 후,


-- 조인의 특징 7가지
-- 1) 조인 컬럼이 필요
-- 두 테이블을 연결하기 위한 공통 컬럼이 필요
-- 보통 외래키와 기본키를 기준으로 조인
SELECT *
FROM comments
JOIN users ON comments.user_id = users.id; -- 조인 컬럼(외래키) = 조인 컬럼(기본키)

-- 2) 조인 컬럼은 서로 자료형이 일치
-- 일치해야 조인 가능
-- 예: 숫자 1과 문자열 '1'은 서로 조인 불가

-- 3) 조인 조건이 필요
-- ON 절과 함께 사용
-- 두 테이블을 어떻게 연결할지를 조인 조건으로 명시

-- 4) 연속적인 조인 가능
-- 연속 조인 연습
SELECT nickname, body, filename -- 4) 원하는 컬럼 조회
FROM comments -- 1) 댓글 테이블에
JOIN users ON comments.user_id = users.id -- 2) 사용자 테이블 조인하고
JOIN photos ON comments.photo_id = photos.id; -- 3) 다시 사진 테이블 조인 후

-- 5) 중복 컬럼은 테이블명을 붙여 구분
-- 컬럼명이 같은 경우 어느 테이블의 것인지 명시해야 함(그렇지 않은 경우 에러 발생)
-- 사용 예: 중복 컬럼 id에 테이블명 명시
SELECT comments.id, body, users.id,nickname
FROM comments
JOIN users ON comments.user_id = users.id
WHERE photo_id = 2;

-- 6) 테이블명에 별칭 사용 가능
-- 간결한 쿼리 작성 및 가독성 향상에 도움
-- 사용 예: comments 테이블과 users 테이블에 별칭 붙이기
SELECT body, nickname
FROM comments AS c
JOIN users AS u ON c.user_id = u.id;
-- 참고: 테이블에 별칭을 붙일 때는 AS를 거의 생략

-- 7) 다양한 조인 유형 사용 가능
-- 다양한 결과 테이블 생성에 도움
-- INNER 조인
-- LEFT 조인
-- RIGHT 조인
-- FULL 조인

-- Quiz
-- 1. 다음은 comments 테이블과 photos 테이블을 조인하는 쿼리이다. 빈칸을 순서대로 채워 쿼리를 완성하시오. (예: aaa, bbb, ccc)

-- SELECT body, filename
-- FROM comments ① __________
-- ② __________ photos AS p ③ __________ c.photo_id = p.id;

-- 정답: AS c, JOIN, ON

-- 2. 다음 조인에 대한 설명으로 옳지 않은 것은?
-- ① 조인 칼럼은 자료형이 달라도 된다.
-- ② 조인 조건은 JOIN 절의 ON 키워드 다음에 작성한다.
-- ③ 중복 칼럼은 '테이블명.칼럼명'과 같이 테이블명을 붙여 구분한다.
-- ④ 조인 테이블에 별칭을 붙일 때는 AS 키워드를 사용한다.

-- 정답:












