/****************************************
���ϸ� : Or13DCL.sql
DCL(Data Control Language)(������ �����)
����ڱ���
���� : ���ο� ����ڰ����� �����ϰ� �ý��۱����� �ο��ϴ� ����� �н�
****************************************/
  
/*
[����ڰ��� ���� �� ���Ѽ���]
�ش� ������ DBA������ �ִ� �ְ������(sys, system)�� ������ ��
�����ؾ� �Ѵ�. (����� ���� ������ ���� �׽�Ʈ�� CMD(���������Ʈ)����
�����ϵ��� �Ѵ�.
*/

/*
1] ����ڰ��� ���� �� ��ȣ����
����]
create user ���̵� identified by �н�����;
*/
create user test_user identified by 1234;
-- cmd���� sqlplus ������� ���ӽ� login denied ���� �߻���

/*
] ������ ����� ������ ���� Ȥ�� ���� �ο�
����]
    grant �ý��۱���1[,�ý��۱���2 .... ] | [����1[,����2....]
        to �����1[,�����2 .... ] | [����1[,����2 ....]
        [with grant option];
*/
-- ���ӱ��Ѻο� : ������ ������ ���̺��� ������ �� ����.
grant create session to test_user1;

-- ���̺� �������� �ο� : ���̺� �����̽��� ���� �������� �ʴ´�.
grant create table to test_user1;

/*
���̺� �����̽���?
    ��ũ ������ �Һ��ϴ� ���̺�� ��, �׸��� �� ���� �ٸ� �����ͺ��̽�
    ��ü���� ����Ǵ� ����̴�. ���� ��� ����Ŭ�� ���ʷ� ��ġ�ϸ�
    hr������ �����͸� �����ϴ� user��� ���̺� �����̽��� �ڵ����� �����ȴ�.
*/
-- ���̺� �����̽� ��ȸ�ϱ�
select tablespace_name, status, contents from dba_tablespaces;
desc dba_tablespaces;

-- ���̺� �����̽��� ��� ������ ���� Ȯ���ϱ�
select tablespace_name, sum(bytes), max(bytes) from dba_free_space
    group by tablespace_name;

-- �տ��� ������ test_user1 ������� ���̺� �����̽��� Ȯ���Ѵ�.
select username, default_tablespace from dba_users
    where username in upper('test_user1');

-- ���̺� �����̽� ���� �Ҵ�
alter user test_user1 quota 2m on system; /*
            test_user1�� system ���̺����̽��� ���̺��� ������ �� �ֵ���
            2m�� �뷮�� �Ҵ��Ѵ�.
        */

-- 2��° ����� �߰� : ���̺����̽� users�� ����� �� �ֵ��� �����Ѵ�.
create user test_user2 identified by 1234 default tablespace users;

-- ���ӱ��� �߰�
grant create session to test_user2; 
-- ���̺� �����õ�1 => insufficient privileges : ���Ѻ����
-- ���̺� �������� �߰�
grant create table to test_user2;
-- ���̺� �����õ�2 => no privileges on tablespace 'USERS' : ���̺����̽��� ���� ����
-- test_user2�� ����ϴ� ���̺� �����̽��� Ȯ��
select username, default_tablespace from dba_users
    where username in upper('test_user2');
-- users ���̺����̽��� ���� �Ҵ�
alter user test_user2 quota 10m on users;
-- ���̺� �����õ�3 => ����

/*
������ ������� ����Ʈ ���̺����̽��� �����ϰ� �������
    : test_user1�� ����Ʈ ���̺� �����̽��� users�� �����Ѵ�.
*/
alter user test_user1 default tablespace users;


/*
# sqlplus���� ED��ɾ�
    : �� �������� �ۼ��Ҷ� �޸����� editer�� Ȱ���Ͽ�
    �����Ű�� ���

1. ���� �����ϱ�
SQL> ed new_table [Enter]
-> �̿Ͱ��� ������ ����ڰ��� ���丮�� new_table.sql ������ �����ȴ�.

2. �޸��忡�� ���̺��� �����Ѵ�.
    ������ ���忡 /�� �� �ٿ��ش�.
    �ۼ��� �Ϸ�Ǹ� ���� �� ������ �ݾ��ش�.
    
3. ����
SQL> @new_table [Enter]

4. �������� �����ÿ��� ���� ������ �����ϰ� �����Ѵ�.
SQL> ed ���ϸ� [Enter]
�� �ش� ������ ������ �����̰�, ���ٸ� ���Ӱ� �����ϰ� �ȴ�.
*/

-- �ý��� ���� ��� Ȯ���ϱ� : 208���� �ý��� ������ ����
select * from system_privilege_map;





/*
3] ��ȣ����
    ; alter table ����ھ��̵� identified by ���ο� ��ȣ;
*/
alter user test_user1 identified by 4321;


/*
4] ROLE(��)�� ���� �������� ���� ���ÿ� �ο��ϱ�
    : ���� ����ڰ� �پ��� ������ ȿ�������� ������ �� �ֵ���
    ���õ� ���ѳ��� ����������� ���Ѵ�.
�� �츮�� �ǽ��� ���� ���Ӱ� ������ ������ connect, resource���� �ַ� �ο��Ѵ�.
*/
--test_user2 ����ڿ� �Ʒ� �ΰ��� ���� �ο��Ѵ�.
grant connect, resource to test_user2;
--cmd���� new_table.sql ������ �����Ѵ�. (����������, ���ڵ� �Է�)

/*
4-1] �� �����ϱ�
    : ����ڰ� ���ϴ� ������ ���� ���ο� ���� ������ �� �ִ�.
����]
    create role ���̸�;
*/
create role kosmo_role;

/*
4-2] �ѿ� ���� �ο��ϱ�
����]
    grant ����1, ����2, ..... to ���̸�;
*/
grant create session, create table, create view to kosmo_role;
--���ο� ����ڻ���
create user test_user3 identified by 1234;
--�տ� ������ ����ڿ� ���� ���� ���Ѻο�
grant kosmo_role to test_user3;
--�����ͻ������� �� Ȯ���ϱ�
select * from role_sys_privs where role like upper('%kosmo_role%');

/*
[4-3] �� �����ϱ�
*/
drop role kosmo_role;
/*
    test_user3 ����ڴ� ���� ���� ������ �ο��޾����Ƿ�
    �ش� ���� �����ϸ� �ο��޾Ҵ� ��� ������ ȸ��(����)�ȴ�.
    ��, �� �����Ŀ��� ������ �� ���� �ȴ�.
*/


/*
5] ��������
    ����] revoke ���� �� ���� from ����ڰ���;
*/
revoke create session from test_user1;


/*
6] ����ڰ��� ����
    ����] drop user ����ھ��̵� [cascade];
�� cascade�� ����ϸ� ����ڰ����� ���õ� ��� �����ͺ��̽� ��Ű����
�����ͻ������κ��� �����ǰ� ��� ��Ű�� ��ü�� ���������� �����ȴ�.
*/
--����ڸ���� Ȯ���� �� �ִ� �����ͻ���
select * from dba_users;

drop user test_user1 cascade;

