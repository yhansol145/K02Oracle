/***************************
파일명 : Or04TypeConvert.sql
형변환함수 / 기타함수
설명 : 데이터타입을 다른 타입으로 변환해야 할때 사용하는 함수와 기타함수
***************************/

/*
sysdate : 현재날짜와 시간을 초단위로 반환해준다. 주로 게시판에서
    새로운 포스팅이 있있을 때 자주 사용된다. 년도부터 초단위까지의 정보를 가지고 있다.
*/
select sysdate from dual;

/* 날짜 포맷 (대소문자를 구분하지 않는다.)*/
--현재날짜를 0000/00/00 형태로 출력하시오
select to_char(sysdate, 'yyyy/mm/dd') "오늘날짜" from dual;
--현재날짜를 00-00-00 형태로 출력하시오
select to_char(sysdate, 'yy-mm-dd') "오늘날짜" from dual;
--현재날짜를 "오늘은 0000년 00월 00일 00요일입니다" 형태로 출력하시오

/*
select 
    to_char(sysdate, '오늘은 yyyy년 mm월 dd일 dy요일입니다') "과연될까?" 
from dual; --에러발생 : 날짜형식이 부적합
*/

select 
    to_char(sysdate, '"오늘은 "yyyy"년 "mm"월 "dd"일 "dy"요일입니다"') "한글을 서식에 적용" 
from dual; --서식문자를 제외한 나머지 문자열을 "(더블쿼테이션)으로 감싸준다.

select
    to_char(sysdate, 'day') "요일(수요일)",
    to_char(sysdate, 'dy') "요일(수)",
    to_char(sysdate, 'mon') "월(3월)",
    to_char(sysdate, 'mm') "월(03)",
    to_char(sysdate, 'month') "월(3월)",
    to_char(sysdate, 'yy') "2자리년도",
    to_char(sysdate, 'dd') "일을 숫자로 표현",
    to_char(sysdate, 'ddd') "1년중 몇번째 일"
from dual;


/* 시간 포맷 */
--현재시간을 00:00:00 형태로 표시하기
select
    to_char(sysdate, 'HH:MI:SS') "대문자서식",
    to_char(sysdate, 'hh:mi:ss') "소문자서식"
from dual;

--현재날짜와 시간을 한꺼번에 표시하기
select
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') "현재시각"
from dual;

--현재시간을 오전/오후 혹은 24시간제로 표시하기
select
    to_char(sysdate, 'hh am') AS "AM사용",
    to_char(sysdate, 'hh pm') "PM사용",
    to_char(sysdate, 'hh24') "24시간제"
from dual;

/* 숫자 포맷 */

/*
    0 : 숫자의 자리수를 나타내며 자리수가 맞지 않는경우 0으로 자리를 채운다.
    9 : 0과 동일하지만, 자리수가 맞지않는경우 공백으로 채운다.
*/

select
    to_char(123, '0000') "서식문자0사용",
    to_char(123, '9999') "서식문자9사용",
    trim(to_char(123,'9999')) "trim()사용"
from dual;

select
    to_char(12345, '000,000'),
    to_char(12345, '999,999'),
    to_char(12345, '999,000'),
    ltrim(to_char(12345, '999,000')) "좌측공백제거",
    ltrim(to_char(1234567, '999,999,000')) "좌측공백제거2"

from dual;

--통화표시 : L -> 각 나라에 맞는 통화표시가 된다. 한국의 경우 \(원)
select to_char(12345, 'L999,999') from dual;

/*
to_number() : 문자형 데이터를 숫자형으로 변환한다.
*/
select to_number('123') + to_number('456') from dual;
-- 두 문자가 숫자로 변환되어 덧셈의 결과 인출됨.

/*
to_date()
    : 문자열 데이터를 날짜형식으로 변환해서 출력해준다. 기본서식은
    년/월/일 순으로 지정된다.
*/
select
    to_date('2021-03-31') "날짜기본서식1",
    to_date('20210331') "날짜기본서식2",
    to_date('2021/03/31') "날짜기본서식3"
from dual;


/*
날짜포맷이 년-월-일 순이 아닌경우는 오라클이 인식하지 못하여 에러발생됨.
이런경우 날짜서식을 이용해서 오라클이 인식할 수 있도록 처리해야 함.
*/
select to_date('31-03-2021') from dual;

