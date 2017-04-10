# Datenbankbasierte Web-Anwendungen
# {{ page.title }} 
## Medieninformatik SoSe 2017
 
Renzo Kottmann 

<a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br
/>This work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons
Attribution-NonCommercial 4.0 International License</a>.

---

# Mini-Welt

Da wir wissen was wir wollen, können wir folgende Fragen beantworten:

* Welchen Ausschnitt der realen Welt brauchen wir?
* Welche Aspekte müssen wir Berücksichtigen?

---

[![mini Welt](/img/mini-world.png)](/img/mini-world.png)

---

# Entity Relationship Modellierung (ERM)

* Semantischer Datenbankentwurf 

  * unabhängig von konkreten Datenbank-spezifischen Modellen

* Graphisch

* Idee simpel

  * Leider sehr viele inkonsistente Varianten 

---
# Entity (Entität)

* Ein Entity-Relationship-Model (ERM) geht von Entitäten (~= Objekten)
aus.

    "Eine Entität ist eine eigenständige Einheit, die im Rahmen des
betrachteten Modells **eindeutig identifiziert** werden kann."

* Ein Entitätstyp wird durch Attribute genauer beschrieben und stellt
somit eine abstrakte Beschreibung oder Charakterisierung von Entitäten
da.

* Beispiel: 

    Lehrer = Entitätstyp

    Renzo ~= Entität (ein spezieller Lehrender)

---

# Attribute

* Eigenschaften von Entitäten werden durch Attribute beschrieben
* Attribute haben einen Namen und eine Domaine (= Bestimmung der Wertmenge).

---

# Keys (Schlüssel)

Da die Definition einer Entität beinhaltet, dass diese zumindest im
Rahmen eines Modells eindeutig identifiziert werden kann, braucht
jeder Entitätstyp eine Menge von Attributen als Schlüssel.

Die Auswahl eines oder meherer Attribute als Schlüssel legt fest, dass
es keine zwei Entitäten eines Entitätstyp geben kann die identische
Attributwerte haben.

* Wichtige Eigenchaften:

  * Eindeutigkeit
  * Zuteilbarkeit

---

# Relationship (Beziehung)

Verschiedene Entitäten können zueinander in Beziehung gesetzt
werden. 

* In jeder Beziehung haben Entitäten gewisse Rollen
* Beziehungen können Eigenschaften (Attribute) haben
* Beziehungen haben Kardinalitäten
  
---
  
# Notationen

Es gibt verschiedene Formen ERM zu notieren (textuell und/oder graphisch):

