/* Implementierung des Projekts: "Toller Name"
 * Autor: Renzo Kottmann
 */
 -- 1. loeschen evtl. schon bestehender Tabellen

DROP TABLE IF EXISTS artist, album;
 
 -- 2. loeschen zuvor angelegter Domainen
 
 -- 3. Anlegen von Domains und anderen wichtigen nicht Tabellen Datenbank-Objekten

CREATE Table artist (
 name text primary key
);

 CREATE Table album (
 -- der ist wohl ziemlich schlecht...
name text primary key
 );
 -- 4. Anlegen der Tabellen
 -- Bei Lookup Tabellen direkt gefolgt von Daten eintragen/laden
 
 -- 5. Fuellen der Tabellen mit Daten
 -- evtl. spaeter in eigene Datei auslagern
 
 -- 6. Abfragen
 -- evtl. spaeter in eigene Datei auslagern
 -- Git ist es die Anfrage hier zu dokumentieren, direkt gefolgt vom SELECT
 -- z.B. Anfrage: "Wieviele Teilnehmerinnen hat der WiSe 2017 Kurs"

 -- Wieviele platten habe ich?

 -- Wieviele Alben von Kuenstler X
 
