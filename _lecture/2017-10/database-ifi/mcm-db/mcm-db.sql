/** 
 * Implementierung des Projekts: "Toller Name"
 * Autor: Renzo Kottmann
 */
 
drop FUNCTION if exists i_artist(
  text, 
  year, 
  text, 
  text
);


-- 1. Loeschen evtl. schon bestehender Tabellen

DROP TABLE IF EXISTS 
 master_release,
 media_type,
 media,
 artist,
 band,
 band_member,
 album, 
 performer,
 invoice_line,
 invoice,
 customer
 ;

drop domain IF EXISTS
  canonical,
  year,
  month,
  day
;
 -- 2. Loeschen zuvor angelegter Domainen

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
 
 -- 3. Anlegen von Domainen und anderen wichtigen nicht Tabellen Datenbank-Objekten

-- erlaube keine Leerzeichen am Anfang und Ende
-- muss mindestens ein Leerzeichen haben

/* ACHTUNG: rege falsch, es laesst Leerzeichen am zu */
create domain canonical as text 
  check (value ~ '^[^\s]+.+[^\s]*$')
;

-- assuming that nothing in DB was generated before year 1800
-- and DB will not exist longer than 2100
-- alles nach gregorianischem kalendar
-- erlaube 0 als wert fuer unbekannt 
create domain year as integer 
  check (value = 0 or Value between 1800 and 2100)
;
create domain month as integer
  check (value between 0 and 12)
;

create domain day as integer
  check (value between 0 and 31)
;

-- 4. Anlegen der Tabellen
-- Bei Lookup Tabellen direkt gefolgt von Daten eintragen/laden
-- Liste aller Kuenstlername von einzel personen und gruppen
CREATE Table performer (
 performer_id uuid 
   DEFAULT uuid_generate_v1()
   PRIMARY KEY,
 -- name needs to be given
 name canonical not null ,
 since_yr year NOT NULL DEFAULT 0,
 -- combination of name and year as 'natural key'
 rating integer,
 UNIQUE (name,since_yr)
);

insert into performer(name) values
('The Cure'),
('Brian Eno'),
('Beyonce'),
('Eminem'),
('Pur'),
('Air')
;

-- A different Band with same name exists
insert into performer(name, since_yr) values
('Air', 1974)
;

-- Wie kann man doppelte Eintraege einfach ignorieren?
insert into performer(name, since_yr)
  values
    ('Air', 1974)  
  ON CONFLICT DO NOTHING
;


CREATE Table artist (
 artist_id uuid 
   DEFAULT uuid_generate_v1()
   PRIMARY KEY,
 name canonical,
 born_yr year,
 born_month month,
 born_day day,
 died_yr year,
 died_month month,
 died_day day,
 origin_country text,
 biography text,
 unique(name, born_yr),
 -- Variant one
 foreign key (name,born_yr) references performer(name, since_yr) 
);




CREATE Table band (
 band_id uuid 
   Primary key
   references performer(performer_id),
 -- variant two leaving out foreign key to performer
 disbanded_yr integer,
 origin_country text,
 biography text
);

CREATE Table band_member (
 band_id uuid references band(band_id),
 -- variant two leaving out foreign key to performer
 artist_id uuid references artist(artist_id),
 PRIMARY KEY (band_id, artist_id)
);


CREATE TABLE media_type (
  label canonical primary key
);
insert into media_type values
('CD'),('LP'),('Cassette');


-- Using Discogs notion of a master release, which 
CREATE TABLE master_release (
 title canonical,
 artist uuid references performer(performer_id),
 release_yr integer,
 -- an artist does not release albums of same name
 PRIMARY KEY (title,artist)
);

 CREATE Table media (
   -- der ist wohl ziemlich schlecht...
  name canonical,
  media_type canonical references media_type(label),
  release_yr integer,
  release_month integer,
  release_day integer
 );

/* 
 * Hier geht jetzt Verkauf und Rechnungen los.
 */

/* Die Kundin */
CREATE TABLE Customer (
  customer_id INT 
    primary key,
  first_name text NOT NULL,
  last_name text NOT NULL,
  Company text,
  Address text,
  City text,
  State text,
  Country text,
  PostalCode text,
  Email text NOT NULL
);

insert into customer 
  (customer_id, first_name, last_name, email)
    Values 
  (1, 'Helmut', 'Kohl', 'kohl@hase.de');


