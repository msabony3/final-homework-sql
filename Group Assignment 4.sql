/* Creating a new database */
CREATE DATABASE assignment4_premiere;

/* use the database */
USE assignment4_premiere;

/* create, describe and insert values into rep table */
CREATE TABLE REP
	(REP_NUM CHAR(2) PRIMARY KEY,
	LAST_NAME CHAR(15) NOT NULL,
	FIRST_NAME CHAR(15) NOT NULL,
	STREET CHAR(15),
	CITY CHAR(15),
	STATE CHAR(2),
	ZIP CHAR(5),
	COMMISSION DECIMAL(7,2),
	RATE DECIMAL(3,2) );
DESC REP;
INSERT INTO REP VALUES ('20','Kaiser','Valerie','624 Randall', 'Grove', 'FL','33321',20542.50,0.05);
INSERT INTO REP VALUES ('35','Hull','Richard','532 Jackson','Sheldon', 'FL','33553',39216.00,0.07);
INSERT INTO REP VALUES ('65','Perez','Juan','1626 Taylor','Fillmore', 'FL','33336',23487.00,0.05);
SELECT * FROM REP;

/*create, describe and insert values into customer table */
CREATE TABLE CUSTOMER
	(CUSTOMER_NUM CHAR(3) PRIMARY KEY,
	CUSTOMER_NAME CHAR(35) NOT NULL,
	STREET CHAR(15),
	CITY CHAR(15),
	STATE CHAR(2),
	ZIP CHAR(5),
	BALANCE DECIMAL(8,2),
	CREDIT_LIMIT DECIMAL(8,2),
	REP_NUM CHAR(2) );
