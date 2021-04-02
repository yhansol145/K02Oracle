/*************************
���ϸ� : Or10SubQuery.sql
��������
���� : �������ȿ� �� �ٸ� �������� ���� ������ select��
*************************/

/*
������ ��������
    ����]
        select * from ���̺�� where �÷�=(
            select �÷� from ���̺�� where ����
        );
    �� ��ȣ���� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�.
*/

/*
�ó�����] ������̺��� ��ü����� ��ձ޿����� ���� �޿��� �޴� �������
�����Ͽ� ����Ͻÿ�.
    ����׸� : �����ȣ, �̸�, �̸���, ����ó, �޿�
*/
select employee_id, first_name, email, salary
from employees
where salary < round(avg(salary));/*
    �ش� �������� ���ƻ� �´µ��ϳ� �׷��Լ��� �����࿡
    ������ �߸��� ���������� ������ �߻��Ѵ�.
*/
-- 1�ܰ� : ��ձ޿��� �������� ���Ѵ�.
select avg(salary) from employees;
-- 2�ܰ� : 6462���� ���� �޿��� �޴� ������ �����Ѵ�.
select * from employees where salary<6462;
-- 3�ܰ� : 2���� ������ �ϳ��� �������������� ��ģ��.
select * from employees where
    salary<(select round(avg(salary)) from employees);
    
/*
�ó�����] ��ü ����� �޿��� �������� ����� �̸��� �޿��� ����ϴ�
������������ �ۼ��Ͻÿ�.
����׸� : �̸�1, �̸�2, �̸���, �޿�
*/
-- 1�ܰ� : �ּұ޿��� ã�´�.
select min(salary) from employees;
-- 2�ܰ� : 2100�޷��� �޿��� �޴� ����� �����Ѵ�.
select * from employees where salary=2100;
-- 3�ܰ� : ������ ����
select * from employees where
    salary=(select min(salary) from employees);
    
/*
�ó�����] ��ձ޿����� ���� �޿��� �޴� ������� ����� ��ȸ�� �� �ִ�
������������ �ۼ��Ͻÿ�.
��³��� : �̸�1, �̸�2, ��������, �޿�
�� ���������� jobs ���̺� �����Ƿ� join�ؾ� �Ѵ�.
*/

-- 1�ܰ� : ��ձ޿� ���ϱ�
select trunc(avg(salary),2) from employees;
-- 2�ܰ� : 6461.83���� �޿��� ���� ����� ����
select * from employees where salary>=6461.83;
-- 3�ܰ� : jobs ���̺�� ������ �Ǵ�.
select
    first_name, last_name, job_title, salary
from employees inner join jobs using(job_id)
where salary>=6461.83;
-- 4�ܰ� : ���������� ����
select
    first_name, last_name, job_title, salary
from employees inner join jobs using(job_id)
where salary>=(select trunc(avg(salary),2) from employees);


/*
������ ��������
    ����]
        select * from ���̺�� where �÷� in (
            select �÷� from ���̺�� where ����
        );
    �� ��ȣ���� ���������� 2�� �̻��� ����� �����ؾ� �Ѵ�.
*/

/*
�ó�����] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
    ��¸�� : ������̵�, �̸�, ���������̵�, �޿�
*/
-- 1. ������̺��� �ܼ� ������ ���� ������ ��׿����� Ȯ��
select job_id, salary from employees
order by job_id, salary desc;
-- 2. 1������ Ȯ���� ���ڵ带 group by ���� �׷�ȭ�Ͽ� �� ������
--  �ִ�޿��� Ȯ���Ѵ�.
select
    job_id, max(salary)
from employees
group by job_id;
-- 3. 2���� ����� ������� �ܼ� ������ �ۼ�
select
    employee_id, first_name, job_id, salary
from employees
where
    (job_id='IT_PROG' and salary=9000) or
    (job_id='AC_MGR' and salary=12008) or
    (job_id='AC_ACCOUNT' and salary=8300) or
    (job_id='ST_MAN' and salary=8200) or
    (job_id='PU_MAN' and salary=11000);/*
        2������ ����� 19���� ����� �ܼ������� �ۼ��ϸ�
        ���Ͱ��� or�����ڸ� ���� ������ �� �ִ�. ������
        ����� ���ٸ� �ۼ��� �Ұ����Ұ��̴�. 
    */
-- 4. 3�� �������� ���������� �����Ѵ�. �������̹Ƿ� in�� ����Ѵ�.
select
    employee_id, first_name, job_id, salary
from employees
where
    (job_id, salary) in(
        select
            job_id, max(salary)
        from employees
        group by job_id
    );
    
/*
�����࿬����2 : any
    ���������� �������� ���������� �˻������ �ϳ��̻�
    ��ġ�ϸ� ���� �Ǵ� ������. �� �� �� �ϳ��� �����ϸ�
    �ش� ���ڵ带 �����´�.
*/
/*
�ó�����] ��ü����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� �޴� ��������
�����ϴ� ������������ �ۼ��Ͻÿ�.
*/
-- 1. 20�� �μ��� �޿��� Ȯ��
select * from employees where department_id=20;
-- 2. 1�� ����� �ܼ� ������ ������...
select * from epmployees where salary>=13000 or salary>=6000;
-- 3. 2�� ����� ���������� �ۼ��Ѵ�. �̶� any�� ����Ѵ�.
select first_name, last_name, department_id, salary
    from employees where 
    salary>=any(select salary from employees where department_id=20);
    /*
        ������ ������ any�� ����ϸ� 2���� ���� or�������� �������
        �����ϰ� �ȴ�. 6000 �Ǵ� 13000 �̻��� ���ڵ常 ����ȴ�.
    */

/*
�����࿬����3 : all
    : ���������� �������� ���������� �˻������ ��� ��ġ�ؾ� �Ѵ�.
*/

select first_name, last_name, department_id, salary
    from employees where
    salary>=all(select salary from employees where department_id=20);
    /*
    6000���� ũ�� 13000���ٵ� Ŀ���ϹǷ� ��������� 13000 �̻��� ���ڵ常 ���
    */
    


/*
Top���� : ��ȸ�� ������� ������ ���� ���ڵ带 �����ö� ����Ѵ�.
    �ַ� �Խ����� ����¡�� ���ȴ�.
    
    rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ�
        ������ �÷��� ���Ѵ�. �ش� �÷��� ��� ���̺� �����Ѵ�.
*/
select * from employees;
select employee_id, first_name, rownum from employees;
select employee_id, first_name, rownum from employees order by first_name;
select employee_id, first_name, rownum from (
    select * from employees order by first_name
);


/*
������̺��� ������ ������ ���� �������� ���� ����������
*/
select * from
    (select Tb.*, rownum rNum from(
        select * from employees order by employee_id desc
    ) Tb)
-- where rNum between 1 and 10;
where rNum between 11 and 20;
/*
    between�� ������ ���Ͱ��� �������ָ� �ش� �������� ���ڵ常
    �������� �ȴ�. ���� ������ ���� JSP���� �������� ������ �����Ͽ�
    ����ؼ� �����ϰ� �ȴ�.
    
    3. 2���� ��� ��ü�� �����ͼ�...
        (2. 1���� ����� rownum�� ���������� �ο��� (
            1. ������̺��� ��� ���ڵ带 �������� �����ؼ� ����
        ) Tb)
     �ʿ��� �κ��� rownum���� ������ ���� �����Ѵ�.
*/
