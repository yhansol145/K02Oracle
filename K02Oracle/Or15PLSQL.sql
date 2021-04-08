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


/*
����] �Ʒ� ������ ���� PL/SQL���� �ۼ��Ͻÿ�.
1.���պ�������
    �������̺� : employees
    ���պ����ڷ����� �̸� : empTypes
        ���1 : emp_id -> �����ȣ
        ���2 : emp_name -> �������ü�̸�(�̸�+��)
        ���3 : emp_salary -> �޿�
        ���4 : emp_percent -> ���ʽ���
    ������ ������ �ڷ����� �̿��Ͽ� ���պ��� rec2�� ������ �����ȣ 
    100���� ������ �Ҵ��Ѵ�.
2.1�� ������ ����Ѵ�.
3.�� ������ �Ϸ����� ġȯ�����ڸ� ����Ͽ� �����ȣ�� ����ڷκ��� �Է¹�����
    �ش� ����� ������ ����Ҽ��ֵ��� �����Ͻÿ�.[����]
*/

select * from employees where employee_id = 100;
select employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
    from employees 
    where employee_id = 100;


set serveroutput on;
declare
    -- 4���� ����� ���� ���պ����ڷ��� ����
    type empTypes is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    --���պ��� ����
    rec2 empTypes;
    
    --ġȯ�����ڸ� ���� �Է¹��� ���� �Ҵ�޴� ����
    inputNum number(3) := &inputNum;
begin
    -- ������ ���ǿ� �����ϴ� select�� ����
    select employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
        into rec2
        from employees
        where employee_id = inputNum;
        dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ���');
        dbms_output.put_line(rec2.emp_id||' / '||rec2.emp_name||' / '||
                            rec2.emp_salary||' / '||rec2.emp_percent);
end;
/



/*
ġȯ������ : PL/SQL ���� ����ڷκ��� �����͸� �Է¹����� ����ϴ�
    �����ڷ� �����տ� &�� �ٿ��ָ� �ȴ�. ����� �Է�â�� ���.
*/
-- ���� ����3������ �䱸�� ġȯ�����ڷ� �����Ͽ� �����ȣ�� �Է¹޾� ó���Ѵ�.




/*
���ε� ����
    : ȣ��Ʈȯ�濡�� ����� �����ν� �� PL/SQL�����̴�.
    ȣ��Ʈȯ���̶� PL/SQL�� ���� ������ ������ �κ��� ���Ѵ�.
    �ܼ�(CMD)������ SQL> ���������Ʈ�� �ִ� ���¸� ���Ѵ�.
    
    ����]
        var ������ �ڷ���;
        Ȥ��
        variable ������ �ڷ���;
*/

set serveroutput on;
var return_var number; --ȣ��Ʈȯ�濡�� ���ε� ���� ����
declare
begin
    -- PL/SQL ���� ����Ҷ��� �ݵ�� :�� �����տ� �ٿ��� �Ѵ�.
    -- �Ϲݺ����� ���ε庯���� �����ϱ� ���� �뵵�� ���ȴ�.
    :return_var :=999;
    dbms_output.put_line(:return_var);
end;
/
print return_var;
/*
    ȣ��Ʈȯ�濡�� ����Ҷ��� print���� ����Ѵ�.
    ����� �ȵǸ� CMDâ���� Ȯ���غ���.
*/




--------------------------------------------
--���(���ǹ�) : if��, case���� ���� ���ǹ�

--if��
--Ȧ��¦���� �Ǵ��ϴ� if�� ����
declare
    num number;
begin
    num := 10;
    
    if mod(num,2) = 0 then
        dbms_output.put_line(num ||'�� ¦��');
    else
        dbms_output.put_line(num ||'�� Ȧ��');
    end if;
end;
/

-- �� ������ ġȯ�����ڸ� ���� ���ڸ� �Է¹��� �� �Ǵ��� �� �ֵ��� ����
declare
    -- ġȯ�����ڴ� ����ο� ��� ����
    num number := &num;
