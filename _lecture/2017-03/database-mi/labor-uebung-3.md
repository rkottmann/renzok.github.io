
# Datenbankbasierte Web-Anwendungen
# {{ page.title }}
## Medieninformatik SoSe 2017
 
Renzo Kottmann


<a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/"><img
alt="Creative Commons License" style="border-width:0"
src="https://licensebuttons.net/l/by-nc/4.0/88x31.png" /></a><br
/>This work is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons
Attribution-NonCommercial 4.0 International License</a>.

---

# Ziel dieses Labors
 
* Beziehungen mit Foreign Keys fertig stellen
* Daten manipulieren
* Transaktionen
* Von Anfragen zu Abfragen
* Ueberlegungen zu Datenbank-Normalisierung  
---

# Aufgabe 8 (continued) : 

## Stelle die Beziehungen her

Implementiere die Beziehungen zwischen Tabellen mit `FOREIGN KEYS`.

Bestimme, was bei `UPDATE` und `DELETE` Operationen passieren soll.

---

# Aufgabe 9: 

* Fuelle die Datenbank mit genug Daten, fuer die folgenden Aufgaben 
aber auch um spaeter genug Testdaten fuer Eure Anwendung zu haben.

---
# Aufgabe 10

## Daten Manipulation

* Ueberlegt welche 
  * Dateneinfuege (`INSERT`) 
  * Loesch (`DELETE`) 
  * und Aenderungs  (`UPDATE`)
  
  - Operationen von Eurer Anwendung benoetigt werden.
* Formuliere die dazu passenden SQL Kommandos 

---

# Aufgabe 11:

* Unterteile Dein(e) SQL Skript(e) in sinvolle Transaktionsbloecke.

---
# Aufgabe 12: 

* Ueberlege mindestens 15 Anfragen welche die User, Mitarbeiter, Geschaeftsfuehrer 
und Admins mittels Eurer Anwendung oder direkt an Euch stellen koennten.
  
* Uebersetze diese in effiziente `SELECTS`
  * Verwende dabei Funktionen auf Spalten, Aggregatfunktionen, Gruppierung, JOINS und mehr... 
  * Sortiere dies nach steigender Kompliziertheit
  
---
# Aufgabe 13

* Was ist Datenbank-Normalisierung?
* Welche Normalformen gibt es?
* Stelle sicher, dass Eure Datenbank final mindestens 3NF ist.