select
    to_date('31-03-2021', 'dd-mm-yyyy') "날짜서식알려주기1",
    to_date('03-31-2021', 'mm-dd-yyyy') "날짜서식알려주기2"
from dual;

--시간서식이 포함되므로 오류발생됨
select to_date('2020-03-31 12:48:33') from dual;
--방법1
select to_date(substr('2020-03-31 12:48:33', 1, 10)) "날짜만잘라옴" from dual;
--방법2
select to_date('2020-03-31 12:48:33', 'yyyy-mm-dd hh-mi-ss') "시간서식포함" from dual;
--만약 차후 시간을 사용해야 한다면 방법2를 이용해야한다.

/*
시나리오1] 문자열 '2012/04/03'는 어떤 요일인지 변환함수를 통해 출력하시오
*/
select
    to_date('2012/04/03') "1단계",
    to_char(to_date('2012/04/03'), 'day') "요일서식1",
    to_char(to_date('2012/04/03'), 'dy') "요일서식2"
from dual;


/*
[퀴즈] 문자열 '2013년10월24일'은 어떤 요일인지 변환함수를 통해
    출력할 수 있는 쿼리문을 작성하시오. 단 문자열은 임의로 변경할 수 없습니다.
*/

select
    to_date('2013년 10월 24일', 'yyyy"년"mm"월"dd"일"') "1단계:날짜로변경",
    to_char(to_date('2013년10월24일','yyyy"년"mm"월"dd"일"'), 'day') "2단계:요일로변경"
from dual;


/*
[퀴즈] : hr계정의 employees 테이블에서 사원번호 206인 사원이 어떤 요일에
    입사했는지 출력하는 쿼리문을 작성하시오.
*/

select hire_date, first_name from employees where employee_id like 206;

select 
    to_date('2002/06/07'),
    to_char(to_date('2002/06/07'), 'day')
from dual;


/*
시나리오2 : '2015-10-24 12:34:56' 형태로 주어진 데이터를 인자로 하여
    '0000년00월00일 0요일' 형식으로 변환함수를 이용하여 출력하시오.
*/
select
    to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss') "1단계 : 날짜로변환",
    to_char(to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss'),
            'yyyy"년 "mm"월 "dd"일 "dy"요일 "') "2단계 : 결과출력"
from dual;


/*
nvl() : null값을 다른 데이터로 변경하는 함수
    형식] nvl(컬럼명, 대체할값)
    
    ※ 레코드를 select해서 웹브라우저에 출력을 하는 경우 해당 컬럼이 null이면
    NullPointerException이 발생하게 된다. 그러므로 아예 데이터를 가져올때 null값이
    나올 수 있는 컬럼에 대해 미리 처리하면 예외발생을 미리 차단할 수 있으므로 편리하다.
*/
--사원테이블에서 보너스율이 null인 레코드를 0으로 대체해서 출력하는 쿼리를 작성하시오.
select
    first_name, commission_pct, nvl(commission_pct, 0) AS "보너스율"
from employees;


/*
decode() : java의 switch문과 비슷하게 특정값에 해당하는 출력문이 있는 경우 사용한다.
    형식] decode(컬럼명,
                값1, 결과1,
                값2, 결과2,
                ..........
                기본값)
    ※내부적인 코드값을 문자열로 변환하여 출력할때 많이 사용된다.
*/


/*
시나리오] 사원테이블에서 각 부서에 해당하는 부서명을 출력하는 쿼리문을
    decode를 이용해서 작성하시오.
*/
select
    first_name, last_name, department_id,
    decode(department_id,
        10,	'Administration',
        20,	'Marketing',
        30,	'Purchasing',
        40,	'Human Resources',
        50,	'Shipping',
        60,	'IT',
         '그외부서') AS TeamName
from employees;


/*
case() : java의 if~else문과 비슷한 역할을 하는 함수
    형식] case
            when 조건1 then 값1
            when 조건2 then 값2
            .......
            else 기본값
        end
*/
select
    case
        when department_id=10 then 'Administration'
        when department_id=20 then	'Marketing'
        when department_id=30 then	'Purchasing'
        when department_id=40 then	'Human Resources'
        when department_id=50 then	'Shipping'
        when department_id=60 then	'IT'
        else '그외부서'
    end as TeamName
from employees;


