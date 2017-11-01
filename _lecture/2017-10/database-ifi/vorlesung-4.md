# Datenbank-Systeme
# {{ page.title }} 
## Internationaler Frauenstudiengang Informatik 
## WiSe 2017/18
 
Renzo Kottmann 

<a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br
/>This work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons
Attribution-NonCommercial 4.0 International License</a>.

---
 
## Kontakt:

* mail
* linkedin:http://www.linkedin.com/in/renzokottmann
* twitter: @renzokott

---
# Wiederholung

* Entity Relationship Modellierung (ERM)
    * Entität, Attribute, Beziehungen
    * Wichtige Gute Diskussion zu: Keys
* Labor: Fertige Arbeitsumgebung
* Erster Blick auf SQL

---

---

# Relationales Datenbankmodell 


## Generische Datenstruktur

* Relationen mit eindeutigen Namen

  * jede Relation ist eine Menge von Tupeln (Datensätzen) gleichen
  Typs

  * Die Struktur ist insofern generisch, als die Relationen und ihre
  Attribute (Spalten) beliebig gewählt werden können bzw. beim
  Einrichten der Datenbank angegeben werden müssen.

---

## Operatoren

* relationale Algebra

* Daten

  * eintragen

  * ändern

  * löschen

  * abfragen

  * ableiten

---

## Integritätsbedingungen

* Bestimmung von ein-eindeutigen Tupeln

* Einschränkungen vom Wertbereich bestimmter Datentypen

https://de.wikipedia.org/wiki/Datenbankmodell


---
# Structured Query Language (SQL)
SQL ist eine Datenbanksprache 

1. zur Definition von Datenstrukturen/Modellen 

2. zum Bearbeiten (Einfügen, Verändern, Löschen) 

3. zum Abfragen von darauf basierenden Datenbeständen

4. zur Rechtevergabe

---

# SQL Eigenschaften

* basiert auf relationaler Algebra

* an English angelehnt

* Deklarativ und funktional

* Fast alle Datenbanken verstehen SQL

* Standardisiert

  * PostgreSQL hat einer der besten Umsetzungen

---
# Datenbank Anlegen

* `CREATE DATABASE`
   * [Dokumentation](https://www.postgresql.org/docs/9.6/static/sql-createdatabase.html)
---
class: split-60
# SQL Überblick

.column-left[
  <a title="By Bagok (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ASQL.png"><img width="512" alt="SQL" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/SQL.png/512px-SQL.png"/></a>
]

.column-right[ 

* DDL = Data Definition Language:

  .text-xs[Definition des Datenbankschemas]
* DML = Data Manipulation Language:
  
  .text-xs[Ändern, Einfügen, Löschen und lesender Zugriff]
* DRL = Data Retrievel Language
  
  .text-xs[Nicht standardisierte Bezeichnung des `SELECT` aus DML]
* DCL = Data Control Language:

  .text-xs[Rechteverwaltung und Transaktionskontrolle]
]

---
class: split-50
# DDL: Create Table

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql
CREATE TABLE teilnehmerin (
--Spalten Name Datentyp,
  vorname text,
  nachname text,
  matrikel_nr integer,
  email text,
  semester integer
);

```
]

s. http://www.postgresql.org/docs/9.6/interactive/ddl-basics.html und http://www.postgresql.org/docs/9.6/interactive/sql-createtable.html
---
# SQL in PostgreSQL

* Scheinbar viele SQL Kommandos
  * [Sehr guter Überblick in der PostgreSQL Dokumentation](https://www.postgresql.org/docs/9.6/static/sql-commands.html)
* Die meisten sind __DDL__ Kommandos
  * `CREATE`, `DROP` oder `ALTER`
     * Jeweils ein Eintrag pro Datenbank-Objekt
     * Folgen dem selben Syntax Schema 
     
---

# Integritätsbedingungen

> "Integritätsbedingungen beschreiben Annahmen, die über die Daten getroffen werden, beispielsweise ein bestimmter Datentyp, 
ein Wertebereich oder eine Abhängigkeitsbeziehung zwischen zwei Objekten."

[Ziatat Wikipedia: Integritätsbedingung](https://de.wikipedia.org/wiki/Integrit%C3%A4tsbedingung)

---
# Constraints
> Mit Constraints (deutsch „Einschränkung“) werden in diversen Programmiersprachen Bedingungen definiert, 
die zwingend vom Wert einer Variablen erfüllt werden müssen, damit der Wert ins System übernommen werden kann. 
In Datenbanksystemen finden Constraints rege Anwendung um den Wertebereich (Domain) von Attributen einzuschränken 
und Werte auf deren Zulässigkeit zu überprüfen.

[modifiziert von Wikipedia: Constraint](https://de.wikipedia.org/wiki/Constraint)
---

class: split-50

# Datentypen sind erste Constraints

.column[
* PostgreSQL stellt [viele Datentypen zur Verfügung](http://www.postgresql.org/docs/current/static/datatype.html)
* Auch eigene Datentypen können definiert werden
* Verwende Datentypen so strikt wie möglich
]

.column[
```sql
CREATE table teilnehmerin (
  --Spaltenname Datentyp,
  vorname text,
  nachname text,
  matrikel_nr integer PRIMARY KEY,
  email text,
  semester integer
);
```
]

---
## Weitere Contraints für Datenintegrität

* Primary Keys
* NULL or NOT NULL Constraints
* DEFAULT VALUES
* CHECK Constraints
* Unique Constraint

---

    
---

class: split-30
# DML: Daten Einfügen

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql

INSERT INTO teilnehmerin
  (vorname, nachname, matrikel_nr, email, semester)
VALUES
  ('renzo','kottmann',007,'renzo@007.bond', 0);

```
]

