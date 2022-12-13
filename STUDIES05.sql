-----------------------------------------JOINS----------------------------------------------------
--1.INNER JOIN: Common (ortak)data verir. 
--2.LEFT JOIN: Birinci table ın tüm datasını verir
--3.RIGHT JOIN: İkinci table ın tüm datasını verir.
--4.FULL JOIN: İki table ın da tüm datasını verir.
--5. SELF JOIN: Tek table üzerinde çalışırken, iki table varmış gibi çalışılır. 
CREATE TABLE orders
( company_id char(3),
 order_id char(3),
 order_date date
);
INSERT INTO orders VALUES (101,11,'17-Apr-2020');
INSERT INTO orders VALUES (102,22,'18-Apr-2020');
INSERT INTO orders VALUES (103,33,'19-Apr-2020');
INSERT INTO orders VALUES (104,44,'20-Apr-2020');
INSERT INTO orders VALUES (105,55,'21-Apr-2020');
select * from orders;
select * from mycompanies;
CREATE TABLE mycompanies
(company_id char (3),
 company_name varchar(10)
);
INSERT INTO mycompanies VALUES (100,'IBM');
INSERT INTO mycompanies VALUES (101,'GOOGLE');
INSERT INTO mycompanies VALUES (102,'MICROSOFT');
INSERT INTO mycompanies VALUES (103,'APPLE');

--INNER JOIN
--Ortak company ler için company_name, order_id,order_date degerlerini cagırınız
SELECT company_name,order_id,order_date FROM  mycompanies a INNER JOIN orders b
ON a.company_id=b.company_id;

--LEFT JOIN
--mycompanies table ımdaki company ler için order_id ve order_date degerlerini çağırınız
SELECT company_name,order_id,order_date FROM mycompanies m LEFT JOIN orders o
ON m.company_id=o.company_id;

--RIGHT JOIN
--Order table daki companyler için company_name,company_id ve order_date degerlerini çağırın
SELECT o.company_id,mc.company_name,o.order_date FROM mycompanies mc RIGHT JOIN orders o 
ON o.company_id=mc.company_id;

--FULL JOIN
--Iki tabledan da company_name, order_id ve order_date degerlerini cağırınız
SELECT company_name, order_id, order_date FROM orders o FULL JOIN mycompanies mc
ON o.company_id=mc.company_id;

--SELF JOIN
CREATE TABLE workerss
(
id char(2),
name varchar (20),
title varchar (20),
manager_id char(2)
);
INSERT INTO workerss VALUES (1,'Ali Can','SDET',2);
INSERT INTO workerss VALUES (2,'John Walker','QA',3);
INSERT INTO workerss VALUES (3,'Angie Star','QA LEAD',4);
INSERT INTO workerss VALUES (4,'Amy Sky','CEO',5);
SELECT * FROM workerss;
--workerss tablosunu kullanarak çalışanların yöneticilerini gösteren bir tablo hazırlayınız
SELECT employee.name, manager.name FROM workerss employee INNER JOIN workerss manager
ON employee.manager_id=manager.id;

											------------------ALTER TABLE-------------------
--1. Field (Sütun)ekleme
ALTER TABLE workerss
ADD company_industry varchar(20);

--2.Default (varsayılan) deger iel sütun ekleme
ALTER TABLE workerss
ADD worker_address varchar(80);

ALTER TABLE workerss
ADD workrs_address varchar(80) DEFAULT 'FL USA';

--3.Çoklu Field Ekleme
ALTER TABLE workerss
ADD COLUMN num_of_workers char(5) DEFAULT 0,
ADD COLUMN name_of_ceo varchar(20);

--4.Field nasıl kaldırılır
ALTER TABLE workerss
DROP COLUMN worker_address;

--5.Field nasıl adlandırılır?
ALTER TABLE workerss
RENAME COLUMN company_industry TO company_profession;

--6.Table nasıl yeniden adlandırılır?
ALTER TABLE workerss
RENAME TO employeess;

--7.Field nasıl modifiye edilir? (constraint ekleme, data tipi değiştirme, data kapasite değiştirme)
--constraint eklerken mevcut data tipine dikkat edilmelidir

ALTER TABLE employeess
ALTER COLUMN num_of_workers SET NOT NULL;   --NOT NULL constraint ekleme, not null u constraint saymıyor

SELECT * FROM employeess

ALTER TABLE employeess         --UNIQUE CONSTRAINT ekleme
ADD CONSTRAINT cpuq UNIQUE (company_profession);

--!!! Mevcut veri duplicate (tekrarlı) ise UNIQUE CONSTRAIT eklenemez.

--8.Data tipi, boyutunu değiştirme
ALTER TABLE employeess
ALTER COLUMN company_profession TYPE CHAR(5);

--!!! Belirlediğimiz yeni data tipi kapasitesi, deger için uygun değilse hata alırız.Sütunun data boyutu, içindeki degere eşit/fazla olmalıdır

-----------------------------------------------------------FUNCTIONS-----------------------------------------------
--Bazı görevleri daha hızlı yapabilmek için function oluşturulur.
--CRUD operation için function oluşturulabilir.

--SQL de her function, return type olarak bir data verir.
--Return type olarak data vermeyen işlemlere "procedure" denir

CREATE OR REPLACE FUNCTION addf(x NUMERIC,y NUMERIC) --Bu fonksiyonu oluştur ya da üzerine yaz
RETURNS NUMERIC   --returns sondaki s yi unutma
LANGUAGE plpgsql  --procedural language postgre sql dilini kullandığını belirt
AS                --şeklinde yap
$$                --dolar işaretini parantez gibi düşünelim
BEGIN             --başla
RETURN x+y;       --işlemi tanımla
END               --bitir
$$                --parantez görevindeki işaretle bitir

SELECT * FROM addf(2,3); --işlemi göster





































