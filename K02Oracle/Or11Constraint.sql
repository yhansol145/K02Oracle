/****************************
���ϸ� : Or11Constraint.sql
��������
���� : ���̺� ������ �ʿ��� �������� �������ǿ� ���� �н��Ѵ�.
****************************/

-- study �������� �ǽ��մϴ�.


/*
Primary key : �⺻Ű
- �������Ἲ�� �����ϱ� ���� ���������̴�.
- �ϳ��� ���̺� �ϳ��� �⺻Ű�� ������ �� �ִ�.
- �⺻Ű�� �����Ǹ� �� �÷��� �ߺ��Ȱ��̳� NULL���� �Է��� �� ����.
*/

/*
����1] �ζ��� ���
    create table ���̺�� (
        �÷��� �ڷ��� [constratin PK�����] primary key
    );
*/
create table tb_primary1 (
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
);
desc tb_primary1;
/*
�������� Ȯ���ϱ�
    user_cons_column : ���̺� ������ �������Ǹ�� �÷�����
        ������ ������ Ȯ���� �� �ִ�.
    user_constraints : ���̺� ������ ���������� ���� ������
        Ȯ���� �� �ִ�.
�� �̿Ͱ��� ���������̳� ��, ���νü����� ������ �����ϰ� �ִ�
    �ý��� ���̺��� "�����ͻ���"�̶�� �Ѵ�.
*/
select * from user_cons_columns;
select * from user_constraints;

insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'kosmo', '�ڽ���');
insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'gasmo', '������');/*
        ���Ἲ�������� ����� �����߻�. PK�� ������ �÷� idx����
        �ߺ��� ���� �Է� �� �� ����.
    */
insert into tb_primary1 values (2, 'black', '��');
insert into tb_primary1 values ('', 'white', 'ȭ��Ʈ');/*
        PK�� ������ �÷������� null(��) �� �Է��� �� ����.
    */
select * from tb_primary1;
update tb_primary1 set idx=2 where user_name='�ڽ���';/*
        update���� ���������� idx���� �̹� �����ϴ� 2��
        ���������Ƿ� �������� ����� �����߻�
    */


/*
����2] �ƿ����� ���
    create table ���̺�� (
        �÷��� �ڷ���,
        [constraint �����] primary key (�÷���)
    );
*/
create table tb_primary2 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50),
    primary key (user_id)
);
desc tb_primary2;
select * from user_constraints;


/*
����3] ���̺� ������ alter������ �������� �߰�
    alter table ���̺�� add [constraint �����] primarry key (�÷���);
*/
create table tb_primary3 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50)
);
alter table tb_primary3 add
    constraint tb_primarry3_pk
        primary key (user_name);
desc tb_primary3;
select * from user_constraints;

--���̺��� �����ϸ� �ο��ߴ� PK �������ǵ� ���� �����ȴ�.
drop table tb_primary3;
select * from user_constraints;



/*
Unique : ����ũ
- ���� �ߺ��� ������� �ʴ� ��������
- ����, ���ڿ��� �ߺ��� ������� ������, null���� ���ؼ���
    �ߺ��� ����Ѵ�.
- unique�� �� ���̺� 2�� �̻� ������ �� �ִ�.
*/
create table tb_unique1(
    idx number unique not null,
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    unique(telephone, nickname)
);
select * from user_constraints;
select * from user_cons_columns;

insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '���̸�', '010-1111-1111', '����뺪');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (2, '����', '010-2222-2222', '');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (3, '����', '', '');
select * from tb_unique1;

insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '����', '010-3333-3333', ''); --�����߻�. �ߺ��� idx�� ����.

insert into tb_unique1 values (4, '���켺', '010-4444-4444', '��ȭ���');
insert into tb_unique1 values (5, '������', '010-5555-5555', '��ȭ���'); --�Է¼���
insert into tb_unique1 values (6, 'Ȳ����', '010-4444-4444', '��ȭ���'); --�����߻�
/*
    telephone�� nickname �÷��� ������ ��������� �����Ǿ����Ƿ�
    �ΰ��� �÷��� ���ÿ� ������ ���� ������ ��찡 �ƴ϶�� �ߺ��Ȱ���
    ���ȴ�.
    �� 4���� 5���� ���� �ٸ� �����ͷ� �ν��ϹǷ� �Էµǰ�,
    4���� 6���� ������ �����ͷ� �νĵǾ� ������ �߻��Ѵ�.
*/


/*
Unique 2��° ����
*/
create table tb_unique2(
    idx number primary key,
    name varchar2(30),
    mobile varchar2(20),
    unique (mobile)
);
select * from user_cons_columns;



