USE classicmodels;

SHOW DATABASES;

SHOW TABLES;

DESCRIBE customers;

SELECT contactfirstname, contactlastname 

FROM customers 

ORDER BY contactlastname DESC,

contactfirstname ASC;

SELECT COUNT(customernumber) FROM customers;

DESCRIBE orderdetails;

SELECT ordernumber, productcode, orderlinenumber, quantityordered*priceeach AS subtotal

FROM orderdetails

ORDER BY quantityordered*priceeach DESC;

SELECT FIELD('D', 'B', 'A', 'C','D');

SELECT * FROM ORDERS;

SELECT ORDERNUMBER, STATUS

FROM ORDERS

ORDER BY FIELD(STATUS,  'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');
        
        DESCRIBE EMPLOYEES;
        
 SELECT FIRSTNAME, REPORTSTO
 
    FROM EMPlOYEEs
    
    ORDER BY reportsto;        
    
    
   SELECT firstname FROM employees WHERE reportsto IS NULL;
   
   SELECT * FROM employees WHERE jobtitle= 'sales rep' AND officecode=1;
   
   SELECT 
    lastName, 
    firstName, 
    jobTitle, 
    officeCode
FROM
    employees
WHERE
    
    officeCode IN(1,2,3,4)
ORDER BY 
    officeCode;
    
    SELECT 
    firstName, 
    lastName
FROM
    employees
WHERE

   lastName LIKE '%son'
   
   GROUP BY firstname;
   
   SELECT firstname FROM employees ORDER BY firstname;
   
   SELECT DISTINCT state, city FROM customers WHERE state IS NOT NULL ORDER BY state , city;  
   
   SELECT 1=1 AND 1/0;
   
   SELECT 
    customername, 
    country, 
    state, 
    creditlimit
FROM
    customers
    
WHERE 
     country= 'usa' AND state = 'ca'
     AND creditlimit >100000;
     
     
     SELECT 1 IN ( 1,2,3,4,5,6);
     
     
     SELECT * FROM customers WHERE country IN ('usa','france') ORDER BY country;
     
     SELECT 15 BETWEEN 10 AND 20;
