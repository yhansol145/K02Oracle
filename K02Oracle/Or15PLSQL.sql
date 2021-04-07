/***************************
���ϸ� : Or15PLSQL.sql
PL/SQL
���� : ����Ŭ���� �����ϴ� ���α׷��� ���
***************************/

/*
PL/SQL(Procedural Language)
    : �Ϲ� ���α׷��� ���� ������ �ִ� ��Ҹ� ��� ������ ������ 
    DB������ ó���ϱ� ���� ����ȭ�� ����̴�.
*/

-- HR�������� �ǽ��մϴ�.

--ȭ��� ������ ����ϰ� ������ on���� �����Ѵ�. off�϶��� ��µ��� �ʴ´�.
set serveroutput on;
declare -- ����� : ������ �ַ� �����Ѵ�.
    cnt number; -- ����Ÿ���� ������ ����
begin -- ����� : begin ~ end �� ���̿� ������ ���� ������ ����Ѵ�.
    cnt := 10; -- ����cnt�� 10�� �Ҵ��Ѵ�. �̶� ���Կ����ڴ� := �� ����Ѵ�.
    cnt := cnt+1;
    dbms_output.put_line(cnt); -- java���� println()�� �����ϴ�.
end;
/
/*
    PL/SQL ������ ������ �ݵ�� /�� �ٿ��� �ϴµ�, ����
    ������ ȣ��Ʈȯ������ ���������� ���Ѵ�. �� PL/SQL������ 
    Ż���ϱ����� �ʿ��ϴ�.
*/

/*
�ó�����] ������̺��� �����ȣ�� 120�� ����� �̸��� ����ó�� ����ϴ�
    PL/SQL ���� �ۼ��Ͻÿ�.
*/
select concat(first_name||' ',last_name), phone_number
    from employees 
    where employee_id=120;

declare
    /*
    ����ο��� ������ �����Ҷ� ���̺� �����ÿ� �����ϰ�
    �����ϸ� �ȴ�. �� first_name�� last_name�� ������ �����̹Ƿ�
    ���� �� �˳��� ũ��� �����ϴ°��� ����.
    */
    empName varchar2(50);
    empPhone varchar2(30);
begin
    /*
    ����� : select ������ ������ ����� ����ο��� ������
        ������ 1:1�� �����Ͽ� ���� �����Ѵ�. �̶� into��
        ����Ѵ�.
    */
    select concat(first_name||' ', last_name), phone_number
        into empName, empPhone
    from employees 
    where employee_id=120;
    
    dbms_output.put_line(empName||' '||empPhone);
end;
/

/*
�ó�����] �μ���ȣ 10�� ����� �����ȣ, �޿�, �μ���ȣ�� �����ͼ�
    �Ʒ� ������ ���� �� ȭ��� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�.
    ��, ������ �������̺��� �ڷ����� �����ϴ� '��������'�� �����Ͻÿ�.
    
    �������� : Ư�� ���̺��� Ư�� �÷��� �����ϴ� �����ν�
        ������ �ڷ����� ũ��� �����ϰ� ������ ����Ѵ�.
        ����] ���̺��.�÷���%tpye
            => ���̺��� '�ϳ�'�� �÷����� �����Ѵ�.
*/
-- �ó������� ���ǿ� �´� select ���� �ۼ��Ѵ�.
select employee_id, salary, department_id
    from employees where department_id=10;

declare
    -- ������̺��� Ư�� �÷��� �����ϴ� ���������� �����Ѵ�.
    empNo employees.employee_id%type; --NUMBER(6,0)
    empSal employees.salary%type; --NUMBER(8,2)
    deptId employees.department_id%type; --NUMBER(4,0) �� �����ϴ�.
begin
    -- select�� ����� into�� ���� ������ ������ �Ҵ��Ѵ�.
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees where department_id=10;
    
    --������
    dbms_output.put_line(empNo||' '||empSal||' '||deptId);
end;
/

/*
�ó�����] �����ȣ�� 100�� ����� ���ڵ带 �����ͼ� emp_row������ ��ü�÷���
������ �� ȭ�鿡 ���� ������ ����Ͻÿ�.
��, emp_row�� ������̺��� ��ü�÷��� ������ �� �ִ� ���������� �����ؾ� �Ѵ�.
������� : �����ȣ, �̸�, �̸���, �޿�
*/
select * from employees where employee_id=100;

declare
    /*
    ��ü�÷��� �����ϴ� �������� : ���̺��ڿ� %rowtype�� �ٿ���
        �����Ѵ�.
    */
    emp_row employees%rowtype;
begin
    /*
    ���ϵ�ī�� *�� ���� ���� ��ü�÷��� ���� emp_row��
    �Ѳ����� �����Ѵ�.
    */
    select * into emp_row
    from employees where employee_id=100;
    
    /*
    emp_row���� ��ü�÷��� ������ ����ǹǷ� ��½ÿ���
    ������.�÷��� ���·� ����ؾ� �Ѵ�.
    */
    dbms_output.put_line(emp_row.employee_id||' '||
                        emp_row.first_name||' '||
                        emp_row.email||' '||
                        emp_row.salary);
end;
/



/*
���պ���
    : class�� �����ϵ� �ʿ��� �ڷ����� ��� �����ϴ� ����
    
    �Ʒ��� 3���� �ڷ����� ���� ���պ����� �����ϰ� �ִ�.
    Ư�� �÷��� �״�� ����Ҷ��� �������� %type���·� �����ϰ�
    �÷��� ��ġ�ų� �����ؾ� �� ��� ���ǻ����� �����ϴ�.
    ����]
        type ���պ����ڷ��� is record(
            �÷���1 �ڷ���1,
            �÷���2 ��������%type ....
        );
*/

declare
--3���� ���� �����Ҽ� �ִ� �����ڷ����� �����Ѵ�. �������ƴ� �ڷ����������Ѱ�!!!!!!
    type emp_3type is record(
        emp_id employees.employee_id%type,--�������̺��� �÷��� �����ϴ� ����
        emp_name varchar2(50),--���Ӱ� ������ ����
        emp_job employees.job_id%type 
        );
        --�����ڷ����� ���� ������ ���պ���. 3���� �÷��� �����Ҽ��ֵ�.
        record3 emp_3type;
begin
--select ������ ������ 3���� �÷��� �ϳ��� ���պ����� �����Ѵ�. 
    select employee_id,first_name||''||last_name,job_id 
        into record3
        from employees
        where department_id=10;            
        --��½ÿ��� ������.�÷��� ���·� ����Ѵ�. 
          dbms_output.put_line(record3.emp_id||''|| 
                        record3.emp_name||''||record3.emp_job);
end;
/