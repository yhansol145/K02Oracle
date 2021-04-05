/*********************
���ϸ� : Or12Sequence & Index.sql
������ & �ε���
���� : ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� ��������
    �˻��ӵ��� ����ų �� �ִ� �ε���
*********************/

-- study �������� �ǽ��մϴ�.

/*
������
    : ���̺��� Į���� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��ϴ�
    ������ �Ѵ�. �׻� ������ �ǰ� ���Ҵ� ���� �ʴ� Ư¡�� ������ �ִ�.
*/

-- ��ǰ���̺� ����
create table tb_goods (
    g_idnx number(10) primary key,
    g_name varchar2(30)
);
insert into tb_goods values (1, '�����'); --�Է¼���
insert into tb_goods values (1, '���ı�'); --�Է½���
-- �������� ���ٸ� max() �Լ��� ���� �Ϸù�ȣ�� ���ؾ� �Ѵ�.
select max(g_idx)+1 from tb_goods;
insert into tb_goods values (2, '���ı�'); --�Է½���
/*
�Է��� �Լ��� ���� Ȯ���ϴ°��� ���ŷο�Ƿ� �������� �����Ͽ�
�Է½� ����Ѵ�.
*/
create sequence seq_serial_num
    increment by 1      -- ����ġ
    start with 100      -- ������ ��
    minvalue 99         -- �ּҰ�
    maxvalue 110        -- �ִ밪
    cycle               -- ����Ŭ ��뿩��(�����)
    nocache;            -- ĳ�� ��뿩��(������)
    
-- ������ �������� ������ ������ Ȯ��
select * from user_sequences;

-- �������� ����ؼ� ������ �Է�
insert into tb_goods values (seq_serial_num.nextval, '������');
insert into tb_goods values (seq_serial_num.nextval, 'Ȩ����');
select * from tb_goods;

/*
    currval : ���� ���������� ��ȯ�Ѵ�.
    nextval : ���� �������� ��ȯ�Ѵ�.
*/
select seq_serial_num.currval from dual;
select seq_serial_num.nextval from dual;

-- 10�� �̻� �Է��ϸ� PK�������� ����� ������ �߻��Ѵ�.
insert into tb_goods values (seq_serial_num.nextval, '��������');
/*
    �������� cycle�ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ ���ư�
    �Ϸù�ȣ�� �����ǹǷ� ���Ἲ �������ǿ� ����ȴ�. �� �⺻Ű�� �����
    �������� cycle�ɼ��� ����ϸ� �ȵȴ�.
*/

-- ������ �����ϱ�
alter sequence seq_serial_num
    increment by 10
    nomaxvalue -- �������� ǥ���� �� �ִ� �ִ�ġ�� ����ϰڴٴ� �ǹ�.
    minvalue 1
    nocycle
    nocache; -- start with�� ������ �� ����.
select * from user_sequences;

-- ������ �����ϱ�
drop sequence seq_serial_num;
select * from user_sequences;

-- �Ϲ����� ������ ������ �Ʒ��� ���� �մϴ�.
create sequence seq_serial_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;/*
        �ִ밪, ����Ŭ, ĳ���� �Ϲ������� ������� �ʴ´�.
    */
select * from user_sequences;

select seq_serial_num.currval from dual;
select seq_serial_num.nextval from dual;

/*
������ ���� �� ���� ����ÿ��� currval�� ������ �߻��Ѵ�.
nextval�� ���� �����Ͽ� ���������� ��ȯ�� �� currval�� ����������
������ �������� ��ȯ�ȴ�.
*/

-- ��ǰ���̺� ���ο� �÷��� �߰��Ѵ�.
alter table tb_goods add re_idx number;
select * from tb_goods;

/*
���� ������ �������� nextval�� ������ ����ϴ��� �׻� ��������
��ȯ�Ѵ�.
*/
insert into tb_goods values (seq_serial_num.nextval,
    '��Ʈ��', seq_serial_num.nextval);



/*
�ε��� : ���� �˻��ӵ��� ����ų �������� �����ϴ� ��ü
    primary key, unique�� ������ �÷����� �ڵ����� index�� �����ȴ�.
*/

-- �ε��� ����
create index tb_goods_name_idx on tb_goods (g_name);

-- �����ͻ������� Ȯ���ϱ�
select * from user_ind_columns;

-- �ε��� ����
drop index tb_goods_name_idx;

-- �ε����� ������ �Ұ����ϹǷ� ���� ������ �ʿ��ϴٸ� ���� �� �ٽ� �����Ѵ�.