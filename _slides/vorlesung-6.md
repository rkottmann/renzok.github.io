
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
# Vorlesung 6
# Geschaeftprozesse 
# Beispiel Pizza Service Datenbank
###### IFI Wintersemester 2015/16
---
# Beim letzten Mal besprochen

* [Implementierung von Attributen mit Aufzaehlbaren Werten](/slides/vorlesung-6#6)
* [SQL: Create Domain](/slides/vorlesung-6.html#12)
* [SQL: Select](/slides/vorlesung-6.html#16)
* [SQL: Joins](/slides/vorlesung-6.html#32)

---
class: center, middle
# Vorherige Spezifikations-Versionen

* [Erste Spezifikation](/slides/pizza-service-spec-v1.html)
* [Zweite Spezifikation](/slides/pizza-service-spec-v2.html)
* [Dritte Spezifikation](/slides/pizza-service-spec-v3.html)
* [Vierte Spezifikation](/slides/pizza-service-spec-v4.html)
---
# Aktuelles ER Diagram

![erd-teilnehmerinnen](/img/dbl/pizza-complete-erd-v6.png)
---
# Abfrage: Menue-Uebersicht

![menu-zoom](/img/dbl/pizza-menu-zoom-erd-v6.png)
---
# Welche Pizza hat welchen Belag?
```sql
SELECT pizza_name, topping_name 
  FROM pizza_compilation;
```
---
# Welche Pizza hat welchen Belag?
## Nur eine Zeile pro Pizza!
SQL: [GROUP BY](http://www.postgresql.org/docs/9.5/interactive/queries-table-expressions.html#QUERIES-GROUP)
```sql
SELECT pizza_name, string_agg(topping_name, ',')
  FROM pizza_compilation
 GROUP BY pizza_name;
```
---
# Zeig mir zum Menu die Pizza-Bilder

```sql
SELECT num,menu.name,cost, pizza.img
  FROM menu
  LEFT JOIN
       pizza
    ON (menu.name = pizza.name)
 ORDER BY num;
```
---
# Zeig mir zum Menu Pizza-Bilder und toppings
SQL: [Subqueries](http://www.postgresql.org/docs/9.5/interactive/queries-table-expressions.html#QUERIES-FROM)
```sql
SELECT num,menu.name,cost, pizza.img, toppings
  FROM menu
  LEFT JOIN
       pizza
    ON (menu.name = pizza.name)
  LEFT JOIN (
         SELECT pizza_name, string_agg(topping_name, ',') AS toppings
           FROM pizza_compilation
           GROUP BY pizza_name
        ) AS pizza_topping
    ON (pizza.name = pizza_topping.pizza_name)
 ORDER BY num;
```
---
# Zeig mir zum Menu Pizza-Bilder und toppings
SQL: [CASE Expression](http://www.postgresql.org/docs/9.5/interactive/functions-conditional.html#FUNCTIONS-CASE)
```sql
SELECT num,menu.name,cost, pizza.img, 
       CASE WHEN toppings IS NULL 
            THEN 'kein Belag'
            ELSE toppings
        END as topping
  FROM menu
  LEFT JOIN
       pizza
    ON (menu.name = pizza.name)
  LEFT JOIN (
         SELECT pizza_name, string_agg(topping_name, ',') AS toppings
           FROM pizza_compilation
           GROUP BY pizza_name
        ) AS pizza_topping
    ON (pizza.name = pizza_topping.pizza_name)
 ORDER BY num;
```
---
class: center, middle
# Modellierung: Preisgestaltung
---
# Zoom in Menu
![menu-zoom](/img/dbl/pizza-menu-zoom-erd-v6a.png)
---
class: center, middle
# Modellierung: Bestellung
---
# Bestellung ERD
![menu-zoom](/img/dbl/pizza-bestellung-zoom-erd-v6a.png)
---
# Bestellvorgang vor Ort

1. Kunde kommt in den Laden
--

```sql
INSERT INTO "order" 
  (channel, delivery) 
VALUES
  ('lokal', 'f');
```
--
2. Sagt Bestellungswuensche
--

```sql
INSERT INTO order_item 
   (order_id,food_name, num, category, size) 
VALUES
   (1, 'Salami', 1, 'pizza', 32),
   (1, 'Fungi', 2, 'pizza', 28);
```
---
# Bestellvorgang vor Ort
## Zuordnungs-Problem:

Welcher **order_item** gehoert zu welcher **order**?
---
# Bestellvorgang vor Ort
## Loesung I: INSERT RETURNING

```sql
INSERT INTO "order" 
  (channel, delivery) 
VALUES
  ('lokal', 'f')
RETURNING *;
```
---
# SERIAL data type

* [SERIAL type](http://www.postgresql.org/docs/9.5/interactive/datatype-numeric.htm#DATATYPE-SERIAL) 
ist ein Datenbankobjekt
* Erzeugt eindeutige Identifier durch sequentielles hochzaehlen

```sql
CREATE TABLE tablename (
    colname SERIAL
);
``` 
identisch zu

```sql
CREATE SEQUENCE tablename_colname_seq;
CREATE TABLE tablename (
    colname integer NOT NULL DEFAULT nextval('tablename_colname_seq')
);
...
``` 
* Mit [SQL-Funktionen](http://www.postgresql.org/docs/9.5/interactive/functions-sequence.html), kann der Wert einer Sequence hochgezaehlt, neu gesetzt werden oder der aktuelle Wert bestimmt werden.
---
# Aktuelle Implementierung

* [SQL file mit ersten Testdaten](/slides/pizza-unconnected-erd.sql)

---
name: referenzen
# Referenzen:

* M. Unterstein and G. Matthiessen, Relationale Datenbanken und SQL in
  Theorie und Praxis. Berlin, Heidelberg: Springer Berlin Heidelberg,
  2012.
