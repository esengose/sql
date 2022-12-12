--ORDER BY: Recordları artan ya da azalan düzende sıralamak için kullanılır
--ORDER BY sadece SELECT statement ile kullanılır

SELECT * FROM words

--Recordları artan düzende, number of letters a göre diziniz
SELECT * FROM words
ORDER BY number_of_letters; 
--  DEFAULT OLARAK SIRALAMA ascending order, küçükten büyüğe ya da natural order olarak da adlandırılır. 

--Recordları azalan düzende word degerlerine göre sıralayını
SELECT * FROM words
ORDER BY word DESC;  --Azalan sıralamalarda DESC keywordunu yazmak zorunludur.

--NOT: SÜTUN ADI YERİNE SÜTUN NUMARASI İLE DE SIRALAMA YAPILABİLİR
SELECT * FROM words
ORDER BY 3 DESC; -- number_of_letters yerine geçer

CREATE TABLE points
(
name varchar (50),
point smallint	
);
INSERT INTO points VALUES('Ali',25);
INSERT INTO points VALUES('Veli',37);
INSERT INTO points VALUES('Kemal',43);
INSERT INTO points VALUES('Ali',36);
INSERT INTO points VALUES('Ali',25);
INSERT INTO points VALUES('Veli',29);
INSERT INTO points VALUES('Ali',45);
INSERT INTO points VALUES('Veli',11);
INSERT INTO points VALUES('Ali',125);
SELECT * from points

drop table addresses

--Kodları azalan düzende name degerine ve artan düzende point sütununa göre sırala.

SELECT * FROM points
ORDER BY name DESC, point ASC; -- önce ters alfabetik sıralandı, sonra da kendi içinde notlara göre artan sıralama yapıldı

CREATE TABLE employees_
(employee_id char(9),
 employee_firstname varchar(20),
 employee_lastname varchar(20)
);
INSERT INTO employees_ VALUES (14,'Chris','Tae');
INSERT INTO employees_ VALUES (11, 'John', 'Walker');
INSERT INTO employees_ VALUES (12, 'Amy', 'Star');
INSERT INTO employees_ VALUES (13,'Brad','Pitt');
INSERT INTO employees_ VALUES (15,'Chris','Way');
select * from employees_

CREATE table addresses
(
employee_id char(9),
street varchar(20),
city varchar(20),
state char(2),
zipcode char(5)
);
INSERT INTO addresses VALUES (11,'32nd Star 1234','Miami','FL',33018);
INSERT INTO addresses VALUES (12,'23rd Rain 567', 'Jacksonville','FL',32256);
INSERT INTO addresses VALUES (13,'5th Snow 765','Hialeah','VA',20121);
INSERT INTO addresses VALUES (14, '3rd Man 12', 'Weston', 'MI',12345);
INSERT INTO addresses VALUES (15, '11th Chris 12','St. Johns','FL',32259);
select * from addresses
--ALIASES
--Table isimleri için aliases nasıl kullanılır?

--employee first name ve state degerlerini çağırın. employee first name sütunu için firstname, state için employeestate denmeli
SELECT employee_firstname AS firstname, state AS employee_state
FROM employees_,addresses
WHERE employees_.employee_id=addresses.employee_id;

--Tek bir sütuna çoklu sütun nasıl konulur, Alias nasıl kullanılır?

--employee_id degerlerini id adıyla, employee firstname ve lastname degelreini fullname adıyla çağırınız
SELECT employee_id AS id, employee_firstname || ' ' ||employee_lastname AS full_name
FROM employees_;

--NOT: Alt çizgi-underscore kullanmak istemiyorsak iki kelimelik degerleri çift tırnak içine alabliriz

--------------------------------------------GROUP BY-----------------------------------
SELECT * FROM workers

--Her bir name için toplam salary degerini bulalım
SELECT name, SUM(salary) AS "total salary" FROM workers
GROUP BY name
ORDER BY "total salary" DESC;

--Her bir state degeri için çalışan sayısını bulup azalan düzeyde sıralayınız
SELECT state, COUNT(*) AS "num of employee" FROM workers
GROUP BY state
ORDER BY "num of employee" DESC;


--Her bir company için 2000$ üzeri maaş alan çalışan sayısını bulalım
SELECT company, COUNT (name) AS calisan_sayisi FROM workers
WHERE salary>2000
GROUP BY company;

--Her bir company için en düşük ve en yüksek salary degerlerini bulunuz
SELECT company, MIN(salary) AS "minimum salary", MAX(salary) AS "maximum salary" FROM workers
GROUP BY company;