s. http://www.postgresql.org/docs/9.6/interactive/dml-insert.html und http://www.postgresql.org/docs/9.3/interactive/sql-insert.html

---
class: split-50
# Primary Keys

.column[
* Die Eindeutigkeit jedes Eintrags wird durch den `PRIMARY KEY` Ausdruck sichergestellt
]

.column[
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname text,
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text,
  semester integer
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
* oder Schlüsselwort `NOT NULL` 

]

.column[
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname text,
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL,
  semester integer
);

Die Verwendung von `NOT NULL` 
implementiert hier die Anforderung:
"Zu jeder Teilnehmerin muss es 
eine E-mail geben."
```
]
---
class: middle, center
# Für welche Attribute ist `NOT NULL` noch sinnvoll?


---
## Weitere Massnahmen zur Gestaltung der Datenintegrität

* DEFAULT VALUES
* CHECK Constraints
* Unique Constraint
---
class: split-50
# Default Values Constraint

.column[
* Für jedes Attribut kann man einen Standard-Wert festlegen
* der Standwert wird dann eingetragen, wenn 
  * kein Wert angegeben wurde
  * oder explizit auf `DEFAULT` gesetzt wurde  
]

.column[
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname text,
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL,
  semester integer DEFAULT 3
);


Die Verwendung von `DEFAULT` 
implementiert hier die Anforderung:
"Bei jeder Teilnehmerin ist das Standard Semester 3."
```
]

---
# Default Values Constraint


> `
INSERT INTO teilnehmerin
  (vorname, nachname, matrikel_nr, email)
VALUES
  ('renzo','kottmann',007,'renzo@007.bond');` 

  führt zu einem Eintrag mit:

  <table style="border:1px solid blue">
    <thead>
      <tr>
        <th>vorname</th>
        <th>nachname</th>
        <th>matrikel_nr</th>
        <th>email</th>
        <th>semester</th>
      </tr>
    </thead>
       <tr>
         <td>renzo</td>
         <td>kottmann</td>
         <td>7</td>
         <td>renzo@007.bond</td>
         <td>3</td>
       </tr>
   </table>
---
class: split-50
# Check Constraint

.column[
* Ein Wert in ein oder mehreren Spalten muss einer boolschen Funktion entsprechen
  * es muss `TRUE` ergeben
]

.column[
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname text CHECK ( vorname != '' ),
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ),
  semester integer DEFAULT 3
);
```
]

---
class: split-50
# Unique Constraint

.column[
* Alle Werte einer- oder meherer Spalte(n) müssen eindeutig sein
* Damit werden weitere Schlüssel implementiert
]

.column[
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname text CHECK ( vorname != '' ),
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3
);
Jede Teilnehmerin muss eine andere E-Mail haben.
```
]

---
class: split-50
# Logisch gesehen: Primary Key vs. Unique

.column[
* Ein `PRIMARY KEY` ist nichts anderes als ein `UNIQUE NOT NULL`
* D.h. es kann mehrere Schlüssel geben, aber nur einer wird als `PRIMARY KEY` gewählt
]

.column[
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname text CHECK ( vorname != '' ),
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3
);
Jede Teilnehmerin muss eine andere E-Mail haben.
```
]

---
# SQL Kommando: CREATE DOMAIN

* Definition von [eigenen Datentypen](http://www.postgresql.org/docs/current/static/sql-createdomain.html) basierend of existierenden

~~~sql
CREATE DOMAIN person_name AS text CHECK (
  VALUE ~ '^[A-Z][a-z]*'
);
~~~
```sql
CREATE TABLE teilnehmerin (
  -- Spaltenname Datentyp,
  vorname person_name CHECK ( vorname != '' ),
  nachname person_name,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3
);
```

---
class: middle, center

# Danke fuer die Zusammenarbeit



