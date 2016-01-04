
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
# Erstes ER Diagram

![erd-teilnehmerinnen](/img/dbl/pizza-unconnected-erd.png)

---
# Umsetzung der Entitaeten

* [Rohes SQL file mit ersten Testdaten](/slides/pizza-unconnected-erd.sql)

---

## Massnahmen zur Gestaltung der Datenintegritaet
* Datentypen
* Primary Keys
* NULL or NOT NULL Constraints

---
# Welche Beziehungen?

---
# Umsetzung der Beziehungen

* Durch Foreign Keys (Fremdschluessel)
* Legen die genauen Bedingung der Beziehung fest
  * Was identifiziert die Beziehung?!?
---
## Weitere Massnahmen zur Gestaltung der Datenintegritaet

* DEFAULT VALUES
* CHECK Constraints
* Unique Constraint

---
name: referenzen
# Referenzen:

* M. Unterstein and G. Matthiessen, Relationale Datenbanken und SQL in
  Theorie und Praxis. Berlin, Heidelberg: Springer Berlin Heidelberg,
  2012.
