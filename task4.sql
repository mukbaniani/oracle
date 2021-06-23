-- შექმენით dept რელაცია, რომელსაც ექნება ორი სვეტი id და name. id სვეტი უნდა
-- იყოს რიცხვითი ტიპის მონაცემები მაქსიმუმ 6 თანრიგიანი, ასევე ეს სვეტი
-- წარნოადგენდეს პირველად გასაღებს. Name სვეტი იყოს სიმბოლური ტიპის
-- მაქსიმუმ 23 სიმბოლოს მოცულობის.

create table dept (id number(6), name varchar(23));

-- Dept რელაციაში ჩაამატეთ სიმბოლური ტიპის მონაცემების სვეტი loc, სიგრძით
-- მაქსიმუმ 15 სიმბოლო.

alter table dept 
    add loc varchar(15);

-- Dept რელაციიდან ამოშალეთ loc სვეტი.

alter table dept
    drop column loc

-- შეავსეთ dept რელაცია departments რელაციის ჩანაწერების საშუელებით, id სვეტში
-- მოთავსდეს დეპარტამენტის აიდები, ხოლო name სვეტში დეპარტამენტის
-- სახელები.

insert into dept (id, name) 
select department_id, department_name from hr.departments

-- შექმენით emp რელაცია employees რელაციაზე დაყრდნობით თანამშრომლის
-- აიდით, გვარით, ხელფასით, დეპარტმენტის აიდით, თანაც შეივსოს მხოლოდ იმ
-- თანამშროიმლების ინფორმაციებით რომელლებსაც ერიცხებათ ხელფასი 10000-
-- დან 17000-მდე.

create table emp
    as select employee_id, last_name, salary, department_id 
    from hr.employees;
insert into emp
select employee_id, last_name, salary, department_id 
from hr.employees 
where salary between 10000 and 17000

-- შექმენით emp2 რელაცია, რომელსაც ექნება id სვეტი რიცხვითი მაქსიმუმ 4
-- თანრიგი, name სვეტი სიმბოლური ტიპის მონაცემებით მაქსიმუმ 17 სიმბოლო,
-- dept_id სვეტი რიცხვითი მაქსიმუმ 6 თანრიგი, (შეზღუდეთ ეს სვეტი მეორადი
-- გასაღებით, რომელიც დაკავშირებუყლი იქნება dept რელაცისი id სვეტთან), email
-- სვეტი რომელიც შეზღუდული უნდა იყოს უნიკალურობის შეზღუდვით.

create table emp2(
    id number (6) primary key,
    name varchar(17),
    email varchar(40) unique,
    dept_id number(6) references dept(id)
)

-- შექმენით რელაცია test რომელსაც ექნება 1 სვეტი id ცვალებადი სიგრძის
-- სიმბოლური მნიშვნელობა მაქსიმუმ 12 სიმბოლო.

create table test(
    id number(12)
)

-- 12-ში მიღებული ცხრილში id გახადე პირველადი გასაღები.

alter table test
    modify id primary key

-- 14-ში მიღებული ცხრილში id-ის მაქსიმალური ზომა გახადე 6 სიმბოლო.

alter table test
    modify id number(6)

-- 15-ში მიღებულ ცხრილში id-ს გადაარქვით სახელი და დაარქვით t_id.

alter table test
    rename column id to t_id

-- 16-ში მიღებულ ცხრილში ჩაამატე სვეტი date თარიღის ტიპის.

alter table test
    add date_time date

-- 17-ში მიღებულ ცხრილში date სვეტის დეფაულტ მნიშვნელობა გახადე სისტემური
-- თარიღის წინა 10 დღის წინა თარიღი.

alter table test
    modify date_time date default sysdate - 10

-- წაშალე emp2 ცხრილი.

drop table emp2

წაშალე test ცხრილი.

drop table test