--EXISTS CONDITION-- subquery ile kullanılır, eger subquery herhangi bir data çağırırsa 
--outer query yani üstteki çağırdığımız query çalıştırılır. Eğer subquery herhangi bir data çağırmazsa outer
--query geçersiz olur, çalıştırılmaz.
--EXISTS condition SELECT, INSERT, UPDATE, DELETE komutlarında kullanılabilir

CREATE TABLE customers_products
(product_id CHAR(10),
 customer_name VARCHAR(50),
 product_name VARCHAR(50)
 );
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy',  'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adam', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple');

select * from customers_products;

--Customers name arasınd Eddie varsa onu no name olarak güncelle
UPDATE customers_products
SET customer_name = 'no name'
WHERE EXISTS (SELECT product_name FROM customers_products WHERE customer_name='Eddie');
			--burda ne yazdığı önemlid eğil, data verip vermediği önemli

DROP TABLE customers_products

CREATE TABLE customers_likes
(product_id CHAR(10),
 customer_name VARCHAR(50),
 liked_product VARCHAR(50)
 );
INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary',  'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adam', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

select * from customers_likes
DROP TABLE customers_likes

--ürünler arasında orange, pinapple ya da avocado varsa name degerlerini no name yapınız
UPDATE customers_likes
SET customer_name = 'no name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE liked_product IN('Orange','Pineapple','Avocado'));
				--burada bir deger verip vermediğini kontrol ederiz, deger veriyorsa, üstteki de çalışır

--customer_name degerleri arasında orange olan recordları siliniz
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product='Orange');

--------------------------------------------SUBQUERY--------------------------------------------

CREATE TABLE employees
(
id char(9),
name varchar(50),
state varchar(50),
salary smallint,
company varchar(20)
);
INSERT INTO employees VALUES (123456789, 'John Walker','Florida',2500,'IBM');
INSERT INTO employees VALUES (234567890, 'Brad Pitt','Florida',1500,'APPLE');
INSERT INTO employees VALUES (345678901, 'Eddie Murphy','Texas',3000,'IBM');
INSERT INTO employees VALUES (456789012, 'Eddie Murphy','Virginia',1000,'GOOGLE');
INSERT INTO employees VALUES (567890123, 'Eddie Murphy','Texas',7000,'MICROSOFT');
INSERT INTO employees VALUES (456789012, 'Brad Pitt','Texas',1500,'GOOGLE');
INSERT INTO employees VALUES (123456710, 'Mark Stone','Pennsylvania',2500,'IBM');
Select * from employees
 
CREATE TABLE companies
(compnay_id char(9),
 company varchar(50),
 number_of_employees smallint
);
INSERT INTO companies VALUES (100,'IBM',12000);
INSERT INTO companies VALUES (101,'GOOGLE',18000);
INSERT INTO companies VALUES (102,'MICROSOFT',10000);
INSERT INTO companies VALUES (103,'APPLE',21000);

SELECT * FROM companies;

--number_of_employees degeri 15000 den büyük olan name ve company degerlerini çağırın
SELECT name, company FROM employees
WHERE company IN(SELECT company FROM companies
				WHERE number_of_employees > 15000);
				
--florida da bulunan company_id ve company degerlerini giriniz
SELECT compnay_id, company FROM companies
WHERE company IN (SELECT company FROM employees WHERE state = 'Florida');

--company id degeri 100den büyük olan name ve state degerlerini çağırın
SELECT name, state, company FROM employees
WHERE company IN (SELECT company FROM companies WHERE compnay_id>'100');

--her bir company için company, number_of_employees ve ortalama salary degerlerini bulunuz

SELECT company, number_of_employees, (SELECT AVG(salary)FROM employees
									 WHERE companies.company=employees.company) AS avg_maas
FROM companies

--her bir company için, company_id, en yüksek ve en düşük salary degerlerini bulunuz
SELECT compnay_id,company,(SELECT MAX(salary) FROM employees WHERE companies.company=employees.company)
				   AS max_salary,
				  (SELECT MIN(salary) FROM employees WHERE companies.company=employees.company)
				   AS min_salary
FROM companies

----------------------------- LIKE ----------------------------------------
--Like Condition: WildCard ile kullanılır.
--1. % Percentage Wildcard: Sıfır yada daha fazla karakteri temsil eder

--'E' ile başlayan employee name degerlerini çağırınız
SELECT name FROM employees WHERE name LIKE 'E%';
--'e' ile biten name dgerini çağırınz
SELECT name FROM employees WHERE name LIKE '%e';
--'B' ile başlayıp 't' ile biten name degerlerini giriniz
SELECT name FROM employees WHERE name LIKE 'B%t';
--Herhangi bir yerinde a bulunan name degerlerini bulunuz
SELECT name FROM employees WHERE name LIKE '%a%';
--Herhangi bir yerinde e veya r bulunan name degerlerini bulunuz
SELECT name FROM employees WHERE name LIKE '%e%r%';


--2. _ Wildcard : Tek karakteri temsil eder.

--İkinci karakteri e ve 4. karakteri n olan statte degerlerini bçağırınız
SELECT state FROM employees
WHERE state LIKE '_e_n%';

--Sondan ikinci karakteri i olan state degerlerini çağırınız
SELECT state FROM employees
WHERE state LIKE '%i_';

--ikinci karakteri 'e' olan ve en az 6 karakteri bulunan state degerlerini çağırınız
SELECT state FROM employees
WHERE state LIKE '_e____%';

--ikinci karakterinden sonra herhangi bir yerinde i bulunan state degerlerini çağırınız
SELECT state FROM employees
WHERE state LIKE '__%i%';


