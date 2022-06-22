CREATE DATABASE PRODUCT;
USE PRODUCT;

CREATE TABLE Products(
	id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(255) ,
    productName VARCHAR(255) ,
    productPrice DOUBLE ,
    productAmount int ,
    productDescription VARCHAR(255) ,
    productStatus VARCHAR(255) 
);

INSERT INTO Products
VALUES (2, 'a', 'b',12.4 ,1 , 'c', 'd'),
		(3, 'a', 'b',12.4 ,1 , 'c', 'd'),
        (4, 'a', 'b',12.4 ,1 , 'c', 'd');

ALTER TABLE Products add INDEX MaSP (productCode);

CREATE INDEX NamePrice1 ON Products(productName,productPrice);

EXPLAIN SELECT * FROM Products WHERE productCode = 1;

CREATE VIEW view_products AS
SELECT productCode,productName,productPrice,productStatus
FROM Products;

SELECT * FROM view_products;

UPDATE view_products
SET productPrice = 23.3
WHERE productCode = 'a';

DROP VIEW view_products;

DELIMITER //
CREATE PROCEDURE product_info()
	BEGIN
    SELECT * FROM Products;
    END //
DELIMITER ;    

ALTER TABLE Products DROP INDEX MaSP;
