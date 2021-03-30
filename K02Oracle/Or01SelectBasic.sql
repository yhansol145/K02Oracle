/************************************
���ϸ� : Or01SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
���� : select, where �� ���� �⺻���� DQL�� ����غ���
************************************/

select * from employees;
select * from employees where employee_id=100;

/*
SQL Developer���� �ּ� ����ϱ�
    ������ �ּ� : �ڹٿ� ����
    ���δ��� �ּ� : -- ���๮��. ������ 2���� �������� ���
*/

--select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�.

/*
����]
    select �÷�1, �÷�2 .....[�Ǵ� *]
    from ���̺��
    where ����1 and ����2 or ����3......
    order by ������ �÷� asc(��������), desc(��������);
    ex(select * from employees where employee_id=100);
*/

--������̺� ����� ��� ���ڵ� ��ȸ�ϱ�
select * from employees;

--�÷����� �����ؼ� �����ڰ� ������� �÷��� ��ȸ�� �� �ִ�.
--�����ȣ, �̸�, �̸���, �μ����̵� ��ȸ����...
select employee_id, first_name, last_name, email, department_id 
from employees;

--���̺��� �Ӽ��� �ڷ����� Ȯ���ϴ� ���
desc employees;

--�ش� �÷��� number(����) Ÿ���̸� ��������� �����ϴ�.
select employee_id, first_name, salary, salary+100 from employees;
--���� Ÿ���� �÷������� ���굵 �����ϴ�.
select employee_id, first_name, salary, commission_pct, salary+commission_pct
from employees;

/*
AS(�˸��ƽ�) : ���̺� Ȥ�� �÷��� ��Ī(����)�� �ο��� �� ����Ѵ�.
    ���� ���ϴ� �̸�(����, �ѱ� ��) ���� ������ �Ŀ� ����� �� �ִ�.
    Ȱ���] ���� 2�� �̻��� ���̺��� join�ؾ� �� ��� �÷�����
    �ߺ��� �� �����ϴ� �뵵�� ���� �� �ִ�.
*/
select first_name, salary, salary+100 as "�޿�100����" from employees;
select first_name, salary, salary+100 as salaryUp100 from employees;

--as�� ������ �� �ִ�.
select employee_id "������̵�", first_name, last_name "��"
from employees where first_name='William';

--����Ŭ�� �⺻������ ��ҹ��ڸ� �������� �ʴ´�. ������ �Ѵ� ��밡���ϴ�.
select employee_id "������̵�", first_name, last_name "��"
from EMPLOYEES where first_name='William';

--��, ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�. �Ʒ� SQL���� �����ϸ� ����� ������ �ʴ´�.
select employee_id "������̵�", first_name, last_name "��"
from EMPLOYEES where first_name='WILLIAM'; --�̸���ü�� �빮�ڷ� �ۼ���.


/*
where���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
    : last_name�� Smith�� ���ڵ带 �����´�.
    ����] where���� ������ �Է��Ҷ� �÷��� �������̸�
    �̱������̼��� ����ؾ� �Ѵ�. �������� ��� ���������ϴ�.
*/

select * from employees where last_name='Smith'; --2������
select * from employees where last_name='Smith' and salary=8000; --1������
select * from employees where last_name='Smith' or salary=8000; --4������

--�޿��� 5000�̸� Ȥ�� 5000�̻��� ����� ������ ��������
select * from employees where salary<5000; --49������
select * from employees where salary>=5000; --58������


/*
�Ի����� 04��01��01�� ������ ��������� �����Ͻÿ�
    : ��¥�� ����ó�� <,>= ��� ���� �񱳿����ڸ� ���� ������ ������ �� �ִ�.
*/
select * from employees where hire_date>='04/01/01';


/*
and������ : �� �̻��� ������ ���ÿ� �����Ҵ�� ��ũ�带 �����´�.
    �μ����̵� 50�̸鼭 �޴������̵� 100�� ��������� �����Ͻÿ�.
*/

select * from employees where department_id = 50 and manager_id=100;


/*
in������ : or �����ڿ� ����� ������� �ϳ��� �÷��� ���������� 
    ������ �ɰ� ������ ����ϴ� ������
    �޿��� 4200, 6400, 8000�� ������ ������ ��ȸ�Ͻÿ�.
*/