/* Die Rechnung */
CREATE TABLE invoice
(
  invoice_id INT primary key,
  customer_id INT NOT NULL
    references customer(customer_id),
  billint_date TIMESTAMP NOT NULL default now(),
  BillingAddress text,
  BillingCity text,
  BillingState text,
  BillingCountry text,
  BillingPostalCode text
  --Total NUMERIC(10,2) NOT NULL,
  
);

insert into invoice 
  (invoice_id, customer_id)
values
  (2,1);

CREATE TABLE invoice_line
(
  invoice_line_id INT primary key,
  invoice_id INT NOT NULL
    references invoice(invoice_id),
  unit_price NUMERIC(10,2) NOT NULL,
  quantity INT NOT NULL
);

insert into invoice_line
  (invoice_line_id, invoice_id, unit_price, quantity)
  values
  (1,2,20.2, 2),
  (2,2,23.4, 1),
  (3,2,20.2, 2);
 
 
 -- 5. Fuellen der Tabellen mit Daten
 
 -- 6. Abfragen
 
 -- Wieviele Platten habe ich?
SELECT count(*) from performer;
 -- Wieviele Alben von Kuenstler X

 
-- Jetzt will ich aber einfach einen artist einfuegen
insert into performer(name, since_yr)
  values
    ('David Bowie', 1974)  
  ON CONFLICT (name,since_yr) DO update set name = excluded.name
  returning *
;
-- keine ahnung ob David schon in DB ist, aber in jedem Fall neues rating einfuegen oder updaten
insert into performer(name, since_yr, rating)
  values
    ('David Bowie', 1974,5)
  ON CONFLICT (name,since_yr) DO update set rating = excluded.rating
  returning *
;


-- Bei der Variante mit Artist geht auch einfache Transaktion
begin;

insert into performer(name, since_yr)
  values
    ('Wolfgang Petry', 1974)  
  ON CONFLICT (name,since_yr) DO update set name = excluded.name
  returning *
;


insert into artist(name, born_yr, origin_country, biography)
  values
    ('Wolfgang Petry', 1974, 'Germany', 'Super duper artist' ) ;
;
commit;


-- um weniger tippen zu mussen

CREATE OR REPLACE FUNCTION i_artist(
  f_name text, 
  f_born_year year, 
  f_country text, 
  f_biography text
) returns artist as $$

insert into performer(name, since_yr)
  values
    (f_name, f_born_year)  
  ON CONFLICT (name,since_yr) 
    DO update set name = excluded.name
  returning *
;
insert into artist(name, born_yr, origin_country, biography)
  values
    (   f_name, 
  f_born_year , 
  f_country , 
  f_biography) returning *;
$$ LANGUAGE SQL;


select * from i_artist('Khaled', 1991, 'Germany', 'Geile Type') as t;

--select * from i_artist('Heino', 1991, 'Geany', 'Geile Type') as t;

CREATE OR REPLACE FUNCTION random_text(int)
RETURNS text
AS $$ 
  SELECT array_to_string(
    ARRAY (
      SELECT substring(
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' FROM (random() *26)::int FOR 1)
      FROM generate_series(1, $1) ), '' ) 
$$ LANGUAGE sql;


insert into customer(customer_id, first_name, last_name, email) 
     Select g.id, 
            trunc(g.id * random() + 1),--chr(generate_series(65,90),
            random_text(7),--chr(generate_series(65,90),
            md5(random()::text) || '@' || md5(random()::text) || '.de' 
       from generate_series(2,100) AS g(id)
            ;

select * from customer;


-- now generate xml similar to
/*
 <cac:InvoiceLine>
    <cbc:ID>1</cbc:ID>
    <cbc:LineExtensionAmount currencyID="CAD">100.00</cbc:LineExtensionAmount>
    <cac:Item>
       <cbc:Description>Cotter pin, MIL-SPEC</cbc:Description>
    </cac:Item>
  </cac:InvoiceLine>
*/
select 
  xmlelement( name "InvoiceLine", 
      xmlelement( name "ID", il.invoice_line_id),
      xmlelement( name "LineExtensionAmount", 
                  xmlattributes( 'EUR' as "currencyID"),
                  il.unit_price
      ),
      xmlelement( name "Item",
          xmlelement( name "Description", 'a description' )
      )
  ) as single_column
FROM invoice_line as il;

  