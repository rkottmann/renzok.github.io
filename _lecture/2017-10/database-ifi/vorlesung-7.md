# Datenbank-Systeme
## {{ page.title }} 
### {{ page.lecture }}
 
Renzo Kottmann 

<a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br
/>This work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons
Attribution-NonCommercial 4.0 International License</a>.

---
# Wiederholung

## [Datenbank-Projekt](vorlesung-5.html#11)

---
# Anfragen

Z.B. Wieviel Teilnehmer sind in meinem Kurs?

---

# Stärken relationaler Datenbanken:
  
  1. Persistente, sichere und strukturierte Datenspeicherung
  1. Effiziente **Abfragen** um Anfragen beantworten zu können! 
      
--

* SQL hat nur einen Befehl dafür:

--

 
#  **`SELECT`**

---
# Anatomie von `SELECT`

~~~sql
SELECT *        -- welche Spalten sollen wie angezeigt werden
  FROM tabelle  -- Daten welcher Tabelle 
 WHERE true     -- Selektionesbedingungen: nur Daten, die Kriterium entsprechen
~~~
--
Kann gelesen werden als:

     Zeige mir alle Spalten der Tabelle "tabelle" an und davon alle Zeilen.
--
Datenbank interpretiert das in der Reihenfolge `FROM`, `WHERE`, `'*'` (Spalten)

     Hole aus der Tabelle "tabelle" alle Zeilen die der Bedingung 'true' entsprechen
	 und zeige davon alle Spalten an.
---
# Anatomie von `SELECT`

~~~sql
SELECT *        -- welche Spalten sollen wie angezeigt werden
  FROM tabelle  -- Daten welcher Tabelle 
 WHERE true     -- Selektionesbedingungen: nur Daten, die Kriterium entsprechen
~~~

Es wird immer eine und nur eine Tabelle durch `SELECT` erzeugt, daher ist das technisch präziser:

     Erzeuge und zeig mir *eine* virtuelle Tabelle, die folgender Anweisung enpricht:
     Hole aus der Tabelle "tabelle" alle Zeilen die der Bedingung 'true' entsprechen
	 und zeige davon alle Spalten an.
---



# Konkretes SELECT

~~~sql
SELECT *        -- * (asterisk) heisst alle spalten, wie sie sind
  FROM "teilnehmer"; -- Daten der Tabelle mit dem Namen "order"
~~~
Boolsche `WHERE` Bedingung kann weggelassen werden, wenn man alle Zeilen will.

---
# Diagramm der Teilnehmer-Datenbank

![erd-teilnehmerinnen](/img/dbl/mi-teilnehmer-erd-2.png)
---
class: middle,centerE
# Source Code der Teilnehmer-Datenbank

* [SQL file mit ersten Testdaten](/lecture/2017-03/database-mi/mi-db-vorlesung-6.sql)

---
class: middle,centerE

# Sammeln von Anfragen

---
### **ANFRAGE:**
# Gib mir alle Daten aller Teilnehmer

### **ABFRAGE:**
~~~sql
select * 
  from Teilnehmer;
~~~
---
# Welche Teilnehmer sind im hoeheren Semester als 3


~~~sql
select * 
  from Teilnehmer 
 where semester > 3 ;
~~~
---
# Datenbank: Query Plan

* Jede Abfrage wird vom DBMS ausgewertet
  * DBMS findet einen optimalen Plan zur Ausführung der Abfrage
  * DBMS bestimmt einen optimalen Algorithmus!
  
---

# Logische Ausführung vs. Aktuelle Ausführung

* SQL standard legt eine logische Auswertungsreihenfolge fest
* DBMS kann intern davon abweichen

---
class: split-50
# Logische Ausführungsreihenfolge

.column[

  (1) FROM, JOIN, APPLY 
  
  (2) WHERE 

  (3) CONNECT BY (Oracle)

  (4) GROUP BY

  (5) AGGREGATIONS

  (6) HAVING

  (7) WINDOW

]
.column[

  (8) MODEL (Oracle)

  (9) SELECT 

  (10) DISTINCT

  (11)UNION, INTERCEPT, EXCEPT

  (12) ORDER BY

  (13) OFFSET

  (14) LIMIT

  (15) FOR UPDATE

]


---
class: split-50
# Es geht noch viel mehr mit SQL


.column[

  (1) [FROM, JOIN](https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html), APPLY 
  
  (2) [WHERE](https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-WHERE) 
  
  (3) CONNECT BY (Oracle)

  (4) [GROUP BY](https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-GROUP)

  (5) [AGGREGATIONS](https://www.postgresql.org/docs/9.6/static/functions-aggregate.html)

  (6) [HAVING](https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-GROUP)

  (7) [WINDOW](https://www.postgresql.org/docs/9.6/static/queries-table-expressions.html#QUERIES-WINDOW)

]
.column[

  (8) MODEL (Oracle)

  (9) [SELECT](https://www.postgresql.org/docs/9.6/static/queries-select-lists.html)

  (10) [DISTINCT](https://www.postgresql.org/docs/9.6/static/queries-select-lists.html#QUERIES-DISTINCT)

  (11)[UNION, INTERCEPT, EXCEPT](https://www.postgresql.org/docs/9.6/static/queries-union.html)

  (12) [ORDER BY](https://www.postgresql.org/docs/9.6/static/queries-order.html)

  (13) [OFFSET](https://www.postgresql.org/docs/9.6/static/queries-limit.html)

  (14) [LIMIT](https://www.postgresql.org/docs/9.6/static/queries-limit.html)

  (15) [FOR UPDATE](https://www.postgresql.org/docs/9.6/static/sql-select.html#SQL-FOR-UPDATE-SHARE)

]
.footnote[
 [1] [Gesamtüberblick](https://www.postgresql.org/docs/9.6/static/queries.html)
 
 [2] [SELECT Details](https://www.postgresql.org/docs/9.6/static/sql-select.html)
]


---
class: middle, center

# Danke für die Zusammenarbeit



