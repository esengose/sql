--DISTINCT CLAUSE--TEKRARLI VERİLERİN YALNIZCA BİRİNCİSİNİ ALIR

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');
--Musteri ürün tablosundan ürün isimlerini tekrarsız grup halde listeleyiniz
--GROUP BY COZUMU
SELECT urun_isim FROM musteri_urun
GROUP BY urun_isim
--DISTINCT COZUMU
SELECT DISTINCT urun_isim
FROM musteri_urun
-- Tabloda kac farkli meyve vardir ?
SELECT urun_isim, count(urun_isim) FROM musteri_urun
GROUP BY urun_isim
-- FETCH NEXT () ROW ONLY / OFFSET / LIMIT
-- Musteri urun tablosundan ilk uc kaydi listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY;
-- LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT(3);
-- Musteri urun tablosundan ilk kaydi listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id DESC
LIMIT(3);

CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

--EN YÜKSEK MAASI ALANI GETİR
SELECT * FROM maas ORDER BY maas DESC limit 1;

--EN YÜKSEK İKİNCİ MAAŞI LİSTELEYİNİZ
SELECT * FROM maas ORDER BY maas DESC LIMIT 1 OFFSET 1;

--YA DA 
SELECT * FROM maas ORDER BY maas DESC 
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--> SATIR ATLAMAK ISTEDIGIMIZDE OFFSET KOMUTU KULLANIRIZ

/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */

-- DDL --> ALTER TABLE
drop table personel -- Tabloyu ortadan kaldırmak için kullanılır
 CREATE TABLE personell  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pky PRIMARY KEY (id)
);
INSERT INTO personell VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personell VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personell VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personell VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personell VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personell VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personell VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
SELECT * FROM personell
-- 1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personell;
add zipcode varchar(30)
ALTER TABLE personell;  
ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak oluşturduğumuz sütüna belirttiğimiz veriyi tüm satırlara girer
-- DDL --> ALTER TABLE
drop table personel -- Tabloyu ortadan kaldırmak için kullanılır
--2) drop tablodan sütun silme
alter table personel 
drop column zipcode

alter table personel
drop adres, drop sirket -- iki sütun birden silindi

--3) rename column sütun adı değiştirme
alter table personel
rename column sehir to il

--4) rename tablonun ismini değiştirme
alter table personel
rename to isci

--5) type/set sütunlarının özelliklerini değiştirme
alter table isci
alter column il type varchar (30),

alter column maas set not null;

/*
Eğer numerik data türüne sahip bir sütunun data türüne string bir data türü atamak istersek
TYPE varchar(30) USING(maas::varchar(30)) bu formatı kullanırız
*/
ALTER COLUMN maas
TYPE int USING(maas::varchar(30))

/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
 */

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;





