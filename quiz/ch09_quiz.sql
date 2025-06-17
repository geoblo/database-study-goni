-- 1. 서브쿼리 확인 문제

-- 문제 1
-- 서브쿼리에 대한 설명으로 옳은 것은 무엇입니까?

-- ① 하나의 SQL 문에서 다른 SQL 문을 중첩하여 사용하는 것
-- ② 여러 테이블을 결합하여 하나의 결과를 반환하는 것
-- ③ 특정 조건을 기준으로 데이터를 필터링하는 명령
-- ④ 쿼리 실행 결과를 정렬하는 방식

-- 정답: 


-- 문제 2
-- 다음 중 서브쿼리를 사용할 수 없는 절은 무엇입니까?

-- ① SELECT 절
-- ② WHERE 절
-- ③ JOIN 절
-- ④ LIMIT 절

-- 정답: 


-- 문제 3
-- 서브쿼리와 JOIN의 차이에 대한 설명으로 옳은 것은 무엇입니까?

-- ① 서브쿼리는 데이터를 결합하고, JOIN은 데이터를 필터링한다.
-- ② 서브쿼리는 독립적으로 실행되며, JOIN은 두 테이블 간의 관계를 결합한다.
-- ③ JOIN은 두 테이블 간의 모든 데이터를 결합하고, 서브쿼리는 특정 데이터를 필터링한다.
-- ④ JOIN은 임시 테이블을 생성하고, 서브쿼리는 모든 데이터를 반환한다.

-- 정답: 


-- 문제 4
-- 다음 쿼리에서 서브쿼리가 반환하는 데이터는 무엇입니까?

SELECT name
FROM members
WHERE id IN (
	SELECT member_id
	FROM borrow_records
);

-- ① 회원의 이름을 포함한 모든 정보
-- ② 대출 기록에서 조회된 회원의 이름
-- ③ 대출 기록에서 조회된 회원 ID
-- ④ 대출 기록에서 조회된 도서 ID

-- 정답: 


-- 문제 5
-- 다음 중 서브쿼리가 특정 절에서 사용되는 이유와 그 역할로 가장 적절한 것은 무엇입니까?

-- ① SELECT 절: 서브쿼리의 결과를 메인쿼리의 출력 값으로 계산하여 제공한다.
-- ② FROM 절: 서브쿼리의 결과를 임시 테이블처럼 활용하여 메인쿼리에서 참조한다.
-- ③ WHERE 절: 서브쿼리의 결과를 조건으로 사용하여 메인쿼리의 데이터를 필터링한다.
-- ④ HAVING 절: 그룹화된 데이터의 집계 결과를 조건으로 제한한다.
-- ⑤ 모두 맞다.

-- 정답: 


-- 2. 서브쿼리 연습 문제

-- 회사 데이터베이스를 보고 문제에 답하세요.

-- 부서 테이블
CREATE TABLE departments (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(50) NOT NULL, -- 부서명
	location VARCHAR(50), -- 위치
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 직원 테이블
CREATE TABLE employees (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(50) NOT NULL, -- 직원명
	hire_date DATE NOT NULL, -- 입사 날짜
	salary INTEGER NOT NULL, -- 급여
	department_id INTEGER, -- 부서 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (department_id) REFERENCES departments(id) -- 외래키 지정: department_id
);

-- 프로젝트 테이블
CREATE TABLE projects (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(100) NOT NULL, -- 프로젝트명
	start_date DATE NOT NULL, -- 시작 날짜
	end_date DATE, -- 종료 날짜
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 직원-프로젝트 테이블 (다대다 관계)
CREATE TABLE employee_projects (
	id INTEGER AUTO_INCREMENT, -- id
	employee_id INTEGER NOT NULL, -- 직원 id
	project_id INTEGER NOT NULL, -- 프로젝트 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (employee_id) REFERENCES employees(id), -- 외래키 지정: employee_id
	FOREIGN KEY (project_id) REFERENCES projects(id) -- 외래키 지정: project_id
);

-- 급여 기록 테이블
CREATE TABLE salary_records (
	id INTEGER AUTO_INCREMENT, -- id
	salary_date DATE NOT NULL, -- 급여 지급 날짜
	amount INTEGER NOT NULL, -- 지급 금액
	employee_id INTEGER NOT NULL, -- 직원 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (employee_id) REFERENCES employees(id) -- 외래키 지정: employee_id
);

-- 문제에서 주어진 조건은 참고만 하되 너무 복잡하다면 다르게 짜도 상관없습니다!!
-- 같은 결과에 대해서도 다양한 답이 나올수 있음

-- 문제 1: SELECT 절에서의 서브쿼리
-- 각 직원의 이름과 참여 중인 프로젝트 수를 조회하세요.

-- 정답:



-- 문제 2: WHERE 절에서의 서브쿼리
-- 특정 부서(예: IT 부서)의 직원 이름을 조회하세요.

-- 정답: 



-- 문제 3: FROM 절에서의 서브쿼리
-- 부서별 직원 수를 조회하세요.

-- 정답: 



-- 문제 4: JOIN 절에서의 서브쿼리
-- 가장 높은 급여를 받은 직원의 이름과 급여를 조회하세요.

-- 정답: 



-- 문제 5: HAVING 절에서의 서브쿼리
-- 부서별 평균 급여가 전체 평균 급여 이상인 부서명을 조회하세요.

-- 정답:



-- 문제 6: 복합 조건을 조합한 서브쿼리
-- 가장 많은 직원이 참여한 프로젝트명을 조회하세요.

-- 정답:




