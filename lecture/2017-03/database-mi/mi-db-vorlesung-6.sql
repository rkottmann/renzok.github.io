/* Disclaimer: Dieses SQL entspricht nicht unbeding 100% einem der ERDs in den Vorlesungen, 
 *  da es ja Work in Progress ist.
 */

create extension if not exists "uuid-ossp";


DROP TABLE IF EXISTS
  labor_abgabe,
  teilnehmer;

DROP TABLE IF EXISTS 
  projekt_gruppe,
  labor_gruppe;
  
DROP TABLE IF EXISTS 
  labor_uebung;
  
drop table if exists geschlecht;



CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

INSERT INTO geschlecht 
  VALUES ('maennlich'),('weiblich');
  

CREATE TABLE labor_gruppe (
  code text 
    PRIMARY KEY
    CHECK ( code IN  ('w','x','y','z') ) ,
  anfangstag date 
    NOT NULL,
  anfangszeit time
    NOT NULL
);

INSERT INTO labor_gruppe 
  (code,anfangstag,anfangszeit)
VALUES
  ('w', '2017-03-21', '10:00:00'),
  ('x', '2017-03-21', '13:30'),
  ('y', '2017-03-28', '10:00'),
  ('z', '2017-03-28', '13:30');

CREATE TABLE projekt_gruppe (
  titel text 
    PRIMARY KEY
    CHECK ( titel != '' ) ,
  thema text 
    NOT NULL
    DEFAULT ''
);

  
CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
    CHECK ( vorname != '' ),
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4,
  note numeric 
    default 'nan'
    NOT NULL,
  projekt text
    REFERENCES projekt_gruppe,
  labor text
    --NOT NULL
    REFERENCES labor_gruppe(code),
  geschlecht text
    REFERENCES geschlecht(name) on update cascade,
  uid uuid default uuid_generate_v4()
);


CREATE TABLE labor_uebung (
  titel text 
    PRIMARY KEY,
  gestellt date 
    NOT NULL
    UNIQUE 
);

CREATE TABLE labor_abgabe (
  gruppe text
    REFERENCES projekt_gruppe(titel),
  uebung text
    REFERENCES labor_uebung(titel),
    
  PRIMARY KEY (gruppe,uebung)
);


INSERT INTO teilnehmer 
  (geschlecht,vorname, nachname, matrikel_nr, email, semester) 
VALUES 
  ('maennlich','renzo','kottmann',007,'renzo@007.bond', 10),
  ('weiblich','Zoe','Nice',044,'zoe@mi5.bond', 4),
  ('weiblich','Money','Penny',0664,'euro@mi5.bond', 2),
  ('maennlich','peter','lustig',008,'peter@007.bond',4);


INSERT INTO labor_uebung
  (titel,gestellt)
VALUES
  ('Labor Uebung 1', '2017-03-21'),
  ('Labor Uebung 2', '2017-03-28'),
  ('Labor Uebung 3', '2017-03-29')
  ;


INSERT INTO projekt_gruppe
  (titel, thema)
VALUES
('Blackhats',''),
('Cupcakes',''),
('Datenbanker',''),
('die lambdas',''),
('DieMannschaft',''),
('diesdas',''),
('Tatooines',''),
('fsociety',''),
('FUNFUNFUN',''),
('Germanien',''),
('Gravidus',''),
('IT - BoyZ',''),
('IT-Girls',''),
('Lucarts',''),
('Magnus Opus',''),
('MI-LF',''),
('MIY',''),
('MyFridge',''),
('DogSitter',''),
('ToolTime 24',''),
('WebCV',''),
('Zio',''),
('404','')
;


INSERT INTO labor_abgabe 
  (gruppe,uebung)
VALUES
  ('MIY', 'Labor Uebung 1'),
  ('MIY', 'Labor Uebung 2'),
  ('MIY', 'Labor Uebung 3'),
  ('MyFridge', 'Labor Uebung 1');


-- gib alle daten aller teilnehmer
select * from Teilnehmer;

-- Wieviele teilnehmer gibt es im kurs
select count(*) from Teilnehmer;


-- welches geschlecht hat renzo kottmann
select geschlecht from Teilnehmer where vorname = 'renzo' and nachname = 'kottmann' ;

-- Welche teilnehmer sind im hoeheren Semster als 3
select * from Teilnehmer where semester < 3 ;

-- Wieviele teilehmer sind semester > 3
select count(*) from Teilnehmer where semester < 3 ;

-- Wieviele semester haben alle studenten zusaamengenommen studiert und was ist der durchshcnitt
select sum(semester) as summe_semester, 
       avg(semester) as durchschnitt_semester 
  from Teilnehmer;

-- alle teil. deren vorname mit Z anfaengt
select * 
  from Teilnehmer 
 where vorname ~* '^z';

-- Summe und Durchschnittssemester der Teilnehmer pro Geschlecht
select geschlecht, sum(semester) as summe, avg(semester) as durchschnitt
  FROM teilnehmer
  GROUP by geschlecht



 
 
 