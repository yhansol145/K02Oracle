
/*
01.�����ȣ�� 7782�� ����� ��� ������ ���� ����� ǥ��(����̸��� ��� ����)�Ͻÿ�.
*/

select job from emp where empno=7782;
select ename from emp where job=('MANAGER');

select ename, job from emp  where job=(select job from emp where empno=7782);

--------------------------------------------------------------------------------

/*
02.�����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ��(����̸��� ��� ����)�Ͻÿ�.
*/

select sal from emp where empno=7499;
select ename from emp where sal>1600;

select ename, job from emp where sal>(select sal from emp where empno=7499);

--------------------------------------------------------------------------------

/*
03.�ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�(�׷��Լ� ���).
*/

select min(sal) from emp;
select ename, job, sal from emp;

select ename, job, sal from emp where sal=(select min(sal) from emp);

--------------------------------------------------------------------------------

/*
04.��� �޿��� ���� ���� ����(job)�� ��� �޿��� ǥ���Ͻÿ�.
*/

select job, avg(sal) from emp group by job;
select min(avg(sal)) from emp group by job;

select job, avg(sal) from emp group by job having avg(sal)
                =(select min(avg(sal)) from emp group by job);

--------------------------------------------------------------------------------

/* (~ing)
05.���μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/

select deptno, min(sal) from emp group by deptno;

select ename, sal, deptno from emp where 

--------------------------------------------------------------------------------

/*
06.��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 ������ �м���(ANALYST)�� 
    �ƴ� ������� ǥ��(�����ȣ, �̸�, ������, �޿�)�Ͻÿ�.
*/

select sal from emp where job='ANALYST';

select empno, ename, job, sal from emp 
where sal<(select sal from emp where job='ANALYST') and job != 'ANALYST';

--------------------------------------------------------------------------------

/* 
07.���������� ���� ����� �̸��� ǥ���Ͻÿ�.
*/

select ename from emp where empno not in 
(select mgr from emp group by mgr having mgr is not null);

--------------------------------------------------------------------------------

/*
08.���������� �ִ� ����� �̸��� ǥ���Ͻÿ�
*/

select ename from emp where empno in 
(select mgr from emp group by mgr having mgr is not null);

--------------------------------------------------------------------------------

/*
09.BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��. BLAKE�� ����).
*/

select deptno from emp where ename = 'BLAKE';

select ename, hiredate from emp 
where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';

--------------------------------------------------------------------------------

/*
10.�޿��� ��� �޿� ���� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ������������ ���� �Ͻÿ�.
*/

select avg(sal) from emp;

select empno, ename, sal from emp where sal>(select avg(sal) from emp)
order by sal asc;

--------------------------------------------------------------------------------

/*
11.�̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
*/

select deptno from emp where ename like '%K%';

select empno, ename from emp where deptno in (select deptno from emp where ename like '%K%');

--------------------------------------------------------------------------------

/*
12.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/

-- ??

--------------------------------------------------------------------------------

/*
13.KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�.
*/

select empno from emp where ename='KING';
select ename, sal from emp where mgr=(select empno from emp where ename='KING');

--------------------------------------------------------------------------------

/*
14.RESEARCH �μ��� ����� ���� �μ���ȣ ����̸� �� ��� ������ ǥ���Ͻÿ�.
*/

--------------------------------------------------------------------------------

/* (~ing)
15.��� �޿� ���� ���� �޿��� �ް� �̸��� k�� ���Ե� ����� ���� �μ����� 
    �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/

select avg(sal) from emp;
select ename from emp where sal>(select avg(sal) from emp);

select ename, deptno from emp where ename like '%K%';

--------------------------------------------------------------------------------

/* (~ing)
16.��� �޿��� ���� ���� ������ ã���ÿ�.
*/

select job, avg(sal) from emp group by job;

--------------------------------------------------------------------------------

/*
17.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/

select deptno from emp where job='MANAGER';

select ename from emp where deptno in (select deptno from emp where job='MANAGER');

--------------------------------------------------------------------------------