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
# Zusammenfassung der vorherigen Vorlesung



{% assign lecture = "vorlesung-4" %}

## [Constraints]({{ lecture }}#14)

* [Datentypen]({{ lecture }}#15)
* [Primary Keys]({{ lecture }}#18)
* [NULL or NOT NULL Constraints]({{ lecture }}#19)
* [DEFAULT VALUES]({{ lecture }}#22)
* [CHECK Constraint]({{ lecture }}#24)
* [UNIQUE Constraint]({{ lecture }}#25)
* [CREATE DOMAIN]({{ lecture }}#27)

---

# Vertiefung: 
## Einschränkung von Wertebereichen durch Aufzählungen

---

# Arten von Daten

1. Zahlen (integer, numeric, double precision...)
2. Free Text (text, char)
3. Enumeration
4. Code-List
5. Komplexe Zusamensetzungen der oberen "einfachen Arten"
   Z.B. Telefonnummern, Zeitstempel (Datum + Uhrzeit)...
---

# Enumeration & Code List
1. **Enumeration**:
   Liste von Werten, die in Zukunft wenig bis gar nicht geändert wird
   
   z.B. `Geschlecht = {maennlich,weiblich}`
1. **Code-List**:
   Liste von Werten, die in Zukunft häufig und zu jeder Zeit geändert wird
   * Und haeufig der eigentliche Wert codifiziert wird
---

# Implementierungsvarianten
1. `check` constraint: 
   
   `gender text check (gender in ['maennlich','weiblich'])`
2. [Enumerated Types](http://www.postgresql.org/docs/{page.pg_version}/static/datatype-enum.html):

   `CREATE TYPE gender AS ENUM ('maennlich','weiblich');` 

3. Lookup-Tabelle

---
class: split-40
# Implementierung durch Lookup-Tabelle

~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);
INSERT INTO geschlecht 
  VALUES ('maennlich'),('weiblich');

CREATE TABLE teilnehmerin (
  vorname person_name CHECK ( vorname != '' ),
  nachname person_name,
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3,
  geschlecht text
    REFERENCES geschlecht(name)
);

INSERT INTO teilnehmerin (geschlecht,vorname, nachname, matrikel_nr, email) 
  VALUES ('maennlich','renzo','kottmann',007,'renzo@007.bond');

~~~

---
class: split-50

# `Foreign Key`-Referenz auf Lookup-Tabelle

.column[
A [foreign key constraint](https://www.postgresql.org/docs/9.6/static/tutorial-fk.html) specifies that the values in a column (or a group of columns) 
must match the values appearing in some row of another table. 

We say this maintains the referential integrity between two related tables.

]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);


CREATE TABLE teilnehmerin (
  vorname person_name CHECK ( vorname != '' ),
  nachname person_name,
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3,
  geschlecht text
    REFERENCES geschlecht(name)
);
~~~
]


---

class: split-50

# `Foreign Key`-Referenz auf Lookup-Tabelle

.column[
* Kann man erst Tabelle `teilnehmerin` und dann `geschlecht` anlegen?
* Was passiert, wenn in `teilnehmerin` geschlecht null ist?
* Muss `name` in Tabelle `geschlecht` Ein-Eindeutig sein?
* Was passiert, wenn in `geschlecht` die Zeile `maennlich` geloescht wird?
   
]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

CREATE TABLE teilnehmerin (
  vorname person_name CHECK ( vorname != '' ),
  nachname person_name,
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3,
  geschlecht text
    REFERENCES geschlecht(name)
);
~~~
]

---
class: split-50

# `Foreign Key` Verhalten bei Datenänderung


.column[
* Was soll mit Einträgen in `teilnehmerin` passieren wenn ein 
`FOREIGN KEY` (also ein Eintrag in `geschlecht` geändert wird?
  * Verhindern oder alle Einträge in `teilnehmerin` auch ändern?

]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

CREATE TABLE teilnehmerin (
  vorname person_name CHECK ( vorname != '' ),
  nachname person_name,
  matrikel_nr integer PRIMARY KEY,
  email text NOT NULL CHECK ( email ~ '.*@.*' ) UNIQUE,
  semester integer DEFAULT 3,
  geschlecht text
    REFERENCES geschlecht(name)
);
~~~
]

---


# Entity Relationships (Beziehungen) revisited

Verschiedene Entitäten können zueinander in Beziehung gesetzt
werden. 

* In jeder Beziehung haben Entitäten gewisse Rollen
* Beziehungen können Eigenschaften (Attribute) haben
* Beziehungen haben Kardinalitäten
  
---
class: split-50
# Notationen

.column[
![](/img/crow-foot-notation-matthiessen-abb10-6.png)
]

.column[
1. UML
2. Crow Foot
3. Darstellung nach Chen-Notationen
4. Darstellung nach [Zehnder](https://www.springer.com/de/book/9783519024804) 
]

aus [Matthiesen et al.](./#matthiessen)
---
class: middle

# Agile änderung

Wie ändert sich das ERM und die implementierung wenn folgende
Anforderng hinzukommt:
  * Die Datenbank soll für alle vergangenen und zukünftigen
  Datenbankkurse informationen speichern können
  
## Whiteboard
## ERD und Beziehungen von Teilnehmerin Datenbank

---
# Beziehungen

* Teilenhmer ist in einer Projektgruppe und einer Laborgruppe
* Jede Projektgruppe bearbeitet mehere Laboruebungen

![erd-teilnehmer](/img/dbl/mi-teilnehmer-erd-1.png)

---
# Beziehungen mit Foreign Keys 

* Bestimmem die 
  * Attribute welche die Beziehungen identifizieren
  * Kardinalitäten
  
![erd-teilnehmer](/img/dbl/mi-teilnehmer-erd-1.png)

---
class: split-40
# Foreign Keys (one to many)

.column[
* Koennen nur eins zu viele Beziehungen umsetzen
* Werden immer von viele zu eins gesetzt

]

.column[
```sql

CREATE TABLE labor_gruppe (
  code text 
    PRIMARY KEY
    CHECK ( code IN  ('w','x','y','z') ) ,
  -- Attribute fehlen
  anfangszeit time
    NOT NULL
);

CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
    CHECK ( vorname != '' ),
  matrikel_nr integer 
    PRIMARY KEY,
  -- Attribute fehlen
  labor text
    REFERENCES labor_gruppe(code),
  geschlecht text
    REFERENCES geschlecht(name) 
    ON UPDATE CASCADE
);
```
]

---
class: split-40
# Foreign Keys (one to many)

.column[
# Frage

Wird hier `0..1 zu N` 

oder 

`1 zu N` umgesetzt?

]

.column[
```sql

CREATE TABLE labor_gruppe (
  code text 
    PRIMARY KEY
    CHECK ( code IN  ('w','x','y','z') ) ,
  -- Attribute fehlen
  anfangszeit time
    NOT NULL
);

CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
    CHECK ( vorname != '' ),
  matrikel_nr integer 
    PRIMARY KEY,
  -- Attribute fehlen
  labor text
    REFERENCES labor_gruppe(code),
  geschlecht text
    REFERENCES geschlecht(name) 
    ON UPDATE CASCADE
);
```
]

---
# Foreign Keys (many to many) 

![erd-teilnehmer](/img/dbl/mi-teilnehmer-erd-1.png)

---
# Foreign Keys (many to many) 
* Umsetzung durch neue "Beziehungs"-Relation

![erd-teilnehmerinnen](/img/dbl/mi-teilnehmer-erd-2.png)

---
class: split-40
# Foreign Keys (many to many) 

.column[
 * Neue Tabelle, die auf die beiden existierenden referenziert
 * Primary Key der neuen Tabelle ist Kombination der PKs der existierenden Tabellen
]

.column[
```sql
CREATE TABLE projekt_gruppe (
  titel text 
    PRIMARY KEY
    CHECK ( titel != '' ) ,
  thema text 
    NOT NULL
    DEFAULT ''
);

CREATE TABLE labor_uebung (
  titel text 
    PRIMARY KEY,
  gestellt date 
    NOT NULL
    UNIQUE
);

CREATE TABLE labor_abgabe (
  gruppe text
    REFERENCES projekt_gruppe(titel),
  uebung text
    REFERENCES labor_uebung(titel),
    
  PRIMARY KEY (gruppe,uebung)
);
```
]

---
class: middle, center

# Danke für die Zusammenarbeit



