

set client_min_messages = 'error';
-- SQL der ersten Umsetzung des Pizza Service

/* Zur Uebung lege folgende constraints fest
 * Datentypen (gibt es bessere Datentypen??)
 * Primary Keys 
 * NULL or NOT NULL Constraints
 * DEFAULT VALUES
 * CHECK Constraints
 * Unique Constraint
 *
 */ 

/* 
 * Domains fuer einheitliche checks 
 */

DROP DOMAIN IF EXISTS url,price CASCADE;

CREATE DOMAIN url AS text CHECK (
  VALUE ~ '^(file|http).*'
);

CREATE DOMAIN price AS numeric(8,2) CHECK (
  VALUE >= 0
);

DROP TABLE IF EXISTS 
  salad, beverage, pizza, topping, 
  image, pizza_compilation,
  menu, channel,"order", order_item, pizza_extra_topping,
  client, branch, deleivery_adress, channel,
  food_category, food_size_price ;



CREATE TABLE channel (
  name text PRIMARY KEY check(name != ''::text)
);
INSERT INTO channel (NAME)
VALUES ('internet'),('lokal'),('telefon');

CREATE TABLE image (
  location url PRIMARY KEY,
  name text 
    NOT NULL 
	DEFAULT 'placeholder',
  copyright text 
    NOT NULL DEFAULT 'unknown',
  type text 
    NOT NULL DEFAULT 'unknown'
);

-- falsche Daten
--INSERT INTO image (location, copyright, type)
--  VALUES 
--  ('super file location', 'super copyright', 'super bild type')
  --,
  --('super file location', 'super copyright', 'super bild type'),
  --(null, null, null),
  --('', NULL, NULL),
  --(NULL, '', null),
  --(NULL, NULL, '')
  ;
  
-- richtige Daten
INSERT INTO image (location, copyright, type)
  VALUES
  ('file://here', 'Renzo Kottmann', 'png'),
  ('http://sonstwo', 'renzo', 'jpg');
INSERT INTO image (location)
  VALUES
  ('file://placeholder'),
  ('http://sonstwo/fungi'),
  ('http://sonstwo/hawai'),
  ('http://sonstwo/mozarella'),
  ('http://sonstwo/spinaci'),
  ('http://sonstwo/tubel');
  
CREATE TABLE menu (
  name text PRIMARY KEY,
  num integer check (num > 0) NOT NULL UNIQUE
);

INSERT INTO menu (num, name)
  VALUES  
  (5,'Fungi'),
  (2,'Salami'),
  (6,'Hawai'),
  (4,'Mozarella'),
  (1,'Spinaci'),
  (3,'Tubel'),
  (7,'Griechischer Salat'),
  (8,'Tomaten Salat'),
  (9,'Cola'),
  (10,'Biolunder'),
  (11,'Wasser');
  

-- Implementiert entitaet pizza
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
    PRIMARY KEY
    REFERENCES menu(name),
  img url NOT NULL 
    DEFAULT 'file://placeholder'
    UNIQUE
    REFERENCES image (location)
);
-- falsche Daten

-- Meiste verwendete INSERT Syntax
--INSERT INTO pizza (name,image) VALUES (null,null);
--INSERT INTO pizza (name,image) VALUES ('salami',null);
--INSERT INTO pizza (name,image) VALUES ('Salami', '');
--INSERT INTO pizza (name,image) VALUES (null, 'super image location');

-- richtige daten
INSERT INTO pizza (name,img) 
 VALUES ('Salami', 'file://here');
 
INSERT INTO pizza (name,img) 
 VALUES ('Fungi', 'http://sonstwo/fungi'),
 ('Hawai','http://sonstwo/hawai'),
  ('Mozarella','http://sonstwo/mozarella'),
  ('Spinaci','http://sonstwo/spinaci');

INSERT INTO pizza (name)
VALUES
  ('Tubel');

CREATE TABLE topping (
  name text PRIMARY KEy,
  img text 
    NOT NULL DEFAULT 'file://placeholder'
    REFERENCES image(location),
  cost price NOT NULL
);

-- Falsche Daten
-- Spaltennamen koennen weggelassen werden, aber gefaehrlich
--INSERT INTO topping VALUES (null,null);
--INSERT INTO topping VALUES (null, 'super image location');

-- richtige daten
INSERT INTO topping (name,cost)
 VALUES ('salami',0.5),
        ('kalamari',1.5),
        ('knoblauch',0.0),
        ('champion',1.5),
        ('schincken',1.0),
        ('ananas',1.0),
        ('mozarella',1.5),
        ('spinat',1.0),
        ('hackfleisch',1.0);

