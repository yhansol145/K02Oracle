/************************************
파일명 : Or01SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 혹은 Query문)
설명 : select, where 등 가장 기본적인 DQL문 사용해보기
************************************/

select * from employees;
select * from employees where employee_id=100;

/*
SQL Developer에서 주석 사용하기
    블럭단위 주석 : 자바와 동일
    라인단위 주석 : -- 실행문장. 하이픈 2개를 연속으로 사용
*/

--select문 : 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당한다.

/*
형식]
    select 컬럼1, 컬럼2 .....[또는 *]
    from 테이블명
    where 조건1 and 조건2 or 조건3......
    order by 정렬할 컬럼 asc(오름차순), desc(내림차순);
    ex(select * from employees where employee_id=100);
*/

--사원테이블에 저장된 모든 레코드 조회하기
select * from employees;

--컬럼명을 지정해서 개발자가 보고싶은 컬럼만 조회할 수 있다.
--사원번호, 이름, 이메일, 부서아이디만 조회하자...
select employee_id, first_name, last_name, email, department_id 
from employees;

--테이블의 속성과 자료형을 확인하는 명령
desc employees;

--해당 컬럼이 number(숫자) 타입이면 산술연산이 가능하다.
select employee_id, first_name, salary, salary+100 from employees;
--숫자 타입의 컬럼끼리의 연산도 가능하다.
select employee_id, first_name, salary, commission_pct, salary+commission_pct
from employees;

/*
AS(알리아스) : 테이블 혹은 컬럼에 별칭(별명)을 부여할 때 사용한다.
    내가 원하는 이름(영문, 한글 등) 으로 변경한 후에 출력할 수 있다.
    활용법] 차후 2개 이상의 테이블을 join해야 할 경우 컬럼명이
    중복될 때 구분하는 용도로 사용될 수 있다.
*/
select first_name, salary, salary+100 as "급여100증가" from employees;
select first_name, salary, salary+100 as salaryUp100 from employees;

--as는 생략할 수 있다.
select employee_id "사원아이디", first_name, last_name "성"
from employees where first_name='William';

--오라클은 기본적으로 대소문자를 구분하지 않는다. 예약어는 둘다 사용가능하다.
select employee_id "사원아이디", first_name, last_name "성"
from EMPLOYEES where first_name='William';

--단, 레코드인 경우 대소문자를 구분한다. 아래 SQL문을 실행하면 결과가 나오지 않는다.
select employee_id "사원아이디", first_name, last_name "성"
from EMPLOYEES where first_name='WILLIAM'; --이름전체가 대문자로 작성됨.


/*
where절을 이용해서 조건에 맞는 레코드 추출하기
    : last_name이 Smith인 레코드를 가져온다.
    주의] where절에 조건을 입력할때 컬럼이 문자형이면
    싱글쿼테이션을 사용해야 한다. 숫자형인 경우 생략가능하다.
*/

select * from employees where last_name='Smith'; --2개인출
select * from employees where last_name='Smith' and salary=8000; --1개인출
select * from employees where last_name='Smith' or salary=8000; --4개인출

--급여가 5000미만 혹인 5000이상인 사원의 정보를 가져오기
select * from employees where salary<5000; --49개인출
select * from employees where salary>=5000; --58개인출


/*
입사일이 04년01월01일 이후인 사원정보를 인출하시오
    : 날짜도 숫자처럼 <,>= 등과 같은 비교연산자를 통해 조건을 지정할 수 있다.
*/
select * from employees where hire_date>='04/01/01';


/*
and연산자 : 둘 이상의 조건이 동시에 만족할대는 레크드를 가져온다.
    부서아이디가 50이면서 메니져아이디가 100인 사원정보를 인출하시오.
*/

select * from employees where department_id = 50 and manager_id=100;


/*
in연산자 : or 연산자와 비슷한 기능으로 하나의 컬럼에 여러값으로 
    조건을 걸고 싶을때 사용하는 연산자
    급여가 4200, 6400, 8000인 직원의 정보를 조회하시오.
*/

