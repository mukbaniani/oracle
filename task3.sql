-- my_employee რელაციაში სათითაოდ შეიტანეთ ქვემოთ მოცემული სტრიქონები insert-ში
-- სვეტების ლისტის მითითებით, გამოიყენეთ დეფაულტ განლაგება.
-- id last_name first_name userid salary
-- 2 Dodashvili Solomoni solomon2 4500
-- 6 Razikashvili Luka vaja75 6540
-- 11 Kalandadze Ana Kalanda7 7510

insert all
 into MY_EMPLOYEE (id, last_name, first_name, userid, salary) values(2, 'Dodashvili', 'Solomoni',
'solomon2', 4500)
 into MY_EMPLOYEE (id, last_name, first_name, userid, salary) values(6, 'Razikashvili', 'luka',
'vaja75', 6540)
 into MY_EMPLOYEE (id, last_name, first_name, userid, salary) values(11, 'Kalandadze', 'Ana',
'kalanda7', 7510)
select 1 from dual 

შეიტანეთ ქვემოთ მოცემული სტრიოქნები სვეტების ლისტის მითითების გარეშე
id last_name first_name userid salary
3 Megrelishvili Gurami Gurami12 2500
9 Arsenishvili Zaira Zara45 6950

insert all
 into MY_EMPLOYEE values(3, 'Megrelishvili', 'Gurami', 'Gurami12', 2500)
 into MY_EMPLOYEE values(9, 'Arsenishvili', 'Zaira', 'Zara45', 6950)
select 1 from dual 

-- my_employee რელაციიდან გამოიტანეთ იმ ადამიანზე ინფორმაცია რომელსაც ერიცხება ყველაზე
-- მეტი ხელფასი.

select * from MY_EMPLOYEE
where salary=(
 select max(salary)
 from MY_EMPLOYEE
) 

-- my_employee რელაციიდან გამოიტანეთ იმ ადამიანზე ინფორმაცია რომლის გვარშიც ურევია ასო
-- z ან ხელფასი აქვს 5000-ზე მეტი. გამოტანილი სტრიქონები დაალაგეთ id-ის კლებადობით.

select * from MY_EMPLOYEE
where last_name like '%z%' or
salary > 5000
order by id

-- my_employee რელაციიდან გამოიტანეთ იმ თანამშრომლების ჯამური ხელფასი რომლის აიდი
-- არის ლუწი.

select sum(salary)
from MY_EMPLOYEE
where mod(id,2) != 1

-- my_employee რელაციიდან გამოტანეთ გვარი, ხელფასი და ახალ სვეტში 45%-ით მომატებული
-- ხელფასი, რომლის სახელია „NEW Salary“. გამოტანილი სტრიქონები დაალაგეთ ახალი ხელფასის
-- კლების მიხედვით.

select last_name, salary, salary * 1.45 "New Salary"
from MY_EMPLOYEE
order by 3 des

-- my_employee რელაციიდან გამოიტანეთ რისი ტოლია თითოეულ ჩანაწერში last_name-ისა და
-- userid-ის სიგრძეთა ჯამის ნაშთი 13-ზე.

select mod(length(last_name) + length(userid), 13)
from my_employee 

-- Employees რელაციაზე დაყრდნობით my_employee რელაციაში შეიტანეთ ის სტრიქონები სადაც
-- დეპარტამენტის აიდია 30 ან 50, ან 80, ან 90. P.s. გაითვალსიწინეთ id-ის როლში employee_id, userid-
-- ის ნაცვლად შეიტანეთ job_id, თუმცა რადგანაც userid-ის მაქსიმალური დასაშვები სიმბოლოთა
-- ოდენობა არის 8, job_id-დან ამოიღეთ პირველი რვა სიმბოლო. სხვა სვეტები კი იდენტური
-- სახელებითაა.

insert into my_employee (id, last_name, userid, salary)
select employee_id, last_name, substr(job_id, 1, 8), salary from hr.employees where department_id
in
(30,50,80,90) 

მე7 სავარჯიშოში შეტანილ თანამშრომელს შევუცვალოთ სახელი Levani-ით.

update my_employee
set first_name='Levani'
where id = 13 

-- მე7 სავარჯიშოში შეტანილ თანამშრომელს შევუცვალოთ იუზერის აიდი bora23-ით.

update my_employee
set userid='bora23' 
where id = 13

-- წაშალეთ ის ჩანაწერი რომლის აიდია 11.

delete from my_employee
where id = 11 