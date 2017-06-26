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
 
## Kontakt:

* mail
* linkedin:http://www.linkedin.com/in/renzokottmann
* twitter: @renzokott

---

# Schritte im ad-hoc Projekt

Datenverwaltungssystem: semistrukturierte Daten im Filesystem (CSV)

1. Problem in der realen Welt
  * Wer sind die Teilnehmerinnen in meinem Kurs?

2. Implizites Model (Tabelle)

3. Datenerfassung
  * Liste der Teilnehmerinnen
  
---
class: middle, center
# Was sind die Nachteile von diesem System und dieser Vorgehensweise?  

---
class: middle
# Was wäre besser?

--

1. Hohe Datenintegrität bzw. Konsistenz
2. Mehrere Nutzer können gleichzeitg an denselben Daten arbeiten
3. Klare Trennung von Struktur und Inhalt bzw. Daten
3. Effiziente Suche in grossen Daten

---

# Für Datenintegrität und Strukturtrennung

* Strukturierte Daten

* (relationale) Datenbank (DB)

 * Schema („Modell“, „Metadaten“)

 * \+ Daten („Extension“, „Nutzdaten“)

  * Modell und Daten sind konzeptionell getrennt!

---
# Für Effizienz und Mehrbenutzer

* Datenbankmanagementsystem (DBMS)

* Softwaresystem 

    * Ermöglicht Erstellung und Pflege vieler Datenbanken

    * Stellt Werkzeuge für _alle_ Aspekte der Datenverwaltung bereit

---

# 2. Runde
## Mit dem relationalem Ziel vor Auge

---
# Schritte im agilen Datenbank Projekt

Datenverwaltungssystem: Relationales Datenbankmanagemensystem

1. Anwendungsdefinition
  * Genaue textuelle Beschreibung des Problems in der realen Welt.
  
2. Konzeptioneller Entwurf / Datenbankmodellierung
  * Entity Relationship Modellierung (ERM)

3. Datenbank Realisierung
   * Skript(e) zur Implementierung des Datenmodells
   * Skript(e) zum laden/einfügen der Daten 

4. Von Geschäftsanfragen zu Datenbank-Abfragen
  * Skript(e) für SQL´s `SELECT`s 

---
# Alternativer Blick: Datenbankentwicklungszyklus

<img src="https://upload.wikimedia.org/wikipedia/commons/d/d4/DatMod_v_semMod_zur_DBK.svg" alt="entwurfsmodell">

.text-s[
  <a href="https://commons.wikimedia.org/wiki/File:DatMod_v_semMod_zur_DBK.svg#/media/File:DatMod_v_semMod_zur_DBK.svg">DatMod v semMod zur DBK</a> von <a href="//de.wikipedia.org/wiki/User:V%C3%96RBY" title="de:User:VÖRBY">VÖRBY</a>, Konvertierung zu SVG <a href="//de.wikipedia.org/wiki/User:Perhelion" title="de:User:Perhelion">Perhelion</a> - eigene Erstellung, aus Wikipedia-Text abgeleitet. Lizenziert unter Gemeinfrei über <a href="https://commons.wikimedia.org/wiki/">Wikimedia Commons</a>.
]
---
# Anwendungsdefinition

In der Phase der Systemanalyse werden ausgehend von der
Problemstellung die Anforderungen an die Lösung formuliert. Diese
sollten möglichst vollständig und konsistent sein, d.h. alle
(vollständigen) Anforderungen sollten widerspruchsfrei (konsistent)
formuliert werden.

Ein guter Einstieg in die Anwendungsdefinition ist, sich zu
verdeutlichen, welche genaueren Zwecksetzungen erfüllt werden
sollen. D.h. was ist das Ziel des Projektes.

---
# Anwendungsdefinition

Welchen Zwecken soll die Erfassung aller Kursteilnehmer dienen?

--
Antwort:


* Notenvergabe

* Ermittlung des Wissenstands

* Wer macht welches Datenbankprojekt?

* Wer ist in welcher Laborgruppe?

* Wer hat welche Laboruebung, wann fertig gemacht?

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
class: split-50
# DDL: Create Table

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql
CREATE TABLE teilnehmer (
--Spalten Name Datentyp,
  vorname text,
  nachname text,
  matrikel_nr integer,
  email text,
  semester integer
);

```
]

s. http://www.postgresql.org/docs/9.3/interactive/ddl-basics.html und http://www.postgresql.org/docs/9.3/interactive/sql-createtable.html


---

class: split-50
# DDL: Create Table Primary Key

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql
CREATE TABLE teilnehmer (
--Spalten Name Datentyp,
  vorname text,
  nachname text,
  matrikel_nr integer,
  email text,
  semester integer
);

```
]

---

class: split-50
# DDL: Create Table Primary Key

.column[
![erd-teilnehmerinnen](/img/erd-teilnehmerinnen-only.png)
]

.column[
```sql
CREATE TABLE teilnehmer (
--Spalten Name Datentyp,
  vorname text,
  nachname text,
  -- Simpler (nicht bester Primary Key)
  matrikel_nr integer PRIMARY KEY,
  email text,
  semester integer
);

```
]
    
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
  ('renzo','kottmann',007,'renzo@007.bond', 0);

```
]

s. http://www.postgresql.org/docs/9.6/interactive/dml-insert.html und http://www.postgresql.org/docs/9.3/interactive/sql-insert.html

---

# Weiterfuehrende Fragen:

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
class: middle, center

# Danke fuer die Zusammenarbeit



