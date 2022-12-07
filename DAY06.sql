--              INNER JOIN
/*
    NOT :
    1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
    2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
    3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
 */
 
/*
    NOT :
    1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
    2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
    3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
    
    1) Left Join’de ilk tablodaki tum record’lar gosterilir.
    2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
ortak olmayan datalar icin o kisimlar bos kalir
    3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
 */
 
 
--  INNER JOIN
/*
    NOT :
    1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
    2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
    3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
*/
--  LEFT JOIN
/*
    NOT :
    1) Left Join’de ilk tablodaki tum record’lar gosterilir.
    2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
    ortak olmayan datalar icin o kisimlar bos kalir
    3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
*/
--  RIGHT JOIN
/*
    NOT :
    1)Right Join’de ikinci tablodaki tum record’lar gosterilir.
    2)Ikinci tablodaki datalara 1.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir
    ancak ortak olmayan datalar icin o kisimlar bos kalir
*/

CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');
SELECT * FROM sirketler;

CREATE TABLE siparisler  (
siparis_id int,  
sirket_id int,  
siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17'); 
INSERT INTO siparisler VALUES(22, 102, ' 2020-04-18');  
INSERT INTO siparisler VALUES(33, 103, ' 2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, ' 2020-04-20');  
INSERT INTO siparisler VALUES(55,  105, ' 2020-04-21');
SELECT * FROM siparisler;

-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler INNER JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;


-- SORU) Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--       siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler           --1.TABLONUN HEPSİNİ VE ORTAK DATALARI GETİRİR
ON sirketler.sirket_id=siparisler.sirket_id;   

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler           --2.TABLONUN HEPSİNİ GETİRİR
ON sirketler.sirket_id=siparisler.sirket_id; 

/*
 NOT :
1) Left Join’de ilk tablodaki tum record’lar gosterilir.
2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
ortak olmayan datalar icin o kisimlar bos kalir
3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
 */
 --FULL JOIN
 
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id; 
 
 CREATE TABLE personel_ 
(
id int,
isim varchar(20), 
title varchar(60), 
yonetici_id int
);
INSERT INTO personel_ VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel_ VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel_ VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel_ VALUES(4, 'Fatma Can', 'CEO', 5);
SELECT * FROM personel_;
--Her personelin yanına yönetici ismini yazdıran bir tablo oluşturun






-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/

-- Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin 
kullanmak istersek ~~* sembollerini kullanırız
*/
SELECT * FROM musteriler WHERE isim ILIKE 'A%'
SELECT * FROM musteriler WHERE isim ~~* 'A%'
--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin

select isim,gelir
from musteriler
where isim LIKE '%e';

select isim,gelir
from musteriler
where isim LIKE '%er';

CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  
Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4);  
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
--SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran
--       QUERY yazin

SELECT * FROM kelimeler
	WHERE kelime ~* 'h[ai]t';
	
--SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin 
--tum bilgilerini  yazdiran QUERY yazin	

SELECT * FROM kelimeler
	WHERE kelime ~* 'h[a-k]t';

--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin


--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~* '[mf]$';

/*
							LIKE Condition
LIKE: Sorgulama yaparken belirli patternleri(KAlıp ifadelerle sorgu) kullanabilmezi sağlar
ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
LIKE = ~~
ILIKE = ~~*
NOT LIKE = !~~
NOT ILIKE = !~~*
NOT REGEXP_LIKE = !~*
NOT REGEXP_LIKE = !~
 */
 /*
UPPER – LOWER - INITCAP
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
 */
 
 -- Kelimeler tablosundaki kelime sutunundaki verileri once hepsi buyuk harf,
 --sonra kucuk harf ve ilk harfleri buyuk olacak sekilde yazdiralim

SELECT UPPER(kelime) AS kelime FROM kelimeler
SELECT LOWER (kelime) AS kelime FROM kelimeler
SELECT INITCAP (kelime) AS kelime FROM kelimeler
/* Eğer birden fazla sütundaki büyük/küçük harf yapmak istersek 
--select lower (title), upper (isim) from personel şeklinde yapabiliriz

 
 
 