CREATE TABLE beverage (
  name text PRIMARY KEy
    check (name != '')
    REFERENCES menu(name),
  img text 
    NOT NULL DEFAULT 'file://placeholder'
    REFERENCES image(location)
);


INSERT INTO beverage (name)
VALUES ('Cola'),('Wasser');


CREATE TABLE salad (
  name text PRIMARY KEy
    check (name != '')
    REFERENCES menu(name),
  img text 
    NOT NULL DEFAULT 'file://placeholder'
    REFERENCES image(location)
);
INSERT INTO beverage(name)
  VALUES ('Griechischer Salat'),
         ('Tomaten Salat');

CREATE TABLE pizza_compilation (
  pizza_name text
    references pizza(name),
  topping_name text
    references topping(name),
  PRIMARY KEY (pizza_name, topping_name)
);

INSERT INTO 
  pizza_compilation (pizza_name,topping_name) 
  VALUES ('Salami', 'salami'),
         ('Fungi','champion'),
         ('Hawai','schincken'),
         ('Hawai','ananas'),
         ('Mozarella','mozarella'),
         ('Spinaci','spinat'),
         ('Tubel','champion'),
         ('Tubel','hackfleisch');

CREATE TABLE food_category (
  name text 
    PRIMARY KEY 
    check (name != '')
);

INSERT INTO food_category (name)
VALUES ('beverage'),('salad'),('pizza');

CREATE TABLE food_size_price (
  category text 
    REFERENCES food_category,
  size numeric
    check (size > 0),
  cost price,
  PRIMARY KEY (category,size,cost)
);

INSERT INTO food_size_price 
  (category, size, cost)
VALUES
  ('beverage', 0.3, 1.0),
  ('beverage', 0.7, 1.50),
  ('beverage', 1.0, 2.0),
  ('salad', 1, 5.0),
  ('salad', 2, 7.0),
  ('pizza', 26, 6.0),
  ('pizza', 28, 8.0),
  ('pizza', 32, 10.0);


CREATE TABLE client (
  id BIGSERIAL PRIMARY KEY,
  first_name text 
    check (first_name != ''),
  last_name text
    check (last_name != ''),
  email text NOT NULL DEFAULT '',
  phone text NOT NULL DEFAULT ''
);

INSERT INTO client 
  (first_name,last_name)
VALUES
   ('renzo','k'),
   ('lady','gaga'),
   ('mesut','oezil');


INSERT INTO client 
  (first_name,last_name,email)
VALUES
   ('matthias','a', 'ma@supermail.com'),
   ('olaf','p', 'op@supermail.com'),
   ('peter','pan', 'pp@supermail.com');

INSERT INTO client 
  (first_name,last_name,email, phone)
VALUES
   ('matthias','a', 'ma@supermail.com', '0177666886'),
   ('olaf','p', 'op@supermail.com', '0177666889'),
   ('peter','pan', 'pp@supermail.com', '01776668876');


CREATE TABLE branch (
  code_name text PRIMARY KEY,
  full_name text 
    NOT NULL
    check (full_name != ''),
  city text 
    NOT NULL 
    DEFAULT ('Bremen'),
  street text 
    NOT NULL
    check (full_name != ''),
  num text 
    NOT NULL
    check (full_name != ''),
  opening_times text 
    NOT NULL
    check (full_name != '')
);

INSERT INTO branch
  (code_name, full_name,street, num, opening_times)
VALUES 
  ('mm1', 'Mama Mia!', 'Schoenhausen', 
   '343', 
   'MO-FR 11.00-24.00\nSA 11.00-2.00\nSO 14.00-22.00'
   );




CREATE TABLE "order" (
  id BIGSERIAL PRIMARY KEY,
  received timestamp 
    NOT NULL DEFAULT now(),
  channel text
    REFERENCES channel(name),
  estimated interval,
  prep_finish timestamp 
    NOT NULL 
    DEFAULT 'infinity',
  delivery_start timestamp,
  delivery_finished timeSTAMp
);

CREATE TABLE order_item (
  order_id bigint 
    REFERENCES "order"(id),
  food_name text
    REFERENCES menu(name),
  num integer not null DEFAULT 1,
  category text NOT NULL,
  cost price NOT NULL,
  size numeric NOT NULL,
  PRIMARY KEY (order_id,food_name,size,num),
  FOREIGN KEY (category,cost,size) 
   REFERENCES food_size_price
     (category,cost,size)
);


create table pizza_extra_topping (
  order_id bigint,
  num integer,
  topping_name text,
  pizza_name text,
  size numeric,
  PRIMARY KEY 
    (order_id, num,
     topping_name, pizza_name,size),
  FOREIGN KEY
    (order_id, num, pizza_name,size)
    REFERENCES order_item
    (order_id, num,food_name,size)
);