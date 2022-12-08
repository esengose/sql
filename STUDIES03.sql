--EXIST CONDITION- subquery ile kullanılır
-- Eğer Subquery herhangi bir data çağırırsa 'Outer Query' çalıştırılır
--Eğer Subquery herhangi bir data çağırmazsa 'Outer Query' çalıştırılmaz

--Customers name arasında Ediie varsa customer names no name olarak güncelle
UPDATE customers_products
SET customers_name= 'No name'
WHERE EXISTS (SELECT product_name from customers_products WHERE customer_name= 'Eddie');