begin
    if mod(num,2) = 0 then
        dbms_output.put_line(num ||'�� ¦��');
    else
        dbms_output.put_line(num ||'�� Ȧ��');
    end if;
end;
/

/*
�ó�����] �����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ��μ�����
�ٹ��ϴ����� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�. ��, if~eslif���� ����Ͽ� �����Ͻÿ�.
*/

declare
    -- ġȯ�����ڸ� ���� �����ȣ�� �Է¹���
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������'; -- �μ����� ����� ���ÿ� �ʱ�ȭ
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id; -- �Է¹��� �����ȣ�� ���� ��������
    
    /*
    �������� ������ ����� ��� java�� ���� else if�� ������� �ʰ�
    elsif�� ����ؾ� �Ѵ�. ���� �߰�ȣ ��� then�� ;�� ���ȴ�.
    */
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';
    elsif emp_dept = 80 then
        dept_name := 'Sales';
    elsif emp_dept = 90 then
        dept_name := 'Executive';
    elsif emp_dept = 100 then
        dept_name := 'Finance';
    end if;
    
    dbms_output.put_line('�����ȣ'||emp_id||'�� ����');
    dbms_output.put_line('�̸�:'||emp_name
                        ||', �μ���ȣ:'|| emp_dept
                        ||', �μ���:'|| dept_name);
end;
/



/*
case�� : java�� switch���� ����� ���ǹ�
����]
    case ����
        when ��1 then '�Ҵ簪1'
        when ��2 then '�Ҵ簪2'
        ....
    end;
    
�ó�����] ������ if~elsif�� �ۼ��� PL/SQL���� case~when������ 
*/

declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������'; 
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id; 
  
    /*
    case~when���� if���� �ٸ����� �Ҵ��� ������ ���� ������ ��
    ���峻���� ������ �Ǵ��Ͽ� �ϳ��� ���� �Ҵ��ϴ� ����̴�.
    */
    
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Sales'
            when 90 then 'Executive'
            when 100 then 'Finance'
        end;
    
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';
    elsif emp_dept = 80 then
        dept_name := 'Sales';
    elsif emp_dept = 90 then
        dept_name := 'Executive';
    elsif emp_dept = 100 then
        dept_name := 'Finance';
    end if;
    
    dbms_output.put_line('�����ȣ'||emp_id||'�� ����');
    dbms_output.put_line('�̸�:'||emp_name
                        ||', �μ���ȣ:'|| emp_dept
                        ||', �μ���:'|| dept_name);
end;
/



/*
���(�ݺ���)

�ݺ���1 : Basin loop��
    java�� do~while���� ���� ����üũ ���� �ϴ� loop�� ������ ��
    Ż�������� �ɶ����� �ݺ��Ѵ�.
*/
declare
    num number := 0;
begin
    loop
        -- 0~10���� ��µ�
        dbms_output.put_line(num);
        num := num + 1;
        exit when (num>10);
    end loop;
end;
/

/*
����] Basic loop������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ�.
*/

declare
    strNum number := 0; --������ų ����
    sumNum number := 0; --�������� ���� ����
    /*
    ���������� sum�� ����� �� ����. ����� �̹Ƿ� ������ �߻��Ѵ�.
    */
begin
    /*
    ���մ��Կ�����, ���������ڰ� �����Ƿ� ������ Ȥ�� ������
    ������ �Ʒ��Ͱ��� �����ؾ� �Ѵ�.
    */
    loop
        sumNum := sumNum+strNum;
        strNum := strNum+1;
        exit when (strNum>10);
    end loop;
    dbms_output.put_line(sumNum);
end;
/



/*
�ݺ���2 : while��
    Basic loop�ʹ� �ٸ��� ������ ���� Ȯ���� �� �����Ѵ�.
    ��, ���ǿ� ���� �ʴ´ٸ� �ѹ��� ������� ���� �� �ִ�.
*/

declare
    num1 number := 0;
