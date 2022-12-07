CREATE TABLE workers
(worker_id smallint,
 worker_name varchar (50),
 worker_salary int,
 CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)
);
SELECT * FROM workers;

INSERT INTO workers VALUES (101, 'Ali Can', 12000);
INSERT INTO workers VALUES (102, 'Veli Han', 12000);
INSERT INTO workers VALUES (103, 'Ayşe Kan', 7000);
INSERT INTO workers VALUES (104, 'Angie Ocean', 8500);

--VeliHanın salary degerini, en yüksek salary değerinin %20 düşüğüne yükseltin

UPDATE workers
SET worker_salary = (SELECT MAX(worker_salary) * 0.8 FROM workers )
WHERE worker_id =102;

--AliCanın salary degerini, en düşük salary degerinin %30 fazlasına düşürün
UPDATE workers
SET worker_salary = (SELECT MIN(worker_salary) * 1.3 FROM workers)
where worker_id=101;

--Ortalama salary değerinden düşük salary değerlerini 1000 artırınız

UPDATE workers
SET worker_salary = worker_salary+1000
WHERE worker_salary<(SELECT AVG(worker_salary) FROM workers)

select * from workers

--Ortalama salary degerinden düşük salary degerlerine ortalam salary degeri atayın
UPDATE workers
SET worker_salary = (SELECT AVG(worker_salary) FROM workers)
WHERE worker_salary < (SELECT AVG(worker_salary) FROM workers)

-- IS NULL CONDITION
CREATE TABLE people
(ssn char(9),
 name varchar(50),
 adress varchar (80)
 );
 
INSERT INTO people VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES (345678901, 'Marry Tien', 'New Jersey');
INSERT INTO people (ssn, adress)VALUES (456789012, 'Michigan');
INSERT INTO people (ssn, adress)VALUES (567890123, 'California');
INSERT INTO people (ssn, name) VALUES (567890123, 'California');
select * from people;
--null name degerlerini to be inserted later degerine güncelleyiniz
UPDATE people
SET name = 'To be inserted later'
WHERE name IS NULL

--null adres degerlerini to be inserted later degerine güncelleyiniz
UPDATE people
SET adress = 'To be inserted later'
WHERE adress IS NULL

--Bir table dan bir record nasıl silinir
DELETE FROM people
WHERE ssn = '234567890';

--İsimsiz recordları siliniz
DELETE FROM people
WHERE name= 'To be inserted later';

--Tüm recordları sil

--DELETE COMMAND SADECE RECORDLARI SİLER, TABLOYU YOK ETMEZ
DELETE FROM people;
DROP TABLE IF EXISTS people;

--name ve adres degerleri null olan recordları siliniz
DELETE FROM people
WHERE name IS NULL OR adress IS NULL;
select * from people;

--ssn değeri 123456789 dan büyük 345678901 den küçük olan recordları siliniz
DELETE FROM people
WHERE ssn > '123456789' AND ssn<'345678901'; --tırnak işareti koymazsam arithmatic / logic opr. kullanamıyorum

--name degeri null olmayan tüm recordları siliniz
DELETE FROM people
WHERE name IS NOT NULL;

--TRUNCATE TABLE, GERİ DÖNDÜRÜLEMEYECEK ŞEKİLDE TÜM RECORDLARI SİLER, DELETE ile KISMEN AYNI İŞLEMİ YAPAR.
--DELETE komutunda filtrelemek için WHERE CLAUSE kullanılabilir FAKAT TRUNCATE komutunda kullanılamaz
--DELETE komutunda sildiğimiz recordları geri çağırabiliriz fakat TRUNCATE komutunda geri çağrılamaz
--ROLLBACK) YAPILAMAZ

--SCHEMA(ŞEMA) DAN TABLE NASIL KALDIRILIR?
DROP TABLE people;
DROP TABLE workers;

--DQL--> DATA QUERY LANGUAGE DATA OKUMAK İÇİN KULLANILAN DİL

