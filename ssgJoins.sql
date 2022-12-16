create table qa_dersler
(
ders_id int,
ders_ismi varchar(30),
ders_saati varchar(30)
);

insert into qa_dersler values (101, 'Core Java', 40);
insert into qa_dersler values (102, 'Selenium', 30);
insert into qa_dersler values (103, 'API', 15);
insert into qa_dersler values (104, 'SQL', 10);
insert into qa_dersler values (105, 'SDLC', 10);
insert into qa_dersler values (106, 'LAMDA', 12);


create table developer_dersler
(
ders_id int,
ders_ismi varchar(30),
ders_saati varchar(30)
);

insert into developer_dersler values (101, 'Core Java', 40);
insert into developer_dersler values (103, 'API', 15);
insert into developer_dersler values (104, 'SQL', 10);
insert into developer_dersler values (105, 'SDLC', 10);
insert into developer_dersler values (106, 'LAMDA', 12);
insert into developer_dersler values (107, 'Spring Framework', 20);
insert into developer_dersler values (108, 'Micro Services', 12);

select * from qa_dersler;

select * from developer_dersler;

--SORU: join kullanarak ortak dersleri sorgulayınız
SELECT A.ders_ismi,B.ders_ismi FROM qa_dersler A INNER JOIN developer_dersler B ON A.ders_id=B.ders_id;

--hoca şöyle yapmış:
select A.ders_id, A.ders_ismi, A.ders_saati
from qa_dersler A
inner join developer_dersler B
on A.ders_id=B.ders_id

create table filmler
(film_id int,
film_ismi varchar(30),
kategori varchar(30)
);

insert into filmler values (1, 'Eyvah Eyvah', 'Komedi');
insert into filmler values (2, 'Kurtlar Vadisi', 'Aksiyon');
insert into filmler values (3, 'Eltilerin Savasi', 'Komedi');
insert into filmler values (4, 'Aile Arasinda', 'Komedi');
insert into filmler values (5, 'GORA', 'Bilim Kurgu');
insert into filmler values (6, 'Organize Isler', 'Komedi');
insert into filmler values (7, 'Babam ve Oglum', 'Dram');


create table aktorler
(id int,
aktor_ismi varchar(30),
film_id int
);

insert into aktorler values (101, 'Ata Demirer', 1);
insert into aktorler values (102, 'Necati Sasmaz', 2);
insert into aktorler values (103, 'Gupse Ozay', 3);
insert into aktorler values (104, 'Engin Gunaydin', 4);
insert into aktorler values (105, 'Cem Yilmaz', 5);
insert into aktorler values (107, 'Tarik Akan', 8);
insert into aktorler values (108, 'Turkan Soray', 9);



select * from filmler;
select * from aktorler;
-- SORU1: Tüm film_ismi'leri, kategori'lerini ve filmlerde oynayan aktor_ismi'leri listeleyiniz.
SELECT film_ismi, kategori,aktor_ismi from filmler A LEFT JOIN aktorler B ON A.film_id=B.film_id;

SELECT film_ismi, kategori,aktor_ismi from aktorler B RIGHT JOIN filmler A ON A.film_id=B.film_id;

-- SORU2: Tüm actor_ismi'leri ve bu aktorlerin oynadıgı film_ismi'lerini listeleyiniz.
SELECT aktor_ismi, film_ismi FROM aktorler A LEFT JOIN filmler B ON A.film_id=B.film_id;

-- SORU3: Tüm film_ismi'lerini ve tüm aktor_ismi'lerini listeleyiniz
--Aktoru olmasa bile film, filmi olmasa bile aktor listelenmelidir.
SELECT film_ismi,aktor_ismi FROM filmler A FULL JOIN aktorler B ON A.film_id=B.film_id;


CREATE TABLE personel
(
id int,
isim varchar(20),
title varchar(60),
yonetici_id int
);

INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);


--Her personelin yanina yonetici 
--ismini yazdiran bir tablo olusturun

select personeller.isim as personel_isim, 
yoneticiler.isim as yonetici_isim
from personel as personeller
inner join personel as yoneticiler
on personeller.yonetici_id=yoneticiler.id




drop table personel;
drop table bolumler;


CREATE TABLE bolumler (
bolum_id   int PRIMARY KEY,
bolum_isim VARCHAR(14),
konum      VARCHAR(13)
  );
    
INSERT INTO bolumler VALUES (10,'MUHASEBE','ISTANBUL');
INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
    
select * from bolumler;

CREATE TABLE personel (
personel_id   int PRIMARY KEY,
personel_isim VARCHAR(10),
meslek        VARCHAR(9),
mudur_id      int,
maas          int,
bolum_id      int
);
    
  
INSERT INTO personel VALUES (7499,'BAHATTIN','SATISE',1222,1600,30);
INSERT INTO personel VALUES (7521,'NESE','SATISE',1222,1250,30);
INSERT INTO personel VALUES (7654,'MUHAMMET','SATISE',1222,1250,30);
INSERT INTO personel VALUES (1222,'EMINE','MUDUR',7839,2850,30);
INSERT INTO personel VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
INSERT INTO personel VALUES (7788,'MESUT','ANALIST',1111,3000,20);
INSERT INTO personel VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
INSERT INTO personel VALUES (7876,'ALI','KATIP',1111,1100,20);
INSERT INTO personel VALUES (7900,'MERVE','KATIP',1222,950,30);
INSERT INTO personel VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
INSERT INTO personel VALUES (7934,'EBRU','KATIP',1333,1300,10);
INSERT INTO personel VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);
    
SELECT * FROM personel;

/* -----------------------------------------------------------------------------
  SORU1: Tüm bolumlerde calisan personelin isimlerini, bolum isimlerini ve 
  maaslarini, bolum ters ve maas sirali listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/  

--esas tablo bolumler
select personel_isim, bolum_isim, maas
from bolumler B
left join personel P
on B.bolum_id=P.bolum_id
order by B.bolum_isim desc, P.maas


























































