begin
    --while������ �����ϱ� �� ������ ���� �Ǵ��Ѵ�.
    while num1<11 loop
        dbms_output.put_line('�̹����ڴ�:'|| num1);
        num1 := num1 + 1;
    end loop;
end;
/

/*
����] while loop������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ�.
*/

declare
    strNum number := 0;
    sumNum number := 0;
begin
    while strNum<11 loop
        sumNum := sumNum+strNum;
        strNum := strNum+1;
    end loop;
    dbms_output.put_line(sumNum);
end;
/



/*
�ݺ���3 : for��
    �ݺ��� Ƚ���� �����Ͽ� ����� �� �ִ� �ݺ�������, �ݺ��� ����
    ������ ������ �������� �ʾƵ� �ȴ�. �׷��Ƿ� Ư���� ������ ���ٸ�
    declare(�����)�� ������� �ʾƵ� �ȴ�.
*/
declare
begin
    for num2 in 0 .. 10 loop
        dbms_output.put_line('for��¯�ε�:'||num2);
    end loop;
end;
/


begin
    for num3 in reverse 0 .. 10 loop
        dbms_output.put_line('for��¯�ε�:'||num3);
    end loop;
end;
/


/*
�ó�����] for loop������ �������� ����Ͻÿ�.
*/


--�ٹٲ� �ִ� ����
begin
    for dan in 2 .. 9 loop
        dbms_output.put_line(dan||'��');
        for su in 1 .. 9 loop
            dbms_output.put_line(dan||'*'||su||'='||(dan*su));
        end loop;
    end loop;
end;
/


--�ٹٲ� ���� ����
declare
    --�����ܿ��� �ϳ��� ���� �����ϱ� ���� ����
    guguStr varchar2(1000);
begin
    --�ܿ� �ش��ϴ� for loop��(2~9)
    for dan in 2 .. 9 loop
        --���� �ش��ϴ� for loop��(1~9)
        for su in 1 .. 9 loop
            --�ϳ��� ���� �����ؼ� �����Ѵ�.
            guguStr := guguStr || dan ||'*'|| su ||'='|| (dan*su) ||' ';
        end loop;
        --�ϳ��� ���� ����� �� �ٹٲ� �Ѵ�.
        --put_line�� �⺻������ �ٹٲ� ����� ����
        dbms_output.put_line(guguStr);
        --�� ���� ���� �����ϱ� ���� ���ڿ��� �ʱ�ȭ�Ѵ�.
        guguStr := '';
    end loop;
end;
/


/*
Ŀ��(Cursor)
    : select���忡 ���� �������� ��ȯ�Ǵ� ��� �� �࿡ �����ϱ�
    ���� ��ü
    
    ������]
        Cursor Ŀ���� Is 
            Select ���� (��, into���� ���� select)
    Open Cursor
        : ������ �����϶�� �ǹ�. �� Open�Ҷ� Cursor �������
        select������ ����Ǿ� ������� ��Եȴ�. Cursor�� �� �������
        ù��°�࿡ ��ġ�ϰ� �ȴ�.
        
        Open Ŀ����;
        
    Fetch ~ Into ~
        : ����¿��� �ϳ��� ���� �о���̴� �۾����� ������� ����(Fetch)
        �Ŀ� Cursor�� ���������� �̵���.
        
        Fetch Ŀ���� Into (����1, ����2....)
    
    Close Cursor
        : Ŀ�� �ݱ�� ������� �ڿ��� �ݳ��Ѵ�. select ������ ���
        ó���� �� Cursor�� Close����
        
        Close Ŀ����;
        
    Cursor�� �Ӽ�
        %Found : ���� �ֱ��� ����(Fetch)�� ���� Return�ϸ� True,
            �ƴϸ� False�� ��ȯ�Ѵ�.
        %RowCount : ���ݱ��� Return�� ���� ������ ��ȯ�Ѵ�.
*/


