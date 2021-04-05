/****************************
파일명 : Or11Constraint.sql
제약조건
설명 : 테이블 생성시 필요한 여러가지 제약조건에 대해 학습한다.
****************************/

-- study 계정에서 실습합니다.


/*
Primary key : 기본키
- 참조무결성을 유지하기 위한 제약조건이다.
- 하나의 테이블에 하나의 기본키만 설정할 수 있다.
- 기본키로 설정되면 그 컬럼은 중복된값이나 NULL값을 입력할 수 없다.
*/

/*
형식1] 인라인 방식
    create table 테이블명 (
        컬럼명 자료형 [constratin PK제약명] primary key
    );
*/
create table tb_primary1 (
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
);
desc tb_primary1;
/*
제약조건 확인하기
    user_cons_column : 테이블에 지정된 제약조건명과 컬럼명의
        간략한 정보를 확인할 수 있다.
    user_constraints : 테이블에 지정된 제약조건의 상세한 정보를
        확인할 수 있다.
※ 이와같이 제약조건이나 뷰, 프로시서등의 정보를 저장하고 있는
    시스템 테이블을 "데이터사전"이라고 한다.
*/
select * from user_cons_columns;
select * from user_constraints;

insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'kosmo', '코스모');
insert into tb_primary1 (idx, user_id, user_name)
    values (1, 'gasmo', '가스모');/*
        무결성제약조건 위배로 에러발생. PK로 지정된 컬럼 idx에는
        중복된 값을 입력 할 수 없다.
    */
insert into tb_primary1 values (2, 'black', '블랙');
insert into tb_primary1 values ('', 'white', '화이트');/*
        PK로 지정된 컬럼에서는 null(빈값) 을 입력할 수 없다.
    */
select * from tb_primary1;
update tb_primary1 set idx=2 where user_name='코스모';/*
        update문은 정상이지만 idx값이 이미 존재하는 2로
        변경했으므로 제약조건 위배로 오류발생
    */


/*
형식2] 아웃라인 방식
    create table 테이블명 (
        컬럼명 자료형,
        [constraint 제약명] primary key (컬럼명)
    );
*/
create table tb_primary2 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50),
    primary key (user_id)
);
desc tb_primary2;
select * from user_constraints;


/*
형식3] 테이블 생성후 alter문으로 제약조건 추가
    alter table 테이블명 add [constraint 제약명] primarry key (컬럼명);
*/
create table tb_primary3 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50)
);
alter table tb_primary3 add
    constraint tb_primarry3_pk
        primary key (user_name);
desc tb_primary3;
select * from user_constraints;

--테이블을 삭제하면 부여했던 PK 제약조건도 같이 삭제된다.
drop table tb_primary3;
select * from user_constraints;



/*
Unique : 유니크
- 값의 중복을 허용하지 않는 제약조건
- 숫자, 문자열은 중복을 허용하지 않으나, null값에 대해서는
    중복을 허용한다.
- unique는 한 테이블에 2개 이상 적용할 수 있다.
*/
create table tb_unique1(
    idx number unique not null,
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    unique(telephone, nickname)
);
select * from user_constraints;
select * from user_cons_columns;

insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '아이린', '010-1111-1111', '레드밸벳');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (2, '웬디', '010-2222-2222', '');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (3, '슬기', '', '');
select * from tb_unique1;

insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '예리', '010-3333-3333', ''); --에러발생. 중복된 idx값 있음.

insert into tb_unique1 values (4, '정우성', '010-4444-4444', '영화배우');
insert into tb_unique1 values (5, '이정재', '010-5555-5555', '영화배우'); --입력성공
insert into tb_unique1 values (6, '황정민', '010-4444-4444', '영화배우'); --에러발생
/*
    telephone과 nickname 컬럼이 동일한 제약명으로 설정되었으므로
    두개의 컬럼이 동시에 동일한 값을 가지는 경우가 아니라면 중복된값이
    허용된다.
    즉 4번과 5번은 서로 다른 데이터로 인식하므로 입력되고,
    4번과 6번은 동일한 데이터로 인식되어 에러가 발생한다.
*/


/*
Unique 2번째 형식
*/
create table tb_unique2(
    idx number primary key,
    name varchar2(30),
    mobile varchar2(20),
    unique (mobile)
);
select * from user_cons_columns;