CREATE TABLE words
(word_id char(10) UNIQUE,
 word varchar(50) NOT NULL,
 number_of_letters smallint
 );
 
INSERT INTO words VALUES (1001,'hot',3);
INSERT INTO words VALUES (1002, 'hat',3);
INSERT INTO words VALUES (1003, 'hit',3);
INSERT INTO words VALUES (1004,'hbt',3);
INSERT INTO words VALUES (1008, 'hct',3);
INSERT INTO words VALUES (1005, 'adem',4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf',5);

SELECT * FROM words;

--NOT LIKE CONDITION -- LIKE GIBI SYNTAX FAKAT ONUN GIBI OLMAYANLARI CAGIRIR
--Herhnagi bir yerinde h bulunmayan word degerlerini cağırınız
SELECT word FROM words WHERE word NOT LIKE '%h%';

--t veya f ile bitmeyen word degerlerini cağırınız
SELECT word FROM words WHERE word NOT LIKE '%t' AND word NOT LIKE '%f';

--herhangi bir karakterle başlayıp a veya e ile devam etmeyen word degerlerini yazınız
SELECT word FROM words WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';

-------------------- REGULAR EXPRESSION CONDITION-------------
--ilk karakteri h, son karakteri t ve ikinci karakteri o, a veya i olan word degerlerini 
--cağırınız.  1.  LIKE ILE:
 SELECT word FROM words WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'hi%t';
--			2.YOL REGEX ILE
 SELECT word FROM words WHERE word ~ 'h[oai](.*)t';--
							   --oai den sonra .tek veya daha çok* karakter gelebilir

--il karakteri h, son karakteri t ve ikinci karakteri a an e ye herhangi bir karakter 
--olan word degerlerini çağırınız
SELECT word FROM words WHERE word ~ 'h[a-e](.*)t'; --abcde karakterlerini kapsar

--ilk karakteri, s, a veya y olan word degerlerini çağırınız
SELECT word FROM words WHERE word ~ '^[say](.*)'; --şapka işareti ilk harf olsun demek

--son karakteri m,a veya f olan word degerlerini çağırınız
SELECT word FROM words WHERE word ~'(.*)[maf]$';

--ilk karakteri s ve son karakteri a olan word degerlerini bulunuz
SELECT word FROM words WHERE word ~'s(.*)a'; -- 

--rhangi bir yerinde a olan word degerlerini bulunuz
SELECT word FROM words WHERE word ~ 'a';

--ilk karakteri d ten t ye olan, herhangi bir karakterle devam edip üçüncü karakteri
--l olan word degerlerini bulunuz
SELECT word FROM words WHERE word ~ '^[d-t].l';

--ilk karakteri d ten t ye olan, herhangi iki karakterle devam edip dördüncü karakteri e
-- olan word degerlerini bulunuz
SELECT word FROM words WHERE word ~ '^[d-t]..e';

CREATE TABLE workers
(
id char(9),
name varchar(50),
state varchar(50),
salary smallint,
company varchar(20)
);
INSERT INTO workers VALUES  (123456789, 'John Walker','Florida',2500,'IBM');
INSERT INTO workers VALUES (234567890, 'Brad Pitt','Florida',1500,'APPLE');
INSERT INTO workers VALUES (345678901, 'Eddie Murphy','Texas',3000,'IBM');
INSERT INTO workers VALUES (456789012, 'Eddie Murphy','Virginia',1000,'GOOGLE');
INSERT INTO workers VALUES (567890123, 'Eddie Murphy','Texas',7000,'MICROSOFT');
INSERT INTO workers VALUES (456789012, 'Brad Pitt','Texas',1500,'GOOGLE');
INSERT INTO workers VALUES (123456710, 'Mark Stone','Pennsylvania',2500,'IBM');

--E ile başlayıp y ile biten name degerleri dışındaki name degerlerini bulunuz
SELECT name FROM workers WHERE name ~ '^[^E](.*)[^y]$';
--köşeli parantez içindeki şapka işareti, o şekilde olmasın, farklı olsun demektir

--J,B YA DA E ile başlayan ve r ya da t ile biten word degerlerini yazınız
SELECT name FROM workers WHERE name ~ '^[JBE](.*)[rt]$';

--J,B YA DA E ile başlayan VEYA r ya da t ile biten word degerlerini yazınız
SELECT name FROM workers WHERE name ~ '^[JBE]' OR name ~ '[rt]$';
 
--J, B, E ile başlamayan ve r ya da t ile de bitmeyen name degerlerini giriniz
SELECT name FROM workers WHERE name ~ '^[^JBE](.*)[^rt]$';

--J, B, E ile başlamayan VEYA r ve t ile  bitmeyen name degerlerini giriniz
SELECT name FROM workers WHERE name ~ '^[^JBE]' OR name ~ '[^rt]$';

--Herhangi bir yerinde a ya da k bulunan name degerlerini bulunuz
SELECT name FROM workers WHERE name ~ '[ak]';

--ilk harfi a dan f ye bir karakter olan ikinci harf hrehangi bri karakter olup üçüncü harf
--a olan name degerlerini çağırınız
SELECT name FROM workers WHERE name ~ '^[A-F].a(.*)';
 
--üçüncü karakteri o yada x olan state degerlerini çağırınız
SELECT state FROM workers WHERE state ~ '..[ox](.*)';
 
--sondan üçüncü karakteri n ya x olan state degerleri bulnz
SELECT state FROM workers WHERE state ~ '(.*)[nx]..';

--sondan üçüncü karakteri n ya x olmayan state degerlerini veriniz
SELECT state FROM workers WHERE state ~ '(.*)[^nx]..';



SELECT * FROM workers









