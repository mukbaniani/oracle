--გამოიტანეთ World Data(world) სქემაში შემავალი world_population რელაციის
-- სტრუქტურა.

desc world.world_population

-- World Data(world) სქემაში შემავალი world_population რელაციიდან მოახდინეთ ყველა
-- სვეტის პროექცია.

select * from world.world_population

-- World Data(world) სქემაში შემავალი world_population რელაციიდან მოახდინეთ ქვეყნის
-- დასახელების სვეტის პროექცია, ასევე 1990, 1998, 2000, 2012 წლის მონაცემების გამოტანა,
-- შემდეგი ქვეყნებისთვის : საქართველო, აზერბაიჯანი, ჩეხეთი, რუმინეთი, ისრაელი და
-- აშშ. მონაცემები იქნეს დალაგებული 2000 წლის სვეტის მონაცემების კლებადობით.

select country, "1990", "1998", "2000", "2012"
from world.world_population
where country in ('Georgia', 'Israel', 'Azerbaijan', 'Romania', 'Czechia', 'USA')
order by 4 desc

-- Order Entry (oe) სქემაში შემავალი customers რელაციიდან მოახდინეთ იმ
-- მომხმარებლ(ებ)ის მომხმარებლის აიდის, გვარის, იმეილიდან პირველი 8 სიმბოლოს და
-- შემოსავლის დონის გამოტანა, რომელთათვისაც სრულდება პირობა მომხმარებელი არის
-- დასაოჯახებელი და მისი შემოსავლის დონეა A, G ან C. დასორტირება მოახდინეთ
-- სახელებით ალფავიტურად.

select customer_id, cust_last_name, substr(cust_email, 1,8) cust_email, income_level
from oe.customers
where marital_status = 'single' and
substr(income_level,1,1) in ('A', 'G', 'C')
order by cust_first_name

-- Order Entry (oe) სქემაში შემავალი orders რელაციიდან გამოიტანეთ შეკვეთების აიდები,
-- შეკვეთის ტიპები, შეკვეთის თარიღიდან დღემდე გასულ დღეთა ოდენობა, შეკვეთის
-- თარიღიდან დღემდე გასულ თითოეულ დღეზე 17 დოლარის დარიცხვა, შეკვეთის
-- თარიღიდან დღემდე გასულ თითოეულ დღეზე დარიცხული დოლარების ქართულ
-- ლარში კონვერტირებული თანხები (თუ 1 დოლარის კურსია 3.18 ლარი). მოთხოვნილი
-- ინფორმაცია გამოსატანია მხოლოდ მათთვის სადაც შეკვეთის ტიპია ონლაინი.
-- მონაცემები იქნეს დასორტირებული შეკვეთის ღირებულების მიხედვით ზრდადობით.
-- სვეტებს გაუკეთეთ ლოგიკური ალიასები. შეკვეთის თარიღი აიღეთ თრანქირებული.

select order_id, order_mode, trunc(sysdate) - trunc(order_date) "გასული დღეების
რაოდენობა",
to_number(trunc(sysdate) - trunc(order_date)) * 17 "In Dolar", to_number(trunc(sysdate) -
trunc(order_date)) * 17 * 3.13 "In Lari"
from oe.orders
where order_mode = 'online'
order by order_total


-- გამოიტანეთ Order Entry (oe) სქემაში შემავალი რელაციის product_information-ის
-- სტრუქტურა. მოახდინეთ აღნიშნული რელაციიდან პროქდუქციის აიდის, პროდუქციის
-- დასახელების (ყველა ასო დიდი სიმბოლოთი), კატეგორიის, მინიმალური ფასების და
-- მიმწოდებლის აიდის გამოტანა, იმ ჩანაწერებისთვის რომლითვისაც კმაყოფილდება
-- პროდუქციის დასახელებაში არ გვხვედბა HD ან Monitor ჩანაწერი და ასევე მიმწოდებლის
-- აიდი არის კენტი. დაასოტირეთ მონაცემები პროდუქციის დასახელების სიგრძის
-- კლებადობით.

desc oe.product_information

select product_id, upper(product_name) product_name, category_id, min_price, supplier_id
from oe.product_information
where mod(supplier_id, 2) != 1
and instr(product_name, 'HD') = 0 and instr(product_name, 'Monitor') = 0
order by length(product_name) desc