/*
Foreign key : �ܷ�Ű, ����Ű
- �ܷ�Ű�� �������Ἲ�� �����ϱ� ���� ���������̴�.
- ���� ���̺��� �ܷ�Ű�� �����Ǿ� �ִٸ� �ڽ����̺� ��������
    ������ ��� �θ����̺��� ���ڵ�� �������� �ʴ´�.
*/

/*
����1] �ζ��ι��
    create table ���̺�� (
        �÷��� �ڷ��� [constraint �����]
            references �θ����̺�� (�θ����̺��� PK�÷���)
    );
*/
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    f_id varchar2(30) constraint tb_foreign1_fk
        references tb_primary2 (user_id)
);
-- �θ����̺� ���ڵ尡 ���� ���� ������
select * from tb_primary2;
-- �θ����̺� ������ ���ڵ尡 �����Ƿ� �ڽ����̺� �ԷºҰ�
insert into tb_foreign1 values (1, '���ʿ�', 'WannerOne');
-- �θ����̺� ���ڵ� ���� ����
insert into tb_primary2 values (1, 'BTS', '��ź�ҳ��');
-- �θ����̺��� ������ ���ڵ带 ������� �ڽ����̺� ���ڵ� ���Ե�
insert into tb_foreign1 values (1, '��ź�ҳ��', 'BTS');
-- �θ�Ű�� �����Ƿ� �ԷºҰ�
insert into tb_foreign1 values (2, 'Ʈ���̽�', 'Twice');

-- �Էµ� ���ڵ� Ȯ��
select * from tb_primary2;
select * from tb_foreign1;

/*
    �ڽ����̺��� �����ϴ� ���ڵ尡 ������, �θ����̺��� ���ڵ带
    ������ �� ����. �̰�쿡�� �ݵ�� �ڽ����̺��� ���ڵ带 ���� ������ ��
    �θ����̺��� ���ڵ带 �����ؾ� �Ѵ�.
*/
delete from tb_primary2 where idx=1; -- �����߻�

delete from tb_foreign1 where f_idx=1; -- �ڽ����̺��� ���ڵ带 ���� ������ ��
delete from tb_primary2 where idx=1; -- �θ����̺��� ���ڵ带 �����Ѵ�.

-- �����̺� ��ο��� �����Ǿ����� Ȯ��
select * from tb_primary2;
select * from tb_foreign1;


/*
����2] �ƿ����� ���
    create table ���̺�� (
        �÷��� �ڷ��� ,
        
        [constraint �����] foreign key (�÷���)
            references �θ����̺� (�θ����̺��� �������÷�)
    )
*/
create table tb_foreign2 (
    f_id number primary key,
    f_name varchar2(30),
    f_date date,
    
    foreign key (f_name) references tb_primary3(user_name)
);
select * from user_constraints;
/*
������ �������� �������� Ȯ�ν� �÷���
P : Primary key
R : Reference integrity �� Foreign key�� ����
C : Check Ȥ�� Not null
U : Unique
*/


