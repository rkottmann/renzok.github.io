
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

DROP TABLE IF EXISTS pizza, topping, image, pizza_compilation;


CREATE TABLE image (
  location text PRIMARY KEY,
  name text 
    NOT NULL 
	DEFAULT 'placeholder',
  copyright text 
    NOT NULL DEFAULT 'unknown',
  type text 
    NOT NULL DEFAULT 'unknown'
);

-- falsche Daten
INSERT INTO image (location, copyright, type)
  VALUES 
  ('super file location', 'super copyright', 'super bild type')
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
  ('file://here', 'Renzo Kottmann', 'png');

-- Implementiert entitaet pizza
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL 
    DEFAULT 'placeholder'
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
INSERT INTO pizza (name,img) VALUES ('Salami', 'file://here');

CREATE TABLE topping (
  name text PRIMARY KEy,
  img text 
);

-- Falsche Daten
-- Spaltennamen koennen weggelassen werden, aber gefaehrlich
--INSERT INTO topping VALUES (null,null);
--INSERT INTO topping VALUES (null, 'super image location');

-- richtige daten
INSERT INTO topping VALUES ('salami',null);


CREATE TABLE pizza_compilation (
  pizza_name text
    references pizza(name),
  topping_name text
    references topping(name),
  PRIMARY KEY (pizza_name, topping_name)
);

INSERT INTO 
  pizza_compilation (pizza_name,topping_name) 
  VALUES ('Salami', 'salami');