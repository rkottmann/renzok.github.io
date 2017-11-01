
# Datenbankbasierte Web-Anwendungen
# {{ page.title }}
## Internationaler Frauenstudiengang Informatik 
## WiSe 2017/18
 
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

* Erstes Arbeiten mit SQL
* Intigritätsbedingungen mit Constraints

---
# Wiederholung

## Aufgabe 10: Anlegen einer Datenbank

* Lege mit SQL eine eigene Datenabnk an

## Aufgabe 11: Anlegen einer Tabelle

* Lege mit SQL eine Tabelle gemäss Deines kleinen ad-hoc Projektes aus [Labor-Uebung 1](/lecture/2017-10/database-ifi/labor-uebung-1#4.html) an

---
# Aufgabe 12:

* Recherchiert was ein `SCHEMA/SCHEMATA` speziell in PostgreSQL ist
* In welchem `SCHEMA/SCHEMATA` werden Datenbankobjekte wie Tabellen per default angelegt?

---

# Aufgabe 13:

## Datentypen

* Welche Datentypen gibt es schon in PostgreSQL?


---
# Aufgabe 14: 

## Verbessert Eure Tabelle aus Aufgabe 11 

mit 

* Passenderen Datentypen
* Primary Keys
* NULL or NOT NULL Constraints
* DEFAULT VALUES
* CHECK Constraints
* Unique Constraint

---
class: split-30
# Aufagbe 15:

.column[
Wie kann die Intigrität dieser Tabelle noch verbessert werden?
]

.column[
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
]


---
# Aufagbe 16:

## Domains

* Wie kann man eigene Datentypen definieren?
    * Definiert einen eigenen Datentyp fuer Eure Tabelle

---
class: middle

and more to come in near future



