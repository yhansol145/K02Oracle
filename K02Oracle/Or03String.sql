/*************************
파일명 : Or03String.sql
문자열 처리함수
설명 : 문자열에 대해 대소문자를 변환하거나 문자열의 길이를 반환하는 등 문자열을
조작하는 함수
*************************/

/*
concat(문자열1, 문자열2)
    : 문자열 1과 2를 서로 연결해서 출력하는 함수
    사용법1 - concat('문자열1', '문자열2')
    사용법2 - '문자열1' || '문자열2'
*/
select concat('Good ', 'morning') AS "아침인사" from dual;
select 'Oracle'||' 11kg'||' Good' from dual;
-- => 위의 SQL 문을 concat()으로 변경하면...
    select concat(concat('Oracle', ' 11g'), ' Good') from dual;


/*
initcap(문자열)
    : 문자열의 첫문자만 대문자로 변환하는 함수.
    단, 첫문자를 인식하는 기준은 다음과 같다.
    - 공백문자 다음에 오는 첫문자를 대문자로 변환한다.
    - 알파벳과 숫자를 제외한 나머지 문자 다음에 나오는 첫번째 문자를 대문자로 변환한다.
*/
select initcap('hi hello 안녕') from dual;
select initcap('good/bad morning') from dual;
select initcap('never6say*good가bye') from dual;

--사원테이블에서 john 을 찾아서 인출하시오
select first_name, last_name from employees
    where first_name='john'; --결과없음
select first_name, last_name from employees
    where first_name='John'; --3개인출
select first_name, last_name from employees
    where first_name=initcap('john'); --3개인출


/*
대소문자변경
lower() : 소문자로 변경함
upper() : 대문자로 변경함
*/
select lower('GOOD'), upper('bad') from dual;
--위에서와 같이 john을 검색하려면...
select * from employees where lower(first_name)='john';
select * from employees where upper(first_name)='JOHN';
--컬럼에 저장된 값을 대문자 혹은 소문자로 변경한 후 조건으로 검색한다.


/*
lpad(), rpad()
    : 문자열의 왼쪽, 오른쪽에 특정한 기호로 채울때 사용하는 함수
    형식] lpad('문자열', '전체자리수', '채울문자열')
        -> 전체자리수에서 문자열의 길이만큼을 제외한 나머지
        좌측부분을 주어진 문자열로 채워주는 함수
        rpad()는 오른쪽을 채워줌.
*/
select
    'good',
    lpad('good', 7, '#'),
    rpad('good', 7, '#'),
    lpad('good', 7),
    rpad('good', 7)
from dual;


/*
trim() : 공백을 제거할때 사용하는 함수
    형식] trim([leading | trailing | both] 제거할문자 from 컬럼)
        - leading : 왼쪽에서 제거함
        - trailing : 오른쪽에서 제거함
        - both : 양쪽에서 제거함. 설정값이 없으면 both가 디폴트임.
        [주의1] 양쪽 끝의 문자만 제거되고, 중간에 있는 문자는 제거되지 않음.
        [주의2] '문자' 만 제거할 수 있고, '문자열' 은 제거할 수 없다. 에러발생됨
*/
select 
    ' 공백제거테스트 ' as trim1,
    trim(' 공백제거테스트 ') as trim2,
    trim('다' from '다람쥐가 나무를 탑니다') as trim3,
    trim(both '다' from '다람쥐가 나무를 탑니다') as trim4,
    trim(leading '다' from '다람쥐가 나무를 탑니다') as trim5,
    trim(trailing '다' from '다람쥐가 나무를 탑니다') as trim6,
    trim(both '다' from '다람쥐가 다리위의 나무를 탑니다') as trim7
from dual;
--trim7 : 중간의 '다'는 제거되지 않는다.
--옵션이 없는경우 both가 디폴트이므로 trim3, trim4는 동일한 결과가 나온다.

/*
아래 문장은 쿼리에러 발생됨. trim()은 문자만 제거할 수 있다. 만약
문자열을 제거하고 싶다면 replace() 함수를 사용해햐 한다.
*/
select
    trim(both '다람쥐' from '다람쥐가 다리위의 나무를 탑니다') as trimError
from dual;