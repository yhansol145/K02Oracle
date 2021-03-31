/**************
파일명 : Or05Date.sql
날짜함수
설명 : 년, 월, 일, 시, 분, 초 의 포맷으로 날짜형식을 지정하거나
    날짜를 계산할때 활용하는 함수들
**************/

/*
months_between()
    : 현재날짜와 기준날짜 사이의 개월수를 반환한다.
    형식] months_between(현재날짜, 기준날짜[과거날짜])
*/
--2017년 1월1일부터 지금까지 지난 개월수는 얼마인가요?
select
    months_between(sysdate, '2017-01-01') "결과1",
    months_between(sysdate, to_date('2017년 1월1일', 'yyyy"년"mm"월"dd"일"')) "결과2",
    round(months_between(sysdate, '2017-01-01')) "결과3"
from dual;
--만약 날짜 서식이 아니라면 to_date()로 날짜형식으로 변경해준다.


/*
시나리오1] employees 테이블에 입력된 직원들의 근속개월수를 계산하여
    출력하시오. 근속개월수를 기준으로오름차순 정렬하시오.
*/
select
    first_name, last_name, hire_date,
    months_between(sysdate, hire_date) "근속개월수1",
    trunc(months_between(sysdate, hire_date), 2) "근속개월수2"
from employees
order by 근속개월수1 asc;


/*
활용시나리오2] [퀴즈] 위 문제를 현재날짜 기준이 아닌 '2017년12월31일'을
기준으로 변경하시오.
*/

select
first_name, last_name, hire_date,
trunc(months_between(to_date('2017년12월31일','yyyy"년"mm"월"dd"일"'), hire_date), 2) AS "근속개월수1"
from employees
order by "근속개월수1" asc;
/*
    months_between() 함수의 인자로 날짜로 주어질때 오라클 기본서식인
    년-월-일 인 경우에는 to_date()로 변환없이 그대로 사용할 수 있다.
    단, 기본서식이 아닌 경우에만 날짜형식으로 변환후 사용하면 된다.
*/


/*
add_months() : 날짜에 개월수를 더한 결과를 반환한다.
    형식] add_months(현재날짜, 더할 개월수)
*/
--현재를 기준으로 7개월 이후의 날짜를 구하시오

select
    to_char(sysdate, 'yyyy-mm-dd') "현재날짜",
    to_char(add_months(sysdate, 7), 'yyyy-mm-dd') "7개월이후날짜"
from dual;


/*
next_day() : 현재날짜를 기준으로 인자로 주어진 요일에 해당하는
    미래의 날짜를 반환하는 함수
    형식] next_daay(현재날짜, '월요일')
            => 다음주 월요일은 몇일인가요??
*/

select
    sysdate "오늘날짜",
    next_day(sysdate, '금요일') "다음금요일은?",
    next_day(sysdate, '월요일') "다음월요일은?",
    next_day(sysdate, '수요일') "다음수요일은?"
from dual; --일주일 이후의 날짜는 조회할 수 없다.


/*
last_day() : 해당월의 마지막 날짜를 반환한다.
    형식] last_day(날짜)
*/
select last_day('20/02/01') from dual;
select last_day('21/02/01') from dual;
select last_day(sysdate) from dual;
select last_day(hire_date), hire_date from employees where employee_id=106;
--2020년은 윤년이므로 2월이 29일까지 있다.

select
    sysdate "현재날짜",
    sysdate -1 "어제",
    sysdate +1 "내일",
    sysdate +30 "한달 후"
from dual;