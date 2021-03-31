/**************
���ϸ� : Or05Date.sql
��¥�Լ�
���� : ��, ��, ��, ��, ��, �� �� �������� ��¥������ �����ϰų�
    ��¥�� ����Ҷ� Ȱ���ϴ� �Լ���
**************/

/*
months_between()
    : ���糯¥�� ���س�¥ ������ �������� ��ȯ�Ѵ�.
    ����] months_between(���糯¥, ���س�¥[���ų�¥])
*/
--2017�� 1��1�Ϻ��� ���ݱ��� ���� �������� ���ΰ���?
select
    months_between(sysdate, '2017-01-01') "���1",
    months_between(sysdate, to_date('2017�� 1��1��', 'yyyy"��"mm"��"dd"��"')) "���2",
    round(months_between(sysdate, '2017-01-01')) "���3"
from dual;
--���� ��¥ ������ �ƴ϶�� to_date()�� ��¥�������� �������ش�.


/*
�ó�����1] employees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ�
    ����Ͻÿ�. �ټӰ������� �������ο������� �����Ͻÿ�.
*/
select
    first_name, last_name, hire_date,
    months_between(sysdate, hire_date) "�ټӰ�����1",
    trunc(months_between(sysdate, hire_date), 2) "�ټӰ�����2"
from employees
order by �ټӰ�����1 asc;


/*
Ȱ��ó�����2] [����] �� ������ ���糯¥ ������ �ƴ� '2017��12��31��'��
�������� �����Ͻÿ�.
*/

select
first_name, last_name, hire_date,
trunc(months_between(to_date('2017��12��31��','yyyy"��"mm"��"dd"��"'), hire_date), 2) AS "�ټӰ�����1"
from employees
order by "�ټӰ�����1" asc;
/*
    months_between() �Լ��� ���ڷ� ��¥�� �־����� ����Ŭ �⺻������
    ��-��-�� �� ��쿡�� to_date()�� ��ȯ���� �״�� ����� �� �ִ�.
    ��, �⺻������ �ƴ� ��쿡�� ��¥�������� ��ȯ�� ����ϸ� �ȴ�.
*/


/*
add_months() : ��¥�� �������� ���� ����� ��ȯ�Ѵ�.
    ����] add_months(���糯¥, ���� ������)
*/
--���縦 �������� 7���� ������ ��¥�� ���Ͻÿ�

select
    to_char(sysdate, 'yyyy-mm-dd') "���糯¥",
    to_char(add_months(sysdate, 7), 'yyyy-mm-dd') "7�������ĳ�¥"
from dual;


/*
next_day() : ���糯¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ�
    �̷��� ��¥�� ��ȯ�ϴ� �Լ�
    ����] next_daay(���糯¥, '������')
            => ������ �������� �����ΰ���??
*/

select
    sysdate "���ó�¥",
    next_day(sysdate, '�ݿ���') "�����ݿ�����?",
    next_day(sysdate, '������') "������������?",
    next_day(sysdate, '������') "������������?"
from dual; --������ ������ ��¥�� ��ȸ�� �� ����.


/*
last_day() : �ش���� ������ ��¥�� ��ȯ�Ѵ�.
    ����] last_day(��¥)
*/
select last_day('20/02/01') from dual;
select last_day('21/02/01') from dual;
select last_day(sysdate) from dual;
select last_day(hire_date), hire_date from employees where employee_id=106;
--2020���� �����̹Ƿ� 2���� 29�ϱ��� �ִ�.

select
    sysdate "���糯¥",
    sysdate -1 "����",
    sysdate +1 "����",
    sysdate +30 "�Ѵ� ��"
from dual;