/*
�ó�����] �μ����̺��� ���ڵ带 Cursor�� ���� ����ϴ� PL/SQL����
    �ۼ��Ͻÿ�.
*/
declare
    -- �μ����̺��� ��ü�÷��� �����ϴ� �������� ����
    v_dept departments%rowtype;
    -- Ŀ�� ����(�μ����̺��� ��� ���ڵ带 ��ȸ�ϴ� select��) 
    cursor cur1 is
        select
            department_id, department_name, location_id
        from departments;
begin
    /*
    �ش� �������� �����ؼ� ������� ��������� �������
    ������̶� ����(����)���� ������ �� ��ȯ�Ǵ� ���ڵ��� �����
    ���Ѵ�. (java������ ResultSet��ü�� ������ ������ �Ѵ�.)
    */
    open cur1;
    
    /*
    basic�������� ���� ���� ������� ������ŭ �ݺ��Ͽ� �����Ѵ�.
    */
    loop
        /*
        �� �÷��� ���� ���������� �����Ѵ�.
        */
        fetch cur1 into
            v_dept.department_id,
            v_dept.department_name,
            v_dept.location_id;
            
        /*
        Ż���������� ���̻� ������ ���� ������ exit�� ����ȴ�.
        */
        exit when cur1%notfound;
        dbms_output.put_line(v_dept.department_id||' '||
                                v_dept.department_name||' '||
                                v_dept.location_id);
    end loop;
    
    -- Ŀ���� �ڿ��ݳ�
    close cur1;
end;
/

/*
��������] Cursor�� ����Ͽ� ������̺��� Ŀ�̼��� null�� �ƴ�
����� �����ȣ, �̸�, �޿��� ��������(�̸�)���� ����Ͻÿ�.
*/

select employee_id, first_name||''||last_name, salary
from employees where commission_pct is not null
order by concat(first_name||' ', last_name) asc;
    

declare
    -- ������ ���ǿ� �´� Ŀ���� �����Ѵ�. �̶� into���� ������� �ʴ´�.
    cursor curEmp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
    --������̺��� ��ü�÷��� �����ϴ� �������� ����
    varEmp employees%rowType;
begin
    --Ŀ���� �����Ͽ� ������ �����Ѵ�.
    open curEmp;
    --Basic loop���� ���� Ŀ���� ����� ������� �����Ѵ�.
    loop
        --������ �� ������ �����ϱ� ���� into�� ����Ѵ�.
        fetch curEmp 
            into varEmp.employee_id, varEmp.last_name, varEmp.salary;
        --���̻� ������ ������� ������ ������ Ż���Ѵ�.
        exit when curEmp%notfound;
        dbms_output.put_line(varEmp.employee_id||' '||
                                varEmp.last_name||''||
                                varEmp.salary);
    end loop;
    --Ŀ���� �ݾ� �ڿ��ݳ��Ѵ�.
    close curEmp;
end;
/


/*
�÷���(�迭)
    �Ϲ� ���α׷��� ���� ����ϴ� �迭Ÿ���� PL/SQL ������ ���̺� Ÿ���̶�� �Ѵ�.
    1����, 2���� �迭�� �����غ��� ���̺�(ǥ)�� ���� �����̱� �����̴�.
    
����
- �����迭
- VArray
- ��ø���̺�
*/

/*
1. �����迭(Associative Array / Index-by Table)
    : Ű�� �� �ѽ����� ������ �÷������� Java�� �ؽøʰ� ���� �����̴�.
    Key : �ڷ����� �ַ� ���ڸ� ����ϸ� binary_integer, pls_integer��
        ���ȴ�. �� �ΰ��� Ÿ���� number���� ũ��� �۰�, ������꿡 ����
        Ư¡�� ������. ���� ������(varchar2)���� ����Ҽ��� �ִ�.
    Value : �ڷ����� �������̸� �ַ� varchar2�� ���ȴ�.
    
    ����]
        Type �����迭�ڷ��� Is
            Table of �����迭 �� Ÿ��
            Index By �����迭 Ű Ÿ��;
*/

