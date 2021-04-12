/*******************************************
                연습문제
*******************************************/

/*
1. 사원테이블에서 사원아이디로 조회해서 사원이름의 문자수만큼 #을 찍는 PL/SQL문을 작성하시오.
출력예] 이름이 ‘Ismael’ 라면 ###### 형태로 출력된다.
*/
set serveroutput on;

select * from emp; --전체조회
select ename from emp; --이름만 조회
select ename, length(ename) from emp;
--사원아이디로 레코드 조회하여 길이를 확인
select ename, length(ename) from emp where empno=7369;

-- PL/SQL문 작성
declare
    -- 치환연산자를 통해 입력받을 사원아이디
    input_id emp.empno%type;
    -- 사원의 이름과 이름의길이를 저장할 변수
    emp_name varchar2(30);
    name_length number(10);
    -- #을 줄바꿈없이 저장한 후 출력하기 위한 변수
    sharp_str varchar2(50);
begin
    -- 선언한 변수를 통해 select절을 수정한다.
    select ename, length(ename) 
        into emp_name, name_length
    from emp where empno = &input_id; /* 치환연산자를 통해 사원번호 입력받음 */
    
    -- 사원이름의 길이만큼 반복해서 #을 연결한다.
    for i in 1 .. name_length loop
        sharp_str := sharp_str || '#';
    end loop;
    
    dbms_output.put_line('사원의이름:'|| emp_name);
    dbms_output.put_line('#문자출력:'|| sharp_str);
end;
/



/*
2. basic loop 문으로 구구단을 출력하시오.
*/
set serveroutput on;
declare
    dan number := 2; -- 2단부터 9단까지 증가
    su number := 1; -- 1~9까지 증가
    guguStr varchar2(300); -- 구구단을 문자열로 하나의 단을 저장할 용도
begin
    -- 단에 해당하는 루프문
    loop
        dbms_output.put_line(dan||'단');
            -- 수에 해당하는 루프문
            loop
                -- 1~9까지 증가하면서 하나의 단을 문자열에 저장
                guguStr := guguStr || dan ||'*'|| su ||'='|| (dan*su) ||' ';
                su := su+1;
                if su>9 then
                    exit; -- if문을 통한 탈출조건
                end if;
            end loop;
            -- 하나의 단을 출력
            dbms_output.put_line(guguStr);
            
        guguStr := ''; -- 문자열 초기화
        su := 1; -- 수 초기화
        dan := dan+1;
        exit when(dan>9); -- when문을 통한 탈출조건
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

-----------------------------------------------------------------

declare
    cnt number := 1; -- 반복을 위한 변수
    starStr varchar2(100); -- *를 연결하기 위한 변수
begin
    /*
        *를 출력한 후 초기화하지 않으므로 하나의
        while문으로 구현이 가능하다.
    */
    while cnt<=5 loop
        starStr := starStr || '*';
        dbms_output.put_line(starStr);
        cnt := cnt + 1;
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
        -- 한줄 출력 후 문자열 초기화
        numStr := null;
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

select * from emp where ename='KING';

declare
    -- 치환연산자를 통해 입력받을때 문자열이라면 '을 붙여줘야 한다.
    input_name varchar2(30) := '&input_name';
    dept_no emp.deptno%type; -- 사원테이블의 부서번호를 참조
    dept_name dept.dname%type; -- 부서테이블의 부서명을 참조
begin
    -- 입력받은 이름을 통해 
    select deptno 
        into dept_no
    from emp
    where ename=input_name;
    
    -- 부서번호를 통해 부서명 판단
    if dept_no=10 then
        dept_name := 'ACCOUNTING';
    elsif dept_no=20 then   
        dept_name := 'RESEARCH';
    elsif dept_no=30 then
        dept_name := 'SALES';
    elsif dept_no=40 then
        dept_name := 'OPERATIONS';
    end if;
    
    dbms_output.put_line('부서번호 / 부서명');
    dbms_output.put_line(dept_no ||' / '|| dept_name);
end;
/
