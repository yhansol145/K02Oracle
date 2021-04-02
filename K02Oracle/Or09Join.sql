/********************
���ϸ� : Or09Join.sql
���̺�����
���� : �ΰ� �̻��� ���̺��� ���ÿ� �����Ͽ� �����͸� 
�����;� �Ҷ� ����ϴ� SQL��
********************/

/*
1] inner join(��������)
- ���� ���� ���Ǵ� ���ι����� ���̺��� ���������� ��� �����ϴ�
���� �˻��Ҷ� ���ȴ�.
- �Ϲ������� �⺻Ű(primary key)�� �ܷ�Ű(foreign key)�� ����Ͽ�
join�ϴ� ��찡 ��κ��̴�.
- �ΰ��� ���̺� ������ �̸��� �÷��� �����ϸ� "���̺��,�÷���"
���·� ����ؾ� �Ѵ�.
- ���̺��� ��Ī�� ����Ѵٸ� "��Ī��.�÷���" ���·� ������ �ִ�.
����1] (ANSI ǥ�ع��)
    select
        �÷�1, �÷�2,...
    from ���̺�1 inner join ���̺�2
        on ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű�÷�
    where
        ����1 and ����2 ...;
*/

/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select
    employee_id, first_name, last_name, email, 
    department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id;/*
        �����߻���. �������̺� ��ο� �����ϴ� department_id �÷��� 
        �����Ƿ� "column ambiguously defined" ������ �߻��Ѵ�.
        �̶��� � ���̺��� �������� ����ؾ� �Ѵ�.
    */

-- as(��Ī) ���� �ۼ��Ͽ� �������� ����� 
select
    employee_id, first_name, last_name, email, 
    employees.department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id;
    
-- as(��Ī)�� �߰��Ͽ� �ۼ���. �������� ��������
select
    employee_id, first_name, last_name, email, 
    emp.department_id, department_name
from employees emp inner join departments dep
    on emp.department_id=dep.department_id;


/*
3�� �̻��� ���̺� ����
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ�
�������� �ۼ��Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, 
        ���������̵�, ��������, �ٹ�����
*/
select
    first_name, last_name, email, E.department_id, department_name, 
    E.job_id, job_title, city, state_province
from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on E.department_id=D.department_id
    inner join jobs J on E.job_id=J.job_id
where lower(city)='seattle';

/*
����2] ����Ŭ���
    select
        �÷�1, �÷�2......�÷�n
    from
        ���̺��1, ���̺��2
    where
        ���̺��1.�⺻Ű�÷�=���̺��2.����Ű�÷�
        and ����1 and ����2;
*/

/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/

select
    employee_id, first_name, last_name, email, 
    dep.department_id, department_name
from employees emp, departments dep
where emp.department_id=dep.department_id;


/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ�
�������� �ۼ��Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
*/
select
    first_name, last_name, email, D.department_id, department_name, 
    J.job_id, job_title
from locations L, departments D, employees E, jobs J
where
    L.location_id=D.location_id
    and D.department_id=E.department_id
    and E.job_id=J.job_id
    and city='Seattle';


---------------------------------------------------


/*
2] �ܺ�����(outer join)
outer join�� inner join�� �޸� �� ���̺� ���������� ��Ȯ�� ��ġ����
�ʾƵ� ������ �Ǵ� ���̺��� ������� �������� join���̴�.
outer join�� ����Ҷ��� �ݵ�� outer ���� �����͸� � ���̺��� ��������
���������� ����ؾ� �Ѵ�.
    -> left(�������̺�), right(���������̺�), full(�������̺�)
    
����1(ǥ�ع��)
    select �÷�1, �÷�2 ....
    from ���̺�1
        left[right, full] outer join ���̺�2
            on ���̺�1.�⺻Ű=���̺�2.����Ű
    where ����1 and ����2 or ����3;
*/
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(left)��
    ���� ����Ͻÿ�.
*/
select
    employee_id, first_name, last_name, E.department_id, department_name, 
    city, state_province
from employees E
    left outer join departments D
        on E.department_id=D.department_id
    left outer join locations L
        on D.location_id=L.location_id;


/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(right)��
    ���� ����Ͻÿ�.
*/
select
    employee_id, first_name, last_name, e.department_id,
    department_name, D.location_id, city, state_province
