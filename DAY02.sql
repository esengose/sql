select * FROM ogrenciler; -- Buradaki yıldız sembolü "herşeyi" anlamındadır.

-- VAROLAN BİR TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler;

select * from notlar;

--INSERT- TABLO İÇİNE VERİ EKLEME

INSERT INTO notlar VALUES ('Fatma',95.5);
INSERT INTO notlar VALUES ('Ali',75.5);
INSERT INTO notlar VALUES ('Musa',45.5);
INSERT INTO notlar VALUES ('Hakan',65.5);
INSERT INTO notlar VALUES ('Adem',75.5);
INSERT INTO notlar VALUES ('Sümeyye',85.5);

select * from notlar;

Create table talebeler
(
isim varchar(18),
notlar real	
);
INSERT INTO talebeler VALUES ('Fatma',95.5);
INSERT INTO talebeler VALUES ('Ali',75.5);
INSERT INTO talebeler VALUES ('Musa',45.5);
INSERT INTO talebeler VALUES ('Hakan',65.5);
INSERT INTO talebeler VALUES ('Adem',75.5);
INSERT INTO talebeler VALUES ('Sümeyye',85.5);

select isim from notlar;

--CONSTRAINT
--UNIQUE

CREATE TABLE ogrenciler6
( ogrenci_no char(7) unique,
 isim varchar(20)not null, --not null 
 soyisim varchar(25),
 not_ort real,
 kayit_tarih date
 );
 select * from ogrenciler6;
 
 INSERT INTO ogrenciler6 VALUES('1234567','Erol','Evren','75.5',now());
 INSERT INTO ogrenciler6 VALUES('1234568','Ali','Veli','75.5',now());
 INSERT INTO ogrenciler6 (ogrenci_no,isim,soyisim,not_ort)VALUES('1234569','Mehmet','Cancan','85.5');
 
 CREATE TABLE ogrenciler8
( ogrenci_no char(7) PRIMARY KEY,			--PRIMARY KEY ATAMA 1.YOL
 isim varchar(20),
 soyisim varchar(25),
 not_ort real,
 kayit_tarih date
 );
 CREATE TABLE ogrenciler9                   --PRIMARY KEY ATAMA 2.YOL
( ogrenci_no char(7),
 isim varchar(20),
 soyisim varchar(25),
 not_ort real,
 kayit_tarih date,
 CONSTRAINT ogr PRIMARY KEY (ogrenci_no)
 );
  CREATE TABLE ogrenciler10                   --PRIMARY KEY ATAMA 3.YOL
( ogrenci_no char(7),
 isim varchar(20),
 soyisim varchar(25),
 not_ort real,
 kayit_tarih date,
 PRIMARY KEY (ogrenci_no)
 );
 --FOREIGN KEY
 
 CREATE TABLE tedarikciler3
 (tedarikci_id CHAR(5) PRIMARY KEY,
  tedarikci_ismi VARCHAR(20),
  iletisim_isim VARCHAR(20)
  );
  select * from tedarikciler3  --tabloyu  görebiliriz
  
  CREATE TABLE urunler
( tedarikci_id CHAR(5),
  urun_id CHAR(5),
 FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
  );
  select * from urunler  --tabloyu  görebiliriz
  
  CREATE TABLE calisanlar
  (
id char(5) PRIMARY KEY,
isim varchar(15) UNIQUE,
maas int NOT NULL,
ise_baslama date
 );
 
 CREATE TABLE adresler
 (adres_id char(5),
  sokak varchar(15),
  cadde varchar(15),
  sehir varchar(15),
  FOREIGN KEY (adres_id) REFERENCES calisanlar (id)
 );
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz, 5000, '2018-04-14'); --unique cons.
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --maas null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --unique cons.
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--maas hiclik
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --p.k. ilk hiçliği kabul etti.null etmez
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --uniqe değil
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--null deger
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');-- primary key de böyle bir id yok
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');
							  select * from adresler;
							  select * from calisanlar;
							  
							  --CHECK CONSTRAINT
CREATE TABLE calisanlar1
 (id varchar (15)PRIMARY KEY,
  isim varchar(20)UNIQUE,
  maas int CHECK (maas>10000),
  ise_baslama date
 );
	select * from calisanlar1;
	INSERT INTO calisanlar1 VALUES ('100001','Mehmet Yılmaz',19000,now()); --9000 olmadı checkten dolayı 
							  
							  --DQL--WHERE KULLANIMI
	SELECT * FROM calisanlar;
	SELECT isim FROM calisanlar;
		--Calisanlar tablosndan maası 5000 den çok olanı getir
			SELECT isim FROM calisanlar WHERE maas>5000;				  
        --Calisanlar tablosundan ismi Veli Han olan veriyi listeleyin
			SELECT * FROM calisanlar WHERE isim='Veli Han';			 
		--Calisanlar tablosundan maası 5000 olan tüm verileri listeleyin
			SELECT * FROM calisanlar WHERE maas=5000;	
							  
							  --DML DELETE FROM  data manipulating language
							  
							  
							  
							  