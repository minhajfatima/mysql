USE mysql;
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL
);

INSERT INTO contacts (first_name,last_name,email) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');

SELECT * FROM contacts ;

SELECT email , COUNT(email) FROM contacts

GROUP BY email 

HAVING COUNT(email)>1;


DELETE t1 FROM contacts t1

INNER JOIN contacts t2

WHERE t1.id > t2.id

AND

t1.email = t2.email;

SELECT email, COUNT(email) FROM contacts

GROUP BY email

HAVING COUNT(email)>1;

DROP TABLE contacts;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
	employeeNumber INT,
	lastName VARCHAR(20),
	firstName VARCHAR(20),
	extension VARCHAR(20),
	email VARCHAR(60),
	officeCode INT,
	reportsTo INT, 
	jobTitle VARCHAR(60) 
	);
	
	SHOW TABLES;
	
 LOAD DATA LOCAL INFILE 'D:\employees.txt' INTO TABLE employees
 LINES TERMINATED BY '\r\n';
 
 SELECT * FROM emp loyees;
 
 