
#

by Renzo Kottmann


<a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br
/>This work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons
Attribution-NonCommercial 4.0 International License</a>.

---
class: center, middle
# Modul Datenbanken
# Vorlesung 5
# Von Anfragen zu Abfragen: 
# Beispiel Pizza Service Datenbank
###### IFI Wintersemester 2015/16
---
# Beim letzten Mal besprochen

* [Constraints auf einzelnen Tabellen](/slides/vorlesung-4#11)
* [SQL Implementierung von Entitaets-Beziehungen](/slides/vorlesung-4.html#20)
---
class: center, middle
# Vorherige Spezifikations-Versionen

* [Erste Spezifikation](/slides/pizza-service-spec-v1.html)
* [Zweite Spezifikation](/slides/pizza-service-spec-v2.html)
* [Dritte Spezifikation](/slides/pizza-service-spec-v3.html)
---
class: center, middle
# Von unteilbaren Attributen
## Vertiefung
---

# Wertebereiche (Domaenen)

## Arten von Daten
1. Zahlen (integer, numeric, double precision...)
2. Free Text (text, char)
3. Enumeration
2. Code-List
5. Komplexe Zusamensetzungen der oberen "einfachen Arten"
   Z.B. Telefonnummern, Zeitstempel (Datum + Uhrzeit)...
---
# Enumeration & Code List
1. **Enumeration**:
   Liste von Werten, die in Zukunft wenig bis gar nicht geaendert wird
   
   z.B. `Geschlecht = {maennlich,weiblich}`
1. **Code-List**:
   Liste von Werten, die in Zukunft haeufig und zu jeder Zeit geaendert wird
---
# Implementierung mit SQL Commands
1. `check` constraint: 
   
   `gender text check (gender in ['maennlich','weiblich'])`
2. [Enumerated Types](http://www.postgresql.org/docs/9.3/static/datatype-enum.html):

   `CREATE TYPE gender AS ENUM ('maennlich','weiblich');` 
---
class: split-40
# Implementierung mit Hilfe einer Tabelle

## Beispiel Kunde

.column[
 ![kunde-geschlecht-lookup-erd](/img/dbl/kunde-geschlecht-lookup-erd.png)
]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);
INSERT INTO geschlecht 
  VALUES ('maennlich'),('weiblich');
CREATE TABLE kunde (
  name text PRIMARY KEY,
  alter integer,
  geschlecht text 
    REFERENCES geschlecht(name)
);
INSERT INTO kunde (name, alter, geschlecht) 
   VALUES ('renzo','100','maennlich');
~~~
]
---
# Aktuelles ER Diagram

![erd-teilnehmerinnen](/img/dbl/pizza-complete-erd-v5.png)
---
# Zoom in Menu

![menu-zoom](/img/dbl/pizza-menu-zoom-erd-v5.png)
---
# SQL Kommando: CREATE DOMAIN

* Definition von [eigenen Datentypen](http://www.postgresql.org/docs/current/static/sql-createdomain.html) basierend of existierenden

~~~sql
CREATE DOMAIN url AS text CHECK (
  VALUE ~ '^file|http'
);
~~~
---
class: center, middle
# Von Anfragen zu Abfragen
---
# Anfragen
* Gruende fuer relationale Datenbanken:
  
  1. Persistente, sichere und strukturierte Datenspeicherung
  1. Effiziente Anfragen! 
     Z.b. wieviel Umsatz hat die Pizzeria am 15.10.2015 gemacht? 
--

* SQL hat nur einen Befehl dafuer: 
  **SELECT**

---
# Anatomy von SELECT

~~~sql
SELECT *        -- welche Spalten sollen wie angezeigt werden
  FROM tabelle  -- Daten welcher Tabelle 
 WHERE true     -- Selektionesbedingungen: nur Daten, die Kriterium entsprechen
~~~
---
# Anatomy von SELECT

~~~sql
SELECT *        -- * (asterisk) heisst alle spalten, wie sie sind
  FROM order    -- Daten der Tabelle mit dem Namen "order"
 WHERE true     -- Boolsche Bedingung: hier true also alle Daten
~~~
---
### **ANFRAGE:**
# Zeig mir alle Preise pro Groesse!

### **ABFRAGE:**
~~~sql
SELECT *       
  FROM food_size_price;
~~~
---
# Wie teuer ist ein Getraenk der Groesse 0.3L ?

~~~sql
SELECT *       
  FROM food_size_price
 WHERE size = 0.3;
~~~
---
# Wie teuer ist ein Getraenk der Groesse 0.3L ?

### Explizite Nennung der gewuenschten Spalten
~~~sql
SELECT category, cost, size       
  FROM food_size_price
 WHERE size = 0.3;
~~~
---
# Wie teuer ist ein Getraenk der Groesse 0.3L ?

### Umbennung der gewuenschten Spalten und Tabelle
~~~sql
SELECT category AS art, cost AS preis, size as groesse       
  FROM food_size_price
 WHERE size = 0.3;
~~~
---
# Welche Getraenke sind groesser als 0.3L ?

~~~sql
SELECT category AS art, cost AS preis, size as groesse  
  FROM food_size_price
 WHERE size > 0.3;
~~~
---

# Welche Getraenke sind groesser als 0.3L ?

### Besssere, da praezisere Abfrage:
~~~sql
SELECT category AS art, cost AS preis, size as groesse
  FROM food_size_price
 WHERE size > 0.3
       AND
	   category = 'beverage';
~~~
---
# Zeig mir alle Pizza-Groessen!

~~~sql
SELECT category AS art, cost AS preis, size as groesse
  FROM food_size_price
 WHERE category = 'Pizza';
~~~
---
# Zeige mir alle Getraenke-Groesse mit Masseinheit ?

~~~sql
SELECT size || 'L' AS groesse_einheit       
  FROM food_size_price
 WHERE category = 'beverage';
~~~
---
# Zeig mir das Menu

~~~sql
SELECT *       
  FROM menu;
~~~
---
# Zeig mir das Menu geordnet nach nummer!

~~~sql
SELECT *       
  FROM menu
  ORDER BY num;
~~~
--
## und umgedrehte Reihenfolger

~~~sql
SELECT *       
  FROM menu
  ORDER BY num DESC;
~~~
---
# Wieviele Eintraege hat das Menu?
~~~sql
SELECT count(*)       
  FROM menu
  ORDER BY num DESC;
~~~
---
# Abfragen ueber mehere Tabellen
---
# Beispiel Tabelle
~~~
TabelleA      TabelleB
id name       id  name
-- ----       --  ----
1  Pirate     1   Rutabaga
2  Monkey     2   Pirate
3  Ninja      3   Darth Vader
4  Spaghetti  4   Ninja
~~~
---
class: split-50
# INNER JOIN

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       INNER JOIN 
	   TabelleB as b
    ON a.name = b.name
~~~
~~~
id  name       id   name
--  ----       --   ----
1   Pirate     2    Pirate
3   Ninja      4    Ninja
~~~
]

.column[
![inner-join](/img/dbl/inner-join-small.png)
]
---
class: split-50
# FULL OUTER JOIN

.column[
~~~sql
SELECT * 
  FROM TabelleA as a
       FULL OUTER JOIN 
	   TabelleB as b
    ON a.name = b.name
~~~

~~~
id    name       id    name
--    ----       --    ----
1     Pirate     2     Pirate
2     Monkey     null  null
3     Ninja      4     Ninja
4     Spaghetti  null  null
null  null       1     Rutabaga
null  null       3     Darth Vader
~~~
]

.column[
![inner-join](/img/dbl/full-outer-join-small.png)
]
---
class:split-50
# LEFT OUTER JOIN

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       LEFT OUTER JOIN 
	   TabelleB AS b
    ON a.name = b.name
~~~

~~~
id  name       id    name
--  ----       --    ----
1   Pirate     2     Pirate
2   Monkey     null  null
3   Ninja      4     Ninja
4   Spaghetti  null  null
~~~
]
.column[
![sql-joins-venn](/img/dbl/left-outer-join-small.png)
]
---
class:split-50
#  LEFT OUTER JOIN: nur Zeilen von TabelleA

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       LEFT OUTER JOIN 
	   TabelleB AS b
    ON a.name = b.name
 WHERE b.id IS null
