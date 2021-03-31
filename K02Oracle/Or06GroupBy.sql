/************************
���ϸ� : Or06GroupBy.sql
�׷��Լ�(select�� 2��°)
���� : ��ü ���ڵ�(�ο�)���� ������� ����� ���ϱ� ���� �ϳ� �̻���
    ���ڵ带 �׷����� ��� ���� �� ����� ��ȯ�ϴ� �Լ� Ȥ�� ������
************************/

/*
distinct
    - �ߺ��Ǵ� ���ڵ带 ������ �� �ϳ��� ���ڵ常 �����ͼ� �����ش�.
    - ���� ������� �����͸� ����� �� ����.
*/
select distinct job_id from employees;

/*
group by
    - ������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����´�.
    - �������� ����� �ϳ��� ���ڵ�������, �������� ���ڵ尡 ������
    ����̹Ƿ� ������� �����͸� ����� �� �ִ�.
    - �ִ�, �ּ�, ���, �ջ� ���� �����ϴ�.
*/
select job_id from employees group by job_id;

/*
�׷��Լ��� �⺻����
    : [] ���ȣ �κ��� ���� ����
    
    select
        �÷�1, �÷�2,.... Ȥ�� *(��ü)
    from
        ���̺��
    [where
        ����1 or ����2 and ����3....]
    [group by
        ������ �׷�ȭ�� ���� �÷���]
    [having
        �׷쿡�� ã�� ����]
    [order by
        ���ڵ� ������ ���� �÷��� ���Ĺ��(asc / desc)]
    
    �� ������ �������
        from > where > group by > having > select > order by
*/


/*
sum() : �հ踦 ���Ҷ� ����ϴ� �Լ�
    ����] sum(�÷�)
    - numberŸ���� �÷������� ��밡��
    - �ʵ���� �ʿ��� ��� AS�� �̿��ؼ� ��Ī �ο� ����
*/
--��ü������ �޿��� �հ踦 ����Ͻÿ�.
select
    sum(salary) "�޿����հ�1",
    to_char(sum(salary), '000,000') "�޿����հ�2"
from employees;

--10�� �μ����� �ٹ��ϴ� ������� �޿��հ�� ������ ����Ͻÿ�.
select
    sum(salary) "�޿�1",
    to_char(sum(salary), '999,999') "�޿�2",
    to_char(sum(salary), '000,999') "�޿�3",
    ltrim(to_char(sum(salary), '9,999,999')) "�޿�4"
from employees
where department_id=10;

--sum()�� ���� �׷��Լ��� numberŸ���� �÷������� ��밡���ϴ�.
select num(first_name) from employees; --�����߻�


/*
count() : ���ڵ��� ������ ī��Ʈ�Ҷ� ����ϴ� �Լ�
*/
--������̺� ����� ��ü ������� ����ΰ���??
select count(*) from employees;--���1 : �������
select count(employee_id) from employees;--���2 : ������׾ƴ�

/*
    count() �Լ��� ����Ҷ��� �� 2���� ��� ��� �����ϳ�,
    *�� ����Ұ��� �����Ѵ�. �÷��� Ư���� Ÿ�� �ʾ�
    �˻��ӵ��� ������.
*/

/*
count()�Լ���
    ����1 : count(all �÷���)
        => ����Ʈ�� �÷���ü�� ���ڵ带 �������� ī��Ʈ�Ѵ�.
    ����2 : count(distinct �÷���)
        => �ߺ��� ������ ���¿��� ī��Ʈ�Ѵ�.
*/
select
    count(all job_id) "��������ü����",
    count(distinct job_id) "��������������"
from employees;


/*
avg() : ��հ��� ���Ҷ� ����ϴ� �Լ�
*/
--��ü����� ��ձ޿��� �������� ����ϴ� �������� �ۼ��Ͻÿ�.
select
    count(*) "�����",
    sum(salary) "�޿����հ�",
    sum(salary)/count(*) "��ձ޿�1",
    avg(salary) "��ձ޿�2",
    to_char(avg(salary), '$999,000') "��ձ޿�3" 
from employees
where 1=1;


-- �������� ��ձ޿��� ���ΰ�?
-- 1. �μ����̺��� �������� �μ���ȣ�� Ȯ���Ѵ�.
select * from departments where department_name='sales';
select * from departments where lower(department_name)='sales';
select * from departments where upper(department_name)='SALES';
/*
    �����˻��� ��ҹ��� Ȥ�� ������ ���Ե� ��� ��� ���ڵ忡 ����
    ���ڿ��� Ȯ���ϴ°� �Ұ����ϹǷ� �ϰ����� ��Ģ�� �����ϱ� ����
    upper()�� ���� ��ȯ�Լ��� ����Ͽ� �˻��ϸ� ���ϴ�.
*/

-- 2. ������ ã�� 80���μ����� �ٹ��ϴ� ������ ��ձ޿��� ���Ѵ�.
select
    avg(salary) "��������ձ޿�1",
    to_char(avg(salary), '$999,000.00') "��������ձ޿�2"
from employees where department_id=80;
/*
to_char()�� ���� ���ڸ����� �ĸ��� ��ȭǥ��
�׸��� �Ҽ��� ���� 2�ڸ����� �������� ǥ���Ѵ�.
*/


/*
min() / max() : �ּ�/�ִ밪�� ã�� �� ����ϴ� �Լ�
*/
--����� ���� ���� �޿��� �޴� ����� �����ΰ���?
select min(salary) from employees; -- 1. ������̺��� ���峷�� �޿��� ��?
select first_name, last_name from employees
    where salary=2100; -- 2. �տ��� ���� 2100�� �޴� ����� select�ؼ� ������.
/*
    ����� ���� ���� �޿��� min()���� ���� �� ������
    ���� ���� �޿��� �޴� ����� ���Ͱ��� 2���� ������ ����ϰų�
    ���������� ����Ͽ� ���� �� �ִ�.
*/
select first_name, last_name from employees
    where salary=(select min(salary) from employees);
    
    
/*
group by�� : �������� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� ������
    ����� ��ȯ�ϴ� ������
    �� distinct�� �ܼ��� �ߺ����� �����Ѵ�.
*/
--������̺��� ���ڵ带 �μ����� �׷�ȭ�Ͽ� Ȯ���ϱ�
select department_id from employees
group by department_id;
--�� �μ��� �޿��� �հ�� ���ΰ�?
select
    department_id,
    sum(salary) "�μ����޿�����1",
    to_char(sum(salary), '999,000') "�μ����޿�����2"
from employees
group by department_id;


/*
�ó�����][����] �μ��� ������� ��ձ޿��� ���ΰ���?
    ��°��] �μ���ȣ, �޿�����, �������, ��ձ޿�
        �μ���ȣ ������� �������� �����ϼ���.
*/
select
    department_id "�μ���ȣ",
    sum(salary) "�޿�����",
    count(*) "�������",
    to_char(avg(salary), '9,999,000.00') "��ձ޿�"
from employees
group by department_id
order by department_id asc;



select
    department_id "�μ���ȣ",
    first_name
from employees
group by department_id; -- �����߻�
/*
    ������ ����ߴ� group by���� first_name�� �߰��Ͽ�����
    ������ �߻��Ѵ�. select���� group by���� ����� �÷���
    from������ ����� �� �ִ�. �׷�ȭ�� ���¿��� Ư�� ���ڵ�
    �ϳ��� �����ϴ°��� �ָ��ϹǷ� ������ �߻��Ѵ�.
*/