/*
Foreign key : 외래키, 참조키
- 외래키는 참조무결성을 유지하기 위한 제약조건이다.
- 만약 테이블간에 외래키가 설정되어 있다면 자식테이블에 참조값이
    존재할 경우 부모테이블의 레코드는 삭제되지 않는다.
*/

/*
형식1] 인라인방식
    create table 테이블명 (
        컬럼명 자료형 [constraint 제약명]
            references 부모테이블명 (부모테이블의 PK컬럼명)
    );
*/
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    f_id varchar2(30) constraint tb_foreign1_fk
        references tb_primary2 (user_id)
);
-- 부모테이블에 레코드가 전혀 없는 상태임
select * from tb_primary2;
-- 부모테이블에 참조할 레코드가 없으므로 자식테이블에 입력불가
insert into tb_foreign1 values (1, '워너원', 'WannerOne');
-- 부모테이블에 레코드 먼저 삽입
insert into tb_primary2 values (1, 'BTS', '방탄소년단');
-- 부모테이블의 참조할 레코드를 기반으로 자식테이블에 레코드 삽입됨
insert into tb_foreign1 values (1, '방탄소년단', 'BTS');
-- 부모키가 없으므로 입력불가
insert into tb_foreign1 values (2, '트와이스', 'Twice');

-- 입력된 레코드 확인
select * from tb_primary2;
select * from tb_foreign1;

/*
    자식테이블에서 참조하는 레코드가 있으면, 부모테이블의 레코드를
    삭제할 수 없다. 이경우에는 반드시 자식테이블의 레코드를 먼저 삭제한 후
    부모테이블의 레코드를 삭제해야 한다.
*/
delete from tb_primary2 where idx=1; -- 에러발생

delete from tb_foreign1 where f_idx=1; -- 자식테이블의 레코드를 먼저 삭제한 후
delete from tb_primary2 where idx=1; -- 부모테이블의 레코드를 삭제한다.

-- 두테이블 모두에서 삭제되었는지 확인
select * from tb_primary2;
select * from tb_foreign1;


/*
형식2] 아웃라인 방식
    create table 테이블명 (
        컬럼명 자료형 ,
        
        [constraint 제약명] foreign key (컬럼명)
            references 부모테이블 (부모테이블의 참조할컬럼)
    )
*/
create table tb_foreign2 (
    f_id number primary key,
    f_name varchar2(30),
    f_date date,
    
    foreign key (f_name) references tb_primary3(user_name)
);
select * from user_constraints;
/*
데이터 사전에서 제약조건 확인시 플래그
P : Primary key
R : Reference integrity 즉 Foreign key를 뜻함
C : Check 혹은 Not null
U : Unique
*/


