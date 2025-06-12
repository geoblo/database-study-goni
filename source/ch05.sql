/*
5. 다양한 자료형 활용하기
5.1 자료형이란
*/
-- 무엇? 데이터의 형태(data type)
-- 관리하고 싶은 데이터에 맞게 자료형이 필요
-- 자료형을 잘못 지정할 경우, 메모리 공간의 낭비와 연산에 제약이 생길 수 있음

-- DB의 자료형 크게 숫자형, 문자형, 날짜 및 시간형이 있음

-- 선행학습
-- 컴퓨터의 저장 단위와 자료형의 크기
-- 단위            | 크기        | 저장 예
-- 비트(Bit)         1Bit         True 또는 false 저장(0 또는 1을 저장)
-- 바이트(Byte)       8bit         알파벳 한 개 저장
-- 킬로바이트(KB)      1,024Byte    몇 개의 문단 저장
-- 메가바이트(MB)      1,024KB      1분 길이의 MP3 파일 저장
-- 기가바이트(GB)      1,024MB      30분 가량의 HD 영화 저장
-- 테라바이트(TB)      1,024GB      약 200편의 FHD 영화 저장

-- 자료형의 종류
-- 1. 숫자형
-- 숫자를 저장하기 위한 데이터 타입
-- 크게 정수형, 실수형으로 나뉨

-- 1) 정수형
-- 소수점이 없는 수 저장: -2, -1, 0, 1, 2, ...
-- 세부 타입이 존재: 차지하는 메모리 크기에 따른 분류
-- 종류: TINYINT, SMALLINT, MEDIUMINT, INTEGER(또는 INT), BIGINT

-- UNSIGNED(언사인드) 제약 조건 부여 가능: 음수 값을 허용하지 않는 정수
-- CREATE TABLE 테이블명 (
-- 	컬럼명 데이터_타입 UNSIGNED
-- );
-- 유효성 보장: 나이는 0~255의 유효한 값만 저장
CREATE TABLE users (
	age TINYINT UNSIGNED
);
-- 안전성 보장: 재고는 음수가 될 수 없음
CREATE TABLE products (
	stock INTEGER UNSIGNED
);

-- 2) 실수형
-- 소수점을 포함하는 수 저장: 3.14, -9.81, ...
-- 부동 소수점(floating-point): 가수부와 지수부를 통해 소수점 위치를 변경(FLOAT, DOUBLE)
-- 고정 소수점(fixed-point): 자릿수가 고정된 실수를 저장(DECIMAL)

-- 부동 소수점 vs 고정 소수점
-- 부동 소수점: 넓은 범위를 표현 가능, 숫자 계산에 오차 발생(2진수 기반이라서)
-- FLOAT과 DOUBLE 타입은 0.1을 정확히 저장하지 않고 근사값으로 저장(왜? 0.1은 2진수로 무한 소수)
-- FLOAT: 약 7자리 정확도
-- DOUBLE: 약 15~17자리 정확도
-- 고정 소수점: 특정 범위 안에서 정확한 연산을 수행(10진수 기반이라서)
-- DECIMAL 타입은 0.1을 근사값이 아니라 정확하게 저장
-- 정확한 소수값이 필요하면 DECIMAL을 사용

-- 실습: 숫자형 사용하기
-- 학생 기록(student_records) 테이블을 만들어 다음 데이터를 저장한다면?
-- (학년은 초등학교 1학년부터 고등학교 3학년까지를 숫자 1~12로 표현할 것)

-- 아이디  | 학년 | 평균 점수   | 수업료
-- ----------------------------------
-- 1     | 3   | 88.75   | 50000.00
-- 2     | 6   | 92.5    | 100000.00

-- data_type DB 생성 및 진입
CREATE DATABASE data_type;
USE data_type;
SELECT DATABASE(); -- 확인

-- 학생 기록 테이블 생성
CREATE TABLE student_records (
	id INTEGER, -- 아이디(표준 정수)
    grade TINYINT UNSIGNED, -- 학년(부호가 없는 매우 작은 정수), 0~255
    average_score FLOAT, -- 평균 점수(부동 소수점 방식의 실수)
    tuition_fee DECIMAL(10, 2), -- 수업료(고정 소수점 방식의 실수), 돈계산 관련은 정확하게
    PRIMARY KEY (id) -- 기본키 지정: id
);

-- 학생 기록 데이터 삽입
INSERT INTO
	student_records (id, grade, average_score, tuition_fee)
VALUES
	(1, 3, 88.75, 50000.00),
    (2, 6, 92.5, 100000.00);
    
-- 데이터 조회
SELECT * FROM student_records;

-- 자료형의 범위를 벗어난 값을 입력 => 에러 발생!
INSERT INTO
	student_records (id, grade, average_score, tuition_fee)
VALUES
	(3, -2, 66.5, 20.00);