DESC CUSTOMER;
INSERT INTO CUSTOMER VALUES ('148','Al''s Appliance and Sport','2837 Greenway','Fillmore','FL','33336',6550.00,7500.00,'20');
INSERT INTO CUSTOMER VALUES ('282','Brookings Direct','3827 Devon','Grove','FL','33321',431.50,10000.00,'35');
INSERT INTO CUSTOMER VALUES ('356','Ferguson''s','382 Wildwood','Northfield','FL','33146',5785.00,7500.00,'65');
INSERT INTO CUSTOMER VALUES ('408','The Everything Shop','1828 Raven','Crystal','FL','33503',5285.25,5000.00,'35');
INSERT INTO CUSTOMER VALUES ('462','Bargains Galore','3829 Central','Grove','FL','33321',3412.00,10000.00,'65');
INSERT INTO CUSTOMER VALUES ('524','Kline''s','838 Ridgeland','Fillmore','FL','33336',12762.00,15000.00,'20');
INSERT INTO CUSTOMER VALUES ('608','Johnson''s Department Store','372 Oxford','Sheldon','FL','33553',2106.00,10000.00,'65');
INSERT INTO CUSTOMER VALUES ('687','Lee''s Sport and Appliance','282 Evergreen','Altonville','FL','32543',2851.00,5000.00,'35');
INSERT INTO CUSTOMER VALUES ('725','Deerfield''s Four Seasons','282 Columbia','Sheldon','FL','33553',248.00,7500.00,'35');
INSERT INTO CUSTOMER VALUES ('842','All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,'20');
SELECT * FROM CUSTOMER;

/*create, describe and insert values into orders table */
CREATE TABLE ORDERS
	(ORDER_NUM CHAR(5) PRIMARY KEY,
	ORDER_DATE DATE,
	CUSTOMER_NUM CHAR(3) );
DESC ORDERS;
INSERT INTO ORDERS VALUES ('21608','2007-10-20','148');
INSERT INTO ORDERS VALUES ('21610','2007-10-20','356');
INSERT INTO ORDERS VALUES ('21613','2007-10-21','408');
INSERT INTO ORDERS VALUES ('21614','2007-10-21','282');
INSERT INTO ORDERS VALUES ('21617','2007-10-23','608');
INSERT INTO ORDERS VALUES ('21619','2007-10-23','148');
INSERT INTO ORDERS VALUES ('21623','2007-10-23','608');
SELECT * FROM ORDERS;

CREATE TABLE PART
	(PART_NUM CHAR(4) PRIMARY KEY,
		DESCRIPTION CHAR(15),
		ON_HAND DECIMAL(4,0) NOT NULL,
		CLASS CHAR(2),
		WAREHOUSE CHAR(1),
		PRICE DECIMAL(6,2) );
DESC PART;
INSERT INTO PART VALUES ('AT94','Iron',50,'HW','3',24.95);
INSERT INTO PART VALUES ('BV06','Home Gym',45,'SG','2',794.95);
INSERT INTO PART VALUES ('CD52','Microwave Oven',32,'AP','1',165.00);
INSERT INTO PART VALUES ('DL71','Cordless Drill',21,'HW','3',129.95);
INSERT INTO PART VALUES ('DR93','Gas Range',8,'AP','2',495.00);
INSERT INTO PART VALUES ('DW11','Washer',12,'AP','3',399.99);
INSERT INTO PART VALUES ('FD21','Stand Mixer',22,'HW','3',159.95);
INSERT INTO PART VALUES ('KL62','Dryer',12,'AP','1',349.95);
INSERT INTO PART VALUES ('KT03','Dishwasher',8,'AP','3',595.00);
INSERT INTO PART VALUES ('KV29','Treadmill',9,'SG','2',1390.00);


-- 1. Create ORDER_LINE table, order_num and part_num composite ID, order_num and part_num FKs -- 
CREATE TABLE ORDER_LINE
	(ORDER_NUM CHAR(5),
	PART_NUM CHAR(4),
	NUM_ORDERED CHAR(3),
	QUOTED_PRICE DECIMAL(6,2),
	PRIMARY KEY (ORDER_NUM, PART_NUM),
	CONSTRAINT FK_ORDER_NUM FOREIGN KEY (ORDER_NUM) REFERENCES ORDERS(ORDER_NUM),
	CONSTRAINT FK_PART_NUM FOREIGN KEY (PART_NUM) REFERENCES PART(PART_NUM)
	);
DESC ORDER_LINE;

-- 2. Insert values into ORDER_LINE -- 
INSERT INTO ORDER_LINE
VALUES ('21608', 'AT94', '11', 21.95);

INSERT INTO ORDER_LINE
VALUES ('21610', 'DR93', '1', 495.00);

INSERT INTO ORDER_LINE
VALUES ('21610', 'DW11', '1', 399.99);

INSERT INTO ORDER_LINE
VALUES ('21613', 'KL62', '4', 329.95);

INSERT INTO ORDER_LINE
VALUES ('21614', 'KT03', '2', 595.00);

INSERT INTO ORDER_LINE
VALUES ('21617', 'BV06', '2', 794.95);

INSERT INTO ORDER_LINE
VALUES ('21617', 'CD52', '4', 150.00);

INSERT INTO ORDER_LINE
VALUES ('21619', 'DR93', '1', 495.00);

INSERT INTO ORDER_LINE
VALUES ('21623', 'KV29', '2', 1290.00);

-- 3. Use SELECT * command to display table --
SELECT * FROM ORDER_LINE;

-- 4. List all rows for low-availability parts (number of parts on hand <= 25) -- 
SELECT * FROM PART WHERE ON_HAND <= 25;

-- 5. List description of all parts with price > $400 or description is only two words --
SELECT DESCRIPTION FROM PART WHERE PRICE > 400 OR DESCRIPTION LIKE "% %";

-- 6. List descriptions of parts in warehouses other than 4 --
	-- <> --
SELECT DESCRIPTION FROM PART WHERE WAREHOUSE <> 4;
	-- != --
SELECT DESCRIPTION FROM PART WHERE WAREHOUSE != 4;
	-- NOT --
SELECT DESCRIPTION FROM PART WHERE WAREHOUSE NOT IN (4);
SELECT DESCRIPTION FROM PART WHERE WAREHOUSE NOT LIKE 4;

-- 7. Find part numbers, descriptions, and prices of all parts stored in warehouse 2 that have on hand quantity > 20 and price < 150.00 --
SELECT PART_NUM, DESCRIPTION, PRICE FROM PART WHERE WAREHOUSE = "2" AND ON_HAND > 20 AND PRICE < 150.00;

-- 8. List part number, description, and asset value for each part whose asset value  >= $10,500. ON_HAND*PRICE = ASSET_VALUE
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE PART ADD COLUMN ASSET_VALUE DECIMAL(8,2);
UPDATE PART SET ASSET_VALUE = (PRICE * ON_HAND);
SELECT PART_NUM, DESCRIPTION, ASSET_VALUE FROM PART WHERE ASSET_VALUE > 10500.00;

-- 9. New code that combines first two characters of PART_NUM and entire value of CLASS. Cannot use CONCAT or CONCT_WS functions --
ALTER TABLE PART ADD COLUMN NEW_CODE CHAR(4);
UPDATE PART SET NEW_CODE = INSERT(CLASS, 1, 0, SUBSTRING(PART_NUM, 1, 2));
SELECT PART_NUM, CLASS, NEW_CODE FROM PART;

-- 10. Display all rows and columns of the table, sorted by date (desc) then order number --
SELECT * FROM ORDERS 
ORDER BY ORDER_DATE DESC, ORDER_NUM;

-- 11. Display (a) max asset value, (b) min asset value, (c) count of all parts in Warehouse 2 with low availability --
SELECT MAX(ASSET_VALUE), MIN(ASSET_VALUE), COUNT(*)
FROM PART
WHERE WAREHOUSE = '2' AND ON_HAND <= 25;

-- 12. List PART_NUM, DECRIPTION, PRICE of all part classified as AP whose ON_HAND <= AVG(ON_HAND) --
SELECT PART_NUM, DESCRIPTION, PRICE
FROM PART
WHERE CLASS = 'AP' AND ON_HAND <= (SELECT AVG(ON_HAND) FROM PART);

-- 13. Display how many different classes in PART --
SELECT COUNT(DISTINCT(CLASS)) FROM PART;

-- 14. Display unique class types for parts with PRICE > 10 and WAREHOUSE = '2' --
SELECT COUNT(DISTINCT(CLASS))
FROM PART
WHERE PRICE > 10 AND WAREHOUSE = '2';

-- 15. Display PART_NUM and total number of unique orders for each part number --
SELECT PART_NUM, COUNT(DISTINCT(ORDER_NUM))
FROM ORDER_LINE
GROUP BY PART_NUM;

-- 16. Display PART_NUM and total number of unique orders for each part number, sorted by total number of orders DESC --
SELECT PART_NUM, COUNT(DISTINCT(ORDER_NUM)) AS ORDER_NUM_QUANT
FROM ORDER_LINE
GROUP BY PART_NUM
ORDER BY ORDER_NUM_QUANT DESC;

-- 17. Display PART_NUM and total number of unique orders for each part number, restricted to only those parts included in more than 1 unique order --
SELECT PART_NUM, COUNT(DISTINCT(ORDER_NUM)) AS ORDER_NUM_QUANT
FROM ORDER_LINE
GROUP BY PART_NUM
HAVING ORDER_NUM_QUANT > 1
ORDER BY ORDER_NUM_QUANT DESC;

-- 18. Display PART_NUM and total number of unique orders for each part number, only including line items with a quoted price >300, sorted by total number of parts DESC --
SELECT PART_NUM, COUNT(DISTINCT(ORDER_NUM)) AS ORDER_NUM_QUANT, SUM(NUM_ORDERED) AS TOTAL_ORDERED
FROM ORDER_LINE
WHERE QUOTED_PRICE > 300
GROUP BY PART_NUM
ORDER BY TOTAL_ORDERED DESC;

-- 19. Display PART_NUM and total number of unique orders for each part number, only including items where the price > 300 and parts with total number of parts ordered > 2 --
SELECT PART_NUM, COUNT(DISTINCT(ORDER_NUM)) AS ORDER_NUM_QUANT, SUM(NUM_ORDERED) AS TOTAL_ORDERED
FROM ORDER_LINE
WHERE QUOTED_PRICE > 300
GROUP BY PART_NUM
HAVING TOTAL_ORDERED > 2
ORDER BY TOTAL_ORDERED DESC;

-- 20. Add a new column to the parts table, containing prices of each part, with a $ before the price --
ALTER TABLE PART ADD COLUMN Dollar_Price VARCHAR(10);
UPDATE PART SET Dollar_Price = CONCAT("$", PRICE);
SELECT * FROM PART;

-- 21. Add a foreign key constrain without deleting the customer table so that rep_num in the customer table links to rep_num in the rep table. Set the delete rule for the update operation to null. See the delete rule for the delete operation to cascade --
ALTER TABLE CUSTOMER 
ADD CONSTRAINT FK_REP_NUM FOREIGN KEY (REP_NUM) REFERENCES REP(REP_NUM)
ON UPDATE SET NULL ON DELETE CASCADE;

-- 22. List all pairs of customers from the same city and state. --
SELECT customer_name, CONCAT(first_name, " ", last_name) AS rep_name, CONCAT(CUSTOMER.city, ", ", CUSTOMER.state) AS location
FROM CUSTOMER, REP
WHERE CUSTOMER.rep_num = REP.rep_num AND CUSTOMER.city = REP.city AND CUSTOMER.state = REP.state;

-- 23. List all customer names and their corresponding rep's first and last names --
SELECT customer_name, CONCAT(first_name, " ", last_name) AS rep_name
FROM CUSTOMER, REP
WHERE CUSTOMER.rep_num = REP.rep_num;

-- 24. List all orders along with customer names and cities for customers in 'Fillmore' --
SELECT customer_name, city, ORDERS.* FROM customer, orders
WHERE CUSTOMER.customer_num = ORDERS.customer_num AND CUSTOMER.city = 'Fillmore';

-- 25. List all parts and corresponding order line items where part's class is 'AP' and price > 100 --
SELECT * FROM part, order_line
WHERE PART.part_num = ORDER_LINE.part_num AND PART.class = 'AP' AND quoted_price > 100;

-- 26. List each rep's first and last name and how many customers they represent --
SELECT first_name, last_name, COUNT(customer_num) FROM customer, rep
WHERE CUSTOMER.rep_num = REP.rep_num
GROUP BY REP.rep_num;

-- 27. List all part_num and descriptions that have been ordered more than once --
SELECT DISTINCT(PART.part_num), description FROM part, order_line 
WHERE PART.part_num = ORDER_LINE.part_num AND PART.part_num IN (SELECT part_num FROM order_line GROUP BY PART_NUM HAVING COUNT(*) > 1);

-- 28. List each part_num and total quantity ordered across all orders where cost > 200 --
SELECT PART.part_num, SUM(num_ordered) FROM part, order_line
WHERE PART.part_num = ORDER_LINE.part_num AND PART.price > 200.00
GROUP BY PART.part_num;

-- 29. List each part_num and total quantity across all orders where cost > 200 and quoted price > 300 --
SELECT PART.part_num, SUM(num_ordered) FROM part, order_line
WHERE PART.part_num = ORDER_LINE.part_num AND PART.price > 200.00 AND quoted_price > 300.00
GROUP BY PART.part_num;

-- 30. List each part_num and total quantity across all orders where cost > 200, quoted price > 50, total quantity > 2 --
SELECT PART.part_num, SUM(num_ordered) FROM part, order_line
WHERE PART.part_num = ORDER_LINE.part_num AND PART.price > 200.00 AND quoted_price > 50.00
GROUP BY PART.part_num
HAVING SUM(num_ordered) > 2;

-- 31. List customer names with quoted price > 400 --
SELECT customer_name, quoted_price FROM customer, orders, order_line
WHERE CUSTOMER.customer_num = ORDERS.customer_num AND ORDERS.order_num = ORDER_LINE.order_num AND quoted_price > 400;

-- 32. List names of customers who ordered on 2007-10-23, using joins --
SELECT customer_name, order_date FROM customer, orders
WHERE CUSTOMER.customer_num = ORDERS.customer_num AND order_date = '2007-10-23';

-- 33. List names of customers who ordered on 2007-10-23, using subquery --
SELECT customer_name FROM customer
WHERE customer_num IN (SELECT customer_num FROM orders WHERE order_date = '2007-10-23');

-- 34. List all customers and orders they've placed, including customers with no orders --
SELECT C.*, O.* FROM customer C LEFT JOIN orders O
ON C.customer_num = O.customer_NUM;

-- 35. List all orders and customer names, including orders with no associated customer --
SELECT C.*, O.* FROM customer C RIGHT JOIN orders O
ON C.customer_num = O.customer_NUM;

-- 36. List all customers and orders, showing matching records where available and displaying NULL if no match --
SELECT C.customer_name, O.order_num FROM customer C LEFT JOIN orders O
ON C.customer_num = O.customer_NUM
UNION
SELECT C.customer_name, O.order_num FROM customer C RIGHT JOIN orders O
ON C.customer_num = O.customer_NUM;

-- 37. Create a list of cities with every city from the customer and rep tables, without duplicated --
SELECT C.city FROM customer C
UNION
SELECT R.city from rep R;

-- 38. Find cities that are common between customers and reps --
SELECT DISTINCT(C.city) FROM customer C 
WHERE C.city IN
(SELECT R.city from rep R);

-- 39. List cities where there are customers but no reps -- 
SELECT DISTINCT(C.city) FROM customer C 
WHERE C.city NOT IN
(SELECT R.city from rep R);

-- 40. List cities where there are reps but no customers --
SELECT DISTINCT(R.city) FROM rep R
WHERE R.city NOT IN
(SELECT C.city from customer C);