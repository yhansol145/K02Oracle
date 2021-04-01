/*****************
���ϸ� : Or07DDL.sql
DDL : Data Definition Language(���������Ǿ�)
���� : ���̺�, ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�.
*****************/

/*
system �������� ������ �� �Ʒ� ��ɾ �����Ѵ�.
���ο� ������ ���� ������ system���� �� �����ڰ����� �����ϴ�.
*/
create user study identified by 1234;
grant connect, resource to study;


-----------------------------------------------------
--study������ ����� �� �����Ѵ�. �ǽ��� study���� �����մϴ�.

select * from dual;
select * from tab;


/*
���̺����
����]
    create table ���̺�� (
        �÷�1 �ڷ��� [not null ...],
        �÷�2 �ڷ��� [�������� ...],
        ......
        primary key (�÷���) �� �������� ...
    );
*/

create table tb_member (
    member_idx number(10), --10�ڸ��� ����ǥ��
    userid varchar2(30),
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2) --��ü 7�ڸ�, �Ҽ����� 2�ڸ��� �Ǽ�ǥ��
);
select * from t
/*
desc ���̺�� : ������ ���̺��� �Ӽ�(����, �÷� Ÿ��)�� Ȯ���ϱ� ���� ��ɾ�
*/
desc tb_member;


/*
���� ������ ���̺� ���ο� �÷� �߰��ϱ�
    -> tb_member ���̺� email �÷��� �߰��Ͻÿ�.
    
    ����] alter table ���̺�� add �߰��� �÷� �ڷ���(ũ��) ��������;
*/
alter table tb_member add email varchar2(100);
desc tb_member;


/*
���� ������ ���̺��� �÷� �����ϱ�
    -> tb_member���̺��� email �÷��� ����� 200���� Ȯ���Ͻÿ�
    ���� �̸��� ����Ǵ� username�÷��� 60���� Ȯ���Ͻÿ�.
    
    ����] alter table ���̺�� modify �������÷��� �ڷ���(ũ��);
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(60);
desc tb_member;


/*
���̺��� �÷� �����ϱ�
    -> tb_member ���̺��� mileage�÷��� �����Ͻÿ�.
    
    ����] alter table ���̺�� drop column �������÷���;
*/
alter table tb_member drop column mileage;
desc tb_member;


/*
���̺� �����ϱ�
    -> tb_member ���̺��� ���̻� ������� �����Ƿ� �����Ͻÿ�.
    
    ����] drop table ���������̺��;
*/
drop table tb_member;
select * from tab;


---------------------------------------------------------
-- ������ create���� �ٽ� �ѹ� �����ؼ� ���̺��� ������ �� �ǽ��մϴ�.

-- ���ο� ���ڵ� ���� �� Ȯ��
insert into tb_member values (1, 'hong', '1234', 'ȫ�浿', 10000);
insert into tb_member (member_idx, userid, passwd, username, mileage)
    values (2, 'gasan', '9876', '����', 20000);
select * from tb_member;

-- ���̺� ���ڵ���� �����ϱ�
create table tb_member_copy
as
select * from tb_member where 1=1;
-- ����Ǿ����� Ȯ���ϱ�
desc tb_member_copy;
select * from tb_member_copy;

-- ���̺��� �Ӽ��� �����ϱ�(���ڵ�� ����)
create table tb_member_empty
as
select * from tb_member where 1=0;
-- ����Ǿ����� Ȯ���ϱ�
desc tb_member_empty;
select * from tb_member_empty;
