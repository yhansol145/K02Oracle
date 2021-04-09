/******************
파일명 : Or16SubProgram.sql
서브프로그램
설명 : 저장프로시져, 함수 그리고 프로시져의 일종인 트리거를 학습
******************/

/*
서브프로그램(Sub Program)
- PL/SQL에서는 프로시져와 함수라는 두가지 유형의 서브프로그램이 있다.
- Select를 포함해서 다른 DML문을 이용하여 프로그래밍적인 요소를 통해
    사용 가능하다.
- 트리거는 프로시져의 일종으로 특정 테이블에 레코드의 변화가 있을경우
    자동으로 실행된다.
*/

/*
저장프로시저(Stored Procedure)
- 프로시져는 return문이 없는 대신 out파라미터를 통해 값을 반환한다.
- 보안성을 높일 수 있고 네트워크의 부하를 줄일 수 있다.
형식]
    Create (Or Replace] Procedure 프로시저명
    [(
        매개변수 In 자료형, 매개변수 Out 자료형
    )]
    Is [변수선언]
    Begin
        실행문장;
    End;    
*/

/*
시나리오] 사원의 급여를 select하여 출력하는 저장프로시져를 생성하시오.
*/
set serveroutput on;

-- 파라미터가 없는 프로시져 정의
create procedure pcd_emp_salary
is
    -- 변수를 생성. 사원테이블의 급여 컬럼을 참조하는 참조변수;
    v_salary employees.salary%type;
begin
    -- 100번 사원의 급여를 변수에 할당한다.
    select salary into v_salary
    from employees
    where employee_id = 100;
    
    dbms_output.put_line('사원번호100의 급여는:'|| v_salary ||'입니다');
end;
/

select * from user_source where name like upper('%pcd_emp_salary%');

-- 호스트 환경에서 프로시져 실행
execute pcd_emp_salary;


/*
- IN 파라미터 사용하여 프로시져 생성

시나리오] 사원의 이름을 매개변수로 받아서 사원테이블에서 레코드를 조회한 후
해당사원의 급여를 출력하는 프로시저를 생성 후 실행하시오.
해당 문제는 in파라미터를 받은 후 처리한다.
사원이름(first_name) : Bruce, Neena
*/
-- in파라미터를 설정한다. 사원테이블의 사원명을 참조하는 참조변수형태.
create or replace procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    /*
    프로시저 생성시 변수를 선언하는 부분.
    PL/SQL에서 declare와 동일하고, 필요없는 경우
    생략할 수 있음.
    */
    valSalary number(10);
begin
    
    /*
    인파라미터로 전달된 사원이름을 조건으로 급여를 구해서
    변수에 할당한다.
    */
    select salary into valSalary
    from employees where first_name = param_name;
    
    dbms_output.put_line(param_name||'의 급여는 '|| valSalary ||' 입니다');
end;
/

-- 사원의 이름을 파라미터로 전달하여 프로시져 호출
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');


/*
- OUT파라미터 사용하여 프로시져 생성

시나리오] 위 문제와 동일하게 이름을 매개변수로 전달받아서 급여를 조회하는
프로시저를 생성하시오. 단, 급여는 out파라미터를 사용하여 반환 후 출력하시오.
*/
create or replace procedure pcd_out_param_salary
    (
        param_name in varchar2,
        param_salary out employees.salary%type
    )-- 두가지 형태의 파라미터를 정의함.
is
    -- 변수선언이 필요없는 경우 생략 가능.
begin
    -- 실행된 결과를 out파라미터에 할당함.
    -- out파라미터는 호스트환경 혹은 Java영역으로 반환된다.
    select salary into param_salary
    from employees where first_name = param_name;
end;
/

-- out파라미터를 확인하기 위해 바인드변수를 선언한다.
var v_salary varchar2(30);

-- 프로시져 실행시 각각의 파라미터를 전달한다. 바인드 변수는 :을 붙여야 한다.
execute pcd_out_param_salary('Matthew', :v_salary);
-- 실행 후 프로시저가 반환하는 out파라미터를 출력한다.
print v_salary;


/*
시나리오] 사원번호와 급여를 매개변수로 전달받아 해당사원의 급여를
    수정하고 실제 수정된 행의 갯수를 반환받아서 출력하는 프로시저를
    작성하시오
*/
-- 실습을 위해 employees 테이블의 레코드까지 전체 복사한다.
create table zcopy_employees
as
select * from employees where 1=1;

