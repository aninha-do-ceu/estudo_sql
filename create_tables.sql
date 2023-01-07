-- Criação das tabelas

CREATE TABLE customers(cli_id, name, address, last_name, email,dt_birth, gender);

CREATE TABLE orders(order_id,cli_id,dt_order, qtd_prod, total_order,prod_id);

CREATE TABLE category(category,prod_id);

CREATE TABLE item(prod_id,price,status,end_date);

INSERT INTO cliente VALUES
	(1,'seu ze','rua anemona 29','da cachoeira','zezao@gmail.com','1999-07-10','M'),
    (2,'dona tonia','avenida sao joao 333','da silva','tonia@gmail.com','2001-10-01','F'),
    (3,'dona celia','avenida sao joao 353','dos santos','celia@gmail.com','2001-10-01','F');
     
INSERT INTO orders VALUES 
	(1,2,'2022-02-03',2,3000.0,1),
    (2,3,'2020-01-01',1,1000.0,2),
    (3,1,'2020-01-25',3,3000.0,1),
    (4,2,'2020-01-23',2,5000.0,3),
    (5,2,'2020-01-15',3,1500.0,5),
    (6,3,'2020-01-20',10,1000.0,5),
    (7,2,'2020-01-20',3,1500.0,3),
    (8,2,'2020-02-15',3,1500.0,4),
    (9,1,'2020-02-20',10,1000.0,4),
    (10,2,'2020-02-20',3,1500.0,5),
    (2,3,'2020-03-01',1,1000.0,2),
    (3,1,'2020-03-25',3,3000.0,3),
    (4,2,'2020-03-23',2,5000.0,2);


INSERT INTO category VALUES
	('Celular',1),
    ('Celular',2),
    ('Celular',3),
    ('Celular',4),
    ('Cama',5);

select * from category

INSERT INTO item VALUES
	(1,1000.0,'a',''),
    (2,2000.0,'i','2020-01-01'),
    (3,2000.0,'a',''),
    (4,2000.0,'i','2020-01-01'),
   	(5,1000.0,'a',''); 
