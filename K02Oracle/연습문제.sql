--DDL
--scott �������� �����մϴ�.

--����1
create table pr_dept(
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

--����2
create table pr_emp(
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
);

--����3
alter table pr_emp modify ename varchar2(50);

--����4
--1.
create table pr_emp_clone
as
select eno"e_no", ename"e_name", job"job_id"
from pr_emp where 1=0;

--2. 
create table pr_emp_clone(
    e_no, e_name, job_id
)
as
select eno, ename, job from pr_emp where 1=1;


--����5
alter table pr_emp_clone rename to pr_emp_clone_rename; -- ���1
rename pr_emp_clone to pr_emp_clone_rename; -- ���2
desc pr_emp_clone; --������ ���̺��� ������
desc pr_emp_clone_rename; --���ο� ���̺� ������

--����6
alter table pr_dept drop column dname;

--����7
alter table pr_emp modify job varchar(50);

--����8
drop table pr_emp_clone_rename;


/*
DDL�� -> ���̺��� ���� �� �����ϴ� ������
���̺���� : create table ���̺��
�÷��߰� : alter table ���̺�� add
�÷����� : alter table ���̺�� modify 
�÷����� : alter table ���̺�� drop column �÷���
���̺���� : drop table ���̺��
*/



/*
-------------------------------------------------------------------
*/



--DML
--scott�������� �����մϴ�.

--����1
insert into pr_emp values (1, '���¿�', '� �¹�', sysdate);
insert into pr_emp values (2, '������', '���л� �¹�', sysdate);
insert into pr_emp values (3, '�Ѱ���', '� ����', sysdate);
insert into pr_emp values (4, '����', '���л� ����', sysdate);

--����2
insert into pr_emp (ename, job, regist_date)
    values ('������', '������', to_date(sysdate-7, 'yy/mm/dd'));
        -- to_date �� �� ����� �ʿ�� ����. 'sysdate-7' �ص� ��

--����3
update pr_emp set job = concat(job, '��¦�����ڵ�')
    where mod(eno, 2) = 0;

-- pr_employees ���̺� ����(�����ͱ���)
create table pr_employees
as
select * from emp where 1=1; -- where ���� ���� ������ �ָ� ��� ���ڵ带 �����Ѵ�.


--����4

-- �����ȣ 7900�� Ȯ��
select * from pr_employees where empno=7900; --��� : �Ŵ��� ��� 7698
-- �Ŵ����� 7698�� ����� Ȯ��
select * from pr_employees where mgt=7698; --��� : �μ���ȣ 30
-- FORD�� �μ���ȣ Ȯ��
select * from pr_employees where ename='FORD'; --��� : �μ���ȣ 20
-- ���� ������Ʈ
update pr_employees set deptno=20 where mgr=7698;

select mgr
from pr_employees
where empno=7900;

select deptno
from pr_employees
where lower(ename)='ford';

update pr_employees 
set deptno =(select deptno from pr_employees where lower(ename)='ford')
where mgr = (select mgr from pr_employees where empno=7900);

--����5
delete from pr_employees where to_char(hiredate, 'mm')=12; --��¥���� ���
delete from pr_employees where substr(hiredate,4,2)=12; --���ڿ� �ڸ��� ���
delete from pr_employees where hiredate like '___12%'; --like�� ���, ���ϵ�ī�� (_) ����� ���

--����6
select max(hiredate)
from pr_employees; --��� : 82/01/23

select * from pr_employees
where to_char(hiredate,'yy')=82; --��� : MILLER

alter table pr_employees modify ename varchar2(20);

update pr_employees set ename=concat(ename, '(���Ի��)')
where hiredate='82/01/23';

/*
update pr_employees
set ename = concat((select ename from pr_employees where hiredate 
          = (select max(hiredate) from pr_employees)),'(���Ի��)')
where hiredate = (select max(hiredate) from pr_employees);
*/ -- �ʹ� �� �ڵ�.. ���� �ۼ��� �ڵ�


/*
DML�� -> ���ڵ带 �Է� �� �����ϴ� ������
���ڵ��Է� : insert into ���̺�� (�÷�) values (��)
���ڵ���� : update ���̺�� set �÷�=�� where ����
���ڵ���� : delete from ���̺�� where ����
���ڵ���ȸ : select �÷� from ���̺�� where ����
*/









--��������
--scott�������� �����մϴ�.


--����1
create table pr_emp_const
as
select * from emp where 1=0; --������ �������� ���̺��� ������ �����Ѵ�.

alter table pr_emp_const add
    constraint pr_emp_pk
        primary key(empno); --�⺻Ű �������� �߰�
        
/*
�����ͻ������� �������� Ȯ���ϱ�
select * from user_cons_columns where constraint_name=upper('pr_emp_pk');
select * from user_constraint where lower(constraint_name)=('pr_emp_pk');
*/

--����2
create table pr_dept_const
as
select * from dept where 1=0; --������ �������� ���̺��� ������ ����

alter table pr_dept_const add
    constraint pr_dept_pk
        primary key(deptno); --�⺻Ű �������� �߰�
        
--�����ͻ������� �������� Ȯ���ϱ�
select * from user_cons_columns where constraint_name=upper('pr_dept_pk');
    
/* ����3
3. pr_dept_const ���̺� �������� �ʴ� �μ��� ����� �������� �ʵ���
�ܷ�Ű ���������� �����ϵ� �������� �̸��� pr_emp_dept_fk�� �����Ͻÿ�.
*/

alter table pr_emp_const
    add constraint pr_emp_dept_fk           -- �������Ǹ� �߰�
        foreign key (deptno)                -- �ڽ����̺��� �ܷ�Ű(����Ű) �÷�
        references pr_dept_const (deptno);  -- �θ����̺��� �⺻Ű(PK) �÷�

--�����ͻ������� �������� Ȯ���ϱ�
select * from user_cons_columns where constraint_name=upper('pr_emp_dept_fk');

/*
4. pr_emp_const ���̺��� comm �÷��� 0���� ū ������ �Է��� �� �ֵ���
���������� �����Ͻÿ�. �������Ǹ��� �������� �ʾƵ� �ȴ�.
*/
alter table pr_emp_const add --[constraint �������Ǹ�] ����
    check (comm > 0);

-- �������� Ȯ���� ���� ���ڵ� ����
insert into pr_emp_const values 
    (100, '�ƹ���', '����', null, sysdate, 1000, 0, 10); 
        --�Է½��� : check �������� ����.
insert into pr_emp_const values 
    (100, '�ƹ���', '����', null, sysdate, 1000, 0.3, 10);
        --�Է½��� : �ܷ�Ű �������� ����. �θ�Ű ����.

-- �θ����̺� ���ڵ� �Է�
insert into pr_dept_const values (10, '���ǹ�', '����');
insert into pr_dept_const values (20, '�����ǹ�', '������');

-- �տ��� �Է½����� ���ڵ� �Է�
insert into pr_emp_const values 
    (100, '�ƹ���', '����', null, sysdate, 1000, 0.3, 10);
insert into pr_emp_const values 
    (101, '����', '��', null, sysdate, 800, 0.45, 20);
select * from pr_emp_const;

/*
5. �� 3�������� �� ���̺��� �ܷ�Ű�� �����Ǿ
pr_dept_const ���̺��� ���ڵ带 ������ �� ������.
�� ��� �θ��ڵ带 ������ ��� �ڽı��� ���� ������ �� �ֵ���
�ܷ�Ű�� �����Ͻÿ�.
*/
--�θ����̺�
select * from pr_dept_const;
--�ڽ����̺�
select * from pr_emp_const;
--�θ����̺��� ���ڵ� �����ϱ�
delete from pr_dept_const where deptno=10; /*
                �ڽķ��ڵ尡 �����Ƿ� �����Ұ���.
                �ܷ�Ű �������� ����.
        */

--�ܷ�Ű �缳���� ���� ������ �ܷ�Ű�� �����Ѵ�.
alter table pr_emp_const drop constraint pr_emp_dept_fk;

--�ܷ�Ű �缳�� : �θ��ڵ� ������ �ڽķ��ڵ���� ���ÿ� �����ǵ��� ����
alter table pr_emp_const
    add constraint pr_emp_dept_fk         
        foreign key (deptno)               
        references pr_dept_const (deptno)
        on delete cascade;

--�ڽķ��ڵ尡 �ִ� ���¿��� �θ��ڵ� �����ϱ�
delete from pr_dept_const where deptno=10;
select * from pr_dept_const;
select * from pr_emp_const; --���������� ������.

commit;

