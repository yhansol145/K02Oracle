--DDL
--scott 계정에서 진행합니다.

--문제1
create table pr_dept(
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

--문제2
create table pr_emp(
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
);

--문제3
alter table pr_emp modify ename varchar2(50);

--문제4
--1.
create table pr_emp_clone
as
select eno"e_no", ename"e_name", job"job_id"
from pr_emp where 1=0;

--2. 
create table pr_emp_clone(
    e_no, e_name, job_id
)
as
select eno, ename, job from pr_emp where 1=1;


--문제5
alter table pr_emp_clone rename to pr_emp_clone_rename; -- 방법1
rename pr_emp_clone to pr_emp_clone_rename; -- 방법2
desc pr_emp_clone; --기존의 테이블은 없어짐
desc pr_emp_clone_rename; --새로운 테이블 생성됨

--문제6
alter table pr_dept drop column dname;

--문제7
alter table pr_emp modify job varchar(50);

--문제8
drop table pr_emp_clone_rename;


/*
DDL문 -> 테이블을 생성 및 조작하는 쿼리문
테이블생성 : create table 테이블명
컬럼추가 : alter table 테이블명 add
컬럼수정 : alter table 테이블명 modify 
컬럼삭제 : alter table 테이블명 drop column 컬럼명
테이블삭제 : drop table 테이블명
*/



/*
-------------------------------------------------------------------
*/



--DML
--scott계정에서 진행합니다.

--문제1
insert into pr_emp values (1, '엄태웅', '어른 승민', sysdate);
insert into pr_emp values (2, '이제훈', '대학생 승민', sysdate);
insert into pr_emp values (3, '한가인', '어른 서연', sysdate);
insert into pr_emp values (4, '수지', '대학생 서연', sysdate);

--문제2
insert into pr_emp (ename, job, regist_date)
    values ('조정석', '납뜩이', to_date(sysdate-7, 'yy/mm/dd'));
        -- to_date 를 꼭 사용할 필요는 없다. 'sysdate-7' 해도 됨

--문제3
update pr_emp set job = concat(job, '난짝수레코드')
    where mod(eno, 2) = 0;

-- pr_employees 테이블 복사(데이터까지)
create table pr_employees
as
select * from emp where 1=1; -- where 절에 참의 조건을 주면 모든 레코드를 복사한다.


--문제4

-- 사원번호 7900번 확인
select * from pr_employees where empno=7900; --결과 : 매니저 사번 7698
-- 매니저가 7698인 사원을 확인
select * from pr_employees where mgt=7698; --결과 : 부서번호 30
-- FORD의 부서번호 확인
select * from pr_employees where ename='FORD'; --결과 : 부서번호 20
-- 최종 업데이트
update pr_employees set deptno=20 where mgr=7698;

select mgr
from pr_employees
where empno=7900;

select deptno
from pr_employees
where lower(ename)='ford';

update pr_employees 
set deptno =(select deptno from pr_employees where lower(ename)='ford')
where mgr = (select mgr from pr_employees where empno=7900);

--문제5
delete from pr_employees where to_char(hiredate, 'mm')=12; --날짜포맷 사용
delete from pr_employees where substr(hiredate,4,2)=12; --문자열 자르기 사용
delete from pr_employees where hiredate like '___12%'; --like절 사용, 와일드카드 (_) 언더바 사용

--문제6
select max(hiredate)
from pr_employees; --결과 : 82/01/23

select * from pr_employees
where to_char(hiredate,'yy')=82; --결과 : MILLER

alter table pr_employees modify ename varchar2(20);

update pr_employees set ename=concat(ename, '(신입사원)')
where hiredate='82/01/23';

/*
update pr_employees
set ename = concat((select ename from pr_employees where hiredate 
          = (select max(hiredate) from pr_employees)),'(신입사원)')
where hiredate = (select max(hiredate) from pr_employees);
*/ -- 너무 긴 코드.. 내가 작성한 코드


/*
DML문 -> 레코드를 입력 및 조작하는 쿼리문
레코드입력 : insert into 테이블명 (컬럼) values (값)
레코드수정 : update 테이블명 set 컬럼=값 where 조건
레코드삭제 : delete from 테이블명 where 조건
레코드조회 : select 컬럼 from 테이블명 where 조건
*/









--제약조건
--scott계정에서 진행합니다.


--문제1
create table pr_emp_const
as
select * from emp where 1=0; --거짓의 조건으로 테이블의 구조만 복사한다.

alter table pr_emp_const add
    constraint pr_emp_pk
        primary key(empno); --기본키 제약조건 추가
        
/*
데이터사전에서 제약조건 확인하기
select * from user_cons_columns where constraint_name=upper('pr_emp_pk');
select * from user_constraint where lower(constraint_name)=('pr_emp_pk');
*/

--문제2
create table pr_dept_const
as
select * from dept where 1=0; --거짓의 조건으로 테이블의 구조만 복사

alter table pr_dept_const add
    constraint pr_dept_pk
        primary key(deptno); --기본키 제약조건 추가
        
--데이터사전에서 제약조건 확인하기
select * from user_cons_columns where constraint_name=upper('pr_dept_pk');
    
/* 문제3
3. pr_dept_const 테이블에 존재하지 않는 부서의 사원이 배정되지 않도록
외래키 제약조건을 지정하되 제약조건 이름은 pr_emp_dept_fk로 지정하시오.
*/

alter table pr_emp_const
    add constraint pr_emp_dept_fk           -- 제약조건명 추가
        foreign key (deptno)                -- 자식테이블의 외래키(참조키) 컬럼
        references pr_dept_const (deptno);  -- 부모테이블의 기본키(PK) 컬럼

--데이터사전에서 제약조건 확인하기
select * from user_cons_columns where constraint_name=upper('pr_emp_dept_fk');

/*
4. pr_emp_const 테이블의 comm 컬럼에 0보다 큰 값만을 입력할 수 있도록
제약조건을 지정하시오. 제약조건명은 지정하지 않아도 된다.
*/
alter table pr_emp_const add --[constraint 제약조건명] 생략
    check (comm > 0);

-- 제약조건 확인을 위한 레코드 삽입
insert into pr_emp_const values 
    (100, '아무개', '열정', null, sysdate, 1000, 0, 10); 
        --입력실패 : check 제약조건 위배.
insert into pr_emp_const values 
    (100, '아무개', '열정', null, sysdate, 1000, 0.3, 10);
        --입력실패 : 외래키 제약조건 위배. 부모키 없음.

-- 부모테이블에 레코드 입력
insert into pr_dept_const values (10, '꿈의방', '가산');
insert into pr_dept_const values (20, '열정의방', '디지털');

-- 앞에서 입력실패한 레코드 입력
insert into pr_emp_const values 
    (100, '아무개', '열정', null, sysdate, 1000, 0.3, 10);
insert into pr_emp_const values 
    (101, '고무개', '꿈', null, sysdate, 800, 0.45, 20);
select * from pr_emp_const;

/*
5. 위 3번에서는 두 테이블간에 외래키가 설정되어서
pr_dept_const 테이블에서 레코드를 삭제할 수 없었다.
이 경우 부모레코드를 삭제할 경우 자식까지 같이 삭제될 수 있도록
외래키를 지정하시오.
*/
--부모테이블
select * from pr_dept_const;
--자식테이블
select * from pr_emp_const;
--부모테이블에서 레코드 삭제하기
delete from pr_dept_const where deptno=10; /*
                자식레코드가 있으므로 삭제불가함.
                외래키 제약조건 위배.
        */

--외래키 재설정을 위해 기존의 외래키를 삭제한다.
alter table pr_emp_const drop constraint pr_emp_dept_fk;

--외래키 재설정 : 부모레코드 삭제시 자식레코드까지 동시에 삭제되도록 설정
alter table pr_emp_const
    add constraint pr_emp_dept_fk         
        foreign key (deptno)               
        references pr_dept_const (deptno)
        on delete cascade;

--자식레코드가 있는 상태에서 부모레코드 삭제하기
delete from pr_dept_const where deptno=10;
select * from pr_dept_const;
select * from pr_emp_const; --정상적으로 삭제됨.

commit;