/*
외래키 삭제시 옵션
[on delete cascade]
    -> 부모레코드 삭제시 자식레코드까지 같이 삭제됨
    형식]
        컬럼형 자료형 references 부모테이블(PK컬럼)
            on delete cascadel;
[on delete set null]
    -> 부모레코드 삭제시 자식레코드값이 null로 변경됨
    형식]
        컬럼명 자료형 references 부모테이블(PK컬럼)
            on delete set null
※ 실무에서 스팸게시물을 남긴 회원과 그 게시글을 일괄적으로 삭제해야 할때
사용할 수 있는 옵션이다. 단, 자식테이블의 모든 레코드가 삭제되므로 사용에
주의해야한다.
*/
create table tb_primary4(
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign4 (
    f_idx number(10) primary key,
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign4_fk
        references tb_primary4 (user_id)
            on delete cascade
);
insert into tb_primary4 values ('kosmo', '코스모'); -- 항상 부모테이블에 먼저 입력 후
insert into tb_foreign4 values (1, '1번입니다', 'kosmo'); -- 자식테이블에 입력해야 한다.
insert into tb_foreign4 values (2, '2번입니다', 'kosmo');
insert into tb_foreign4 values (3, '3번입니다', 'kosmo');
insert into tb_foreign4 values (4, '4번입니다', 'kosmo');
insert into tb_foreign4 values (5, '5번입니다', 'kosmo');
insert into tb_foreign4 values (6, '6번입니다', 'kosmo');
insert into tb_foreign4 values (7, '7번입니다', 'hong'); -- 부모키가 없으므로 에러발생

select * from tb_primary4;
select * from tb_foreign4;

delete from tb_primary4;/*
            부모테이블에서 레코드 삭제 시 on delete cascade 옵션때문에
            부모쪽뿐만 아니라 자식테이블까지 모든 레코드가 삭제된다.
    */

select * from tb_primary4;
select * from tb_foreign4;


-- on delete set null 옵션 테스트
create table tb_primary5 (
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign5 (
    f_idx number(10) primary key,
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign5_fk
        references tb_primary5 (user_id) on delete set null
);

insert into tb_primary5 values ('kosmo', '코스모');
insert into tb_foreign5 values (1, '1번게시물', 'kosmo');
insert into tb_foreign5 values (2, '2번게시물', 'kosmo');
insert into tb_foreign5 values (3, '3번게시물', 'kosmo');
insert into tb_foreign5 values (4, '4번게시물', 'kosmo');
insert into tb_foreign5 values (5, '5번게시물', 'kosmo');

-- 입력된 레코드 확인
select * from tb_primary5;
select * from tb_foreign5;

/*
on delete set null 옵션으로 자식테이블의 레코드는 삭제되지 않고
참조키 부분만 null값으로 변경된다.
*/
delete from tb_primary5;

select * from tb_primary5;
select * from tb_foreign5;


/*
not null : null 값을 허용하지 않는 제약조건
    형식]
        create table 테이블명 (
            컬럼명 자료형 not null,
            컬럼명 자료형 null <- null을 허용하겠다는 의미로 작성했지만
                            이렇게는 사용하지 않는다. null을 기술하지
                            않는것이 권장사항이다.
        )
*/
create table tb_not_null (
    m_idx number(10) primary key, -- PK로 지정했으므로 NN
    m_id varchar2(30) not null,   -- NN (not null)
    m_pw varchar2(40) null,       -- null 허용(일반적으로 null은 생략)
    m_name varchar2(50)           -- null 허용(이와같이 선언한다)
);
desc tb_not_null;

insert into tb_not_null values (10, 'hong1', '1111', '홍길동');
insert into tb_not_null values (20, 'hong2', '2222', '');
insert into tb_not_null values (30, 'hong3', '', '');
insert into tb_not_null values (40, '', '4', '사길동'); -- 입력실패. null을 입력할수없음
insert into tb_not_null (m_id, m_pw, m_name)
    values ('hong5', '5555', '오길동'); -- 입력실패. m_dix컬럼에 값이 입력되야함.
insert into tb_not_null values (60, ' ', '6666', '육길동'); -- 입력성공(space도 문자)

select * from tb_not_null;

/*
Default : insert시 아무런 값도 입력하지 않을때 자동으로 삽입되는 데이터를 말한다.
*/
create table tb_default (
    id varchar2(30) not null,
    pw varchar2(30) default 'qwer'
);
desc tb_default;
select * from tb_default;
insert into tb_default values('aaaa', '1234'); -- 1,2,3,4 입력
insert into tb_default values('bbbb', ''); -- null값이 필요
insert into tb_default (id) values ('cccc'); -- default값 삽입됨
insert into tb_default (id, PW) values ('dddd', default); -- default값 삽입됨
/*
    위에서 보듯이 default값을 입력하려면 insert다시 컬럼자제를 제외하거나
    default 키워드를 사용해야 한다.
*/



/*
check : Domain(자료형) 무결성을 유지하기 위한 제역조건으로
    해당컬럼에 잘못된 데이터가 입력되지 않도록 유지하는 제약조건이다.
*/
create table tb_check1(
    gender varchar2(20) not null
        constraint check_gender
            check (gender in ('M', 'F'))
);
insert into tb_check1 values('M');
insert into tb_check1 values('F');
insert into tb_check1 values('A');  -- 입력실패
insert into tb_check1 values('Man'); -- 입력실패
insert into tb_check1 values('여자'); -- 입력실패

create table tb_check2(
    ticket_cnt number not null
        check(ticket_cnt<=5)
);
insert into tb_check2 values (4);
insert into tb_check2 values (5);
insert into tb_check2 values (6); -- 입력실패. check제약조ㅓ건 위배