* [Chen Notation](https://de.wikipedia.org/wiki/Chen-Notation)
* [Crow Foot's](https://de.wikipedia.org/wiki/Martin-Notation)
* [Unified Modelling Language](https://de.wikipedia.org/wiki/Unified_Modeling_Language) (UML)

---

# Notation

<table width="100%">
  <tr>
    <td>Entity</td>
    <td><img src="/img/single-entity.jpg"/></td>
  </tr>
 <tr>
    <td>Attribute</td>
    <td><img src="/img/single-entity-attribute.jpg"/></td>
  </tr>
 <tr>
    <td>Beziehungen/Relationship</td>
    <td><img src="/img/entity-relationship.jpg"/></td>
  </tr>
</table>
---
class: middle, center
# Von ERM zur ersten Implementation

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
class: split-60
# SQL Überblick

.column-left[
  <a title="By Bagok (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ASQL.png"><img width="512" alt="SQL" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/SQL.png/512px-SQL.png"/></a>
]

.column-right[

* DDL = Data Defintion Language:

  .text-xs[Definition des Datenbankschemas]
* DML = Data Manipluation Language:
  
  .text-xs[Ändern, Einfügen, Löschen und lesender Zugriff]
* DRL = Data Retrievel Language
  
  .text-xs[Nicht standadisierte Bezeichnung des `SELECT` aus DML]
* DCL = Data Control Language:

  .text-xs[Rechteverwaltung und Transaktionskontrolle]
]

---
# SQL in PostgreSQL

* Scheinbar viele SQL Kommandos
  * [Sehr guter Überblick in der PostgreSQL Dokumentation](https://www.postgresql.org/docs/9.6/static/sql-commands.html)
* Die meisten sind __DDL__ Kommandos
  * `CREATE`, `DROP` oder `ALTER`
     * Jeweils ein Eintrag pro Datenbank-Objekt
     * Folgen dem selben Syntax Schema 
     
---
# Datenbank Anlegen

* `CREATE DATABASE`
   * [Dokumentation](https://www.postgresql.org/docs/9.6/static/sql-createdatabase.html)
     
---
# Praktische Anmerkungen

## psql 

*  Kommandozeile = Command Line Interface (CLI)

## PgAdminIII oder 4 

* Graphische Oberfläche = Graphical User Interface (GUI)
---
class: split-50
# DDL: Create Table

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql
CREATE TABLE teilnehmer (
  --Spaltenname Datentyp,
  vorname text,
  nachname text,
  matrikel_nr integer,
  email text,
  semester integer
);

```
]

[s. DDL-Basics](http://www.postgresql.org/docs/9.3/interactive/ddl-basics.html) 
und [CREATE TABLE](http://www.postgresql.org/docs/9.3/interactive/sql-createtable.html)

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
CREATE TABLE teilnehmer (
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
class: split-50
# Primary Keys

.column[
* Die Eindeutigkeit jedes Eintrags wird durch den `PRIMARY KEY` Ausdruck sichergestellt
]

.column[
```sql
CREATE TABLE teilnehmer (
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
CREATE TABLE teilnehmer (
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
"Zu jedem Teilnehmer muss es 
eine E-mail geben."
```
]
---
class: middle, center
# Für welche Attribute ist `NOT NULL` noch sinnvoll?

---

class: split-30
# DML: Daten Einfügen

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql

INSERT INTO teilnehmer
  (vorname, nachname, matrikel_nr, email, semester)
VALUES
  ('renzo','kottmann',007,'renzo@007.bond', 100);

```
]

s. [INSERT Dokumentation](http://www.postgresql.org/docs/9.6/interactive/dml-insert.html)
 und [Komanndo Referenz](http://www.postgresql.org/docs/9.3/interactive/sql-insert.html)


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
CREATE TABLE teilnehmer (
  -- Spaltenname Datentyp,
  vorname text,
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL,
  semester integer DEFAULT 4
);


Die Verwendung von `DEFAULT` 
implementiert hier die Anforderung:
"Bei jedem Teilnehmer ist das Standard Semester 4."
```
]

---
# Default Values Constraint


> `
INSERT INTO teilnehmer
  (vorname, nachname, matrikel_nr, email)
VALUES
  ('renzo','kottmann',007,'renzo@007.bond');` 

  führt zu einem Eintrag mit:

  <table style="border:1px solid black">
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
         <td>4</td>
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
CREATE TABLE teilnehmer (
  -- Spaltenname Datentyp,
  vorname text CHECK ( vorname != '' ),
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ),
  semester integer DEFAULT 4
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
CREATE TABLE teilnehmer (
  -- Spaltenname Datentyp,
  vorname text CHECK ( vorname != '' ),
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 4
);
Jeder Teilnehmer muss eine andere E-Mail haben.
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
CREATE TABLE teilnehmer (
  -- Spaltenname Datentyp,
  vorname text CHECK ( vorname != '' ),
  nachname text,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 4
);
Jeder Teilnehmer muss eine andere E-Mail haben.
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
CREATE TABLE teilnehmer (
  -- Spaltenname Datentyp,
  vorname person_name CHECK ( vorname != '' ),
  nachname person_name,
  -- Simpler Primary Key
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 4
);
```


---

# Weiterführende Fragen:

1. Wie ändert sich das ERM und die implementierung wenn folgende
Anforderng hinzukommt:
  * Die Datenbank soll für alle vergangenen und zukünftigen
  Datenbankkurse informationen speichern können


---
class: middle, center

# Danke für die Zusammenarbeit