---------------------------------------HAVING CLAUSE--------------------------------------------------------
--NOT: GRUPLAMADAN SONRA WHERE KULLANAMIYORUZ, BUNUN YERİNE HAVİNG CLAUSE KULLANILMAKTADIR

--Toplam salary degeri 2500 üzeri olan her bir çalışan için salary toplamını bulunuz
SELECT name, SUM(salary) AS "total salary" FROM workers
GROUP BY name
HAVING SUM(salary)>2500;  -- OLMASI GEREKEN CEVAP
--WHERE İLE BU SORU NEDEN OLMAZ?
SELECT name, SUM(salary) AS "total salary" FROM workers
WHERE SUM(salary)>2500   --!!!! AGGREGIATE FUNCTIONS WHERE İLE KULLANILAMAZ!! WHERE ile field name kullanılır (SUM,MIN,MAX,COUNT,AVG)
GROUP BY name
  --GROUP BY ardından WHERE kullanılmz, HAVING kullanılır
  
  
  --Birden fazla çalışanı olan her bir state için çalışan toplamlarını bulunuz
  SELECT * FROM workers
  SELECT state, COUNT(state) AS "num of employees" FROM workers
  GROUP BY state
  HAVING COUNT(state)>1;
  --NOT: HAVING,GROUP BY ardından filtreleme için kullanılır.
  --NOT: HAVING ardından ALIASES değil, AGGREGATE function kullanmalıyız
  
  
  --Her bir company için degeri 2000den fazla olan mimnum salary degerlerini bulunuz.
  SELECT company, MIN(salary)FROM workers
  WHERE salary>2000
  GROUP BY company					--where ile cozum
  
  SELECT company, MIN (salary) FROM workers
  GROUP BY company
  HAVING MIN(salary)>2000	;		--havıng ile cozum
  
  --Her bir state için degeri 3000 den az olan maximum salary degerlerini bulunuz
  SELECT state, MAX(salary) FROM workers
  GROUP BY state
  HAVING MAX(salary)<3000;
  ----------------------------------------------------UNION OPERATOR-------------------------------------------
  --1. Union, iki query sounucunu birleştirmek için kullanılır.
  --2. Union operator, tekrarsız(unique) recordları verir. 
  --3. Tek bir sütuna çok sütun koyabiliriz
  --4. Tek bir sütuna çok sütun koyarken, data tipleri aynı olmalı ve data boyutları kapasiteyi aşmamalıdır.
  
  --Salary degeri 3000 den yüksek olan state degerleri ve 2000 den küçük olan name degerlerini tekrarsız olarak bulunuz
  SELECT state AS "State/Name", salary FROM workers
  WHERE salary>3000
  UNION
  SELECT name,salary FROM workers
  WHERE salary<2000;
  
--Salary degeri 3000 den yüksek olan state degerleri ve 2000 den küçük olan name degerlerini TEKRARLI olarak bulunuz
SELECT state "State/Name", salary FROM workers
WHERE salary>3000
UNION ALL--> Union ile aynı işi yapar, yalnızca recordları tekrarlı olarak verir
SELECT name,salary FROM workers
WHERE salary<2000;

--INTERSECT OPERATOR: İki query sonucunun ortak degerlerini (common results) verir. Unique tir, tekrarsız recordları döndürür.

--Salary degeri 1000 den yuksek, 2000den az olan ortak name degerlerini bulunuz
SELECT name FROM workers
WHERE salary >1000
INTERSECT
SELECT name FROM workers
WHERE salary<2000;

--Salary degerleri 2000den az olan ve company degeri ıbm apple ya da microsoft  olan ortak name degerlerini bulunuz
SELECT name FROM workers
WHERE salary<2000
INTERSECT
SELECT name FROM workers
WHERE company IN('IBM','APPLE','MICROSOFT');

--EXCEPT OPERATOR: Bir query sounucundan, başka bir sorgu sonucunu çıkarmak için kullanılır. Unique recordları verir. (ORACLE DA MINUS)

--Salary degerleri 3000 den az olan ve google da çalışmayan name degerlerini çağırınız
SELECT name FROM workers
WHERE salary<3000
EXCEPT  --> google da çalışanlar hariç maaşı 3000den az olanları çağırdık
SELECT name FROM workers
WHERE company ='GOOGLE';

-----------------------------------------JOINS----------------------------------------------------
--1.INNER JOIN: Common (ortak)data verir. 
--2.LEFT JOIN: Birinci table ın tüm datasını verir
--3.RIGHT JOIN: İkinci table ın tüm datasını verir.
--4.FULL JOIN: İki table ın da tüm datasını verir.
--5. SELF JOIN: Tek table üzerinde çalışırken, iki table varmış gibi çalışılır. 