CREATE TABLE workers
(id SMALLINT,
 name VARCHAR(50),
 salary SMALLINT,
 CONSTRAINT id4_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES (10001, 'Ali Can', 12000);
INSERT INTO workers VALUES (10002,'Veli Han', 2000);
INSERT INTO workers VALUES (10003, 'Mary Star', 7000);
INSERT INTO workers VALUES (10004, 'Angie Ocean', 8500);
select * from workers;

--Spesifik bir sütun nasıl çağrılır?
SELECT name FROM workers;

--Spesifik çklu fieldlar nasıl çağrılır?
SELECT name, salary FROM workers;

--Spesifik bir record nasıl çağırılır?
SELECT * FROM WORKERS
WHERE id= 10001;

--Çoklu spesifik record lar nasıl çağrılır?

SELECT * FROM workers
WHERE id < 10003;

--Salary degerleri 2000,7000 ya da 12000 olan record ları çağrınız

SELECT * FROM workers
WHERE salary IN(2000,7000,12000);  --OR KULLANMANIN PRATİK HALİ

SELECT name FROM workers
WHERE id=10002;

--EN yüksek değeri olan record ı çağırınız
SELECT * from workers
WHERE salary = (SELECT MAX(SALARY) FROM workers);

--En düşük salary degeri olan name i çağırınız
SELECT name FROM workers
WHERE salary = (SELECT MIN(salary) FROM workers);

--En düşük ve en büyük salary degerlerine sahip recordları çağıralım
SELECT * FROM workers
WHERE salary IN ((SELECT MAX (salary) FROM workers), (SELECT MIN (salary) FROM workers));

--"As" keywordu kullanarak konsola geçici fiel oluşturulabilir (temporary)
SELECT MAX (salary) AS maximum_salary 
FROM workers;

SELECT MIN (salary) AS minimum_salary
FROM workers;

--Salary ortalamasını bulun
SELECT AVG (salary) AS avarage_salary
FROM workers;

--Record adedini/miktarını bulunuz
SELECT COUNT(name) AS number_ofWorkers
FROM workers;

--Salary degerinin toplamını bulunuz
SELECT SUM (salary) AS sum_OfSalry
FROM  workers;

--COMMON INTERVIEW QUESTİON
--En yüksek ikinci salary degerini bulunuz
SELECT MAX (salary) FROM workers
WHERE salary < (SELECT MAX (salary) FROM workers);

--COMMON INTERVIEW QUESTION
--En düşük ikinci salary degerini veriniz
SELECT MIN (salary) FROM workers
WHERE salary > (SELECT MIN (salary) FROM workers);

--En yüksek üçüncü salary degerini bulunuz
SELECT MAX (salary) AS third_max_salary FROM workers
WHERE salary < (SELECT MAX (salary) FROM workers 
				WHERE salary < (SELECT MAX( salary) FROM workers));

--En düşük üçüncü salary yi çağırınız
SELECT MIN (salary) AS third_min_salary FROM workers
WHERE salary> (SELECT MIN( salary) FROM workers 
			   WHERE salary > (SELECT MIN (salary) FROM workers));

--Salary degeri en yüksek ikinci değere sahip olan recordu çağırın  --1.yol
SELECT * FROM workers
WHERE salary=( SELECT MAX (salary) FROM workers
WHERE salary < (SELECT MAX (salary) FROM workers));

----- procedural -- 2.yol
SELECT * FROM workers
ORDER BY salary DESC    --Büyükten küçüğe sıralarım
OFFSET 1 ROW --1 satır atla derim,
FETCH NEXT 1 ROW ONLY; --Yalnızca 1 satırı al derim

--Salary degeri en küçük ikinci degeri getirin.
SELECT * FROM workers
ORDER BY salary
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--Salary degeri en yüsek 3.degerin verilerini getiriniz  --1yol hatırlayalım:
 SELECT * FROM workers
 WHERE salary= (SELECT MAX (salary) from workers
				where salary<(SELECT MAX (salary) from workers
							  where salary< (SELECT MAX (salary) from workers)));
 
						 
							 --2.yol (recommended)

SELECT * FROM workers
ORDER BY salary desc
OFFSET 2 ROWS
FETCH NEXT 1 ROW ONLY;

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
--Product name degeri orange, apple ve palm olan recordları cağırınız
SELECT * from customers_products 
WHERE product_name IN('Orange', 'Apple','Palm');  --p.name=orange or apple or palm

--Product name degeri orange, apple ve palm olmayan recordları cağırınız
SELECT * from customers_products 
WHERE product_name NOT IN ('Orange', 'Apple','Palm');

--BETWEEN CONDITION
--Product id si 30 dan küçük veya eşit VE 20 den büyük eşit recordları çağırınız
SELECT * FROM customers_products
WHERE product_id  BETWEEN '20' AND '30';

--Product id değeri 20 den küçük 25 ten büyük olan recordları çağırınız
SELECT * FROM customers_products
WHERE product_id NOT BETWEEN '20' AND '30';

--EXIST CONDITION- subquery ile kullanılır
-- Eğer Subquery herhangi bir data çağırırsa 'Outer Query' çalıştırılır
--Eğer Subquery herhangi bir data çağırmazsa 'Outer Query' çalıştırılmaz


































