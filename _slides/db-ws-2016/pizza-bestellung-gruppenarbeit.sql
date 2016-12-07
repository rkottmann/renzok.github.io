
drop table if exists 
 pizza,
 topping,
 pizza_compilation,
 kunde,
 bestellposten;

CREATE TABLE pizza (
  name text
    check ( name != ''::text)
    PRIMARY KEY
);

CREATE TABLE topping (
  name text PRIMARY KEY
);

CREATE TABLE pizza_compilation (
  pizza_name text
    references pizza(name),
  topping_name text
    references topping(name),
  PRIMARY KEY (pizza_name, topping_name)
);



CREATE Table kunde (
  kundennummer INTEGER CHECK(kundennummer :: text ~ '[0-9]{5}')
    PRIMARY KEY,
  nachname text,
  vorname text,
  tel INTEGER,
  straße text,
  hausnummer INTEGER,
  plz INTEGER
);


create table bestellung (
  kunde_num integer not null
   references kunde(kundennummer),
  b_start time,
  b_ende time,
  ausgang time,
  PRImary key (kunde_num,b_ende)
);


CREATE Table bestellposten (
  kunde_num integer not null,
  b_ende time not null,

  foreign key (kunde_num,b_ende) references bestellung (kunde_num,b_ende)
  foreign key (kunde_num,b_ende) references bestellung (kunde_num,b_ende)

);

