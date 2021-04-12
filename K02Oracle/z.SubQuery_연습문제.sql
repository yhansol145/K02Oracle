
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

select * from emp group by job; /* �����߻�
                group by�� �׷�ȭ�� �����Ϳ��� �׷��Լ���
                ���� ��� �̿��� ���� ����� �ָ��ϹǷ� 
                ������ �߻��ϰ� �ȴ�.
*/

/*
 �������� �׷�ȭ �Ͽ� ������ ��ձ޿��� ��ȸ
*/
select job, avg(sal) from emp group by job;
select min(round(avg(sal))) from emp group by job;

/*
    ��ձ޿��� ���������� �����ϴ� �÷��� �ƴϹǷ�
    where������ ����� �� ���� having���� ����ؾ� �Ѵ�.
    ��, ��ձ޿��� 1017�� ������ ����ϴ� �������
    ���������� �ۼ��Ѵ�.
*/
select job, round(avg(sal)) 
    from emp group by job 
    having round(avg(sal)) = (select round(min(avg(sal))) from emp group by job);

--------------------------------------------------------------------------------

/*
05.���μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/

select deptno, min(sal) from emp group by deptno;

select ename, sal, deptno from emp where sal in (select min(sal) from emp group by deptno);

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

select deptno from emp where ename like '%K%'; -- �μ���ȣ Ȯ�� : 10, 30

select * from emp where deptno=10 or deptno=30; -- Or�� ���ǰɱ�
select * from emp where deptno in (10, 30); -- in���� ���ǰɱ�
/*
    or������ in���� ������ �� �����Ƿ�, ������������ ������
    ���꿡 in�� ����Ѵ�. 2���̻��� ����� or�� �����Ͽ�
    ����ϴ� ȿ���� ������.
*/

select empno, ename from emp where deptno in (select deptno from emp where ename like '%K%');

--------------------------------------------------------------------------------

/*
12.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/

select ename, deptno, job from emp inner join dept using(deptno)
where loc='DALLAS';

--------------------------------------------------------------------------------

/*
13.KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�.
*/

select empno from emp where ename='KING';
select ename, to_char(sal, '999,000') from emp where mgr=(select empno from emp where ename='KING');

--------------------------------------------------------------------------------

/*
14.RESEARCH �μ��� ����� ���� �μ���ȣ ����̸� �� ��� ������ ǥ���Ͻÿ�.
*/

select deptno, ename, job from emp inner join dept using(deptno) where dname='RESEARCH';

--------------------------------------------------------------------------------

/* 
15.��� �޿� ���� ���� �޿��� �ް� �̸��� k�� ���Ե� ����� ���� �μ����� 
    �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/

select round(avg(sal)) from emp; -- ��� : 2077

select * from emp where ename like '%K%'; -- ��� : 10, 30

-- �޿��� 2077�̻��̰�, �μ���ȣ 10, 30�� ��� ���
select * from emp 
    where sal>2077 and deptno in(10, 30);
    
-- ���������� �ۼ�
select * from emp
    where sal>(select round(avg(sal)) from emp)
    and deptno in(select deptno from emp where ename like '%K%');

select empno, ename, sal from emp
    where sal>(select avg(sal) from emp)
    and deptno in (select deptno from emp where ename like '%K%');

--------------------------------------------------------------------------------

/* 
16.��� �޿��� ���� ���� ������ ã���ÿ�.
*/

select min(avg(sal)) from emp group by job;

select job from emp having avg(sal) = 
    (select min(avg(sal)) from emp group by job) group by job;

--------------------------------------------------------------------------------

/*
17.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/

select deptno from emp where job='MANAGER';

select ename from emp where deptno in (select deptno from emp where job='MANAGER');

--------------------------------------------------------------------------------