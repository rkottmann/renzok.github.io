
DROP TABLE teilnehmer;
drop table datenbank_projekt;

CREATE TABLE teilnehmer (
--Spalten Name Datentyp,
  vorname text,
  nachname text,
  -- Simpler (nicht bester Primary Key)
  matrikel_nr integer PRIMARY KEY,
  email text,
  semester integer
);

CREATE tabLE datenbank_projekt (
 titel text PRIMARY KEY,
 abgabe date
);

INSERT INTO teilnehmer
  (vorname, nachname, matrikel_nr, email, semester)
VALUES
  ('renzo','kottmann',007,'renzo@007.bond', 0);