--방법1 : or를 사용한다. 컬럼명을 반복적으로 기술해야 한다.
select * from employees where salary=4200 or salary=6400 or salary=8000;
--방법2 : in을 사용하면 컬럼을 한번만 기술하면 되므로 편리하다.
select * from employees where salary in(4200, 6400, 8000);


/*
not연산자 : 해당 조건이 아닌 레코드를 가져온다.
    부서번호가 50이 아닌 사원정보를 조회하시오.
    => <> 혹은 not으로 표현한다.
*/
select * from employees where department_id<>50;
select * from employees where not (department_id=50);


/*
between and 연산자 : 컬럼의 구간을 정해 검색할때 사용한다.
    급여가 4000~8000 사이의 사원정보를 조회하시오.
*/
select * from employees where salary>=4000 and salary<=8000;
select * from employees where salary between 4000 and 8000;


/*
distinct : 컬럼에서 중복되는 레코드를 제거할때 사용한다.
    특정 조건으로 select했을때 하나의 컬럼에서 중복되는 값이
    있는 경우 중복값을 제거한 후 결과를 출력할 수 있다.
*/
select job_id from employees;
select distinct job_id from employees;


/*
like 연산자 : 특정 키워드를 통한 문자열 검색하기
    형식) 컬럼명 like '%키워드%'
    와일드카드 사용법
        % : 모든 문자 혹은 문자열을 대체한다.
        Ex) D로 시작하는 단어 : D% -> Da, Dae, Daewoo
            Z로 끝나는 단어 : %Z -> aZ, abcZ
            C가 포함되는 단어 : %C% -> aCb, abCde, Vitamin-C
        
        _ : 언더바는 하나의 문자를 대체한다.
        Ex) D로 시작하는 3글자의 단어 : D__ -> Dab, Ddd, Dxy
            A가 중간에 들어가는 3글자의 단어 : _A_ -> aAa, xAy
*/
--first_name이 'D'로 시작하는 직원을 검색하시오
select * from employees where first_name like 'D%';
--first_name의 세번째 문자가 'a'인 모든 직원을 추출하시오.
select * from employees where first_name like '__a%';
--first_name이 'd'로 끝나는 모든 직원을 검색하시오.
select * from employees where first_name like '%d';
--전화번호가 1344가 포함되는 모든 직원을 검색하시오.
select * from employees where phone_number like '%1344%';


/*
레코드 정렬하기(Sorting)
    오름차순정렬 : order by 컬럼명 asc (혹은 생략가능[디폴트])
    내림차순정렬 : order by 컬럼명 desc
    
    2개 이상의 컬럼으로 정렬해야 할때는 ,(콤마)로 구분해서 정렬한다.
    단, 이때 먼저 입력한 컬럼으로 정렬된 상태에서 두번째 컬럼이 정렬된다.
*/
/*
사원정보 테이블에서 급여가 낮은순서에서 높은순서로 나오도록 정렬하여 조회하시오.
출력할컬럼 : first_name, salary, email, phone_number
*/
select first_name, salary, email, phone_number
from employees
order by salary asc;


/*
부서번호를 내림차순으로 정렬한 후 해당 부서에서 낮은 급여를 받는 직원이
먼저 출력되도록 하는 SQL문을 작성하시오.
출력항목 : 사원번호, 이름, 성, 급여, 부서번호
*/
select employee_id, first_name, last_name, salary, department_id
from employees
order by department_id desc, salary asc;


/*
is null 혹은 is not null
    : 값이 null이거나 null이 아닌 레코드 가져오기
    컬럼중 null값을 허용하는 경우 값을 입력하지 않으면 null값이
    되는데 이를 대상으로 select할때 사용한다.
*/
--보너스율이 없는 사원을 조회하시오.
select * from employees where commission_pct is null;
--보너스율이 있는 사원을 조회하시오
select * from employees where commission_pct is not null;
--보너스율이 없는 사원중 급여가 5000이상인 사원을 조회하는 쿼리문을 작성하시오
select * from employees where commission_pct is null and salary>=5000;
