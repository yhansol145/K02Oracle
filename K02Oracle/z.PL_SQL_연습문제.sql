/*******************************************
                ��������
*******************************************/

/*
1. ������̺��� ������̵�� ��ȸ�ؼ� ����̸��� ���ڼ���ŭ #�� ��� PL/SQL���� �ۼ��Ͻÿ�.
��¿�] �̸��� ��Ismael�� ��� ###### ���·� ��µȴ�.
*/









/*
2. basic loop ������ �������� ����Ͻÿ�.
*/
set serveroutput on;
declare
    dan number := 2;
    su number := 1;
    mulNum number := 0;
begin
    loop
        dbms_output.put_line(dan||'��');
            loop
                mulNum := dan*su;
                dbms_output.put_line(dan||'*'||su||'='||(mulNum));
                su := su+1;
                exit when(su>9);
            end loop;
        dan := dan+1;
        su := 1;
        mulNum := 0;
        exit when(dan>9);
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
                str := str||'1';
            else
                str := str||'0';
            end if;
        end loop;
        dbms_output.put_line(str);
        str := null;
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

