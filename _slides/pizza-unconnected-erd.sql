

set client_min_messages = 'error';
-- SQL zur Implementeirung der Pizza Service Datenbank


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
  client, branch, delivery_address, channel,
  food_category, food_size_price,delivery ;



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

-- falsche Daten, d.h. 
--INSERT INTO image (location, copyright, type)
--  VALUES 
--  ('super file location', 'super copyright', 'super bild type')
  --,
  --('super file location', 'super copyright', 'super bild type'),
  --(null, null, null),
  --('', NULL, NULL),
  --(NULL, '', null),
  --(NULL, NULL, '');
  
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



CREATE TABLE food_category (
  name text 
    PRIMARY KEY 
    check (name != ''),
  size_unit text     
);

INSERT INTO food_category (name,size_unit)
VALUES ('beverage', 'L'),('salad', ''),('pizza', 'cm');
  
CREATE TABLE menu (
  name text PRIMARY KEY,
  num integer check (num > 0) NOT NULL UNIQUE,
  cost price NOT NULL,
  category text REFERENCES food_category NOT NULL
);

INSERT INTO menu (num, name,cost,category)
  VALUES  
  (5,'Fungi', 10.0, 'pizza'),
  (2,'Salami', 10.0,'pizza'),
  (6,'Hawai', 10.0,'pizza'),
  (4,'Mozarella', 10.0,'pizza'),
  (1,'Spinaci', 10.0,'pizza'),
  (3,'Tubel', 10.0,'pizza'),
  (7,'Griechischer Salat', 10.0,'salad'),
  (8,'Tomaten Salat', 10.0,'salad'),
  (9,'Cola', 1.0,'beverage'),
  (10,'Biolunder', 2.0,'beverage'),
  (11,'Wasser', 10.0,'beverage');
  

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

CREATE TABLE food_size_price (
  category text 
    REFERENCES food_category,
  size numeric
    check (size > 0),
  cost price,
  PRIMARY KEY (category,size)
);

INSERT INTO food_size_price 
  (category, size, cost)
VALUES
  ('beverage', 0.3, 0.0),
  ('beverage', 0.7, 0.50),
  ('beverage', 1.0, 1.0),
  ('salad', 1, 0.0),
  ('salad', 2, 2.0),
  ('pizza', 26, 0.0),
  ('pizza', 28, 2.0),
  ('pizza', 32, 4.0);


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
  delivery boolean NOT NULL,
  estimated interval NOT NULL default '00:00:15',
  -- time preparation starts
  prep_start timestamp 
    NOT NULL 
    DEFAULT 'infinity',
  -- time preparation finishes
  prep_end timestamp 
    NOT NULL 
    DEFAULT 'infinity',
  -- time delivery starts
  del_start timestamp
    NOT NULL 
    DEFAULT 'infinity',
  -- time delivery finishes
  del_end timestamp
    NOT NULL
    DEFAULT 'infinity'
);

-- just received order
INSERT INTO "order" 
  (channel, delivery) 
VALUES
  ('telefon', 't');


-- preparation started order
INSERT INTO "order" 
  (received, channel, delivery,estimated,prep_start) 
VALUES
  ('2016-01-02 11:00:00','telefon', 't', '00:00:30', '2016-01-02 11:01:00');


-- preparation done
INSERT INTO "order" 
  (received, channel,delivery,estimated,
   prep_start, prep_end) 
VALUES
  ('2016-01-03 16:00:00','telefon', 't', '00:00:30', 
   '2016-01-03 16:01:00', '2016-01-03 16:14:00');

-- in delivery
INSERT INTO "order" 
  (received, channel,delivery,estimated,
   prep_start, prep_end,
   del_start) 
VALUES
  ('2016-01-03 15:55:00','telefon', 't','00:00:15', 
   '2016-01-03 15:55:00', '2016-01-03 15:04:00',
   '2016-01-03 15:04:00');

-- finished orders
INSERT INTO "order" (
  received, channel, delivery,
  estimated, prep_start, prep_end, 
  del_start, del_end)
VALUES 
('2016-01-01 10:00:00', 'internet', 't',
  '00:00:30', '2016-01-01 10:02:00', '2016-01-01 10:13:00',
  '2016-01-01 10:15:00','2016-01-01 10:28:00'),
('2016-01-01 10:00:00', 'internet', 't',
  '00:00:30', '2016-01-01 10:02:00', '2016-01-01 10:13:00',
  '2016-01-01 10:15:00','2016-01-01 10:28:00')

  ;





CREATE TABLE order_item (
  order_id bigint 
    REFERENCES "order"(id),
  food_name text
    REFERENCES menu(name),
  num integer not null DEFAULT 1,
  category text NOT NULL,
  size numeric NOT NULL,
  PRIMARY KEY (order_id,food_name,size,num),
  FOREIGN KEY (category,size) 
   REFERENCES food_size_price
     (category,size)
);

INSERT INTO order_item (
  order_id,food_name, num, category, size
) VALUES
(
  1, 'Salami', 1, 'pizza', 32
),
(
  1, 'Fungi', 2, 'pizza', 28
),
(
  2, 'Fungi', 1, 'pizza', 28
),
(
  2, 'Fungi', 1, 'pizza', 26
),
(
  3, 'Griechischer Salat', 1, 'salad', 1
)
;

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

insert into pizza_extra_topping 
(order_id, num, topping_name,pizza_name,size)
  VALUES
(1, 1, 'Knoblauch','Salami', 32);


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


CREATE TABLE delivery_address (
  city text,
  street text,
  num text,
  postal_code text default '',
  PRIMARY KEY(city,street,num)
);

insert into delivery_address
  (city,street,num)
VALUES
  ('Bremen','Flughafenalle','10'),
  ('Bremen','Domsheide','99'),
  ('Bremen','Osterweg','77')
  ;

CREATE TABLE delivery (
  order_id integer,
  client_id integer,
  city text,
  street text,
  num text,
  PRIMARY KEY (order_id,client_id,city,street,num)
);


insert into delivery
  (order_id,client_id,city,street,num)
VALUES
  (1,1,'Bremen','Domsheide','99')
  ;