-- in파라미터는 사원번호와, 급여를 전달함. out파라미터는 적용된 행의 갯수 반환함.
create or replace procedure pcd_update_salary
    (
        p_empid in number,
        p_salary in number,
        rCount out number
    )
is
    -- 추가적인 변수 선언이 필요없으므로 생략
begin
    -- 실제 업데이트를 처리하는 쿼리문으로 in파라미터를 통해 값을 설정
    update zcopy_employees
        set salary = p_salary
        where employee_id = p_empid;
    
    /*
    sql%notfound
        : 쿼리실행 후 적용된 행이 없을경우 true를 반환한다.
        found는 반대의 경우를 반환한다.
    sql%rowcount
        : 쿼리실행 후 실제 적용된 행의 갯수를 반환한다.
    */
    if SQL%notfound then
        dbms_output.put_line(p_empid ||'은(는) 없는사원임다');
    else
        dbms_output.put_line(SQL%rowcount ||'명의 자료가 수정되씸');
        -- 실제 적용된 행의 갯수를 반환하여 out파라미터에 저장한다.
        rCount := sql%rowcount;
    end if;
    
    /*
    행의 변화가 있는 쿼리를 실행할 경우 반드시 commit 해야 실제테이블에
    적용되며 oracle외부에서 확인할 수 있다.
    */
    commit;
end;
/ 
-- 프로시저 실행을 위해 바인드변수를 생성(var도 가능함)
variable r_count number;
-- 기존 레코드 확인
select first_name, salary from zcopy_employees where employee_id=100; --Steven 24000
-- 프로시저 실행(바인드 변수에는 반드시 :을 붙여야 함)
execute pcd_update_salary(100, 30000, :r_count);
-- 실행 후 적용된 행의 갯수 확인
print r_count;
select first_name, salary from zcopy_employees where employee_id=100; --Steven 30000


select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') from dual;


/*
2. 함수
- 사용자가 PL/SQL문을 사용하여 오라클에서 제공하는 내장함수와 같은 기능을 정의한 것
- 함수는 In파라메타만 사용할 수 있으며, 반드시 반환될 값의 데이터타입을
    Return문에 선언해야 한다.
- 프로시저는 여러개의 결과값을 얻어올 수 있지만, 함수는 반드시 하나의 값을 반환받는다.

[함수와 프로시저 비교]
값을 반환할때는 Out파라미터를 이용하지만, 함수는 return문을 통해 반환한다.
쿼리의 일부로 사용되므로 반드시 return값이 있어야 한다.
*/

/*
시나리오] 2개의 정수를 전달받아서 두 정수사이의 모든 수를 더해서 결과를 반환하는 함수를 정의하시오.
    실행예) 2, 7 -> 2+3+4+5+6+7 = ??
*/
create or replace function calSumBetween (
    num1 in number,
    num2 number -- 함수는 in파라미터만 사용가능하므로 생략할 수 있다.
)
return
    -- 함수는 반드시 반환값이 있으므로 반환타입을 명시해야 한다.
    number
is
    -- 반환값으로 사용할 변수
    sumNum number;
begin
    sumNum := 0;
    
    for i in num1 .. num2 loop
        sumNum := sumNum + i;
    end loop;
    -- 연산의 결과를 반환한다.
    return sumNum;
end;
/

-- 실행방법1 : 쿼리문의 일부로 사용한다.
select calSumBetween(1,10) from dual;
select calSumBetween(1,1000) from dual;

var hapText varchar2(30);
execute :hapText := calSumBetween(1,10);
print hapText;

-- 데이터 사전에서 확인
select * from user_source where name like upper('%calsum%');


/*
퀴즈] 주민번호를 전달받아서 성별을 판단하는 함수를 정의하시오.
999999-1000000 -> '남자' 반환
999999-2000000 -> '여자' 반환
단, 2000년 이후 출생자는 3이 남자, 4가 여자임.
*/

-- 주민번호의 성별 부분이 정상적으로 잘라지는지 확인
select substr('999999-1000000', 8,1) from dual;
select substr('999999-2000000', 8,1) from dual;

-- 해당 함수는 주민번호를 문자형태로 전달받아 처리함(in생략가능)
create or replace function findGender (juminNum in varchar2)
return varchar2 -- 남자 or 여자를 반환하므로 반환타입은 문자로 설정
is
    genderTxt varchar2(1); -- 성별에 해당하는 문자 하나를 저장
    returnVal varchar2(10); -- 성별 확인 후 남자 or 여자를 저장
