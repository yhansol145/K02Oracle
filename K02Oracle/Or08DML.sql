/**************************
���ϸ� : Or08DML.sql
DML : Data Manipulation Language(������ ���۾�)
���� : ���ڵ带 �����Ҷ� ����ϴ� ������. �տ��� �н��ߴ�
    select���� ����Ͽ� update(���ڵ����), delete(���ڵ����),
    insert(���ڵ��Է�)�� �ִ�.
**************************/

-- study�������� �ǽ��մϴ�.

/*
���ڵ� �Է��ϱ� : insert��
    ���ڵ� �Է��� ���� ������ �������� �ݵ�� '�� ���ξ��Ѵ�.
    �������� '���� �׳� ����. ���� �������� '�� ���θ� �ڵ�����
    ����ȯ�Ǿ� �Էµȴ�.
*/

-- �ǽ��� ���� ���̺� ����
create table tb_sample (
    deptNo number(10),          --�μ���ȣ
    deptName varchar2(20),      --�μ���
    deptLoc varchar2(15),       --����
    deptManager varchar2(30)    --�Ŵ����̸�
);
desc tb_sample;

-- ���1�� ���� ���ڵ� �Է�
insert into tb_sample (deptno, deptname, deptloc, deptmanager)
    values (10, '��ȹ��', '����', '����');
insert into tb_sample (deptno, deptname, deptloc, deptmanager)
    values (20, '������', '����', '����');

-- ���2
insert into tb_sample values (30, '������', '�뱸', '���');
insert into tb_sample values (40, '�λ���', '�λ�', '��ȿ');

select * from tb_sample;
commit;
/*
    ���ݱ����� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� �������
    Ŀ���� �������� ������ �ܺο����� ����� ���ڵ带 Ȯ���� �� ����.
    ���⼭ ���ϴ� �ܺδ� Java/JSP�� ���� Oracle�̿��� ���α׷��� ���Ѵ�.
    �� Ʈ������̶� �۱ݰ� ���� �ϳ��� �����۾��� ���Ѵ�.
*/

-- Ŀ������ ���ο� ���ڵ带 �����ϸ� �ӽ����̺� ����ȴ�.
insert into tb_sample values (50, '������', '����', '���̸�');
-- ����Ŭ���� Ȯ���ϸ� ���� ���ԵȰ�ó�� ���δ�. ������ �ܺο����� Ȯ�ε��� �ʴ´�.
select * from tb_sample;
-- �ѹ� ������� ������ Ŀ�� ���·� �ǵ�����.
rollback;
-- �������� �Է��ߴ� 50�� ���ڵ�('���̸�')�� �������.
select * from tb_sample;
/*
    �ѹ� ����� ������ Ŀ�� ���·� �ǵ����ش�.
    ��, commit�� ������ ���·δ� rollback�� �� ����.
*/


/*
���ڵ� �����ϱ� : update��
    ����]
        update ���̺��
        set �÷�1=��1, �÷�2=��2, ....
        where ����;
        
    �� ������ ���°�� ��� ���ڵ尡 �Ѳ����� �����ȴ�.
    �� ���̺�� �տ� from�� ���� �ʴ´�.
*/
-- �μ���ȣ 40�� ���ڵ��� ������ �̱����� �����Ͻÿ�.
update tb_sample set deptloc='�̱�' where deptno=40;
select * from tb_sample;

-- ������ ������ ���ڵ��� �Ŵ������� '������'���� �����Ͻÿ�.
update tb_sample set deptmanager='������' where deptloc='����';
select * from tb_sample;

-- where�� ���� ��� ���ڵ带 ������� ������ '���������'�� �����Ͻÿ�.
update tb_sample set deptloc='���������';
select * from tb_sample;

/*
������ �����ϱ� : delete��
    ����]
        delete from ���̺�� where ����;
        �� ���ڵ带 �����ϹǷ� delete �ڿ� �÷��� ������� �ʴ´�.
*/
-- �μ���ȣ�� 10�� ���ڵ带 �����Ͻÿ�.
delete from tb_sample where deptno=10;
select * from tb_sample;

--wherer�� ���� �����ϸ� ��� ���ڵ� ������(���ǿ��)
delete from tb_sample;
select * from tb_sample;

rollback;
select * from tb_sample;

update tb_sample set deptname='�ڽ���' where deptno>=30;
select * from tb_sample;
update tb_sample set deptno=deptno+1;
select * from tb_sample;

commit;