--���1 : or�� ����Ѵ�. �÷����� �ݺ������� ����ؾ� �Ѵ�.
select * from employees where salary=4200 or salary=6400 or salary=8000;
--���2 : in�� ����ϸ� �÷��� �ѹ��� ����ϸ� �ǹǷ� ���ϴ�.
select * from employees where salary in(4200, 6400, 8000);


/*
not������ : �ش� ������ �ƴ� ���ڵ带 �����´�.
    �μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�Ͻÿ�.
    => <> Ȥ�� not���� ǥ���Ѵ�.
*/
select * from employees where department_id<>50;
select * from employees where not (department_id=50);


/*
between and ������ : �÷��� ������ ���� �˻��Ҷ� ����Ѵ�.
    �޿��� 4000~8000 ������ ��������� ��ȸ�Ͻÿ�.
*/
select * from employees where salary>=4000 and salary<=8000;
select * from employees where salary between 4000 and 8000;


/*
distinct : �÷����� �ߺ��Ǵ� ���ڵ带 �����Ҷ� ����Ѵ�.
    Ư�� �������� select������ �ϳ��� �÷����� �ߺ��Ǵ� ����
    �ִ� ��� �ߺ����� ������ �� ����� ����� �� �ִ�.
*/
select job_id from employees;
select distinct job_id from employees;


/*
like ������ : Ư�� Ű���带 ���� ���ڿ� �˻��ϱ�
    ����) �÷��� like '%Ű����%'
    ���ϵ�ī�� ����
        % : ��� ���� Ȥ�� ���ڿ��� ��ü�Ѵ�.
        Ex) D�� �����ϴ� �ܾ� : D% -> Da, Dae, Daewoo
            Z�� ������ �ܾ� : %Z -> aZ, abcZ
            C�� ���ԵǴ� �ܾ� : %C% -> aCb, abCde, Vitamin-C
        
        _ : ����ٴ� �ϳ��� ���ڸ� ��ü�Ѵ�.
        Ex) D�� �����ϴ� 3������ �ܾ� : D__ -> Dab, Ddd, Dxy
            A�� �߰��� ���� 3������ �ܾ� : _A_ -> aAa, xAy
*/
--first_name�� 'D'�� �����ϴ� ������ �˻��Ͻÿ�
select * from employees where first_name like 'D%';
--first_name�� ����° ���ڰ� 'a'�� ��� ������ �����Ͻÿ�.
select * from employees where first_name like '__a%';
--first_name�� 'd'�� ������ ��� ������ �˻��Ͻÿ�.
select * from employees where first_name like '%d';
--��ȭ��ȣ�� 1344�� ���ԵǴ� ��� ������ �˻��Ͻÿ�.
select * from employees where phone_number like '%1344%';


/*
���ڵ� �����ϱ�(Sorting)
    ������������ : order by �÷��� asc (Ȥ�� ��������[����Ʈ])
    ������������ : order by �÷��� desc
    
    2�� �̻��� �÷����� �����ؾ� �Ҷ��� ,(�޸�)�� �����ؼ� �����Ѵ�.
    ��, �̶� ���� �Է��� �÷����� ���ĵ� ���¿��� �ι�° �÷��� ���ĵȴ�.
*/
/*
������� ���̺��� �޿��� ������������ ���������� �������� �����Ͽ� ��ȸ�Ͻÿ�.
������÷� : first_name, salary, email, phone_number
*/
select first_name, salary, email, phone_number
from employees
order by salary asc;


/*
�μ���ȣ�� ������������ ������ �� �ش� �μ����� ���� �޿��� �޴� ������
���� ��µǵ��� �ϴ� SQL���� �ۼ��Ͻÿ�.
����׸� : �����ȣ, �̸�, ��, �޿�, �μ���ȣ
*/
select employee_id, first_name, last_name, salary, department_id
from employees
order by department_id desc, salary asc;


/*
is null Ȥ�� is not null
    : ���� null�̰ų� null�� �ƴ� ���ڵ� ��������
    �÷��� null���� ����ϴ� ��� ���� �Է����� ������ null����
    �Ǵµ� �̸� ������� select�Ҷ� ����Ѵ�.
*/
--���ʽ����� ���� ����� ��ȸ�Ͻÿ�.
select * from employees where commission_pct is null;
--���ʽ����� �ִ� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is not null;
--���ʽ����� ���� ����� �޿��� 5000�̻��� ����� ��ȸ�ϴ� �������� �ۼ��Ͻÿ�
select * from employees where commission_pct is null and salary>=5000;
