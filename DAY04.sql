CREATE TABLE calisanlar_ (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar_ VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar_ VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar_ VALUES(345678901, 'Mine Bulut', 'Izmir');
 
 select * from calisanlar_;
-- Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
SELECT calisan_id AS id, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar
--2. YOl
SELECT calisan_id AS id, concat (calisan_isim,' ',calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar
-- IS NULL CONDITION
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');
select * from insanlar
-- Name sutununda null olan değerleri listeleyelim
SELECT name FROM insanlar WHERE name IS NULL
-- Insanlar taplosunda sadece null olmayan değerleri listeleyiniz
SELECT name FROM insanlar WHERE name IS NOT NULL
-- Insanlar toplasunda null değer almış verileri no name olarak değiştiriniz
UPDATE insanlar
SET name = 'No name'
WHERE name is null;

--ORDER BY --NATURAL ORDER YAPAR
CREATE TABLE people
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO people VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO people VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO people VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO people VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO people VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--People tablosundaki verileri adreslere göre sıraya diziniz
select * from people ORDER BY adres;   -- adrese göre sırala
select * from people ORDER BY soyisim;  -- soyisme göre sırala
select * from people WHERE isim= 'Mine' ORDER BY ssn; --adı mine olanları ssn ye göre sırala
select * from people WHERE soyisim= 'Bulut' ORDER BY isim;

/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/
--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from people ORDER BY ssn DESC;
--NOT : Order By komutundan sonra field(sutun) ismi yerine field(sutun) numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin 
SELECT * FROM people WHERE soyisim='Bulut' ORDER BY 2
-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
SELECT * FROM people ORDER BY ssn DESC;
-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM people ORDER BY isim ASC, soyisim DESC;
-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eğer sutun uzunluğuna göre sıralamak istersek LENGTH komutu kullanırız 
Ve yine uzunluğu büyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/
SELECT isim,soyisim FROM people ORDER BY LENGTH (soyisim) DESC;
SELECT * FROM people;
--Tüm isim soyisim değerlerini aynı sütunda çağırarak her bir sütun değerini uzunluğuna göre sıralaynz
SELECT isim ||' '||soyisim as isim_soyisim from people ORDER BY LENGTH (isim || soyisim);
SELECT isim ||' '||soyisim as isim_soyisim from people ORDER BY LENGTH (isim)+LENGTH (soyisim);
SELECT CONCAT (isim,' ',soyisim) AS isim_soyisim from people ORDER BY LENGTH (isim)+ LENGTH (soyisim);
SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM people ORDER BY LENGTH (concat(isim,soyisim));

--GROUP BY

/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

--isme göre alınan toplam ürnleri bulun
SELECT isim, sum(urun_miktar)AS aldigi_toplam_urun from manav
GROUP BY isim;
-- isme göre alınan toplam ürünleri büyükten küçüğe sıralayınız
SELECT isim, sum(urun_miktar) AS aldigi_toplam_urun FROM manav
GROUP BY isim
ORDER BY aldigi_toplam_urun DESC;

--ürün ismine göre ürünü alan toplam kişi sayısı
SELECT urun_adi, count(isim)from manav
GROUP BY urun_adi;

