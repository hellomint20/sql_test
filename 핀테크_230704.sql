-- �Ҽ��� ���� �Լ� --
create table test_func(id number, num VARCHAR2(20));
insert into test_func values(1, '34.5678');
select * from test_func where id=1;

-- ronud �Լ� -- �Ҽ����� �ڸ��� �ݿø� �ȴ�.
select round(num, 2) from test_func where id=1;
select round(num/2, 2) from test_func where id=1;

-- trunc �Լ� -- �Ҽ��� ����
select trunc(num, 2) from test_func where id=1;

insert into test_func values(2, 'aa');  -- ������ �ȵǱ� ������ ������
delete from test_func where id=2;

insert into test_func values(2, '55');

-- mod ���� -- ������
select num from test_func where id=2;
select mod(num, 2) from test_func where id=2;

-- Quiz01 --
-- id 1~10���� �� 10�� �����ϱ�
insert into test_func values(3, '13.5');
insert into test_func values(4, '72');
insert into test_func values(5, '93.64');
insert into test_func values(6, '28');
insert into test_func values(7, '5');
insert into test_func values(8, '12.6304');
insert into test_func values(9, '96');
insert into test_func values(10, '46');

select * from test_func;

-- id 1~10���� Ȧ�� id �� ��� ���
select mod(id, 2) from test_func;
select * from test_func where mod(id,2)=1;

-- id 1~10 ���̿� �ִ� ¦�� id�� ������ 2�� ������ �Ҽ��� 2�ڸ����� ǥ��(�������°� �ݿø� ����)
select id, round(num/2,2) from test_func where mod(id,2) =0;


-- ��ҹ��� ���� �Լ� --
insert into test_func values(11, 'Welcom To Oracle');

-- �빮�� ��ȯ --
select upper(num) from test_func where id =11;

-- �ҹ��� ��ȯ --
select lower(num) from test_func where id =11;

-- ���� ���� ù ���ڴ� �빮�� ��ȯ
select initcap(num) from test_func where id =11;

-- ��ҹ��� Ȱ�� Quiz02 -- 
create table testCompany(
  name varchar2(20),
  ���� varchar2(20),
  class varchar2(20)
);
insert into testCompany values('hong gil dong_M','3600','Manager');
insert into testCompany values('kim gea ddong_M','2555','ManaGer');
insert into testCompany values('Go gil dong_M','2800','ManaGER');
insert into testCompany values('hong gil dong_E','3111','EmpLoyee');
insert into testCompany values('kim gea ddong_E','2600','EmpLoYee');
insert into testCompany values('Go gil dong_E','2950','employee');

-- ������ manager�� ��� �˻��Ͽ� ���
select * from testCompany where upper(class) = 'MANAGER';

-- ������ employee �̸鼭 ������ 2800�̻��� ��� ��� ���
select * from testCompany where upper(class) = 'EMPLOYEE' and ���� >=2800;

-- ��� ��� �̸��� ù���ڴ� �빮�ڷ� ����ϰ� �Ѵ� �޿��� ��� (�Ҽ��� ���� ����)
select initcap(name), trunc(����/12, 0), class from testCompany;


-- �׷� �Լ� --
create table testClass(class varchar2(10), score number);
insert into testClass values('A��',11);
insert into testClass values('A��',12);
insert into testClass values('A��',13);
insert into testClass values('B��',21);
insert into testClass values('B��',22);
insert into testClass values('B��',23);
insert into testClass values('1',31);
insert into testClass values('1',32);
insert into testClass values('1',33);
insert into testClass values('',40);

select * from testClass;

select sum(score) from testclass; -- �հ�
select avg(score) from testclass; -- ���
select max(score), min(score) from testclass; -- �ִ밪, �ּҰ�
select count(class) from testclass; -- null���� ������ ���Ե��� ����
select count(*) from testclass; -- ��ü ������ ����

-- Ȯ�εǴ� �÷��� group�� �÷��� ������ �÷��� ���;� �Ѵ�
select class, sum(score) from testclass group by class;

-- �׷����� ��� ������ ����� ��� having���� �̿��Ѵ�.
select class, sum(score) from testclass group by class having sum(score)>50;

-- Quiz03 --
-- �� Ŭ���� �� ������ ����Ͻÿ�
select class, count(*) from testclass group by class;

-- �� Ŭ���� �� ����� ���ϰ� ��� �� ������������ �����Ͽ� ���
select class, avg(score) from testclass group by class order by avg(score) desc;

-- �� class���� ���� ū���� ���� ���� ���� ���
select class, max(score), min(score) from testclass group by class;


-- join �Լ� --
create table testName(id varchar2(20), class varchar2(20));
insert into testName values('ȫ�浿','A��');
insert into testName values('�谳��','B��');
insert into testName values('��浿','C��');

create table testLesson(id varchar2(20), lesson varchar2(20), score number);
insert into testLesson values('ȫ�浿','python',80);
insert into testLesson values('ȫ�浿','java',90);
insert into testLesson values('ȫ�浿','c���',70);
insert into testLesson values('�谳��','server2012',70);
insert into testLesson values('�谳��','linux',90);
insert into testLesson values('��浿','jsp',100);