INSERT INTO
	student_records (id, grade, average_score, tuition_fee)
VALUES
	(4, 256, 66.5, 20.00);

-- 2. 문자형
-- 한글, 영어, 기호 등의 문자 저장을 위한 타입
-- 다양한 세부 타입이 존재
-- 종류: CHAR, VARCHAR, TEXT, BLOB, ENUM 등

-- 1) CHAR vs VARCHAR
-- CHAR: 고정 길이(최대 255자)
-- VARCHAR: 가변 길이(최대 65,535자)
-- CHAR와 VARCHAR 자료형의 사용 예
CREATE TABLE addresses (
	potal_code CHAR(5), -- 우편번호(고정 길이 문자: 5자), 주로 고정된 길이의 코드값(예: 국가코드)
    -- 문자를 3개만 넣는 경우, 자동으로 공백(space) 문자를 채움(예: 'abc  ')
    street_address VARCHAR(100) -- 거리 주소(가변 길이 문자: 최대 100자)
    -- 최대 100글자 저장 가능하지만, 사용 메모리는 입력된 문자만큼만 사용(예: 'abc')
    -- (참고) UTF-8 기준, VARCHAR(65535)는 현실적으로 불가능하고 VARCHAR(16383) 정도가 안전한 최대치
);

-- 2) TEXT
-- 긴 문자열 저장을 위한 타입
-- CHAR/VARCHAR로는 감당하기 어려운 매우 긴 텍스트 데이터를 저장하기 위해 존재
-- 예: VARCHAR는 최대 약 65KB 정도까지만 저장 가능(이마저도 문자셋에 따라 줄어듦)
-- => 그 이상을 저장하려면 TEXT가 필요
-- 세부 타입 종류: TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT
-- TEXT 자료형의 사용 예
CREATE TABLE acticles (
	title VARCHAR(200), -- 제목(가변 길이 문자: 최대 200자)
    short_description TINYTEXT, -- 짧은 설명(최대 255Byte)
    comments TEXT, -- 댓글(최대 64KB)
    content MEDIUMTEXT, -- 본문(최대 16MB)
    additional_info LONGTEXT -- 추가 정보(최대 4GB)
);

-- 3) BLOB
-- 크기가 큰 파일 저장을 위한 타입
-- 이미지, 오디오, 비디오 등의 저장에 사용
-- 세부 타입 종류: TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB
-- BLOB 자료형의 사용 예
CREATE TABLE files (
	file_name VARCHAR(200), -- 파일명(가변 길이 문자: 최대 200자)
    small_thumbnail TINYBLOB, -- 작은 이미지 파일(최대 255Byte)
    document BLOB, -- 일반 문서 파일(최대 64KB)
    video MEDIUMBLOB, -- 비디오 파일(최대 16MB)
    large_data LONGBLOB -- 대용량 파일(최대 4GB)
);

-- (참고)
-- 자바 웹 개발을 포함한 대부분의 애플리케이션에서는 이미지나 동영상 같은 대용량 파일을
-- 데이터베이스에 직접 저장하지 않고, 클라우드 스토리지나 파일 서버 등에 저장한 뒤,
-- 그 경로나 URL만 데이터베이스에 저장하는 방식이 사실상 표준

-- 왜 DB에 직접 저장하지 않을까?
-- DB 부하가 큼, 성능이 느림, 백업/복구 어려움 등

-- 4) ENUM
-- 주어진 목록 중 하나만 선택할 수 있는 타입
-- 입력 가능한 목록을 제한하여, 잘못된 입력을 예방
-- ENUM 자료형의 사용 예
CREATE TABLE memberships (
	name VARCHAR(100), -- 회원명(가변 길이 문자: 최대 100자)
    level ENUM('bronze', 'silver', 'gold') -- 회원 레벨(선택 목록 중 택1)
);

-- 실습: 문자형 사용하기
-- 다음 데이터를 사용자 프로필(user_profiles) 테이블로 만들어 저장하려면?

-- 아이디  | 이메일                  | 전화번호          | 자기소개     | 프로필 사진   | 성별
-- -------------------------------------------------------------------------------
-- 1     | geoblo@naver.com      | 012-3456-7890  | 안녕하십니까!  | NULL      | 남
-- 2     | hongsoon@example.com  | 098-7654-3210  | 반갑습니다요!  | NULL      | 여

-- 사용자 프로필 테이블 생성
CREATE TABLE user_profiles (
	id INTEGER, -- 아이디(표준 정수)
     -- 이메일(가변 길이 문자: 최대 255자)
    -- 전화번호(고정 길이 문자: 13자)
    -- 자기소개(긴 문자열: 최대 64KB)
    -- 프로필 사진(파일: 최대 16MB)
    -- 성별(선택 목록 중 택 1)
    -- 기본키 지정: id
);