from employees E
    right outer join departments D
        on E.department_id=D.department_id
    right outer join locations L
        on D.location_id=L.location_id;


-- left Ȥ�� right�� ���� ������ �Ǵ� ���̺��� �޶����� ����Ǵ� ����� �޶�����.


/*
����2(����Ŭ���)
    select
        �÷�1, �÷�2........�÷�N
    from
        ���̺�1, ���̺�2
    where
        ���̺�1.�⺻Ű=���̺�2.�ܷ�Ű(+)
        and ����1 or ����2 ... ����n;
    => ����Ŭ������� ����ÿ��� outer join�������� (+)�� where�� �ٿ��ش�.
    => ���� ��� ���� ���̺��� ������ �ȴ�.
*/

/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(left)��
    ���� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
*/
select
    employee_id, first_name, last_name, Dep.department_id, department_name,
    city, state_province
from employees Emp, departments Dep, Locations Loc
where 
    Emp.department_id=Dep.department_id(+)
    and Dep.department_id=Loc.location_id(+);


/*
3] self join(��������)
    ���������� �ϳ��� ���̺� �ִ� �÷����� �����ؾ� �ϴ� ��쿡 ����Ѵ�.
    �� �ڱ��ڽ��� ���̺�� ������ �δ°��̴�.
    �������ο����� ��Ī�� ���̺��� �����ϴ� �������� ������ �ϹǷ� ������ �߿��ϴ�.
    
    ����]
    select
        ��Ī1.�÷�, ��Ī2.�÷� ....
    from
        ���̺� ��Ī1, ���̺� ��Ī2
    where
        ��Ī1.�÷�=��Ī2.�÷� ;
*/

/*
�ó�����] ������̺��� �� ����� �Ŵ������̵�� �Ŵ����̸��� ����Ͻÿ�.
    ��, �̸��� frist_name�� last_name�� �ϳ��� �����ؼ� ����Ͻÿ�.
    
    1. �ϳ��� ���̺��� ���� ����������̺�, �Ŵ����������̺�� ������.
    2. ����� �Ŵ������̵�� �Ŵ����� ������̵� join�Ѵ�.
    3. ������ ���̺� ��Ī�� �̿��ؼ� �ʿ��� ������ select�Ѵ�.
*/
select
    empClerk.employee_id "�����ȣ", 
    (empClerk.first_name||' '||empClerk.last_name) "����̸�",
    empManager.employee_id "�Ŵ������̵�",
    concat(empManager.first_name||' ', empManager.last_name) "�Ŵ����̸�"
from
    employees empClerk, employees empManager
where
    empClerk.manager_id=empManager.employee_id;


/*
�ó�����] self join�� ����Ͽ� "Kimberely / Grant" ������� �Ի����� 
    ���� ����� �̸��� �Ի����� ����Ͻÿ�.
    ��¸�� : first_name, last_name, hire_date
*/
-- 1. Kimberely�� ���� Ȯ��
select * from employees where first_name='Kimberely' and last_name='Grant';
-- 2. 07/05/24 ���Ŀ� �Ի��� �������� ����
select * from employees where hire_date>'07/05/24';
-- 3. self join���� �� Ŀ������ ��ģ��.
select
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
from employees Kimberely, employees Clerk
where
    Kimberely.hire_date<Clerk.hire_date
    and Kimberely.first_name='Kimberely' and Kimberely.last_name='Grant' 
order by hire_date asc;


/*
using : join������ �ַ� ����ϴ� on���� ��ü�� �� �ִ� ����
    ����] on ���̺�1.�÷�=���̺�2.�÷�
                => using(�÷�)
*/

/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ�
�������� �ۼ��Ͻÿ�. �� ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
*/
select
    first_name, last_name, email, department_id, department_name
    job_id, job_title, city
