/***************************
파일명 : Or15PLSQL.sql
PL/SQL
설명 : 오라클에서 제공하는 프로그래밍 언어
***************************/

/*
PL/SQL(Procedural Language)
    : 일반 프로그래밍 언어에서 가지고 있는 요소를 모두 가지고 있으며 
    DB업무를 처리하기 위해 최적화된 언어이다.
*/

-- HR계정에서 실습합니다.

--화면상에 내용을 출력하고 싶을때 on으로 설정한다. off일때는 출력되지 않는다.
set serveroutput on;
declare -- 선언부 : 변수를 주로 선언한다.
    cnt number; -- 숫자타입의 변수를 선언
begin -- 실행부 : begin ~ end 절 사이에 실행을 위한 로직을 기술한다.
    cnt := 10; -- 변수cnt에 10을 할당한다. 이때 대입연산자는 := 을 사용한다.
    cnt := cnt+1;
    dbms_output.put_line(cnt); -- java에서 println()과 동일하다.
end;
/
/*
    PL/SQL 문장의 끝에는 반드시 /를 붙여야 하는데, 만약
    없으면 호스트환경으로 빠져나오지 못한다. 즉 PL/SQL문장을 
    탈출하기위해 필요하다.
*/

/*
시나리오] 사원테이블에서 사원번호가 120인 사원의 이름과 연락처를 출력하는
    PL/SQL 문을 작성하시오.
*/
select concat(first_name||' ',last_name), phone_number
    from employees 
    where employee_id=120;

declare
    /*
    선언부에서 변수를 지정할때 테이블 생성시와 동일하게
    선언하면 된다. 단 first_name과 last_name이 합쳐진 형태이므로
    조금 더 넉넉한 크기로 설정하는것이 좋다.
    */
    empName varchar2(50);
    empPhone varchar2(30);
begin
    /*
    실행부 : select 절에서 가져온 결과를 선언부에서 선언한
        변수에 1:1로 대입하여 값을 저장한다. 이때 into를
        사용한다.
    */
    select concat(first_name||' ', last_name), phone_number
        into empName, empPhone
    from employees 
    where employee_id=120;
    
    dbms_output.put_line(empName||' '||empPhone);
end;
/

/*
시나리오] 부서번호 10인 사원의 사원번호, 급여, 부서번호를 가져와서
    아래 변수에 대입 후 화면상에 출력하는 PL/SQL문을 작성하시오.
    단, 변수는 기존테이블의 자료형을 참조하는 '참조변수'로 선언하시오.
    
    참조변수 : 특정 테이블의 특정 컬럼을 참조하는 변수로써
        동일한 자료형과 크기로 선언하고 싶을때 사용한다.
        형식] 테이블명.컬럼명%tpye
            => 테이블의 '하나'의 컬럼만을 참조한다.
*/
-- 시나리오의 조건에 맞는 select 문을 작성한다.
select employee_id, salary, department_id
    from employees where department_id=10;

declare
    -- 사원테이블의 특정 컬럼을 참조하는 참조변수로 선언한다.
    empNo employees.employee_id%type; --NUMBER(6,0)
    empSal employees.salary%type; --NUMBER(8,2)
    deptId employees.department_id%type; --NUMBER(4,0) 와 동일하다.
begin
    -- select의 결과를 into를 통해 선언한 변수에 할당한다.
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees where department_id=10;
    
    --결과출력
    dbms_output.put_line(empNo||' '||empSal||' '||deptId);
end;
/

/*
시나리오] 사원번호가 100인 사원의 레코드를 가져와서 emp_row변수에 전체컬럼을
저장한 후 화면에 다음 정보를 출력하시오.
단, emp_row는 사원테이블이 전체컬럼을 저장할 수 있는 참조변수로 선언해야 한다.
출력정보 : 사원번호, 이름, 이메일, 급여
*/
select * from employees where employee_id=100;

declare
    /*
    전체컬럼을 참조하는 참조변수 : 테이블명뒤에 %rowtype을 붙여서
        선언한다.
    */
    emp_row employees%rowtype;
begin
    /*
    와일드카드 *를 통해 얻어온 전체컬럼을 변수 emp_row에
    한꺼번에 저장한다.
    */
    select * into emp_row
    from employees where employee_id=100;
    
    /*
    emp_row에는 전체컬럼의 정보가 저장되므로 출력시에는
    변수명.컬럼명 형태로 기술해야 한다.
    */
    dbms_output.put_line(emp_row.employee_id||' '||
                        emp_row.first_name||' '||
                        emp_row.email||' '||
                        emp_row.salary);
end;
/



/*
복합변수
    : class를 정의하듯 필요한 자료형을 묶어서 생성하는 변수
    
    아래는 3개의 자료형을 가진 복합변수를 생성하고 있다.
    특정 컬럼을 그대로 사용할때는 참조변수 %type형태로 선언하고
    컬럼을 합치거나 변경해야 할 경우 임의생성도 가능하다.
    형식]
        type 복합변수자료형 is record(
            컬럼명1 자료형1,
            컬럼명2 참조변수%type ....
        );
*/

declare
--3개의 값을 저장할수 있는 복합자료형을 선언한다. 변수가아님 자료형을선언한것!!!!!!
    type emp_3type is record(
        emp_id employees.employee_id%type,--기존테이블의 컬럼을 참조하는 변수
        emp_name varchar2(50),--새롭게 생성한 변수
        emp_job employees.job_id%type 
        );
        --복합자료형을 통해 선언한 복합변수. 3개의 컬럼을 저장할수있따.
        record3 emp_3type;
begin
--select 절에서 가져온 3개의 컬럼을 하나의 복합변수에 저장한다. 
    select employee_id,first_name||''||last_name,job_id 
        into record3
        from employees
        where department_id=10;            
        --출력시에는 변수명.컬럼명 형태로 기술한다. 
          dbms_output.put_line(record3.emp_id||''|| 
                        record3.emp_name||''||record3.emp_job);
end;
/