begin
    -- 주민번호 자르기
    genderTxt := substr(juminNum, 8, 1);
    if genderTxt = '1' then
        returnVal := '남자';
    elsif genderTxt = '2' then
        returnVal := '여자';
    elsif genderTxt = '3' then
        returnVal := '남자';
    elsif genderTxt = '4' then
        returnVal := '여자';
    end if;
    return returnVal;
end;
/

-- 8번째 문자를 얻어와서 해당 숫자를 통해 성별을 구한다.
select findGender('999999-1000000') from dual; -- -> 남자 반환됨
select findGender('999999-4000000') from dual; -- -> 여자 반환됨



/*
시나리오] 사원의 이름(first_name)을 매개변수로 전달받아서
부서명(department_name)을 반환하는 함수를 작성하시오.
    함수명 : func_deptName
*/
--1단계 : Alexander의 부서명을 출력하기 위한 join문

select first_name, last_name, department_id, department_name from employees
inner join departments using(department_id)
where first_name = 'Nancy';

--2단계 : 함수작성

create or replace function func_deptName(
    param_name varchar2 --in파라미터 설정
)
return varchar2 --부서명을 반환하므로 문자형으로 정의
is
    --부서테이블의 부서명을 참조하는 변수타입으로 정의
    return_deptName departments.department_name%type;
begin
    --쿼리문 실행 후 결과를 변수에 저장
    select department_name into return_deptName
    from employees
    inner join departments using(department_id)
    where first_name = param_name;
    --결과반환
    return return_deptName;
end;
/
select func_deptName('Nancy') from dual;
select func_deptName('&name') from dual;





/*
3] 트리거(Trigger)
    : 자동으로 실행되는 프로시저로 직접 실행은 불가능하다.
    주로 테이블에 입력된 레코드의 변화가 있을때 실행된다.
*/
-- 실습을 위해 HR계정에서 아래 테이블을 복사한다.
create table trigger_dept_original
as
select * from departments where 1=1; -- 부서테이블을 레코드까지 복사

create table trigger_dept_backup
as
select * from departments where 1=0; -- 부서테이블의 구조만 복사

/*
시나리오] 테이블에 새로운 데이터가 입력되면 해당 데이터를 백업테이블에 저장하는
트리거를 작성해보자.
*/
create trigger trigger_dept_backup
    after -- 타이밍 : after -> 이벤트 발생후, / before -> 이벤트 발생전
    INSERT -- 이벤트 : 입력/수정/삭제와 같은 쿼리 실행시 발생됨
    on trigger_dept_original -- 트리거를 적용할 테이블
    for each row /*
        행 단위 트리거로 정의함. 즉 하나의 행이 변화할때마다 트리거가
        수행된다. 만약 문장(테이블)단위 트리거로 정의하고 싶다면
        해당 문장을 제거하면 된다. 이때에는 쿼리를 한번 실행할때 
        트리거도 한번만 실행된다.
    */
begin
    -- insert 이벤트가 발생되면 true를 반환하여 if문이 실행된다.
    if Inserting then
        dbms_output.put_line('insert 트리거 발생됨');
        
        /*
        새로운 레코드가 입력되었으므로 임시테이블 :new에 저장되고,
        해당 레코드를 통해 backup테이블에 입력할 수 있다.
        이와 같은 임시테이블은 행단위 트리거에서만 사용할 수 있다.
        */
        insert into trigger_dept_backup
        values (
            :new.department_id,
            :new.department_name,
            :new.manager_id,
            :new.location_id
        );
    end if;
end;
/
insert into trigger_dept_original values (300, '열정의방', 10, 100);
select * from trigger_dept_original where department_id>=250;
select * from trigger_dept_backup;


/*
시나리오] 원본테이블에서 레코드가 삭제되면 백업테이블의 레코드도 같이
삭제되는 트리거를 작성해보자.
*/
create or replace trigger trig_dept_delete
    after
    delete
    on trigger_dept_original
    for each row /* original테이블에 레코드가 삭제된 후 행단위로
                    발생되는 트리거 정의*/
begin
    dbms_output.put_line('delete 트리거 발생됨');
    
    /*
    레코드가 삭제된 이후에 이벤트가 발생되어 트리거가 호출되므로
    : old 임시테이블을 사용해야 한다.
    */
    if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
    end if;
end;
/
delete from trigger_dept_original where department_id = 300;
-- 오리지날 테이블에서 레코드를 삭제하면 백업테이블에서도 삭제된다.
select * from trigger_dept_original where department_id>=250;
select * from trigger_dept_backup;



