--DDL - DATA DEFINITION LANG.
--CREATE - TABLO OLUŞTURMA

CREATE TABLE ogrenciler2
( 
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(20),
not_ort real,       --double gibi ondalıklı sayılar için kullanılır
kayit_tarih date
);

--VAR OLAN TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE ogrenci_notlari
AS SELECT isim,soyisim,not_ort FROM ogrenciler2; --Benzer tablodaki başlıklar ve data tipleriyle yeni bir tablo
--oluşturmak için normal tablo oluştururken ki parantezler yerine AS kullanıp Select komutuyla
--almak istediğimiz verileri alırız

--DML DATA MANIPULATION LANG.
--INSERT (Database e veri ekleme)
INSERT INTO ogrenciler2 VALUES (1234567,'Said','Ilhan',85.5,now());
INSERT INTO ogrenciler2 VALUES (1234567,'Said','Ilhan',85.5,'2020-12-11');

--TABLOYA PARÇALI VERİ EKLEME
INSERT INTO ogrenciler2 (isim,soyisim)VALUES ('Erol','Evren');

-- DQL - DATA QUERY LANG.
-- SELECT
SELECT * FROM ogrenciler2;


--FGBHNJMK
--DKJLNHSLİ










