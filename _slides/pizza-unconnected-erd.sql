
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

DROP TABLE IF EXISTS pizza, topping, image;
 
CREATE TABLE pizza (
  name text,
  image text
);
-- falsche Daten
-- Meiste verwendete INSERT Syntax
INSERT INTO pizza (name,image) VALUES (null,null);
INSERT INTO pizza (name,image) VALUES ('salami',null);
INSERT INTO pizza (name,image) VALUES ('Salami', '');
INSERT INTO pizza (name,image) VALUES (null, 'super image location');

-- richtige daten
INSERT INTO pizza (name,image) VALUES ('Salami', 'file://here');

CREATE TABLE topping (
  name text,
  image text
);

-- Falsche Daten
-- Spaltennamen koennen weggelassen werden, aber gefaehrlich
INSERT INTO topping VALUES (null,null);
INSERT INTO topping VALUES ('salami',null);
INSERT INTO topping VALUES (null, 'super image location');



CREATE TABLE image (
  location text,
  copyright text,
  type text
);

INSERT INTO image (location, copyright, type)
  VALUES 
  ('super file location', 'super copyright', 'super bild type'),
  ('super file location', 'super copyright', 'super bild type'),
  (null, null, null),
  ('', NULL, NULL),
  (NULL, '', null),
  (NULL, NULL, '');
  
-- richtige Daten
InSERT INTO image (location, copyright, type)
  VALUES
  ('file://here', 'Renzo Kottmann', 'png');