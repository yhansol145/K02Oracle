
--hr�������� �ǽ��մϴ�.


/*
���� ����
����] 
    create [or replace] view ���̸�[(�÷�1, �÷�2....)]
    as
    select * from ���̺�� where ����
        Ȥ�� join���� ������
*/

/*
�ó�����] hr������ ������̺��� �������� ST_CLERK�� ����� ������
        ��ȸ�� �� �ִ� View�� �����Ͻÿ�.
        ����׸� : ������̵�, �̸�, �������̵�, �Ի���, �μ����̵�
*/
-- 1�ܰ� : ���Ǵ�� select �ϱ�
select employee_id, first_name, last_name, job_id, hire_date, department_id
from employees where job_id='ST_CLERK'; -- 20�� ����

-- 2�ܰ� : select���� ������� View�������ϱ�
create view view_employees
as
    select employee_id, first_name, last_name, job_id, hire_date, department_id
    from employees where job_id='ST_CLERK';

-- 3�ܰ� : View ȣ���ϱ�  
select * from view_employees;

-- �����ͻ������� ������ View Ȯ���ϱ�
select * from user_views;


/*
�� �����ϱ�
    : �� �������忡 or replace �� �߰��Ѵ�.
    �ش� �䰡 �����ϸ� �����ǰ�, ���� �������� ������ ���Ӱ� �����ȴ�.
    ���� ó�� �並 �����Ҷ����� or replace�� ����ص� �����ϴ�.
*/
create or replace view view_employees (e_id, f_name, l_name, j_id, h_date, dept_id)
as
    select employee_id, first_name, last_name, job_id, hire_date, department_id
    from employees where job_id='ST_CLERK';
select * from view_employees;
/*
    �� ������ �÷����� �����ϸ� ��ġ ��Ī�� �ذͰ� ����
    ���� ���̺��� �÷����� ������ �� �ִ�.
*/


/*
����] ������ ������ view_employees �並 �Ʒ� ���ǿ� �°� �����Ͻÿ�
        �������̵� ST_MAN�� ����� �����ȣ, �̸�, �̸���, �Ŵ������̵�
        ��ȸ�� �� �ֵ��� �����Ͻÿ�.
        ���� �÷����� e_id, name, email, m_id�� �����Ѵ�. ��, �̸��� first_name��
        last_name�� ����� ���·� ����Ͻÿ�
*/
--step1
select employee_id, concat(first_name||' ', last_name), email, manager_id
from employees where job_id=upper('st_man');

--step2
create or replace view view_employees(e_id, name, email, m_id)
as
    select employee_id, concat(first_name||' ', last_name), email, manager_id
    from employees where job_id=upper('st_man');

--step3
select * from view_employees;

/*
����] �����ȣ, �̸�, ������ ����Ͽ� ����ϴ� �並 �����Ͻÿ�.
�÷��� �̸��� emp_id, l_name, annual_sal�� �����Ͻÿ�.
�������� -> (�޿�+(�޿�*���ʽ���))*12
���̸� : v_emp_salary
��, ������ ���ڸ����� �ĸ��� ���ԵǾ�� �Ѵ�. 
*/

--step1
select 
    employee_id, first_name, 
    trim(to_char((salary+(salary*nvl(commission_pct,0)))*12, '999,000'))
from employees;/*
    ���ʽ����� null�ΰ�� ������ ������ �����Ƿ� nvl() �Լ���
    �̿��ؼ� 0���� ���� ��ȯ�� �� ����Ѵ�. ���� to_char()��
    ���ڸ����� �ĸ��� �����ϰ�, trim()���� ������ ������ �����Ѵ�.
*/

--step2
create or replace view v_emp_salary (emp_id, l_name, annual_sal)
as
    select
        employee_id, first_name, 
        trim(to_char((salary+(salary*nvl(commission_pct,0)))*12, '999,000'))
    from employees;
select * from v_emp_salary;


/*
-������ ���� View ����
�ó�����] ������̺�� �μ����̺�, �������̺��� �����Ͽ� ���� ���ǿ� �´� �並 �����Ͻÿ�.
����׸� : �����ȣ, ��ü�̸�, �μ���ȣ, �μ���, �Ի�����, ������
���Ǹ�Ī : v_emp_join
�����÷� : empid, fullname, deptid, deptname, hdate, locname
�÷��� ������� : 
	fullname => first_name+last_name 
	locname => XXX���� YYY (ex : Texas���� Southlake)
	hdate => 0000��00��00��
*/

--step : select�� �ۼ�
select
    employee_id, first_name||' '||last_name, department_id,
    to_char(hire_date, 'yyyy"��"mm"��"dd"��"'),
    state_province||'���� '||city
from employees 
    inner join departments using(department_id)
    inner join locations using(location_id);

--step2 : view ����
create or replace view v_emp_join 
    (empid, fullname, deptid, deptname, hdate, locname)
as
    select
        employee_id, first_name||' '||last_name,
        department_id, department_name,
        to_char(hire_date, 'yyyy"��"mm"��"dd"��"'),
        state_province||'���� '||city
    from employees
        inner join departments using(department_id)
        inner join locations using(location_id);
select * from v_emp_join;
