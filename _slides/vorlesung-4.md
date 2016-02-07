
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
# Vorlesung 4
# Implementierung der Pizza Service Datenbank
###### IFI Wintersemester 2015/16

---
class: center, middle
# Frohes Neues :)

---
# Beim letzten Mal besprochen

* [Entity Relationships](/slides/vorlesung-3.html#12)
* [SQL Ueberblick](/slides/vorlesung-3.html#17)
* [Erstellung einer Tabelle/Relation](/slides/vorlesung-3.html#20)


---

# Vorbereitungsaufgaben:

1. Wie ändert sich das ERM und die implementierung wenn folgende
Anforderng hinzukommt:
  * Die Datenbank soll für alle vergangenen und zukünftigen
  Datenbankkurse informationen speichern können

2. Welche Datentypen gibt es schon in PostgreSQL?
3. Kann man eigene Datentypen definieren?
   * Wenn ja, welche Möglichkeiten gibt es?
4. Welche weiteren SQL-Befehle für Datenmodell-Management (DDL) gibt es
noch?

---

# Datenbank Einrichtung

1. Installiere auf einem Rechner PostgreSQL version > 9.3
2. Erstelle zwei User (role) A und B (mit Namen Deiner Wahl)
3. Erstelle eine Datenbank die dem User A gehört
4. Erstelle Tabellen die User A gehören und gib User B Leserechte
   (SELECT permission) auf diesen Tabellen

---

class: center, middle
# [Erste Spezifikation](/slides/pizza-service-spec-v1.html)

---

class: center, middle
# [Zweite Spezifikation](/slides/pizza-service-spec-v2.html)

---
# Erstes ER Diagram

![erd-teilnehmerinnen](/img/dbl/pizza-unconnected-erd.png)

---
# Umsetzung der einzelnen Entitaeten

* [Rohes SQL file mit ersten Testdaten](/slides/pizza-unconnected-erd.sql)

---

## Massnahmen zur Gestaltung der Datenintegritaet
* Datentypen
* Primary Keys
* NULL or NOT NULL Constraints
---
class: split-50
# Datentypen

.column[
* PostgreSQL stellt [viele Datentypen zur Verfuegung](http://www.postgresql.org/docs/current/static/datatype.html)
* Auch eigene Dataentypen koennen definiert werden
]

.column[
```sql
CREATE TABLE pizza (
  name text PRIMARY KEY,
  img text
);
```
]
---
class: split-50
# Primary Keys

.column[
* Die Eindeutigkeit jedes Eintrags wird durch den "PRIMARY KEY" Ausdruck sichergestellt
]

.column[
```sql
CREATE TABLE pizza (
  name text PRIMARY KEY 
  -- name kann es nur einmal geben,
  img text
);
```
]

---
class: split-50
# NULL or NOT NULL Constraints

.column[
* Implizit ist jedes Attribut einer Tabelle `NULL`
  * d.h. kann leer sein
* Nicht bei `PRIMARY KEYS`
* oder Schluesselwort `NOT NULL` 

]

.column[
```sql
CREATE TABLE pizza (
  name text PRIMARY KEY 
  -- name kann es nur einmal geben,
  img text NOT NULL
  -- es muss einen Eintrag
  -- fuer image geben
);

Die Verwendung von `NOT NULL` 
implementiert hier die Anforderung:
"Zu jeder Pizza muss es ein Bild geben."
```
]

---
## Weitere Massnahmen zur Gestaltung der Datenintegritaet

* DEFAULT VALUES
* CHECK Constraints
* Unique Constraint
---
class: split-50
# Default Constraint

.column[
* Fuer jedes Attribut kann man einen Standard-Wert festlegen
* D.h. der Standwert wird eingetragen, falls nicht explizit ein anderer Wert angegeben wurde 

* `INSERT INTO PIZZA (name) 
   VALUES ('salami');` fuehrt zu einem Eintrag mit 
   <table>
	<thead>
     <tr><th>name</th><th>img</th></tr>
	</thead>
     <tr><td>salami</td><td>placeholder</td></tr>
   </table>
]

.column[
```sql
CREATE TABLE pizza (
  name text PRIMARY KEY 
  -- name kann es nur einmal geben,
  img text NOT NULL 
    DEFAULT 'placeholder'
  -- es muss einen Eintrag
  -- fuer image geben
);

Die Verwendung von `DEFAULT` 
implementiert hier die Anforderung:
"Zu jeder Pizza muss es ein Bild geben, 
zumindest ein Platzhalter Bild"
```
]
---
class: split-50
# Check Constraint

.column[
* Ein Wert in ein oder meherer Spalten muss einer boolean funktion entsprechen
]

.column[
```sql
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL 
    DEFAULT 'placeholder' 
	REFERENCES image (location)
);
```
]

---
class: split-50
# Unique Constraint

.column[
* Alle Werte ein oder meherer Spalten muss eindeutig sein
* Damit werden weitere Schluessel implementiert
]

.column[
```sql
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL UNIQUE
    DEFAULT 'placeholder'
	REFERENCES image (location)
);
Jede Pizza muss ein anderes Bild haben.
```
]

---
class: split-50
# Logisch gesehen: Primary Key

.column[
* Ein `PRIMARY KEY` ist nichts anderes als ein `UNIQUE NOT NULL`
* D.h. es kann mehere Schluessel geben, aber nur einer wird als `PRIMARY KEY` gewaehlt
]

.column[
```sql
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL UNIQUE
    DEFAULT 'placeholder'
	REFERENCES image (location)
);
Jede Pizza muss ein anderes Bild haben.
```
]	

---
# Welche Beziehungen?

![erd-teilnehmerinnen](/img/dbl/pizza-connected.png)

---
# Umsetzung der Beziehungen

* Durch Foreign Keys (Fremdschluessel)
* Legen die genauen Bedingung der Beziehung fest
  * Wichtige Frage: Was identifiziert die Beziehung?!?

---
class: split-40
# Foreign Keys (1 to many)

.column[
 * Stellt Verknuepfungen zwischen Relationen/Tabellen her
 * Dies geschieht ueber Werte
 * Die Abhaengige Relation referenziert die Quell-Relation 
 * Garantiert existenz des Quell-Eintrags
]

.column[
```sql
CREATE TABLE image (
  location text PRIMARY KEY,
  name text 
    NOT NULL 
	DEFAULT 'placeholder',
  copyright text 
    NOT NULL DEFAULT 'unknown',
  type text 
    NOT NULL DEFAULT 'unknown'
);
CREATE TABLE pizza (
  name text 
    check (name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL 
    DEFAULT 'placeholder' 
	REFERENCES image (location)
	-- referenz auf PK von image
);
INSERT INTO 
  image (location, copyright, type)
  VALUES
  ('file://here', 'Renzo Kottmann', 'png');
INSERT INTO pizza (name,img) 
  VALUES 
  ('Salami', 'file://here');
```
]
---
class: split-40
# Foreign Keys (1 to many)

.column[
 * Garantiert existenz des Quell-Eintrags
   * Werte der Quell-Relation muessen in Abhaengige Relation eingetragen werden
]

.column[
```sql
CREATE TABLE image (
  location text PRIMARY KEY,
  name text 
    NOT NULL 
	DEFAULT 'placeholder',
  copyright text 
    NOT NULL DEFAULT 'unknown',
  type text 
    NOT NULL DEFAULT 'unknown'
);
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL 
    DEFAULT 'placeholder' 
	REFERENCES image (location)
	-- referenz auf PK von image
);
INSERT INTO 
  image (location, copyright, type)
  VALUES
  ('file://here', 'Renzo Kottmann', 'png');
INSERT INTO pizza (name,img) 
  VALUES 
  ('Salami', 'file://here');
```
]
---
# Foreign Keys (many to many) 

![erd-teilnehmerinnen](/img/dbl/pizza-connected-erd-v1.png)

---
# Foreign Keys (many to many) 
* Implementierung durch neue "Beziehungs"-Relation
![erd-teilnehmerinnen](/img/dbl/pizza_compilation.png)

---
class: split-40
# Foreign Keys (many to many) 

.column[
 * Neue Tabelle, die auf die beiden existierenden referenziert
 * Primary Key der neuen Tabelle ist Kombination der PKs der existierenden Tabellen
]

.column[
```sql
CREATE TABLE pizza (
  name text 
    check ( name != ''::text) 
	PRIMARY KEY,
  img text NOT NULL 
    DEFAULT 'placeholder' 
	REFERENCES image (location)
	-- referenz auf PK von image
);
CREATE TABLE topping (
  name text PRIMARY KEY,
  img text 
);
CREATE TABLE pizza_compilation (
  pizza_name text
    references pizza(name),
  topping_name text
    references topping(name),
  PRIMARY KEY (pizza_name, topping_name)
);
```

]

---
name: referenzen
# Referenzen:

* M. Unterstein and G. Matthiessen, Relationale Datenbanken und SQL in
  Theorie und Praxis. Berlin, Heidelberg: Springer Berlin Heidelberg,
  2012.