from locations
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join jobs using(job_id)
where lower(city)='seattle';/*
        using���� ���� �ĺ��� �÷��� ��� select������ ���̺���
        ��Ī�� ���̸� ������ �߻��Ѵ�.
        using���� ���� �÷����� ��, ������ ���̺� ���ÿ� �����ϴ�
        �÷��̶�°��� ����� �ۼ��Ǳ� ������ ���� ��Ī�� �ٿ��� ������
        ���� �����̴�.
    */
    

 /*
 ����] 2005�⿡ �Ի��� ������� California(STATE_PROVINCE) / 
 South San Francisco(CITY)���� �ٹ��ϴ� ������� ������ ����Ͻÿ�.
 ��, ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�.
 
 ��°��] �����ȣ, �̸�, ��, �޿�, �μ���, �����ڵ�, ������(COUNTRY_NAME)
        �޿��� ���ڸ����� �ĸ��� ǥ���Ѵ�. 
 ����] '������'�� countries ���̺� �ԷµǾ��ִ�. 
 */
select
    employee_id, first_name, last_name, 
    to_char(salary, '999,000'), department_name, country_id, country_name
from locations
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join countries using(country_id)
where 
    city='South San Francisco'
    and state_province='California'
    and hire_date>'04/12/31'
    and hire_date<'06/01/01';
    
---------------------------------------------------------    
    
select
    employee_id, first_name, last_name, 
    to_char(salary, '999,000'), department_name, country_id, country_name
from locations
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join countries using(country_id)
where
    (to_char(hire_date, 'yyyy')='2005'
    or substr(hire_date, 1, 2)='05'
    or hire_date like '05%')
    and city='South San Francisco'
    and state_province='California';

/*
    - ��¥ ���ĵ� ���ڿ� ���������� �ڸ��ų� like�� ����
    �˻��� �����ϴ�.   
    - �Լ��� select�� �Ӹ� �ƴ϶� where������ ����� �� �ִ�.
*/





/************************
��������
************************/



/*
1. inner join ����� ����Ŭ����� ����Ͽ� first_name �� Janette �� 
����� �μ�ID�� �μ����� ����Ͻÿ�.
��¸��] �μ�ID, �μ���
*/
select
    Emp.department_id "�μ�ID", department_name "�μ���"
from employees Emp, departments Dep
where Emp.department_id=Dep.department_id
    and first_name='Janette';


/*
2. inner join ����� SQLǥ�� ����� ����Ͽ� ����̸��� �Բ� �� ����� 
�Ҽӵ� �μ���� ���ø��� ����Ͻÿ�
��¸��] ����̸�, �μ���, ���ø�
*/
select
    (first_name||' '||last_name) "����̸�", department_name "�μ���", city "���ø�"
from departments D
    inner join employees E on E.department_id=D.department_id
    inner join locations L on D.location_id=L.location_id ;


/*
3. inner join�� using �����ڸ� ����Ͽ� 50�� �μ�(DEPARTMENT_ID)�� 
���ϴ� ��� ������(JOB_ID)�� �������(distinct)�� �μ��� ���ø�(CITY)�� �����Ͽ� ����Ͻÿ�.
��¸��] ������ID, �μ�ID, �μ���, ���ø�
*/
select
    distinct job_id, department_id, department_name, city
from departments
    inner join employees using(department_id)
    inner join locations using(location_id)
where
    department_id=50;


/*
4. ���������� ����Ͽ� Ŀ�̼�(COMMISSION_PCT)�� �޴� ��� 
����� �̸�, �μ���, ���ø��� ����Ͻÿ�. 
��¸��] ����̸�, �μ�ID, �μ���, ���ø�
*/
select
    first_name, last_name, department_name, city
from employees E, departments D, locations L
where
    E.department_id=D.department_id
    and D.location_id=L.location_id
    and E.commission_pct is not null ;


/*
5. ����� �̸�(FIRST_NAME)�� 'A'�� ���Ե� ������� �̸��� �μ����� ����Ͻÿ�.
��¸��] ����̸�, �μ���
*/
select
    first_name, last_name, department_name
from employees E, departments D
where
    E.department_id=D.department_id
    and first_name like '%A%';


/*
6. ��city : Toronto / state_province : Ontario�� ���� �ٹ��ϴ� ��� ����� �̸�, ������, �μ���ȣ �� �μ����� ����Ͻÿ�.
��¸��] ����̸�, ������, �μ�ID, �μ���
*/
select
    first_name, last_name, job_title, D.department_id, department_name
from employees E, departments D, locations L, jobs J
where 
    E.department_id=D.department_id
    and D.location_id=L.location_id
    and E.job_id=J.job_id
    and city='Toronto'
    and state_province='Ontario';




