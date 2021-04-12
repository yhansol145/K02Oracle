/*******************************************
                ��������
*******************************************/

/*
1. ������̺��� ������̵�� ��ȸ�ؼ� ����̸��� ���ڼ���ŭ #�� ��� PL/SQL���� �ۼ��Ͻÿ�.
��¿�] �̸��� ��Ismael�� ��� ###### ���·� ��µȴ�.
*/
set serveroutput on;

select * from emp; --��ü��ȸ
select ename from emp; --�̸��� ��ȸ
select ename, length(ename) from emp;
--������̵�� ���ڵ� ��ȸ�Ͽ� ���̸� Ȯ��
select ename, length(ename) from emp where empno=7369;

-- PL/SQL�� �ۼ�
declare
    -- ġȯ�����ڸ� ���� �Է¹��� ������̵�
    input_id emp.empno%type;
    -- ����� �̸��� �̸��Ǳ��̸� ������ ����
    emp_name varchar2(30);
    name_length number(10);
    -- #�� �ٹٲ޾��� ������ �� ����ϱ� ���� ����
    sharp_str varchar2(50);
begin
    -- ������ ������ ���� select���� �����Ѵ�.
    select ename, length(ename) 
        into emp_name, name_length
    from emp where empno = &input_id; /* ġȯ�����ڸ� ���� �����ȣ �Է¹��� */
    
    -- ����̸��� ���̸�ŭ �ݺ��ؼ� #�� �����Ѵ�.
    for i in 1 .. name_length loop
        sharp_str := sharp_str || '#';
    end loop;
    
    dbms_output.put_line('������̸�:'|| emp_name);
    dbms_output.put_line('#�������:'|| sharp_str);
end;
/



/*
2. basic loop ������ �������� ����Ͻÿ�.
*/
set serveroutput on;
declare
    dan number := 2; -- 2�ܺ��� 9�ܱ��� ����
    su number := 1; -- 1~9���� ����
    guguStr varchar2(300); -- �������� ���ڿ��� �ϳ��� ���� ������ �뵵
begin
    -- �ܿ� �ش��ϴ� ������
    loop
        dbms_output.put_line(dan||'��');
            -- ���� �ش��ϴ� ������
            loop
                -- 1~9���� �����ϸ鼭 �ϳ��� ���� ���ڿ��� ����
                guguStr := guguStr || dan ||'*'|| su ||'='|| (dan*su) ||' ';
                su := su+1;
                if su>9 then
                    exit; -- if���� ���� Ż������
                end if;
            end loop;
            -- �ϳ��� ���� ���
            dbms_output.put_line(guguStr);
            
        guguStr := ''; -- ���ڿ� �ʱ�ȭ
        su := 1; -- �� �ʱ�ȭ
        dan := dan+1;
        exit when(dan>9); -- when���� ���� Ż������
    end loop;
end;
/



/*
3. while loop������ ������ ���� ����� ����Ͻÿ�.
*
**
***
****
*****
*/
set serveroutput on;
declare
    n1 number := 0;
    n2 number := 0;
    str1 varchar2(50);
begin
    while n1<5 loop
        while n2<=n1 loop
            str1 := str1||'*';
            n2 := n2+1;
        end loop;
        dbms_output.put_line(str1);
        str1 := null;
        n1 := n1+1;
        n2 := 0;
    end loop;
end;
/

-----------------------------------------------------------------

declare
    cnt number := 1; -- �ݺ��� ���� ����
    starStr varchar2(100); -- *�� �����ϱ� ���� ����
begin
    /*
        *�� ����� �� �ʱ�ȭ���� �����Ƿ� �ϳ���
        while������ ������ �����ϴ�.
    */
    while cnt<=5 loop
        starStr := starStr || '*';
        dbms_output.put_line(starStr);
        cnt := cnt + 1;
    end loop;
end;
/



/*
4. for loop������ ������ ���� ����� ����Ͻÿ�.
1 0 0 0 0
0 1 0 0 0
0 0 1 0 0
0 0 0 1 0
0 0 0 0 1
*/
declare
    str varchar2(50);
begin
    for num1 in 1 .. 5 loop
        for num2 in 1 .. 5 loop
            if num1=num2 then
                str := str||'1 ';
            else
                str := str||'0 ';
            end if;
        end loop;
        dbms_output.put_line(str);
        str := null;
    end loop;
end;
/

-----------------------------------------------------------------

declare
    numStr varchar2(50);
begin
    for i in 1 .. 5 loop
        for j in 1 .. 5 loop
            if i=j then
                numStr := numStr || '1 ';
            else
                numStr := numStr || '0 ';
            end if;
        end loop;
        dbms_output.put_line(numStr);
        -- ���� ��� �� ���ڿ� �ʱ�ȭ
        numStr := null;
    end loop;
end;
/



/*
5. ġȯ�����ڸ� ���� ����� �̸��� �Է��ϸ� �μ���ȣ�� ���� �μ����� ����ϴ� ���α׷��� �ۼ��Ͻÿ�.  
�μ����� �Ʒ� ǥ�� �����Ͽ� if���� �����ϸ� �ȴ�. 
�μ���ȣ  �μ���
----------------------------
 10	ACCOUNTING
 20	RESEARCH
 30	SALES
 40	OPERATIONS
----------------------------
���� KING�� �Է��ߴٸ� �μ���ȣ�� 10, �μ����� ACCOUNTING�� ��µǸ� �ȴ�. 
*/

select * from emp where ename='KING';

declare
    -- ġȯ�����ڸ� ���� �Է¹����� ���ڿ��̶�� '�� �ٿ���� �Ѵ�.
    input_name varchar2(30) := '&input_name';
    dept_no emp.deptno%type; -- ������̺��� �μ���ȣ�� ����
    dept_name dept.dname%type; -- �μ����̺��� �μ����� ����
begin
    -- �Է¹��� �̸��� ���� 
    select deptno 
        into dept_no
    from emp
    where ename=input_name;
    
    -- �μ���ȣ�� ���� �μ��� �Ǵ�
    if dept_no=10 then
        dept_name := 'ACCOUNTING';
    elsif dept_no=20 then   
        dept_name := 'RESEARCH';
    elsif dept_no=30 then
        dept_name := 'SALES';
    elsif dept_no=40 then
        dept_name := 'OPERATIONS';
    end if;
    
    dbms_output.put_line('�μ���ȣ / �μ���');
    dbms_output.put_line(dept_no ||' / '|| dept_name);
end;
/
