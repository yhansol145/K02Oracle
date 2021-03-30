/*************************
���ϸ� : Or03String.sql
���ڿ� ó���Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� �� ���ڿ���
�����ϴ� �Լ�
*************************/

/*
concat(���ڿ�1, ���ڿ�2)
    : ���ڿ� 1�� 2�� ���� �����ؼ� ����ϴ� �Լ�
    ����1 - concat('���ڿ�1', '���ڿ�2')
    ����2 - '���ڿ�1' || '���ڿ�2'
*/
select concat('Good ', 'morning') AS "��ħ�λ�" from dual;
select 'Oracle'||' 11kg'||' Good' from dual;
-- => ���� SQL ���� concat()���� �����ϸ�...
    select concat(concat('Oracle', ' 11g'), ' Good') from dual;


/*
initcap(���ڿ�)
    : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�.
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����.
    - ���鹮�� ������ ���� ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
    - ���ĺ��� ���ڸ� ������ ������ ���� ������ ������ ù��° ���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
*/
select initcap('hi hello �ȳ�') from dual;
select initcap('good/bad morning') from dual;
select initcap('never6say*good��bye') from dual;

--������̺��� john �� ã�Ƽ� �����Ͻÿ�
select first_name, last_name from employees
    where first_name='john'; --�������
select first_name, last_name from employees
    where first_name='John'; --3������
select first_name, last_name from employees
    where first_name=initcap('john'); --3������


/*
��ҹ��ں���
lower() : �ҹ��ڷ� ������
upper() : �빮�ڷ� ������
*/
select lower('GOOD'), upper('bad') from dual;
--�������� ���� john�� �˻��Ϸ���...
select * from employees where lower(first_name)='john';
select * from employees where upper(first_name)='JOHN';
--�÷��� ����� ���� �빮�� Ȥ�� �ҹ��ڷ� ������ �� �������� �˻��Ѵ�.


/*
lpad(), rpad()
    : ���ڿ��� ����, �����ʿ� Ư���� ��ȣ�� ä�ﶧ ����ϴ� �Լ�
    ����] lpad('���ڿ�', '��ü�ڸ���', 'ä�﹮�ڿ�')
        -> ��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ������ ������
        �����κ��� �־��� ���ڿ��� ä���ִ� �Լ�
        rpad()�� �������� ä����.
*/
select
    'good',
    lpad('good', 7, '#'),
    rpad('good', 7, '#'),
    lpad('good', 7),
    rpad('good', 7)
from dual;


/*
trim() : ������ �����Ҷ� ����ϴ� �Լ�
    ����] trim([leading | trailing | both] �����ҹ��� from �÷�)
        - leading : ���ʿ��� ������
        - trailing : �����ʿ��� ������
        - both : ���ʿ��� ������. �������� ������ both�� ����Ʈ��.
        [����1] ���� ���� ���ڸ� ���ŵǰ�, �߰��� �ִ� ���ڴ� ���ŵ��� ����.
        [����2] '����' �� ������ �� �ְ�, '���ڿ�' �� ������ �� ����. �����߻���
*/
select 
    ' ���������׽�Ʈ ' as trim1,
    trim(' ���������׽�Ʈ ') as trim2,
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�') as trim3,
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') as trim4,
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') as trim5,
    trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') as trim6,
    trim(both '��' from '�ٶ��㰡 �ٸ����� ������ ž�ϴ�') as trim7
from dual;
--trim7 : �߰��� '��'�� ���ŵ��� �ʴ´�.
--�ɼ��� ���°�� both�� ����Ʈ�̹Ƿ� trim3, trim4�� ������ ����� ���´�.

/*
�Ʒ� ������ �������� �߻���. trim()�� ���ڸ� ������ �� �ִ�. ����
���ڿ��� �����ϰ� �ʹٸ� replace() �Լ��� ������� �Ѵ�.
*/
select
    trim(both '�ٶ���' from '�ٶ��㰡 �ٸ����� ������ ž�ϴ�') as trimError
from dual;