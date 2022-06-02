SELECT 
   MAX(items),
   MIN(items),
   FLOOR(AVG(items))
FROM 
   (SELECT
      ordernumber,COUNT(ordernumber) AS items
      FROM
      orderdetails
      GROUP BY ordernumber)AS lineitems;
      
      USE classicmodels;
      
      SELECT
         productname,
         buyprice
      FROM
         products p1
      WHERE
          buyprice>(SELECT AVG(buyprice)
      FROM
          products WHERE productline=p1.productline); 
          
   SELECT customernumber, customername
   FROM
      customers
      WHERE       
      EXISTS    
          (SELECT ordernumber, SUM(priceeach*quantityordered) total
          
          FROM
          
          orderdetails
              INNER JOIN
              
              orders USING(ordernumber)
            WHERE customernumber=customers.customernumber
            GROUP BY ordernumber
              
              HAVING SUM(priceeach*quantityordered)>60000);       
      
      SELECT productcode, ROUND(SUM(priceeach*quantityordered)) sales, orders.shippeddate
      FROM
      orderdetails
      INNER JOIN
      orders USING (ordernumber)
      WHERE
      YEAR(shippeddate)=2003
      GROUP BY productcode
      ORDER BY sales DESC
      LIMIT 5;
      
      SELECT productname, sales
      FROM
      ( SELECT productcode, ROUND(SUM(priceeach*quantityordered)) sales
      FROM orderdetails
      INNER JOIN orders USING(ordernumber)
      WHERE YEAR(shippeddate)=2003
      GROUP BY productcode
      ORDER BY sales DESC
      LIMIT 5) top5products2003 INNER JOIN products USING(productcode);
      
      SELECT customernumber,
      CASE( WHEN SUM(priceeach*quantityordered)< 10000 THEN 'Silver'
            WHEN SUM(priceeach*quantityordered)< 10000 THEN 'Silver' 
            WHEN SUM(priceeach*quantityordered)< 10000 THEN 'Silver'
     
      