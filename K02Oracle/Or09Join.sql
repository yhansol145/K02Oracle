/********************
파일명 : Or09Join.sql
테이블조인
설명 : 두개 이상의 테이블을 동시에 참조하여 데에터를 
가져와야 할때 사용하는 SQL문
********************/

/*
1] inner join(내부조인)
- 가장 많이 사용되는 조인문으로 테이블간에 연결조건을 모두 만족하는
행을 검색할때 사용된다.
- 일반적으로 기본키(primary key)와 외래키(foreign key)를 사용하여
join하는 경우가 대부분이다.
- 두개의 테이블에 동일한 이름의 컬럼이 존재하면 "테이블명,컬럼명"
형태로 기술해야 한다.
- 테이블의 별칭을 사용한다면 "별칭명.컬럼명" 형태로 쓸수도 있다.

형식1] (ANSI 표준방식)
    select
        컬럼1, 컬럼2,...
    from 테이블1 inner join 테이블2
        on 테이블1.기본키컬럼=테이블2.외래키컬럼
    where
        조건1 and 조건2 ...;
*/

/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단 표준방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/
select
    employee_id, first_name, last_name, email, 
    department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id;/*
        에러발생됨. 양쪽테이블 모두에 존재하는 department_id 컬럼이 
        있으므로 "column ambiguously defined" 에러가 발생한다.
        이때는 어떤 테이블에서 가져올지 명시해야 한다.
    */
    
-- as(별칭) 없이 작성하여 쿼리문이 길어짐 
select
    employee_id, first_name, last_name, email, 
    employees.department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id;
    
-- as(별칭)을 추가하여 작성함. 쿼리문이 간결해짐
select
    employee_id, first_name, last_name, email, 
    emp.department_id, department_name
from employees emp inner join departments dep
    on emp.department_id=dep.department_id;
    
    
/*
3개 이상의 테이블 조인

시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단 표준방식으로 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 
        담당업무아이디, 담당업무명, 근무지역
*/
select
    first_name, last_name, email, E.department_id, department_name, 
    E.job_id, job_title, city, state_province
from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on E.department_id=D.department_id
    inner join jobs J on E.job_id=J.job_id
where lower(city)='seattle';

/*
형식2] 오라클방식
    select
        컬럼1, 컬럼2......컬럼n
    from
        테이블명1, 테이블명2
    where
        테이블명1.기본키컬럼=테이블명2.참조키컬럼
        and 조건1 and 조건2;
*/

/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단 오라클방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/

select
    employee_id, first_name, last_name, email, 
    dep.department_id, department_name
from employees emp, departments dep
where emp.department_id=dep.department_id;


/*
시나리오] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단 오라클방식으로 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역
*/
select
    first_name, last_name, email, D.department_id, department_name, 
    J.job_id, job_title
from locations L, departments D, employees E, jobs J
where
    L.location_id=D.location_id
    and D.department_id=E.department_id
    and E.job_id=J.job_id
    and city='Seattle';
    
    
-------------------------------------------------------


/*
2] 외부조인(outer join)

outer join은 inner join과 달리 두 테이블에 조인조건이 정확히 일치하지
않아도 기준이 되는 테이블에서 결과값을 가져오는 join문이다.
outer join을 사용할때는 반드시 outer 전에 데이터를 어떤 테이블을 기준으로
가져올지를 기술해야 한다.
    -> left(왼쪽테이블), right(오른쪽테이블), full(양쪽테이블)
    
형식1(표준방식)
    select 컬럼1, 컬럼2 ....
    from 테이블1
        left[right, full] outer join 테이블2
            on 테이블1.기본키=테이블2.참조키
    where 조건1 and 조건2 or 조건3;
*/
/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오.
*/
select 
    employee_id, first_name, last_name, e.department_id,
    department_name, D.location_id, city, state_province
from employees E 
    left outer join departments D
        on E.department_id=D.department_id
    left outer join locations L
        on D.location_id=L.location_id;


/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오.
*/
select
    employee_id, first_name, last_name, e.department_id,
    department_name, D.location_id, city, state_province
from employees E
    right outer join departments D
        on E.department_id=D.department_id
    right outer join locations L
        on D.location_id=L.location_id;

-- left 혹은 right와 같이 기준이 되는 테이블이 달라지면 인출되는 결과도 달라진다.

/*
형식2(오라클방식)
    select
        컬럼1, 컬럼2........컬럼N
    from
        테이블1, 테이블2
    where
        테이블1.기본키=테이블2.외래키(+)
        and 조건1 or 조건2 ... 조건n;
    => 오라클방식으로 변경시에는 outer join연산자인 (+)를 where에 붙여준다.
    => 위의 경우 왼쪽 테이블이 기준이 된다.
*/

/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오. 단 오라클방식으로 작성하시오.
*/
select
    employee_id, first_name, last_name, Emp.department_id, department_name,
    Loc.location_id, city, state_province
from employees Emp, departments Dep, locations Loc
where
    Emp.department_id=Dep.department_id(+)
    and Dep.location_id=Loc.location_id(+);
    
    
/*
3] self join(셀프조인)
    셀프조인은 하나의 테이블에 있는 컬럼끼리 연결해야 하는 경우에 사용한다.
    즉 자기자신의 테이블과 조인을 맺는것이다.
    셀프조인에서는 별칭이 테이블을 구분하는 구분자의 역할을 하므로 굉장히 중요하다.
    
    형식]
    select
        별칭1.컬럼, 별칭2.컬럼 ....
    from
        테이블 별칭1, 테이블 별칭2
    where
        별칭1.컬럼=별칭2.컬럼 ;
*/

/*
시나리오] 사원테이블에서 각 사원의 매니저아이디와 매니저이름을 출력하시오.
    단, 이름은 frist_name과 last_name을 하나로 연결해서 출력하시오.
    
    1. 하나의 테이블을 각각 사원정보테이블, 매니저정보테이블로 나눈다.
    2. 사원의 매니저아이디와 매니저의 사원이이디를 join한다.
    3. 각각의 테이블 별칭을 이용해서 필요한 정보를 select한다.
*/
select
    empClerk.employee_id "사원번호", 
    (empClerk.first_name||' '||empClerk.last_name) "사원이름",
    empManager.employee_id "매니저아이디",
    concat(empManager.first_name||' ', empManager.last_name) "매니저이름"
from
    employees empClerk, employees empManager
where
    empClerk.manager_id=empManager.employee_id;