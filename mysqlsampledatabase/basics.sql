

USE classicmodels;

SELECT customername , COUNT(o.ordernumber) total_orders

FROM customers c

INNER JOIN orders o ON c.customernumber=o.customernumber

GROUP BY c.customername

ORDER BY total_orders DESC ;

CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    NAME VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    NAME VARCHAR(100),
    PRIMARY KEY (committee_id)
);

INSERT INTO members(NAME)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(NAME)
VALUES('John'),('Mary'),('Amelia'),('Joe');

SELECT * FROM members;

SELECT * FROM committees;

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c USING(NAME);

SELECT 
	IFNULL(CONCAT(m.lastname,',',m.firstname ), 'top_manager') AS 'manager',

	CONCAT(e.lastname , ',' ,e.firstname) AS 'subordinates'

FROM employees e

LEFT JOIN employees m ON m.employeeNumber=e.reportsTo

ORDER BY manager DESC;

SELECT 
    
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report',e.reportsto,IFNULL(CONCAT(m.lastname, ', ', m.firstname),
            'Top Manager') AS 'Manager',m.employeeNumber
FROM
    employees e
        LEFT JOIN
    employees m ON m.employeeNumber = e.reportsto;
ORDER BY manager DESC;

SELECT 
    STATUS, COUNT(STATUS)
FROM
    orders
GROUP BY STATUS;

SELECT employeeNumber,lastName,firstName,reportsTo,jobTitle FROM employees;


SELECT ordernumber, SUM(quantityOrdered) , SUM(priceEach), SUM(priceEach*quantityOrdered) AS total FROM orderdetails GROUP BY ordernumber;

SELECT * FROM products;

SELECT a.ordernumber, SUM(priceeach*quantityordered) 'Total',
   
   b.status
   
   FROM orderdetails a
   
   INNER JOIN orders b  USING (orderNumber)-- ON a.ordernumber=b.ordernumber
   
   GROUP BY ordernumber, STATUS
   
   HAVING STATUS = 'Shipped' AND 
   
   total>1000;
   
   CREATE TABLE sales
   
   SELECT
       productline,
       YEAR(orderdate) orderyear,
       SUM(quantityOrdered*priceEach) ordervalue
  FROM
       orderdetails
          INNER JOIN orders USING(orderNumber) 
          
          INNER JOIN products USING(productcode)
  GROUP BY productline,
           YEAR(orderdate); 
           
           SELECT * FROM sales ORDER BY orderyear;
           
       
   SELECT productline,
   SUM(ordervalue) totalordervalue
   FROM sales
   GROUP BY
   productline;       
   
   SELECT SUM(ordervalue) totalordervalue FROM sales; 
   
   SELECT productline, SUM(ordervalue) totalordervalue 
   FROM sales GROUP BY productline UNION ALL
   SELECT NULL, SUM(ordervalue) total
   FROM sales;          
   
   SELECT productline, SUM(ordervalue) totalordervalue, orderyear
   FROM sales
   GROUP BY orderyear, productline  WITH
   ROLLUP;
   
   SELECT lastname, firstname
   FROM employees WHERE officecode IN (SELECT officecode FROM offices WHERE country='usa');
   
   SELECT customernumber, checkNumber FROM payments WHERE amount=(SELECT MAX(amount) FROM payments);
   
   SELECT customernumber, checkNumber , amount FROM payments WHERE amount > ( SELECT AVG(amount) FROM payments);
   
   SELECT customername FROM customers WHERE customernumber NOT IN( SELECT customernumber FROM orders);
   
   
   