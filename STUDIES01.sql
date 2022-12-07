--Practice Exercise 1:
--Create a table called “suppliers” that stores “supplier_ID”, “name”, address information which
--has “street”, “city”, “state”, and “zip_code” columns separately.
CREATE TABLE suppliers
(supplier_id char(5),
 name varchar(15),
 street varchar(15),
 city varchar(15),
 state varchar(15),
 zip_code char(3)
);
select * from suppliers;


--Practice Exercise 2:
--Create a table called “suppliers_id_name” that stores “supplier ID”, “name” by using “suppliers” table
CREATE TABLE suppliers_id_name
AS SELECT
supplier_id,
name
FROM suppliers;
select * from suppliers_id_name;


--Practice Exercise 3:
--Create a table called “cities” that stores “area code”, “name”, “population”, “state”
--The “area code” will be “primary key”
--Add “primary key” by using first method.
CREATE TABLE cities
(area_code char(5) primary key,
 area_name varchar(10),
 population int,
 area_state varchar(10)
);
select * from cities;


--Practice Exercise 4:
--Create a table called “teachers” that stores “SSN”, “name”, “subject”, “gender”
--The “SSN” will be “primary key”
--Add “primary key” by using second method
CREATE TABLE teachers
( ssn char(7),
 name varchar(15),
 subject varchar(15),
 gender varchar (10),
 CONSTRAINT cns PRIMARY KEY (ssn)
 );
 select * from teachers;
 
 
 --Practice Exercise 5:
--Create a table called “supplier” that stores “supplier_id”, “supplier_name”, “contact_name” and make “supplier_id”
--as primary key.
--Create another table called “products” that stores “supplier_id” and “product_id” and make “supplier_id”
--as foreign key
CREATE TABLE supplier
(supplier_id char(5) PRIMARY KEY,
 supplier_name varchar (20),
 contact_name varchar (20)
 );
 select * from supplier;
 
 CREATE TABLE products
 (supplier_id char(5),
 product_id char(10),
 CONSTRAINT con FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id));
 select * from products;
 
 
 --Practice Exercise 6:
--Create a table called “supplier” that stores “supplier_id”, “supplier_name”, “contact_name” and make the
--combination of “supplier_id” and “supplier_name” as primary key.
--Create another table called “products” that stores “supplier_id” and “product_id” and make the
--combination of “supplier_id” and “supplier_name” as foreign key
CREATE TABLE supplier1
(supplier_id char(5) NOT NULL,
 supplier_name varchar (20) NOT NULL,
 contact_name varchar (20),
 CONSTRAINT cs PRIMARY KEY (supplier_id, supplier_name)
 );
 select * from supplier1;
 
 CREATE TABLE products1
 (supplier_id char(5),
 product_id char(10),
  CONSTRAINT css FOREIGN KEY (supplier_id, product_id) REFERENCES supplier1 (supplier_id, supplier_name)
 );
 select * from products1;
 


 CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'AliCan', 'Hasan',75);
INSERT INTO talebeler VALUES(124,'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125,'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126,'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127,'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

 select * from talebeler;
 select * from notlar;
 select yazili_notu,id from talebeler;
 
 delete from talebeler WHERE id='125';
 
 select * from notlar WHERE ders_adi='Matematik' OR ders_adi='fizik';
 select * from notlar WHERE yazili_notu BETWEEN 60 AND 90;
 select * from notlar WHERE yazili_notu NOT BETWEEN 60 AND 80;
 
 
 CREATE table personel
(
id char(4),
isim varchar(50),
maas int
	);
	
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);
-- Practice 6
-- id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
-- D ile Y arasındaki personel bilgilerini listeleyiniz
-- D ile Y arasında olmayan personel bilgilerini listeleyiniz
--Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
select * from personel WHERE id BETWEEN '1003' AND '1005';
select * from personel WHERE isim BETWEEN 'D' AND 'Y';
select * from personel WHERE isim NOT BETWEEN 'D' AND 'Y';
SELECT * from personel WHERE maas='70000' AND isim='Sena';

CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
select * from calisanlar2;
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
select * from markalar;
-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve
--maaşlarini listeleyin
select isim, maas, isyeri from calisanlar2 WHERE isyeri IN (select marka_isim from markalar
														   WHERE calisan_sayisi>15000);
-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
select isim,maas,sehir from calisanlar2 WHERE isyeri IN (select marka_isim from markalar
														WHERE marka_id>101);
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
select marka_id,calisan_sayisi from markalar WHERE marka_isim IN (select isyeri from calisanlar2 WHERE 
																 sehir='Ankara');
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.												  
select marka_id,marka_isim,(select count(sehir) from calisanlar2 WHERE marka_isim=isyeri )AS sehir_sayisi
from markalar;
-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
 select marka_isim,calisan_sayisi,(select sum(maas) from calisanlar2 WHERE marka_isim=isyeri ) AS toplam_maas
 from markalar;
 -- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen
--bir Sorgu yaziniz.
select marka_isim,calisan_sayisi,(select min (maas) from calisanlar2 WHERE marka_isim=isyeri)AS min_maas
                                  ,(select max (maas)from calisanlar2 WHERE marka_isim=isyeri)AS max_maas
from markalar;

CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
--URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız. 
select urun_id, musteri_isim from mart WHERE exists (select urun_id from nisan 
													 where mart.urun_id=nisan.urun_id);

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
CREATE TABLE urunler -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino)
REFERENCES tedarikciler(vergi_no)
on delete cascade
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');



INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');









