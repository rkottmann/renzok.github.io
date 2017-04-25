DROP TABLE teilnehmer;
  
drop table geschlecht;

CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

INSERT INTO geschlecht 
  VALUES ('maennlich'),('weiblich');


CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4,
  geschlecht text
    REFERENCES geschlecht(name) on update cascade
);

INSERT INTO teilnehmer 
  (geschlecht,vorname, nachname, matrikel_nr, email) 
VALUES 
  ('maennlich','renzo','kottmann',007,'renzo@007.bond'),
  ('maennlich','peter','lustig',008,'peter@007.bond');







  