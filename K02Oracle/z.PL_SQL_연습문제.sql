/*******************************************
                연습문제
*******************************************/

/*
1. 사원테이블에서 사원아이디로 조회해서 사원이름의 문자수만큼 #을 찍는 PL/SQL문을 작성하시오.
출력예] 이름이 ‘Ismael’ 라면 ###### 형태로 출력된다.
*/









/*
2. basic loop 문으로 구구단을 출력하시오.
*/
set serveroutput on;
declare
    dan number := 2;
    su number := 1;
    mulNum number := 0;
begin
    loop
        dbms_output.put_line(dan||'단');
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
3. while loop문으로 다음과 같은 결과를 출력하시오.
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
4. for loop문으로 다음과 같은 결과를 출력하시오.
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
5. 치환연산자를 통해 사원의 이름을 입력하면 부서번호에 따른 부서명을 출력하는 프로그램을 작성하시오.  
부서명은 아래 표를 참조하여 if문을 구성하면 된다. 
부서번호  부서명
----------------------------
 10	ACCOUNTING
 20	RESEARCH
 30	SALES
 40	OPERATIONS
----------------------------
만약 KING을 입력했다면 부서번호는 10, 부서명은 ACCOUNTING이 출력되면 된다. 
*/