/*
�ܷ�Ű ������ �ɼ�
[on delete cascade]
    -> �θ��ڵ� ������ �ڽķ��ڵ���� ���� ������
    ����]
        �÷��� �ڷ��� references �θ����̺�(PK�÷�)
            on delete cascadel;
[on delete set null]
    -> �θ��ڵ� ������ �ڽķ��ڵ尪�� null�� �����
    ����]
        �÷��� �ڷ��� references �θ����̺�(PK�÷�)
            on delete set null
�� �ǹ����� ���԰Խù��� ���� ȸ���� �� �Խñ��� �ϰ������� �����ؾ� �Ҷ�
����� �� �ִ� �ɼ��̴�. ��, �ڽ����̺��� ��� ���ڵ尡 �����ǹǷ� ��뿡
�����ؾ��Ѵ�.
*/
create table tb_primary4(
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign4 (
    f_idx number(10) primary key,
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign4_fk
        references tb_primary4 (user_id)
            on delete cascade
);
insert into tb_primary4 values ('kosmo', '�ڽ���'); -- �׻� �θ����̺� ���� �Է� ��
insert into tb_foreign4 values (1, '1���Դϴ�', 'kosmo'); -- �ڽ����̺� �Է��ؾ� �Ѵ�.
insert into tb_foreign4 values (2, '2���Դϴ�', 'kosmo');
insert into tb_foreign4 values (3, '3���Դϴ�', 'kosmo');
insert into tb_foreign4 values (4, '4���Դϴ�', 'kosmo');
insert into tb_foreign4 values (5, '5���Դϴ�', 'kosmo');
insert into tb_foreign4 values (6, '6���Դϴ�', 'kosmo');
insert into tb_foreign4 values (7, '7���Դϴ�', 'hong'); -- �θ�Ű�� �����Ƿ� �����߻�

select * from tb_primary4;
select * from tb_foreign4;

delete from tb_primary4;/*
            �θ����̺��� ���ڵ� ���� �� on delete cascade �ɼǶ�����
            �θ��ʻӸ� �ƴ϶� �ڽ����̺���� ��� ���ڵ尡 �����ȴ�.
    */

select * from tb_primary4;
select * from tb_foreign4;


-- on delete set null �ɼ� �׽�Ʈ
create table tb_primary5 (
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign5 (
    f_idx number(10) primary key,
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign5_fk
        references tb_primary5 (user_id) on delete set null
);

insert into tb_primary5 values ('kosmo', '�ڽ���');
insert into tb_foreign5 values (1, '1���Խù�', 'kosmo');
insert into tb_foreign5 values (2, '2���Խù�', 'kosmo');
insert into tb_foreign5 values (3, '3���Խù�', 'kosmo');
insert into tb_foreign5 values (4, '4���Խù�', 'kosmo');
insert into tb_foreign5 values (5, '5���Խù�', 'kosmo');

-- �Էµ� ���ڵ� Ȯ��
select * from tb_primary5;
select * from tb_foreign5;

/*
on delete set null �ɼ����� �ڽ����̺��� ���ڵ�� �������� �ʰ�
����Ű �κи� null������ ����ȴ�.
*/
delete from tb_primary5;

select * from tb_primary5;
select * from tb_foreign5;


/*
not null : null ���� ������� �ʴ� ��������
    ����]
        create table ���̺�� (
            �÷��� �ڷ��� not null,
            �÷��� �ڷ��� null <- null�� ����ϰڴٴ� �ǹ̷� �ۼ�������
                            �̷��Դ� ������� �ʴ´�. null�� �������
                            �ʴ°��� ��������̴�.
        )
*/
create table tb_not_null (
    m_idx number(10) primary key, -- PK�� ���������Ƿ� NN
    m_id varchar2(30) not null,   -- NN (not null)
    m_pw varchar2(40) null,       -- null ���(�Ϲ������� null�� ����)
    m_name varchar2(50)           -- null ���(�̿Ͱ��� �����Ѵ�)
);
desc tb_not_null;

insert into tb_not_null values (10, 'hong1', '1111', 'ȫ�浿');
insert into tb_not_null values (20, 'hong2', '2222', '');
insert into tb_not_null values (30, 'hong3', '', '');
insert into tb_not_null values (40, '', '4', '��浿'); -- �Է½���. null�� �Է��Ҽ�����
insert into tb_not_null (m_id, m_pw, m_name)
    values ('hong5', '5555', '���浿'); -- �Է½���. m_dix�÷��� ���� �ԷµǾ���.
insert into tb_not_null values (60, ' ', '6666', '���浿'); -- �Է¼���(space�� ����)

select * from tb_not_null;

/*
Default : insert�� �ƹ��� ���� �Է����� ������ �ڵ����� ���ԵǴ� �����͸� ���Ѵ�.
*/
create table tb_default (
    id varchar2(30) not null,
    pw varchar2(30) default 'qwer'
);
desc tb_default;
select * from tb_default;
insert into tb_default values('aaaa', '1234'); -- 1,2,3,4 �Է�
insert into tb_default values('bbbb', ''); -- null���� �ʿ�
insert into tb_default (id) values ('cccc'); -- default�� ���Ե�
insert into tb_default (id, PW) values ('dddd', default); -- default�� ���Ե�
/*
    ������ ������ default���� �Է��Ϸ��� insert�ٽ� �÷������� �����ϰų�
    default Ű���带 ����ؾ� �Ѵ�.
*/



/*
check : Domain(�ڷ���) ���Ἲ�� �����ϱ� ���� ������������
    �ش��÷��� �߸��� �����Ͱ� �Էµ��� �ʵ��� �����ϴ� ���������̴�.
*/
create table tb_check1(
    gender varchar2(20) not null
        constraint check_gender
            check (gender in ('M', 'F'))
);
insert into tb_check1 values('M');
insert into tb_check1 values('F');
insert into tb_check1 values('A');  -- �Է½���
insert into tb_check1 values('Man'); -- �Է½���
insert into tb_check1 values('����'); -- �Է½���

create table tb_check2(
    ticket_cnt number not null
        check(ticket_cnt<=5)
);
insert into tb_check2 values (4);
insert into tb_check2 values (5);
insert into tb_check2 values (6); -- �Է½���. check�������ð� ����