-- ��ȸ�ϱ� (���� �����;� ��)
select * from testname;
select * from testlesson;

-- inner join
select * from testname N inner join testlesson L on N.id = L.id;
-- N, L ��Ī���� ���/ ������ id�� ���� ���� ���� ��
select N.*, L.score from testname N inner join testlesson L on N.id = L.id;
-- N�� ��� ���� �������� L�� score �� ������

-- Quiz04 --
-- id �� ȫ�浿�� ����� �������� ���
select N.*, L.lesson, L.score from testname N inner join testlesson L on N.id = L.id
                                where N.id ='ȫ�浿';
-- select N.id,N.class,L.lesson,L.score 
-- from testName N inner join testlesson L on N.id=L.id and N.id='ȫ�浿';
-- on ������ ������ join �����̸� where�� ��� ����
                                
-- �� �̸�, Ŭ������ �հ�� ��� ���
-- id�� testname ���� �޾ƿ��� ������ ���� testlesson ���̺��� ������ �̿��ؼ� ǥ��
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
-- membership �� �ִ� id�� board �ۼ� �����ϰ� ����

insert into board(b_num, b_id) values(1, 'aaa');
-- membership �� 'aaa' id�� ����Ǿ� ���� �ʱ� ������ constraint ���� ��

CREATE SEQUENCE board_SEQ
START WITH 1
INCREMENT BY 1; -- board SEQ++

drop table membership;
-- ���̺� ������ ���� �ڽ��� ���� �����ϰ� �θ� �����ؾ���

drop table membership cascade constraints;
-- ���� ������ �����ϰ� ���� ���� cascade constraints ���

insert into membership(m_id, m_pwd, m_name, m_addr)
    values('aaa', 'aaa', 'ȫ�浿', '���¥��');
    
 insert into board(b_num, b_id, b_title, b_content, b_date)
    values(board_SEQ.nextval, 'aaa', '����', '����', sysdate);
-- board_SEQ.nextval : �ڵ������� 1�� ����������
-- (select max(b_num) from board)+1 �� ��� ����

select * from board;

-- sequence Ȯ��
select * from all_sequences;    -- ��� ������ ������
select * from all_sequences where sequence_owner='FIN';
select * from user_sequences;   -- �α����� ������ ������

-- constraints Ȯ��
select * from all_constraints;
select * from all_constraints where owner='FIN';
select * from user_constraints;

-- ������ Ȯ��
select * from membership;
select * from board;
delete from membership where m_id ='aaa';
-- board ���̺�� ����Ǿ� �־ ���� �Ұ��� (����Ȱ� ������� ���� ����)

-- �������� ����
alter table board drop constraint FK_B_ID_M_ID2;

-- on delete cascade �߰��Ͽ� �ٽ� �����ϱ� (�θ� ������ �� �ڽĵ� ���� ���� ��)
ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id) on delete cascade;

select * from membership;
select * from board;
delete from membership where m_id ='aaa'; -- ���� ���� �Ǵ°� Ȯ��

-- sequence ����
select * from user_sequences;
drop sequence board_seq;

-- Quiz05 --
-- ���̺� ���� SQL - member
CREATE TABLE member
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

-- ���̺� ���� SQL - goods
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

-- Foreign Key ���� SQL - goods(g_id) -> member(m_id)
ALTER TABLE goods
    ADD CONSTRAINT fk_g_id_m_id FOREIGN KEY (g_id)
        REFERENCES member (m_id) ;
        
-- ������ �ֱ� (member)
insert into member values('aaa', 'aaa', 'ȫ�浿', '���¥��');
insert into member values('bbb', 'bbb', '�谳��', '���˺�');
insert into member values('ccc', 'ccc', '��浿', '������');
insert into member values('ddd', 'ddd', '�踻��', '�н���');

select * from member;

-- ������ �ֱ� (goods)
insert into goods values( goods_SEQ.nextval, 'aaa', '�ȭ', 75000, 2, 150000, sysdate);
insert into goods values( goods_SEQ.nextval, 'aaa', 'Ƽ����', 15000, 5, 75000, sysdate);
insert into goods values( goods_SEQ.nextval, 'bbb', '����', 450000, 1, 450000, sysdate);
insert into goods values( goods_SEQ.nextval, 'bbb', 'å', 35000, 2, 70000, sysdate);

select * from goods;

-- inner join ����Ͽ� ���
select M.*, G.* from member M inner join goods G on m.m_id = g.g_id;

select M.m_id, M.m_name, G.g_name, G.g_price_sum
from member M inner join goods G on m.m_id = g.g_id;

-- sum �Լ� �̿��Ͽ� ���
select M.m_id, M.m_name, M.m_addr, sum(G.g_price_sum)
from member M inner join goods G on m.m_id = g.g_id
group by M.m_name, M.m_id, M.m_addr;
