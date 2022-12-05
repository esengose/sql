CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);
select * from ogrenciler3
-- İsmi Mustafa Bak ve Nesibe Yılmaz olan kayıtları silelim
--LETE FROM ogrenciler3 WHERE isim='Mustafa Bak'or isim= 'Nesibe Yılmaz';
--Veli ismi Hasan oaln datayı silelim
--LETE FROM ogrenciler3 WHERE  veli_isim='Hasan';
--UNCATE TABLE ogrenciler3;
--ON DELETE CASCADE
DROP TABLE if exists

CREATE TABLE talebelerr
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlarr(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebelerr(id)
on delete cascade --bunu kullanmazsak silmek istediğim datayı, child dan silmeden parentten silemem.
	--on delete cascade, silmek istediğim datayı child dan da, parenttan da siler.
);
INSERT INTO talebelerr VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebelerr VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebelerr VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebelerr VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebelerr VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO notlarr VALUES ('123','kimya',75);
INSERT INTO notlarr VALUES ('124', 'fizik',65);
INSERT INTO notlarr VALUES ('125', 'tarih',90);
INSERT INTO notlarr VALUES ('126', 'Matematik',90);

select * from talebelerr;
select * from notlarr;

--notlarr tablosundan id si 123 olanı silelim
DELETE FROM notlarr WHERE talebe_id='123';

--IN CONDITION

DROP TABLE if exists musteriler;
CREATE TABLE musteriler  (
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler;

--Musteriler tablosundan urun ismi apple, orange veya apricot olanları listeleyiniz

SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';
--IN CONDITION
SELECT * FROM musteriler WHERE urun_isim IN('Orange','Apple','Apricot');

--NOT IN --> yazdığımız verilerin dışındaki verileri getir.
SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange','Apple','Apricot');

--BETWEEN CONDITION
SELECT * FROM musteriler WHERE urun_id>=20 and urun_id<=40;
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 and 40;

--SUBQUERIES(ALT SORGU)
--Iki tablodan gecici olarak tek bir tabloda sorgulama--> sorgu icinde sorgu
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
CREATE TABLE markalar (
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
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
select * from calisanlar2;
select * from markalar;
-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve
--bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim,maas, isyeri FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);
--marka id si 101 den büyük olan marka çalışanlarının isim,maaş ve şehirlerini listeleynz
SELECT isim,maas,sehir FROM calisanlar2
WHERE isyeri IN(SELECT marka_isim FROM markalar WHERE marka_id>101);

--AGGREGIATE METHODLAR
SELECT max (maas) FROM calisanlar2;
SELECT max(maas) AS maksimum_maas FROM calisanlar2;
/*
    Eger bir sutuna gecici olarak bir isim vermek istersek AS komutunu yazdiktan sonra
vermek istediginiz ismi yazariz.
*/
-- Calisanlar tablosundan en dusuk maasi listeleyelim
SELECT min(maas) AS en_dusuk_maas FROM calisanlar2;
-- Calisanlar tablosundaki maas'larin toplamini listeleyiniz
SELECT sum(maas) AS toplam_maas FROM calisanlar2;
-- Calisanlar tablosundaki maas'larin ortalamasini listeleyiniz
SELECT avg(maas) FROm calisanlar2;
SELECT round (avg(maas),2) FROM calisanlar2; --maaş ortalaması
--maaş sayısını belirtiniz
SELECT count (*) FROM calisanlar2;
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
select * from calisanlar2;
select * from markalar;
SELECT marka_id,marka_isim,
(SELECT count(sehir) as sehir_sayisi FROM calisanlar2 WHERE marka_isim=isyeri)
FROM markalar;

--  Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
--  toplam maaşini listeleyiniz