/*
�ó�����] ������ ���ǿ� �´� �����迭�� ������ �� ���� �Ҵ��Ͻÿ�.
    �����迭 �ڷ��� �� : avType, �����ڷ���:������, Ű���ڷ���:������
    key : girl, boy
    value : Ʈ���̽�, ��ź�ҳ��
    ������ : var_array
*/
declare
    -- �����迭 �ڷ��� ����
   Type avType is
    Table Of varchar2(30) -- value(��)�� �ڷ��� ����
    Index By varchar2(10); -- key(Ű)�� �ڷ��� ����
    -- �����迭 Ÿ���� ��������
    var_array avType;
begin
    --�����迭�� �� �Ҵ�
    var_array('girl') := 'Ʈ���̽�';
    var_array('boy') := '��ź�ҳ��';
    --���
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/


/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �̸��� �����ϴ� �����迭�� �����Ͻÿ�.
    key�� ����, value�� full_name���� �����Ͻÿ�.
*/
-- 100�� �μ��� �ٹ��ϴ� ���� ���
select * from employees where department_id=100; --6��
-- full_name�� ���
select first_name||' '||last_name "full_name"
    from employees where department_id=100; --6��

-- ������ ������ ���� �������� �ټ����� ����ǹǷ� Cursor�� ����ؾ� �Ѵ�.
declare
    -- �������� ���� Ŀ�� ����
    cursor emp_cur is
        select first_name||' '||last_name "full_name"
        from employees where department_id=100;
        
    -- �����迭 �ڷ��� ����(���� ����, Ű�� ���ڷ� �����Ѵ�.)
    Type nameAvType Is
        Table of varchar2(30)
        Index By binary_integer;
    -- �����迭 ������ ����
    names_arr nameAvType;
    -- ����� �̸�, �ε����� ����� ���� ����
    fname varchar2(50);
    idx number := 1;
begin
    open emp_cur;
    loop
        -- �ϳ��� ��(row)���� ������ ������(�̸�)�� ������ �����Ѵ�.
        fetch emp_cur into fname;
        -- Ż������
        exit when emp_cur%NotFound;
        -- �����迭�� ������ ����
        names_arr(idx) := fname;
        -- Ű�� ���� �ε��� ����
        idx := idx + 1;
    end loop;
    close emp_cur;
    
    -- �����迭�� ũ�⸸ŭ �ݺ��ؼ� ���
    for i in 1 .. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/


/*
2. VArray(Variable Array)
    : �������̸� ���� �迭�μ� �Ϲ� ���α׷��� ���� ����ϴ� �迭��
    �����ϴ�. ũ�⿡ ������ �־ ������ �� ũ��(����ǰ���)�� �����ϸ�
    �̺��� ū �迭�� ���� �� ����.
    ����]
        Type �迭Ÿ�Ը� Is
            Array(�迭ũ��) Of ��Ұ�_Ÿ��;
*/

declare
    -- VArray Ÿ�� ���� : ũ��� 5, ������ �����ʹ� ������
    type vaType is
        array(5) of varchar2(20);
    -- VArray �� �迭���� ����
    v_arr vaType;
    cnt number := 0;
begin
    -- �����ڸ� ���� ���� �ʱ�ȭ(�� 5���� 3���� �Ҵ�)
    v_arr := vaType('First', 'Second', 'Third','','');
    
    -- Basic loop���� ���� �迭��� ���(���ε����� 1���� ������)
    loop
        cnt := cnt + 1;
        -- Ż������
        if cnt>5 then
            exit;
        end if;
        -- ���
        dbms_output.put_line(v_arr(cnt));
    end loop;
    
    -- �迭�� ��Ұ� ���Ҵ�
    v_arr(3) := '�츮��';
    v_arr(4) := 'JAVA';
    v_arr(5) := '�����ڴ�';
    
    -- 2�����
    for i in 1 .. 5 loop
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/


---------------------------------------------------------------

declare 
    -- �ϳ��� �÷��� �����ϴ� ���������� ���� VArray�ڷ��� ����
    type vaType1 is
        array(6) of employees.employee_id%Type;
    --�迭 ���� ���� �� �ʱ�ȭ
    va_one vaType1 := vaType1('','','','','','');
    cnt number := 1;
