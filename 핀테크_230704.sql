-- 소수점 관련 함수 --
create table test_func(id number, num VARCHAR2(20));
insert into test_func values(1, '34.5678');
select * from test_func where id=1;

-- ronud 함수 -- 소수점을 자르며 반올림 된다.
select round(num, 2) from test_func where id=1;
select round(num/2, 2) from test_func where id=1;

-- trunc 함수 -- 소수점 버림
select trunc(num, 2) from test_func where id=1;

insert into test_func values(2, 'aa');  -- 연산이 안되기 때문에 오류남
delete from test_func where id=2;

insert into test_func values(2, '55');

-- mod 연산 -- 나머지
select num from test_func where id=2;
select mod(num, 2) from test_func where id=2;

-- Quiz01 --
-- id 1~10까지 총 10명 저장하기
insert into test_func values(3, '13.5');
insert into test_func values(4, '72');
insert into test_func values(5, '93.64');
insert into test_func values(6, '28');
insert into test_func values(7, '5');
insert into test_func values(8, '12.6304');
insert into test_func values(9, '96');
insert into test_func values(10, '46');

select * from test_func;

-- id 1~10까지 홀수 id 값 모두 출력
select mod(id, 2) from test_func;
select * from test_func where mod(id,2)=1;

-- id 1~10 사이에 있는 짝수 id의 값들을 2로 나눈후 소수점 2자리까지 표현(버려지는건 반올림 진행)
select id, round(num/2,2) from test_func where mod(id,2) =0;


-- 대소문자 관련 함수 --
insert into test_func values(11, 'Welcom To Oracle');

-- 대문자 변환 --
select upper(num) from test_func where id =11;

-- 소문자 변환 --
select lower(num) from test_func where id =11;

-- 공백 다음 첫 문자는 대문자 변환
select initcap(num) from test_func where id =11;

-- 대소문자 활용 Quiz02 -- 
create table testCompany(
  name varchar2(20),
  연봉 varchar2(20),
  class varchar2(20)
);
insert into testCompany values('hong gil dong_M','3600','Manager');
insert into testCompany values('kim gea ddong_M','2555','ManaGer');
insert into testCompany values('Go gil dong_M','2800','ManaGER');
insert into testCompany values('hong gil dong_E','3111','EmpLoyee');
insert into testCompany values('kim gea ddong_E','2600','EmpLoYee');
insert into testCompany values('Go gil dong_E','2950','employee');

-- 직급이 manager인 사원 검색하여 출력
select * from testCompany where upper(class) = 'MANAGER';

-- 직급이 employee 이면서 연봉이 2800이상인 사람 모두 출력
select * from testCompany where upper(class) = 'EMPLOYEE' and 연봉 >=2800;

-- 모든 사원 이름의 첫글자는 대문자로 출력하고 한달 급여를 출력 (소수점 이하 버림)
select initcap(name), trunc(연봉/12, 0), class from testCompany;


-- 그룹 함수 --
create table testClass(class varchar2(10), score number);
insert into testClass values('A반',11);
insert into testClass values('A반',12);
insert into testClass values('A반',13);
insert into testClass values('B반',21);
insert into testClass values('B반',22);
insert into testClass values('B반',23);
insert into testClass values('1',31);
insert into testClass values('1',32);
insert into testClass values('1',33);
insert into testClass values('',40);

select * from testClass;

select sum(score) from testclass; -- 합계
select avg(score) from testclass; -- 평균
select max(score), min(score) from testclass; -- 최대값, 최소값
select count(class) from testclass; -- null값은 개수로 포함되지 않음
select count(*) from testclass; -- 전체 개수를 얻어옴

-- 확인되는 컬럼과 group의 컬럼과 동일한 컬럼이 들어와야 한다
select class, sum(score) from testclass group by class;

-- 그룹으로 묶어서 조건을 사용할 경우 having절을 이용한다.
select class, sum(score) from testclass group by class having sum(score)>50;

-- Quiz03 --
-- 각 클래스 별 개수를 출력하시오
select class, count(*) from testclass group by class;

-- 각 클래스 별 평균을 구하고 평균 별 내림차순으로 정렬하여 출력
select class, avg(score) from testclass group by class order by avg(score) desc;

-- 각 class별로 가장 큰값과 가장 작은 값을 출력
select class, max(score), min(score) from testclass group by class;


-- join 함수 --
create table testName(id varchar2(20), class varchar2(20));
insert into testName values('홍길동','A반');
insert into testName values('김개똥','B반');
insert into testName values('고길동','C반');

create table testLesson(id varchar2(20), lesson varchar2(20), score number);
insert into testLesson values('홍길동','python',80);
insert into testLesson values('홍길동','java',90);
insert into testLesson values('홍길동','c언어',70);
insert into testLesson values('김개똥','server2012',70);
insert into testLesson values('김개똥','linux',90);
insert into testLesson values('고길동','jsp',100);

-- 조회하기 (각각 가져와야 함)
select * from testname;
select * from testlesson;

-- inner join
select * from testname N inner join testlesson L on N.id = L.id;
-- N, L 별칭으로 사용/ 조건은 id가 같은 것을 갖고 옴
select N.*, L.score from testname N inner join testlesson L on N.id = L.id;
-- N의 모든 값을 가져오고 L은 score 만 가져옴

