/***************************
���ϸ� : Or04TypeConvert.sql
����ȯ�Լ� / ��Ÿ�Լ�
���� : ������Ÿ���� �ٸ� Ÿ������ ��ȯ�ؾ� �Ҷ� ����ϴ� �Լ��� ��Ÿ�Լ�
***************************/

/*
sysdate : ���糯¥�� �ð��� �ʴ����� ��ȯ���ش�. �ַ� �Խ��ǿ���
    ���ο� �������� ������ �� ���� ���ȴ�. �⵵���� �ʴ��������� ������ ������ �ִ�.
*/
select sysdate from dual;

/* ��¥ ���� (��ҹ��ڸ� �������� �ʴ´�.)*/
--���糯¥�� 0000/00/00 ���·� ����Ͻÿ�
select to_char(sysdate, 'yyyy/mm/dd') "���ó�¥" from dual;
--���糯¥�� 00-00-00 ���·� ����Ͻÿ�
select to_char(sysdate, 'yy-mm-dd') "���ó�¥" from dual;
--���糯¥�� "������ 0000�� 00�� 00�� 00�����Դϴ�" ���·� ����Ͻÿ�

/*
select 
    to_char(sysdate, '������ yyyy�� mm�� dd�� dy�����Դϴ�') "�����ɱ�?" 
from dual; --�����߻� : ��¥������ ������
*/

select 
    to_char(sysdate, '"������ "yyyy"�� "mm"�� "dd"�� "dy"�����Դϴ�"') "�ѱ��� ���Ŀ� ����" 
from dual; --���Ĺ��ڸ� ������ ������ ���ڿ��� "(���������̼�)���� �����ش�.

select
    to_char(sysdate, 'day') "����(������)",
    to_char(sysdate, 'dy') "����(��)",
    to_char(sysdate, 'mon') "��(3��)",
    to_char(sysdate, 'mm') "��(03)",
    to_char(sysdate, 'month') "��(3��)",
    to_char(sysdate, 'yy') "2�ڸ��⵵",
    to_char(sysdate, 'dd') "���� ���ڷ� ǥ��",
    to_char(sysdate, 'ddd') "1���� ���° ��"
from dual;


/* �ð� ���� */
--����ð��� 00:00:00 ���·� ǥ���ϱ�
select
    to_char(sysdate, 'HH:MI:SS') "�빮�ڼ���",
    to_char(sysdate, 'hh:mi:ss') "�ҹ��ڼ���"
from dual;

--���糯¥�� �ð��� �Ѳ����� ǥ���ϱ�
select
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "����ð�"
from dual;

--����ð��� ����/���� Ȥ�� 24�ð����� ǥ���ϱ�
select
    to_char(sysdate, 'hh am') AS "AM���",
    to_char(sysdate, 'hh pm') "PM���",
    to_char(sysdate, 'hh24') "24�ð���"
from dual;

/* ���� ���� */

/*
    0 : ������ �ڸ����� ��Ÿ���� �ڸ����� ���� �ʴ°�� 0���� �ڸ��� ä���.
    9 : 0�� ����������, �ڸ����� �����ʴ°�� �������� ä���.
*/

select
    to_char(123, '0000') "���Ĺ���0���",
    to_char(123, '9999') "���Ĺ���9���",
    trim(to_char(123,'9999')) "trim()���"
from dual;

select
    to_char(12345, '000,000'),
    to_char(12345, '999,999'),
    to_char(12345, '999,000'),
    ltrim(to_char(12345, '999,000')) "������������",
    ltrim(to_char(1234567, '999,999,000')) "������������2"

from dual;

--��ȭǥ�� : L -> �� ���� �´� ��ȭǥ�ð� �ȴ�. �ѱ��� ��� \(��)
select to_char(12345, 'L999,999') from dual;

/*
to_number() : ������ �����͸� ���������� ��ȯ�Ѵ�.
*/
select to_number('123') + to_number('456') from dual;
-- �� ���ڰ� ���ڷ� ��ȯ�Ǿ� ������ ��� �����.

/*
to_date()
    : ���ڿ� �����͸� ��¥�������� ��ȯ�ؼ� ������ش�. �⺻������
    ��/��/�� ������ �����ȴ�.
*/
select
    to_date('2021-03-31') "��¥�⺻����1",
    to_date('20210331') "��¥�⺻����2",
    to_date('2021/03/31') "��¥�⺻����3"
from dual;


/*
��¥������ ��-��-�� ���� �ƴѰ��� ����Ŭ�� �ν����� ���Ͽ� �����߻���.
�̷���� ��¥������ �̿��ؼ� ����Ŭ�� �ν��� �� �ֵ��� ó���ؾ� ��.
*/
select to_date('31-03-2021') from dual;

