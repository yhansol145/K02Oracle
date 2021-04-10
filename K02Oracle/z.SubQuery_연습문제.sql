
/*
01.사원번호가 7782인 사원과 담당 업무가 같은 사원을 표시(사원이름과 담당 업무)하시오.
*/

select job from emp where empno=7782;
select ename from emp where job=('MANAGER');

select ename, job from emp  where job=(select job from emp where empno=7782);

--------------------------------------------------------------------------------

/*
02.사원번호가 7499인 사원보다 급여가 많은 사원을 표시(사원이름과 담당 업무)하시오.
*/

select sal from emp where empno=7499;
select ename from emp where sal>1600;

select ename, job from emp where sal>(select sal from emp where empno=7499);

--------------------------------------------------------------------------------

/*
03.최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시하시오(그룹함수 사용).
*/

select min(sal) from emp;
select ename, job, sal from emp;

select ename, job, sal from emp where sal=(select min(sal) from emp);

--------------------------------------------------------------------------------

/*
04.평균 급여가 가장 적은 직급(job)과 평균 급여를 표시하시오.
*/

select job, avg(sal) from emp group by job;
select min(avg(sal)) from emp group by job;

select job, avg(sal) from emp group by job having avg(sal)
                =(select min(avg(sal)) from emp group by job);

--------------------------------------------------------------------------------

/* (~ing)
05.각부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
*/

select deptno, min(sal) from emp group by deptno;

select ename, sal, deptno from emp where 

--------------------------------------------------------------------------------

/*
06.담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 업무가 분석가(ANALYST)가 
    아닌 사원들을 표시(사원번호, 이름, 담당업무, 급여)하시오.
*/

select sal from emp where job='ANALYST';

select empno, ename, job, sal from emp 
where sal<(select sal from emp where job='ANALYST') and job != 'ANALYST';

--------------------------------------------------------------------------------

/* 
07.부하직원이 없는 사람의 이름을 표시하시오.
*/

select ename from emp where empno not in 
(select mgr from emp group by mgr having mgr is not null);

--------------------------------------------------------------------------------

/*
08.부하직원이 있는 사람의 이름을 표시하시오
*/

select ename from emp where empno in 
(select mgr from emp group by mgr having mgr is not null);

--------------------------------------------------------------------------------

/*
09.BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단. BLAKE는 제외).
*/

select deptno from emp where ename = 'BLAKE';

select ename, hiredate from emp 
where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';

--------------------------------------------------------------------------------

/*
10.급여가 평균 급여 보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름차순으로 정렬 하시오.
*/

select avg(sal) from emp;

select empno, ename, sal from emp where sal>(select avg(sal) from emp)
order by sal asc;

--------------------------------------------------------------------------------

/*
11.이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오
*/

select deptno from emp where ename like '%K%';

select empno, ename from emp where deptno in (select deptno from emp where ename like '%K%');

--------------------------------------------------------------------------------

/*
12.부서 위치가 DALLAS인 사원의 이름과 부서번호 및 담당 업무를 표시하시오.
*/

-- ??

--------------------------------------------------------------------------------

/*
13.KING에게 보고하는 사원의 이름과 급여를 표시하시오.
*/

select empno from emp where ename='KING';
select ename, sal from emp where mgr=(select empno from emp where ename='KING');

--------------------------------------------------------------------------------

/*
14.RESEARCH 부서의 사원에 대한 부서번호 사원이름 및 담당 업무를 표시하시오.
*/

--------------------------------------------------------------------------------

/* (~ing)
15.평균 급여 보다 많은 급여를 받고 이름에 k가 포함된 사원과 같은 부서에서 
    근무하는 사원의 사원번호, 이름, 급여를 표시하시오.
*/

select avg(sal) from emp;
select ename from emp where sal>(select avg(sal) from emp);

select ename, deptno from emp where ename like '%K%';

--------------------------------------------------------------------------------

/* (~ing)
16.평균 급여가 가장 적은 업무를 찾으시오.
*/

select job, avg(sal) from emp group by job;

--------------------------------------------------------------------------------

/*
17.담당 업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
*/

select deptno from emp where job='MANAGER';

select ename from emp where deptno in (select deptno from emp where job='MANAGER');

--------------------------------------------------------------------------------