-- Quiz04 --
-- id 가 홍길동인 사람의 인적사항 출력
select N.*, L.lesson, L.score from testname N inner join testlesson L on N.id = L.id
                                where N.id ='홍길동';
-- select N.id,N.class,L.lesson,L.score 
-- from testName N inner join testlesson L on N.id=L.id and N.id='홍길동';
-- on 다음에 조건은 join 조건이며 where절 사용 가능
                                
-- 각 이름, 클래스별 합계와 평균 출력
-- id는 testname 에서 받아오고 나머지 값은 testlesson 테이블의 조인을 이용해서 표현
select N.id, N.class, sum(L.score), avg(L.score) from testname N 
                            inner join testlesson L on N.id = L.id
                            group by N.id, N.class order by class asc;
                            

-- foreign key
CREATE TABLE membership
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    not NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

CREATE TABLE board
(
    b_num        INT             NOT NULL, 
    b_id         VARCHAR2(20)    NULL, 
    b_title      VARCHAR2(20)    NULL, 
    b_content    VARCHAR2(20)    NULL, 
    b_date       DATE            NULL, 
     PRIMARY KEY (b_num)
);

select * from membership;
select * from board;

ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id) ;
-- membership 에 있는 id만 board 작성 가능하게 설정

insert into board(b_num, b_id) values(1, 'aaa');
-- membership 에 'aaa' id가 저장되어 있지 않기 때문에 constraint 오류 남

CREATE SEQUENCE board_SEQ
START WITH 1
INCREMENT BY 1; -- board SEQ++

drop table membership;
-- 테이블 삭제할 때는 자식을 먼저 삭제하고 부모를 삭제해야함

drop table membership cascade constraints;
-- 만약 강제로 삭제하고 싶을 때는 cascade constraints 사용

insert into membership(m_id, m_pwd, m_name, m_addr)
    values('aaa', 'aaa', '홍길동', '산골짜기');
    
 insert into board(b_num, b_id, b_title, b_content, b_date)
    values(board_SEQ.nextval, 'aaa', '제목', '내용', sysdate);
-- board_SEQ.nextval : 자동적으로 1씩 증가시켜줌
-- (select max(b_num) from board)+1 로 사용 가능

select * from board;

-- sequence 확인
select * from all_sequences;    -- 모든 계정의 시퀀스
select * from all_sequences where sequence_owner='FIN';
select * from user_sequences;   -- 로그인한 계정의 시퀀스

-- constraints 확인
select * from all_constraints;
select * from all_constraints where owner='FIN';
select * from user_constraints;

-- 데이터 확인
select * from membership;
select * from board;
delete from membership where m_id ='aaa';
-- board 테이블과 연결되어 있어서 삭제 불가능 (연결된게 없어야지 삭제 가능)

-- 제약조건 삭제
alter table board drop constraint FK_B_ID_M_ID2;

-- on delete cascade 추가하여 다시 설정하기 (부모 삭제할 때 자식도 같이 삭제 됨)
ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id) on delete cascade;

select * from membership;
select * from board;
delete from membership where m_id ='aaa'; -- 같이 삭제 되는거 확인

-- sequence 삭제
select * from user_sequences;
drop sequence board_seq;

-- Quiz05 --
-- 테이블 생성 SQL - member
CREATE TABLE member
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

-- 테이블 생성 SQL - goods
CREATE TABLE goods
(
    g_num          INT             NOT NULL, 
    g_id           VARCHAR2(20)    NULL, 
    g_name         VARCHAR2(20)    NULL, 
    g_price        INT             NULL, 
    g_count        INT             NULL, 
    g_price_sum    INT             NULL, 
    g_date         DATE            NULL, 
     PRIMARY KEY (g_num)
);

CREATE SEQUENCE goods_SEQ
START WITH 1
INCREMENT BY 1;

-- Foreign Key 설정 SQL - goods(g_id) -> member(m_id)
ALTER TABLE goods
    ADD CONSTRAINT fk_g_id_m_id FOREIGN KEY (g_id)
        REFERENCES member (m_id) ;
        
-- 데이터 넣기 (member)
insert into member values('aaa', 'aaa', '홍길동', '산골짜기');
insert into member values('bbb', 'bbb', '김개똥', '개똥별');
insert into member values('ccc', 'ccc', '고길동', '마포구');
insert into member values('ddd', 'ddd', '김말이', '분식집');

select * from member;

-- 데이터 넣기 (goods)
insert into goods values( goods_SEQ.nextval, 'aaa', '운동화', 75000, 2, 150000, sysdate);
insert into goods values( goods_SEQ.nextval, 'aaa', '티셔츠', 15000, 5, 75000, sysdate);
insert into goods values( goods_SEQ.nextval, 'bbb', '가방', 450000, 1, 450000, sysdate);
insert into goods values( goods_SEQ.nextval, 'bbb', '책', 35000, 2, 70000, sysdate);

select * from goods;

-- inner join 사용하여 출력
select M.*, G.* from member M inner join goods G on m.m_id = g.g_id;

select M.m_id, M.m_name, G.g_name, G.g_price_sum
from member M inner join goods G on m.m_id = g.g_id;

-- sum 함수 이용하여 출력
select M.m_id, M.m_name, M.m_addr, sum(G.g_price_sum)
from member M inner join goods G on m.m_id = g.g_id
group by M.m_name, M.m_id, M.m_addr;
