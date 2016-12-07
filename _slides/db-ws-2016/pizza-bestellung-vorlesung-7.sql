-- pizza bestellungen nach Vorlesung 7 ERD der Studentinnen


drop table if exists
order_item, 
  image, 
  pizza,
  topping,
  "order",
  pizza_compilation;

CREATE TABLE image (
  location text PRIMARY KEY,
  name text 
    NOT NULL 
	DEFAULT 'placeholder',
  copyright text 
    NOT NULL DEFAULT 'unknown',
  format text 
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
INSERT INTO image (location, copyright, format)
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




-- Implementiert entitaet pizza
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
    PRIMARY KEY,
  img text NOT NULL 
    DEFAULT 'file://placeholder'
    REFERENCES image (location)
);

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
    REFERENCES image(location)
);



-- richtige daten
INSERT INTO topping (name)
 VALUES ('salami'),
        ('kalamari'),
        ('knoblauch'),
        ('champion'),
        ('schincken'),
        ('ananas'),
        ('mozarella'),
        ('spinat'),
        ('hackfleisch');

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



CREATE TABLE "order" (
  id BIGSERIAL PRIMARY KEY,
  received timestamp 
    NOT NULL DEFAULT now(),
  
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
  (delivery) 
VALUES
  ( 't');


-- preparation started order
INSERT INTO "order" 
  (received, delivery,estimated,prep_start) 
VALUES
  ('2016-01-02 11:00:00', 't', '00:00:30', '2016-01-02 11:01:00');


-- preparation done
INSERT INTO "order" 
  (received, delivery,estimated,
   prep_start, prep_end) 
VALUES
  ('2016-01-03 16:00:00', 't', '00:00:30', 
   '2016-01-03 16:01:00', '2016-01-03 16:14:00');

-- in delivery
INSERT INTO "order" 
  (received, delivery,estimated,
   prep_start, prep_end,
   del_start) 
VALUES
  ('2016-01-03 15:55:00', 't','00:00:15', 
   '2016-01-03 15:55:00', '2016-01-03 15:04:00',
   '2016-01-03 15:04:00');

-- finished orders
INSERT INTO "order" (
  received,  delivery,
  estimated, prep_start, prep_end, 
  del_start, del_end)
VALUES 
('2016-01-01 10:00:00', 't',
  '00:00:30', '2016-01-01 10:02:00', '2016-01-01 10:13:00',
  '2016-01-01 10:15:00','2016-01-01 10:28:00'),
('2016-01-01 10:00:00', 't',
  '00:00:30', '2016-01-01 10:02:00', '2016-01-01 10:13:00',
  '2016-01-01 10:15:00','2016-01-01 10:28:00')

  ;





CREATE TABLE order_item (
  order_id bigint 
    REFERENCES "order"(id),
  pizza_name text,
  topping_name text,
  num integer not null DEFAULT 1,
  category text NOT NULL,
  PRIMARY KEY (order_id,pizza_name, topping_name,num),
  Foreign key (pizza_name,topping_name)
    REFERENCES pizza_compilation(pizza_name,topping_name)
);

INSERT INTO order_item (
  order_id, pizza_name,topping_name,num, category
) VALUES
(
  1, 'Salami', 'salami', 1, 'pizza'
),
(
  1, 'Fungi','champion', 2, 'pizza'
),
(
  2, 'Fungi','champion', 1, 'pizza'
),
(
  2, 'Hawai','ananas', 1, 'pizza'
)
;