~~~

~~~
id  name       id     name
--  ----       --     ----
2   Monkey     null   null
4   Spaghetti  null   null
~~~
]
.column[
![sql-joins-venn](/img/dbl/left-outer-join-exclusive-small.png)
]
---
class:split-50
#  FULL OUTER JOIN: nur exklusive Zeilen

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       FULL OUTER JOIN
	   TabelleB AS b
    ON a.name = b.name
 WHERE a.id IS null
       OR 
	   b.id IS null
~~~

~~~	
id    name       id    name
--    ----       --    ----
2     Monkey     null  null
4     Spaghetti  null  null
null  null       1     Rutabaga
null  null       3     Darth Vader
~~~
]
.column[
![sql-joins-venn](/img/dbl/full-outer-join-exclusive-small.png)
]
---
class:split-50
# CROSS JOIN: Erzeugt kartesiches Produkt

.column[
~~~sql
SELECT * 
  FROM TabelleA
       CROSS JOIN 
	   TabelleB
~~~
]
.column[
![sql-joins-venn](/img/dbl/cartesian-product.png)
]
In einfachen Worten: Verbindet jede Zeile der TabelleA mit jeder Zeile der TabelleB
---

![sql-joins-venn](/img/dbl/sql-join-venn-overview.jpg)

---
# Diskussion zu Visualisierung von SQL-joins

* [Original Artikel mit Venn-Overview](http://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins)
* [Diskussion und alternative Darstellung](http://stackoverflow.com/questions/13997365/sql-joins-as-venn-diagram)
* [Kategorisierung nach JOIN-Typen](www.way2tutorial.com/sql/sql_join_types_visual_venn_diagram.php)
---

# Aktuelle Implementierung

* [SQL file mit ersten Testdaten](/slides/pizza-unconnected-erd.sql)

---
name: referenzen
# Referenzen:

* M. Unterstein and G. Matthiessen, Relationale Datenbanken und SQL in
  Theorie und Praxis. Berlin, Heidelberg: Springer Berlin Heidelberg,
  2012.
