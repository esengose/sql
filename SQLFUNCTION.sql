CREATE TABLE companies
(
  company_id SMALLINT,
  company VARCHAR(20),
  number_of_employees SMALLINT
);
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);
SELECT * FROM companies;
drop table companies

UPDATE companies
SET number_of_employees=999
WHERE company='IBM';
select * from companies;

CREATE OR REPLACE FUNCTION toplamaf (x NUMERIC, y NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN

RETURN 	x+y;

END
$$

SELECT * FROM toplamaf(4,6)


CREATE OR REPLACE FUNCTION konininHacmiF (r NUMERIC, h NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN
END
$$

SELECT * FROM konininHacmiF (1,6);


