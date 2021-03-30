/******************
파일명 : Or02Number.sql
숫자(수학) 관련 함수
설명 : 숫자데이터를 처리하기 위한 숫자관련 함수를 알아보자
    테이블 생성시 number 타입으로 선언된 컬럼에 저장된 데이터를
    대상으로 한다.
******************/

/*
DUAL테이블
    : 한 행으로 결과를 출력하기 위해 제공되는 테이블로 오라클에서
    자동으로 생성되는 임시 테이블이다.
    varchar2(1)로 정의된 dummy라는 단 하나의 컬럼으로 구성되어있다.
*/
select * from dual;
desc dual;
select 1+2 from dual;

--abs() : 절대값 구하기
select abs(10000) from dual;
select abs(-9000) AS "9000의절대값" from dual;
--사원테이블의 급여 컬럼에 적용함.
select abs(salary) "급여의절대값" from employees;


/*
trunc() : 소수점을 특정자리수에서 잘라낼때 사용하는 함수
    형식 : trunc(컬럼명 혹은 값, 소수점이하 자리수)
        두번째 인자가
            양수일때 : 주어진 숫자만큼 소수점을 표현
            없을때 : 정수부만 표현. 즉 소수점 아래부분은 버림
            음수일때 : 정수부를 숫자만큼 잘라 나머지를 0으로 채움
*/
select trunc(1234.123456, 2) "Trunc양수인자" from dual; --1234,12
select trunc(1234.123456) "Trunc인자없음" from dual; --1234
select trunc(1234.123456, -2) "Trunc음수인자" from dual; --1200

/*
시나리오] 사원테이블에서 보너스율이 있는 사원만 인출한 후 보너스율을 
    소수점 1자리로 표현하시오.
*/
select * from employees where commission_pct is not null; --1.커미션을 받는 사원들

select first_name, commission_pct, trunc(commission_pct,1) from employees
where commission_pct is not null; --2.위 결과에서 소수점을 처리한 후 인출


/*
소수점 관련함수

ceil() : 소수점 이하를 무조건 올림처리
floor() : 소수점 이하를 무조건 버림처리

round(값, 자리수) : 반올림 처리
    두번째 인자가
        없는 경우 : 소수점 첫번째 자리가 5이상이면 올림, 미만이면 버림
        있는 경우 : 숫자만큼 소수점이 표현되므로 그 다음수가 5이상이면
            올림, 미만이면 버림
*/
select ceil(32.8) from dual; --33
select ceil(32.2) from dual; --33

select floor(32.8) from dual; --32
select floor(32.2) from dual; --32

select round(0.123), round(0.543) from dual; --0, 1
-- 첫번째항목 : 소수이하 6자리까지 표현하므로 7을 올림처리
-- 두번째항목 : 소수이하 4자리까지 표현하므로 1을 버림처리
select round(0.1234567, 6), round(2.345612, 4) from dual;


/*
mod() : 나머지를 구하는 함수
*/
select mod(99, 4) from dual; --3
select mod(salary, department_id) "급여를부서번호로나눔" from employees;


/*
power() : 거듭제곱을 계산할때 사용하는 함수
    사용법 : power(k, n) => k를 n번 곱한 결과를 반환한다.
*/
select power(4, 3) from dual;
select power(2, 10) "2의10승" from dual;


/*
sqrl() : 제곱근(루트)을 구하는 함수
    => 어떤수를 제곱하면 64가 되나요?? => 64의 제곱근
*/
select sqrt(64), sqrt(9) from dual;