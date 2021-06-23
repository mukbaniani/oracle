-- დავუშვათ ახალი მარკეტინგული ინიციატივის ფარგლებში, თქვენ მოგეთხოვათ მოამზადოთ
-- მომხმარებლის დაბადების დღის სია, რომელიც მოიცავს დღეიდან ორი დღის წინანადელ და
-- შვიდი დღის შემდეგ თარიღების დიაპაზონს. ინფორმაცია უნდა მოიძებნოს CUSTOMERS
-- ცხრილიდან, რომლიდანაც ეკრანზე იქნება CUST_FIRST_NAME ყველა დიდი სიმბოლოებით,
-- CUST_LAST_NAME ყველა პატარა სიმბოლოებით, CUST_EMAIL, DATE_OF_BIRTH სვეტის
-- მნიშვნელობების 7 თვის შემდგომი თარიღიდან უახლოესი ხუთშაბათი და DATE_OF_BIRTH
-- სვეტებს ზრდადი თანმიმდევრობით, DATE_OF_BIRTH მნიშვნელობის დღის და თვის
-- კომპონენტებზე დაყრდნობით. აღწერითი ამ რეპორტის დასაბრუნებლად საჭიროა ასევე
-- დამატებითი სვეტი, სახელწოდებით BIRTHDAY შემდეგი ცხრილის საფუძველზე.

select upper(CUST_FIRST_NAME) "first name", lower(CUST_LAST_NAME) "last name", CUST_EMAIL
"email", next_day(add_months(DATE_OF_BIRTH, 7), 'Thursday') "+7 month",
to_char(DATE_OF_BIRTH, 'fmdd/mm'),
 case to_char(DATE_OF_BIRTH, 'fmdd/mm')
 when to_char(sysdate - 1, 'fmdd/mm') then 'Yesterday'
 when to_char(sysdate - 2, 'fmdd/mm') then 'Day before yesterday'
 when to_char(sysdate, 'fmdd/mm') then 'today'
 when to_char(sysdate + 1, 'fmdd/mm') then 'Tomorrow'
 when to_char(sysdate + 2, 'fmdd/mm') then 'Day after tomorrow'
 when to_char(sysdate + 3, 'fmdd/mm') then 'Later this week'
 when to_char(sysdate + 4, 'fmdd/mm') then 'Later this week'
 when to_char(sysdate + 5, 'fmdd/mm') then 'Later this week'
 when to_char(sysdate + 6, 'fmdd/mm') then 'Later this week'
 when to_char(sysdate + 7, 'fmdd/mm') then 'Later this week'
 end "Birthday"
from oe.CUSTOMERS
order by to_char(DATE_OF_BIRTH, 'fmddmm')

-- HR დეპარტამენტმა გადაწყვიტა სამსახურში აყვანის დღის მიხედვით გაზარდოს ხელფასები,
-- კერძოდ: ორშაბათ დღეს აყვანილებს 10%-ით, სამშაბათ დღეს აყვენილების 8 %-ით, ოთხშაბათ
-- დღეს 12 %-ით და დანარჩენ დღეებში აყვანილთათვის კი 3 %-ით გაზრდა. თანამშრომელთა
-- რელაციიდან ეკრანზე იყოს გვარები, ძველი ხელფასები, სამსახურში აყვანის თარიღის
-- შესაბამისი კვირის დღის დასახელება და ახალი ხელფასები (მეასედებამდე სიზუსტით
-- დამრგვალებული). მონაცემები მოაწესრიგეთ ახალი ხელფასების კლებით.

select last_name, salary "old salary", to_char(hire_date, 'fmDay'),
 case to_char(hire_date, 'fmDay')
 when 'Monday' then salary * 1.10
 when 'Tuesday' then salary * 1.08
 when 'Wednesday' then salary * 1.12
 else salary * 1.03
 end "new salary"
from hr.employees;

-- PRODUCT_INFORMATION ცხრილში ჩამოთვლილია პროდუქტები, რომლებიც შეკვეთილია,
-- დაგეგმილია, მოძველებულია ან მუშავდება. თქვენ მოგიწევთ მოამზადოთ ანგარიში, რომელიც
-- დააჯგუფებს შეუკვეთავ პროდუქტებს მათი PRODUCT_STATUS–ით და აჩვენებს თითოეულ
-- ჯგუფში პროდუქციის რაოდენობას და პროდუქტების LIST_PRICE ჯამს ჯგუფზე. გარდა ამისა,
-- მხოლოდ იმ ჯგუფის ასახვა უნდა იყოს ნაჩვენები ეკრანზე, სადაც LIST_PRICE-ის ჯამი 4000
-- დოლარია ან 4000-ზე მეტია. პროდუქტი შეუკვეთავია, თუ PRODUCT_STATUS მნიშვნელობა არ
-- არის სტრიქონის orderable ტოლი. დაალაგეთ თითოეულ ჯგუფში პროდუქციის რაოდენობის
-- ზრდის მიხედვით.

select count(PRODUCT_STATUS) "product sum", sum(LIST_PRICE) "price sum"
from oe.PRODUCT_INFORMATION
group by PRODUCT_STATUS
having sum(LIST_PRICE) >= 4000
order by sum(LIST_PRICE)

-- თქვენ მოგიწევთ შეადგინოთ რეპორტი, რომელიც მოიცავს მომხმარებელთა ინფორმაციას
-- რომლებმაც შეიძინეს პროდუქტები, რომელთა ფასი 1000 დოლარზე მეტია. ანგარიში უნდა

-- შეიცავდეს მომხმარებლის სახელებს და გვარებს, პროდუქტის დასახელებას, და მათი list price-
-- ებს. მომხმარებლის ინფორმაცია ინახება CUSTOMERS ცხრილში, რომელსაც პირველად

-- გასაღებად აქვს CUSTOMER_ID სვეტი. პროდუქტის დასახელება და list price დეტალები ინახება
-- PRODUCT_INFORMATION ცხრილში, პირველადი გასაღები PRODUCT_ID სვეტია. შეკვეთის
-- თარიღი ORDERS ცხრილიდან, რომელიც ინახავს CUSTOMER_ID და ORDER_ID ინფორმაციას
-- და UNIT_PRICE-ები ORDER_ITEMS ცხრილიდან, რომელიც ინახავს PRODUCT_ID
-- მნიშვნელობებს, რომლებიც ასოცირდება თითოეულ ORDER_ID- თან.

select c.CUST_FIRST_NAME, c.CUST_FIRST_NAME, p.PRODUCT_NAME, p.list_price,o.ORDER_DATE,
oi.UNIT_PRICE
from oe.orders o, oe.customers c, oe.PRODUCT_INFORMATION p, oe.ORDER_ITEMS oi
where p.PRODUCT_ID = oi.PRODUCT_ID and
c.CUSTOMER_ID = o.CUSTOMER_ID and
o.ORDER_ID = oi.ORDER_id and
p.list_price > 1000