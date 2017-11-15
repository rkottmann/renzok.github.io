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

## [Beziehungen mit Foreign Keys](vorlesung-5.html#11)

---
class: middle, center

# Datenbank-Projekt
 
### Vom Design zur Implementierung und Dokumentation


---

# Schritte im agilen Datenbank Projekt

(Folie von [Vorlesung 3](vorlesung-3#11)

1. Anwendungsdefinition
  * Genaue textuelle Beschreibung des Problems in der realen Welt.
  
2. Konzeptioneller Entwurf / Datenbankmodellierung
  * Entity Relationship Modellierung (ERM)

3. Datenbankrealisierung
   * Skript(e) zur Implementierung des Datenmodells
   * Skript(e) zum laden/einfügen der Daten 

4. Von Geschäftsanfragen zu Datenbank-Abfragen
  * Skript(e) für SQL´s `SELECT`s 

---

# Anwendungsdefinition


> In der Phase der Systemanalyse werden ausgehend von der
Problemstellung bzw. dem formulierten Ziel des Projektes die Anforderungen an die Lösung formuliert.
 
> Diese sollten möglichst vollständig und konsistent sein, d.h. alle
(vollständig) Anforderungen sollten widerspruchsfrei (konsistent)
formuliert werden.


(Verändert von [Vorlesung 3](vorlesung-3#13))
---
# Anwendungsdefinition

* Was ist das Ziel bzw. der Zweck des Projekts
  * Welche(s) „Problem(e)“ soll die Datenbank lösen?
  * Welche Daten sollen erfasst werden?
  * Welche Anfragen sollen an die Datenbank gestellt werden? 
  * Welche Nutzergruppen sind beteiligt?

---
# ERD: Konzeptionelles und/oder logisches Datenbankschema

* Jegliche Tools kann benutzt werden
* Jede Notationsart kann gewählt werden
  * Absolut **wichtig** ist die Legende
* Peroenlich: Bevorzuge physisches Schema

---
# Implementierung

* Am besten in SQL-Source Code Dateien
* Entweder eine Datei oder  
  * Skript(e) zur Implementierung des Datenmodells
  * Skript(e) zum laden/einfügen der Daten 
  * Skript(e) für SQL´s `SELECT`s
* Jeder Texteditor kann benutzt werden
  * Am praktischen sind jedoch PSQL, PgAdmin III oder IV
---
# Dokumentation

Kleine Vorlage ist auf [Dropbox Paper](https://paper.dropbox.com/doc/Datenbank-Projekt-Dokumentation-9czibc7oq6iUb508rdVsq)

---
# Leistungsnachweis

Der Leistungsnachweis im Modul „Datenbanksysteme“ besteht aus einer praktischen Projektarbeit.
In der Projektarbeit wird einzeln oder in 2er-Gruppen ein kleineres Datenbankprojekt **designed**, **realisiert**, **dokumentiert** und **präsentiert**.
* Die Arbeit wird benotet. 
* Bei einer Note von 4.0 oder besser gilt die Arbeit als bestanden.
---
# Leistungsnachweis: Design

* Anwendungsdefinition: Spezifikation der Aufgabenstellung
   * Muss alles relevanten Informationen enthalten, um das ERD und Implementierung verstehen zu koennen
   * Größenordnung: Mindestens 1 Seite
* ERD: Konzeptionelles und/oder logisches Datenbankschema
   * Bild mit Legende
   * Größenordnung: Mindestens 7 Entitätstypen
---
# Leistungsnachweis: Datenbankrealisierung/Implementation

* Anlegen der Tabellen
   * Sinnvolle Verwendung von Attribut- und Tabellen-Constraints
   * Festlegung des Verhaltens beim Verstoß gegen referentielle Integrität
   * Schema mindestens in dritter Normalform
   * Inline-Dokumentation
   * Größenordnung: Mindestens 5 Domänen, 7 Tabellen
* Füllen der Datenbank mit Daten
  * Größenordnung: Mindestens 7 Datensätze je Tabelle

---
# Leistungsnachweis: Nutzung der Datenbank
  * Entwicklung von SQL-Anfragen gemäß Aufgabenstellung
  * Optimierung der Anfragen durch Anlegen geeigneter Zugriffsstrukturen
  * Verwendung von Transaktionen
  * Größenordnung: Mindestens 15 Anfragen, davon 2 Transaktionen
---
# Leistungsnachweis: Extra-Arbeiten

* Verwendung von Triggern
* Erstellung neuer Funktionen
* Tabellen mit > 100.000 Zeilen
* Verwendung von PostgreSQL-Erweiterungen
* Detaillierte Rechtevergabe (Schema, Tabellen, Spalten)
* ....

---
# Leistungsnachweis: Abgabe

* Source Code
* Dokumentation
  * Erstellen eines Dokumentes (PDF-Format), welches Design und Implementation deutlich dokumentiert.
---

# Leistungsnachweis: Präsentation

Darstellung der Arbeitsergebnisse vor dem gesamten Kurs in Form eines Vortrages.

* Anwesenheitspflicht!
* Größenordnung: 10 Minuten + 5 bis 10 Minuten Fragen

---
# Themenwahl

Der Themenbereich kann selbst gewählt werden muss jedoch:
 * in allen Gruppen unterschiedlich sein
 * ein Teil des Themas muss Rechnugnen beinhalten

---
class: middle, center

# Danke für die Zusammenarbeit



