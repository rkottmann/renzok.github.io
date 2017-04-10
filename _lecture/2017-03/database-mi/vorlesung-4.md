# Datenbankbasierte Web-Anwendungen
## {{ page.title }} 
### Medieninformatik SoSe 2017
 
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

## [Constraints](vorlesung-3#20)

* [Datentypen](vorlesung-3#21)
* [Primary Keys](vorlesung-3#23)
* [NULL or NOT NULL Constraints](vorlesung-3#24)
* [DEFAULT VALUES](vorlesung-3#28)
* [CHECK Constraints](vorlesung-3#30)

Nicht besprochen:

* Unique Constraint

---
class: split-40
# Unique Constraint

.column[
* Alle Werte einer- oder meherer Spalte(n) müssen eindeutig sein
* Damit werden weitere Schlüssel implementiert
]

.column[
```sql
CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4
);
Jeder Teilnehmer muss eine 
andere E-Mail haben.
```
]

---
class: split-40
# Logisch gesehen: Primary Key vs. Unique

.column[
* Ein `PRIMARY KEY` ist nichts anderes als ein `UNIQUE NOT NULL`
* D.h. es kann mehrere Schlüssel geben, aber nur einer wird als `PRIMARY KEY` gewählt
]

.column[
```sql
CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4
);
Jeder Teilnehmer muss eine 
andere E-Mail haben.
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
  vorname person_name 
    CHECK ( vorname != '' ),
  nachname person_name,
  matrikel_nr integer PRIMARY KEY,
  email text
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4
);
Jeder Name faengt mit einem 
Gross-Buchstaben an.

```

---

# Vertiefung Einschraenkung von Wertebereichen

## Arten von Daten

1. Zahlen (integer, numeric, double precision...)
2. Free Text (text, char)
3. Enumeration
4. Code-List
5. Komplexe Zusamensetzungen der oberen "einfachen Arten"
   Z.B. Telefonnummern, Zeitstempel (Datum + Uhrzeit)...
---
# Enumeration & Code List
1. **Enumeration**:
   Liste von Werten, die in Zukunft wenig bis gar nicht geaendert wird
   
   z.B. `Geschlecht = {maennlich,weiblich}`
1. **Code-List**:
   Liste von Werten, die in Zukunft haeufig und zu jeder Zeit geaendert wird
---
# Implementierungsvarianten
1. `check` constraint: 
   
   `gender text check (gender in ['maennlich','weiblich'])`
2. [Enumerated Types](http://www.postgresql.org/docs/{page.pg_version}/static/datatype-enum.html):

   `CREATE TYPE gender AS ENUM ('maennlich','weiblich');` 
---
class: split-40
# Implementierung mit Hilfe einer Tabelle

~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);
INSERT INTO geschlecht 
  VALUES ('maennlich'),('weiblich');

CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4,
  geschlecht text
    REFERENCES geschlecht(name)
);

INSERT INTO teilnehmer (geschlecht,vorname, nachname, matrikel_nr, email) 
  VALUES ('maennlich','renzo','kottmann',007,'renzo@007.bond');

~~~

---
class: split-50

# Implementierung durch `Foreign Key`

.column[
A foreign key constraint specifies that the values in a column (or a group of columns) 
must match the values appearing in some row of another table. 

We say this maintains the referential integrity between two related tables.

]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4,
  geschlecht text
    REFERENCES geschlecht(name)
);
~~~
]


---

class: split-50

# Implementierung durch `Foreign Key`

.column[
* Kann man erst Tabelle `teilnehmer` und dann `geschlecht` anlegen?
* Was passiert, wenn in `teilnehmer` geschlecht null ist?
* Was passiert, wenn in `geschlecht` die Zeile `maennlich` geloescht wird?   
]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4,
  geschlecht text
    REFERENCES geschlecht(name)
);
~~~
]

---
class: split-50

# `Foreign Key` Verhalten bei Datenaenderung


.column[
* Was soll mit Eintraegen in `teilnehmer` passieren wenn ein 
`FOREIGN KEY` (also ein Eintrag in `geschlecht` geaendert wird?
  * Verhindern oder alle Eintraege in `teilnehmer` auch aendern?

]

.column[
~~~sql
CREATE TABLE geschlecht (
  name text PRIMARY KEY
);

CREATE TABLE teilnehmer (
  vorname text 
    CHECK ( vorname != '' ),
  nachname text,
  matrikel_nr integer 
    PRIMARY KEY,
  email text 
    NOT NULL 
    CHECK ( email ~ '.*@.*' ) 
    UNIQUE,
  semester integer DEFAULT 4,
  geschlecht text
    REFERENCES geschlecht(name)
);
~~~
]

---


# Relationships (Beziehungen) revisited

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
class: middle,center

# ERD und Beziehungen von Teilnehmer Datenbank

---

# Agile Aenderung

Wie ändert sich das ERM und die implementierung wenn folgende
Anforderng hinzukommt:
  * Die Datenbank soll für alle vergangenen und zukünftigen
  Datenbankkurse informationen speichern können


---
class: middle, center

# Danke für die Zusammenarbeit