begin
    /*
    Java�� Ȯ��for���� ����ϰ� ������ ����� ������ŭ �ڵ�����
    �ݺ��ϴ� ���·� ����Ѵ�. select���� employee_id�� ���� i��
    �Ҵ�ǰ�, �̸� ���� �����Ѵ�. 
    */
    for i in (select employee_id from employees where department_id=100) loop
        -- ������ �����͸� �迭�� �����Ѵ�.
        va_one(cnt) := i.employee_id;
        cnt := cnt + 1;
    end loop;
    -- �迭�� ũ�⸸ŭ �ݺ��ϸ鼭 ���
    for j in 1 .. va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/

select * from employees where department_id=100; --6���� ���ڵ尡 �����.

/*
3. ��ø���̺�(Nested Table)
    : VArray�� ����� ������ �迭�μ� �迭�� ũ�⸦ ������� �����Ƿ�
        �������� �迭�� ũ�Ⱑ �����ȴ�. ���⼭ ���ϴ� ���̺��� �ڷᰡ
        ����Ǵ� �������̺��� �ƴ϶� �÷����� �� ������ �ǹ��Ѵ�.
        ����]
            Type ��ø���̺�� Is
                Table Of ��_Ÿ��;
*/
declare
    -- ��ø���̺� �ڷ��� ���� �� ��������
    type ntType is
        table of varchar2(30);
    nt_array ntType;
begin
    -- �����ڸ� ���� �� �Ҵ�(���⼭ ũ��4�� ��ø���̺� ������)
    nt_array := ntType('ù��°', '�ι�°', '����°','');
    
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '�׹�°���Ҵ�';
    dbms_output.put_line(nt_array(4));
    
    --nt_array(5) := '�ټ���°��??�Ҵ�??';
    --�����߻�. ÷�ڰ� ������ �Ѿ���.
    
    --ũ�⸦ Ȯ���Ҷ��� �����ڸ� ���� �迭�� ũ�⸦ �������� Ȯ���Ѵ�.
    nt_array := ntType('1a', '2b', '3c', '4d', '5e', '6f', '7g');
    
    -- ũ�� 7�� ��ø���̺� ���
    for i in 1 .. 7 loop
        dbms_output.put_line(nt_array(i));
    end loop;[
end;
/



/*
�ó�����]��ø���̺�� for���� ���� ������̺���
    ��ü ���ڵ��� �����ȣ�� �̸��� ����Ͻÿ�.
*/
declare
    /*
    ��ø���̺� �ڷ��� ���� �� ���� ���� : ������̺� ��ü �÷��� �����ϴ�
        ���������� �����̹Ƿ� �ϳ��� ���ڵ�(Row)�� ������ �� �ִ�
        ���·� �����Ͽ���.
    */
    type ntType is
        table of employees%rowtype;
    nt_array ntType;
begin
    -- ũ�⸦ �������� �ʰ� �����ڸ� ���� �ʱ�ȭ�Ѵ�.
    nt_array := ntType();
    
    /*
    ������̺��� ���ڵ� �� ��ŭ �ݺ��ϸ鼭 ���ڵ带 �ϳ��� rec�� �Ҵ��Ѵ�.
    Ŀ��ó�� �����ϴ� for���� ���·� Java�� Ȯ��for��ó�� ���Ǿ���.
    */
    for rec in (select * from employees) loop
        nt_array.extend; -- ��ø���̺��� ���κ��� Ȯ���ϸ鼭 null����.
        nt_array(nt_array.last) := rec; -- ������ �ε����� ���ڵ�(�������) ����
    end loop;
    
    -- ��ø���̺��� ù��° �ε������� ������ �ε������� ����Ѵ�.
    for i in nt_array.first .. nt_array.last loop
        dbms_output.put_line(nt_array(i).employee_id||
            '>'||nt_array(i).first_name);
    end loop;
end;
/