/*
For each row 옵션에 따른 트리거 실행횟수 테스트

생성1 : 오리지날 테이블에 업데이트 이후 행단위로 발생되는
    트리거 생성
*/
create or replace trigger trigger_update_test
    after update
    on trigger_dept_original
    for each row
begin
    if updating then
        insert into trigger_dept_backup
        values (
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id
        );
    end if;
end;
/
-- 기존 레코드 확인하기
select * from trigger_dept_original;

-- 오리지날 테이블의 레코드 1개 업데이트
update trigger_dept_original
    set department_name='열정의방', manager_id=77
    where department_id=20;

select * from trigger_dept_original;
-- 백업데이터 확인
select * from trigger_dept_backup; -- 1개의 추가된 레코드 확인

-- 6개의 레코드를 한꺼번에 업데이트
update trigger_dept_original
    set department_name='한꺼번에한방', manager_id=99
    where department_id between 50 and 100;
select * from trigger_dept_backup; -- 6개 레코드 추가 확인

-- 트리거 삭제하기
drop trigger trigger_update_test;

/*
생성2 : 오리지날 테이블에 업데이트 이후 테이블(문장) 단위로
    발생되는 트리거 생성
*/
create or replace trigger trigger_update_test2
    after update
    on trigger_dept_original
    /* for each row -- 문장단위 트리거 이므로 주석처리한다. */
begin
    if updating then
        insert into trigger_dept_backup
        values (
            999,
            to_char(sysdate, 'yy-mm-dd hh24:mi:ss')||'[update]',
            99,
            99
        );
    end if;
end;
/

-- 10개의 레코드를 한꺼번에 업데이트
update trigger_dept_original
    set department_name='한꺼번에10개', manager_id=99
    where department_id between 110 and 200;
select * from trigger_dept_backup; -- 문장단위 트리거이므로 1개 레코드 추가됨

-- 트리거 삭제하기
drop trigger trigger_update_test2;

-- 생성된 트리거 데이터사전에서 확인하기
select * from user_triggers
    where trigger_name like upper('%update_test2%');
    
/*
    트리거를 설정한 테이블을 삭제하면 트리거도 같이 삭제된다.
*/





-----------------------------------------------------------
--Java와 함수 및 프로시져 연동하기
--kosmo계정에서 실습합니다.

/*
시나리오] 매개변수로 회원아이디(문자열)를 받으면 첫문자를 제외한
    나머지부분을 *로 변환하여 반환하는 함수를 생성하시오.
    실행예) hongildong -> h*********
*/
--select를 통한 확인
select substr('hongildong',1,1) from dual; -- 결과 : h
select length('hongildong') from dual; -- 결과 : 10
select rpad(substr('hongildong',1,1), length('hongildong'), '*') from dual;


create or replace function fillAsterik (idStr varchar2)
return varchar2 -- 반환타입 명시
is retStr varchar2(50); -- 반환값을 저장할 문자형 변수
begin
    -- Or03에 사용예제 있음. 문자열의 오른쪽을 특수기호로 채워준다.
    retStr := rpad(substr(idStr,1,1), length(idStr), '*');
    return retStr;
end;
/

select fillAsterik('kosmo') from dual;
select fillAsterik('nakjasabal') from dual;



/*
시나리오] member 테이블에 새로운 회원정보를 입력하는 프로시져를
    생성하시오
    입력값 : 아이디, 패스워드, 이름
*/
create or replace procedure KosmoMemberInsert (
        p_id in varchar2,
        p_pass in varchar2,
        p_name in varchar2, /* Java에서 전달할 인자를 받을 in파라미터 */
        returnVal out number -- 입력 성공여부 확인
    )
is
begin
    -- 인파라미터를 통해 insert쿼리 작성
    insert into member (id, pass, name)
        values (p_id, p_pass, p_name);
    
    if sql%found then
        -- 입력이 정상처리 되었다면, 성공한 행의 갯수를 얻어와서
        -- out 파라미터에 저장한다. 
        returnVal := sql%rowcount;
        commit;
    else
        -- 입력에 실패한 경우
        returnVal := 0;
    end if;
end;
/

var i_result varchar2(10);
execute KosmoMemberInsert('pro01', '1234', '프로시저1', :i_result);
print i_result;
select * from member;

select * from user_source where name like upper('%kosmomem%');

var insert_count number;
execute KosmoMemberInsert('pro1', 'p1234', '프로시저1', :insert_count);
print insert_count;

select * from member;