select
    to_date('31-03-2021', 'dd-mm-yyyy') "��¥���ľ˷��ֱ�1",
    to_date('03-31-2021', 'mm-dd-yyyy') "��¥���ľ˷��ֱ�2"
from dual;

--�ð������� ���ԵǹǷ� �����߻���
select to_date('2020-03-31 12:48:33') from dual;
--���1
select to_date(substr('2020-03-31 12:48:33', 1, 10)) "��¥���߶��" from dual;
--���2
select to_date('2020-03-31 12:48:33', 'yyyy-mm-dd hh-mi-ss') "�ð���������" from dual;
--���� ���� �ð��� ����ؾ� �Ѵٸ� ���2�� �̿��ؾ��Ѵ�.

/*
�ó�����1] ���ڿ� '2012/04/03'�� � �������� ��ȯ�Լ��� ���� ����Ͻÿ�
*/
select
    to_date('2012/04/03') "1�ܰ�",
    to_char(to_date('2012/04/03'), 'day') "���ϼ���1",
    to_char(to_date('2012/04/03'), 'dy') "���ϼ���2"
from dual;


/*
[����] ���ڿ� '2013��10��24��'�� � �������� ��ȯ�Լ��� ����
    ����� �� �ִ� �������� �ۼ��Ͻÿ�. �� ���ڿ��� ���Ƿ� ������ �� �����ϴ�.
*/

select
    to_date('2013�� 10�� 24��', 'yyyy"��"mm"��"dd"��"') "1�ܰ�:��¥�κ���",
    to_char(to_date('2013��10��24��','yyyy"��"mm"��"dd"��"'), 'day') "2�ܰ�:���Ϸκ���"
from dual;


/*
[����] : hr������ employees ���̺��� �����ȣ 206�� ����� � ���Ͽ�
    �Ի��ߴ��� ����ϴ� �������� �ۼ��Ͻÿ�.
*/

select hire_date, first_name from employees where employee_id like 206;

select 
    to_date('2002/06/07'),
    to_char(to_date('2002/06/07'), 'day')
from dual;


/*
�ó�����2 : '2015-10-24 12:34:56' ���·� �־��� �����͸� ���ڷ� �Ͽ�
    '0000��00��00�� 0����' �������� ��ȯ�Լ��� �̿��Ͽ� ����Ͻÿ�.
*/
select
    to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss') "1�ܰ� : ��¥�κ�ȯ",
    to_char(to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss'),
            'yyyy"�� "mm"�� "dd"�� "dy"���� "') "2�ܰ� : ������"
from dual;


/*
nvl() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�
    ����] nvl(�÷���, ��ü�Ұ�)
    
    �� ���ڵ带 select�ؼ� ���������� ����� �ϴ� ��� �ش� �÷��� null�̸�
    NullPointerException�� �߻��ϰ� �ȴ�. �׷��Ƿ� �ƿ� �����͸� �����ö� null����
    ���� �� �ִ� �÷��� ���� �̸� ó���ϸ� ���ܹ߻��� �̸� ������ �� �����Ƿ� ���ϴ�.
*/
--������̺��� ���ʽ����� null�� ���ڵ带 0���� ��ü�ؼ� ����ϴ� ������ �ۼ��Ͻÿ�.
select
    first_name, commission_pct, nvl(commission_pct, 0) AS "���ʽ���"
from employees;


/*
decode() : java�� switch���� ����ϰ� Ư������ �ش��ϴ� ��¹��� �ִ� ��� ����Ѵ�.
    ����] decode(�÷���,
                ��1, ���1,
                ��2, ���2,
                ..........
                �⺻��)
    �س������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����Ҷ� ���� ���ȴ�.
*/


/*
�ó�����] ������̺��� �� �μ��� �ش��ϴ� �μ����� ����ϴ� ��������
    decode�� �̿��ؼ� �ۼ��Ͻÿ�.
*/
select
    first_name, last_name, department_id,
    decode(department_id,
        10,	'Administration',
        20,	'Marketing',
        30,	'Purchasing',
        40,	'Human Resources',
        50,	'Shipping',
        60,	'IT',
         '�׿ܺμ�') AS TeamName
from employees;


/*
case() : java�� if~else���� ����� ������ �ϴ� �Լ�
    ����] case
            when ����1 then ��1
            when ����2 then ��2
            .......
            else �⺻��
        end
*/
select
    case
        when department_id=10 then 'Administration'
        when department_id=20 then	'Marketing'
        when department_id=30 then	'Purchasing'
        when department_id=40 then	'Human Resources'
        when department_id=50 then	'Shipping'
        when department_id=60 then	'IT'
        else '�׿ܺμ�'
    end as TeamName
from employees;


