
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
# Vorlesung 3
# Vom Datenbankentwurf zur Implementierung
###### IFI Wintersemester 2015/16

---
# Beim letzten Mal besprochen

* [Was sind Datenbanksysteme](/slides/vorlesung-2.html#12)
* [Datenmodelle und relationales Datenmodell?](/slides/vorlesung-2.html#24)
* [Entity Relationship Modellierung](/slides/vorlesung-2.html#37)


---
class: center, middle

# Fortsetzung 2. Runde
## Mit dem relationalem Ziel vor Auge

---
# Schritte im Projekt

1. Problem in der realen Welt / Anwendungsdefinition
  * Wer sind die Teilnehmerinnen in meinem Kurs?

2. Konzeptioneller Entwurf / Datenbankmodellierung

3. Datenbank Realisierung
  * Implementierung des Modells
  * Verabreiten der Daten 

4. System zur Verarbeitung und Speicherung
  * Datenbank im Betrieb: PostgreSQL

---
# Alternativer Blick: Datenbankentwicklungszyklus

<img src="https://upload.wikimedia.org/wikipedia/commons/d/d4/DatMod_v_semMod_zur_DBK.svg" alt="entwurfsmodell">

„<a href="https://commons.wikimedia.org/wiki/File:DatMod_v_semMod_zur_DBK.svg#/media/File:DatMod_v_semMod_zur_DBK.svg">DatMod v semMod zur DBK</a>“ von <a href="//de.wikipedia.org/wiki/User:V%C3%96RBY" class="extiw" title="de:User:VÖRBY">VÖRBY</a>, Konvertierung zu SVG <a href="//de.wikipedia.org/wiki/User:Perhelion" class="extiw" title="de:User:Perhelion">Perhelion</a> - eigene Erstellung, aus Wikipedia-Text abgeleitet. Lizenziert unter Gemeinfrei über <a href="https://commons.wikimedia.org/wiki/">Wikimedia Commons</a>.

---
  
# Anwendungsdefinition

Welchen Zwecken soll die Erfassung aller Kursteilnehmenrinnen dienen?

Die Teilnehmerinnen-Datenbank soll folgendes Ermoeglichen:

* Informationsweitergabe an alle Teilnehmerinnen

* Namen lernen

* Notenvergabe

* Ermittlung des Wissenstands

* Wer macht welches Datenbankprojekt

---

# Entity Relationship Modellierung (ERM)

* Semantischer Datenbankentwurf 

  * unabhängig von konkreten Datenbank-spezifischen Modellen

  * dienen zum Entwurf von relationalen, Netzwerk- oder
    Objekt-Datenbanken

* Graphisch

* Idee simpel

  * Leider sehr viele inkonsistente Varianten 

---

# Entity (Entität)

* Ein Entity-Relationship-Model (ERM) geht von Entitäten (~= Objekten)
aus.

    "Eine Entität ist eine **genständige Einheit**, die im Rahmen des
betrachteten Modells **eindeutig identifiziert** werden kann."

* Ein Entitätstyp wird durch Attribute genauer beschrieben und stellt
somit eine abstrakte Beschreibung oder Charakterisierung von Entitäten
da.

* Beispiel: 

    Lehrer = Entitätstyp

    Renzo ~= Entität (ein spezieller Lehrender)

---

Entitäten der Teilnehmerinnen [Mini-Welt](/slides/vorlesung-2.html#35)

---

# Attribute

* Eigenschaften von Entitäten bzw. Entitätstypen werden durch Attribute beschrieben
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
class: split-60

# Kardinilitaeten

.column[
<img src="/img/crow-foot-notation-matthiessen-abb10-6.png" />
]

.column[
1. UML Notation
2. Crow Foot
3. Darstellung nach Chen
4. Darstellung nach Zehn
]

[Abb. 10.6 aus Matthiessen](#referenzen)


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
class: split-50
# SQL Ueberblick

.column[
<a title="By Bagok (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ASQL.png"><img width="512" alt="SQL" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/SQL.png/512px-SQL.png"/></a>
]

.column[
* DML = Data Manipluation Language:
  Ändern, Einfügen, Löschen und lesender Zugriff
* DDL = Data Defintion Language:
  Definition des Datenbankschemas
* DCL = Data Control Language:
  Rechteverwaltung und Transaktionskontrolle
]

---
class: split-50
# DML: Create Table

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

# Vorbereitungsaufgaben:

1. Wie aendert sich das ERM und die implementierung wenn folgende
Anforderng hinzukommt:
  * Die Datenbank soll fuer alle vergangenen und zukuenftigen
  Datenbankkurse informationen speichern koennen

2. Welche Datentypen gibt es schon in PostgreSQL?
3. Kann man eigene Datentypen definieren?
   * Wenn ja, welche Moeglichkeiten gibt es?
4. Welche weiteren SQL-Befehle fuer Datenmodell-Management gibt es
noch?



---
class: center, middle
# Erholsame Feiertage

---

name: referenzen
# Referenzen:

* M. Unterstein and G. Matthiessen, Relationale Datenbanken und SQL in
  Theorie und Praxis. Berlin, Heidelberg: Springer Berlin Heidelberg,
  2012.

---

Exkurs:


Natural Keys

Ein natürlicher Schlüssel ist die Menge der Attribute einer Entität, die diese Entität eindeutig identifiziert
(natürlich da es nur einer Auswahl der schon eh definierten Attribute braucht).

	* Diese können an der Realität überprüft werden

"Intelligente Schlüssel" basieren häufig auf Industriestandards und können mit Hilfe externer Ressourcen überprüft werden. Z.B: ISBN, EAN, VIN, UPC... 

Artificial Keys

Artifizielle, synthetische Schlüssel sind zusätzlich hinzugefügte Attribute die für die eindeutige Identifizierung einer Entität benutzt werden. 

	* Können nicht an der Realität überprüft werden


Auto-Numbers (Increment, serials) sind schlicht keine relationale Schlüssel, werden aber oft als artificial keys benutzt.



Natural KeyArtificial KeyTeil des DatenmodelsJaNein

In der Realität verifizierbarJaNeinIn sich validierbarJaJa (z.B. bei check-digits)

---


Entitätstyp:


Entitätstyp mit Attributen:


Beziehungen:
Kardinalitäten

Zweistellige Beziehungen


Zur Erläuterung einer Beziehung ist es wichtig, die Beziehung getrennt nach beiden Richtungen zu lesen.

Vom ERM zu einem Datenbankschema

Auf dem Papier sehen sich die Darstellung vom Datenbankschema und ERM sehr ähnlich.

Umsetzung von 1:m Beziehungen
Von einem zu vielen.




Umsetzung von n:m
von vielen zu vielen


Beziehungen bei abhängigen Entitätstypen (weak entities)


Eine Entität heißt abhängige Entität oder engl. weak entity, wenn diese nicht durch eigene Attribute identifiziert werden kann. 

Beispiel: Kinder von Mitarbeitern, bei denen die Firma die Kindergeldzahlung verwaltet. Im Beispiel werden Kinder nur abhängig vom Mitarbeiter eindeutig identifiziert.


