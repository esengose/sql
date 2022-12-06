CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
--Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
SELECT sirket, COUNT(*) AS calisan_sayisini_saydir FROM personel
WHERE maas>5000
GROUP BY sirket;
-- Isme gore toplam maaslari bulun
SELECT isim,sum(maas) FROM personel
GROUP BY isim;
--HAVING KULLANIMI
 /*
	Having komutu yalnizca GROUP BY komutu ile kullanilir
	Eger gruplamadan sonra bir sart varsa HAVING komutu kullanilir
	Where kullanımı ile aynı mantıkta çalışır fakat gruplamadan sonra kullanılır
*/
1) Her sirketin MIN maaslarini eger 2000’den buyukse goster
select * from personel;
SELECT sirket, min(maas)from personel
GROUP BY sirket
HAVING min(maas)>4000;
-- 2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi
-- ve toplam maasi gosteren sorgu yaziniz
select isim, sum(maas) as toplam_maas from personel1 group by isim having sum(maas)>10000;

-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
select sehir, count(isim)from personel
GROUP BY sehir
HAVING count(isim)>1;
--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir, MAX(maas) as en_yuksek_maas from personel GROUP by sehir HAVING max(maas)<5000;


--UNION -----SORGULARI BİRLEŞTİRMEK İÇİN KULLANIRIZ TEKRARSIZ YAPAR
-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz
select isim,maas from personel where maas>4000
UNION
select sehir,maas from personel where maas>5000

-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
select isim, maas from personel where isim='Mehmet Ozturk'
UNION
select sehir,maas from personel where sehir ='Istanbul'

DROP TABLE IF EXISTS personel
CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
	);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel;
select * from personel_bilgi;
--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
select sehir,maas from personel WHERE id=123456789
union
select tel,cocuk_sayisi from personel_bilgi where id=123456789;

---UNION ALL
--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
select isim, maas from personel where maas<5000
union all
select isim, maas from personel where maas<5000

--SQL INTERSECT operatörü, 2 veya daha fazla SELECT ifadesinin sonuçlarını döndürmek için kullanılır. 
--Ancak, yalnızca tüm sorgular veya veri kümeleri tarafından seçilen satırları döndürür. 
--Bir sorguda bir kayıt varsa ve diğerinde yoksa, INTERSECT sonuçlarından çıkarılacaktır.

--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin

SELECT id FROM personel WHERE sehir IN ('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN (2,3)

-- 1) Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
-- 2) Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
-- 3) Iki sorguyu INTERSECT ile birlestirin
select id from personel where maas not between 4800 and 5000
intersect
select id from personel_bilgi where cocuk_sayisi in(2,3)

-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
SELECT isim FROM personel WHERE sirket='Honda'
intersect
SELECT isim FROM personel WHERE sirket='Ford'
intersect
SELECT isim FROM personel WHERE sirket='Tofas'
--EXCEPT İKİ SORGULAMA DIŞINDAKİLERİ GETİRİR

--5000 den az maas alıp Honda da çalışmayamlar
select isim,sirket from personel where maas <5000
except
select isim,sirket from personel where sirket ='Honda'























