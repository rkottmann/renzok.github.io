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

## Lesen und verstehn von [SQL code des Music Collection Projekts](./mcm-db/mcm-db.sql)

---
# Transaktionen

Eine Transkation ist eine Menge von Operationen die atomic, consistent, isoliert und dauerhaft sind (ACID).

---

# ACID 

* __A__lle Änderungen mit 

*  __C__hirurgischer Integrität in einem von allen anderen 

*  __I__soliertem Vorgang zusammengefasst und mit 

*  __D__auerhaftem Ergebnis.

---
Die wichtigsten Eigenschaften im Einzelnen:
 
* Atomic

Eine Transaktion gruppiert mehrere Anweisungen in eine einzige atomare Operation in der "Alles oder Nichts” stattfindet.
--

* Consistent

Eine Transaktion bringt eine Datenbank von einem konsistenten Zustand in den nächsten.
--

* Isolated

Transaktion ist unabhängig, d.h. sie wird nicht durch konkurrierende Transaktionen beeinflusst.
--

* Durable

Bei der erfolgreichen Beendigung einer Transaktion sind alle Änderungen dauerhaft gespeichert.

---

# Konsistenz bei sehr vielen gleichzeitigen Änderungen

* Transaktionen garantieren, dass trotz gleichzeitiger Änderungen von vielen 
verschiedenen Benuztern, alle Änderungen - jede für sich - konsistent sind.
* Tatsächlich ist jede einzelne SQL-Anweisung bei den meisten Datenbankensystemen implizit eine einzelne Transaktion, 
d.h. eine Gruppe von Anweisungen mit nur einer Anweisung.

---
# Transaktion mit mehreren Anweisungen

[PostgreSQL Dokumentation für syntaktische Details und fortgeschrittene Eigenschaften](https://www.postgresql.org/docs/9.6/static/sql-begin.html)

Ausgangslage: Datenbank ist in einem super gutem Zustand: Z1

```sql
-- Transaktion wird angefangen:
BEGIN;
SQL Anweisung 1;
SQL Anweisung 2;
...
SQL Anweisung N;
-- Bleibt offen bis:
COMMIT;
```
Wenn die Transaktion __gut läuft__, d.h. alle Anweisungen korrekt sind:

- Datenbank ist in einem super gutem Zustand: Z2

Wenn Transaktion __fehlschlägt__, d.h. wenn nur eine der Anweisungen zum Fehler führt:

Datenbank wird automatisch in den vorherigen Zustand zurück gesetzt (rollback): Z1

---
# Gewollter Transaktionsabbruch

```sql
-- Transaktion wird angefangen:
BEGIN;
SQL Anweisung 1;
SQL Anweisung 2;
...
SQL Anweisung N;
-- Bleibt offen bis:
ROLLBACK;
```
Wenn Transaktion __fehlschlägt__ oder __erfolgreich__ ist:

Datenbank wird in den vorherigen Zustand zurück gesetzt (rollback): Z1

---
# DDL Entwicklung

* PostgreSQL ist einer der wenigen DBMS, die auch DDL Anweisungen in Transaktionen ausfuhren kann

```sql
-- Transaktion wird angefangen:
BEGIN;
CREATE TABLE test (id integer PRIMARY KEY);
INSERT INTO test VALUES (1),(2),(3);
SELECT * from test;
UPDATE test SET id = id + 3;
SELECT * from test;
ROLLBACK;
```

* Sehr nützlich für iterative, evolutionäre Datenbankentwicklung

---
class: center,middle
# Normalisierung

---
class: center,middle

# Fiktive Teilnehmerinnen Tabelle

<table style="border:1px solid black; width:100%">
  <thead>
   <tr><th>Name</th><th>Nachname</th><th>MatrikelNummer<br>(Primary Key)</th><th>emails</th><th>Klausur</th><th>Aufgabe</th><th>Strasse</th><th>Ort</th><th>PLZ</th></tr>
  </thead>
  
    <tr><td>Ricarda</td><td>Huch</td><td>123456</td><td>huch@stud.hs-bremen.de, ric@gmail.com</td><td>FALSE</td><td>Buchhandlung</td><td>S 1</td><td>HB</td><td>23</td></tr>
    <tr><td>Greta</td><td>Garbo</td><td>234567</td><td>great@web.de, garbo@hollywood.com</td><td>FALSE</td><td>Filmsammlung</td><td>S 1</td><td>HH</td><td>44</td></tr>
    <tr><td>Emma</td><td>Goldman</td><td>345678</td><td>libertat@gmx.de</td><td>FALSE</td><td>Buchhandlung</td><td>S 3</td><td>HB</td><td>44</td></tr>
</table>

* Diese Tabelle ist nicht __Normal__, voll von __Anomalien__.

---
# Update-Anomalien

1. Modifikation: 
     Die Datenbank muss an mehreren Stellen geändert werden, um Einträge zu ändern. Beispiel: wenn der Name der Aufgabe von Buchhandlung in Buchhandlungen geändert werden soll.
2. Einfügung: 
    Um einen Eintrag in eine Tabelle vorzunehmen, müssen nicht reale Werte erfunden werden. Beispiel: Um eine neue Aufgabe einzufügen, muss eine `MatrikelNummer` erfunden werden, da MatrikelNummer Primärschlüssel ist.
3. Löschung: 
    Um einen Eintrag zu löschen, müssen auch ungewollt andere Einträge gelöscht werden: Beispiel: Um die Aufgabe 'Filmsammlung' zu löschen, muss `MatrikelNummer` (und somit die gesamte Zeile) gelöscht werden.

---
# Entwurfs-Ziel

> Entwerfe ein relationales Datenbank-Model derart, dass keine Update-Anomalien vorkommen können.

---
# _Funktionale Abhängigkeit_

* Begriff gehört zur Normalisierung 
 
---
# Definition: _Funktionale Abhängigkeit_

Seien X und Y beliebige Teilmengen der Attribute einer Tabelle T. Dann ist Y von X funktional abhängig, wenn gilt


> für jede Wertekombination von X gibt es – zu einem gegebenen Zeitpunkt – nur eine Wertekombination von Y.

--

Wenn die Werte von X feststehen, stehen auch die Werte von Y fest. 

Auch wenn Y noch nicht bekannt ist, kann es nur eine Wertekombination von Y zu X geben.

Anders: Es kann zu keinem Zeitpunkt zweimal dieselben Werte für X geben, aber jeweils verschiedene Werte für Y.

Das heißt:

> X determiniert Y funktional X → Y

---
# Beispiele

Sei A die Menge aller Attribute der Relation Teilnehmerinnen,

mit:

1. X = {MatrikelNummer}, 
   
   dann gilt X → A denn X ist Primärschlüssel
2. Y = {Name}, 

   dann __gilt nicht__ Y → A. Denn es kann mehrere Teilnehmerinnen mit demselben Namen geben.
3. O = {Ort, Strasse}, P = {PLZ}, 

   dann kann O → P gelten, muss aber nicht
---
# Funktionale Abhängigkeiten sind Kontext-Abhängig

# Beispiel:

3. O = {Ort, Strasse}, P = {PLZ}, 

   dann kann O → P gelten, muss aber nicht
   
* Gilt evtl. nur in Bremen bzw. bestimmten Regionen
* Aber nicht allgemein in Deutschland 

  (s. Unterstein und Matthiessen S. 241)   

---
# 1. Normalform

* Eine Datenbank ist in 1. Normalform (1NF), wenn alle Attribute atomar sind.

  D.h. jedes Attribut enthält nur einen Wert der immer als unzerteilbare Einheit betrachtet wird.

---
# 1. Normalform(isierung)

<table style="border:1px solid black; width:100%">
  <thead>
   <tr><th>Name</th><th>Nachname</th><th>MatrikelNummer<br>(Primary Key)</th><th>emails</th><th>Klausur</th><th>Aufgabe</th><th>Strasse</th><th>Ort</th><th>PLZ</th></tr>
  </thead>
  
    <tr><td>Ricarda</td><td>Huch</td><td>123456</td><td>huch@stud.hs-bremen.de, ric@gmail.com</td><td>FALSE</td><td>Buchhandlung</td><td>S 1</td><td>HB</td><td>23</td></tr>
    <tr><td>Greta</td><td>Garbo</td><td>234567</td><td>great@web.de, garbo@hollywood.com</td><td>FALSE</td><td>Filmsammlung</td><td>S 1</td><td>HH</td><td>44</td></tr>
    <tr><td>Emma</td><td>Goldman</td><td>345678</td><td>libertat@gmx.de</td><td>FALSE</td><td>Buchhandlung</td><td>S 3</td><td>HB</td><td>44</td></tr>
</table>
---
# 2. Normalform (2NF)

* Eine Relation ist in 2. Normalform (2NF), 
  * wenn sie 1NF erfüllt und jedes Attribut, das nicht zum Primärschlüssel gehört, voll von diesem abhängig ist.
  * "Alle Attribute, die nicht Teil des Schlüssels sind, hängen voll funktional von diesem ab."

  Ist der Primärschlüssel einfach, so ist 2NF trivialerweise erfüllt.

  Daher ist die obige Tabelle schon in 2NF.

---
# Verstoss gegen 2. Normalform

Folgendes schematisches Beispiel verdeutlicht einen Verstoss:

![Verstoss gegen 2. Normalform](/img/dbl/verstoss-2nf.png)
---
# 3. Normalform (3NF)

> "Eine Relation ist in der dritten Normalform, wenn für jede nicht triviale funktionale Abhängigkeit 
> T → A mit T Obermenge eines Schlüssels ist oder A (mindestens) ein Primattribut enthält."

* Aus 2NF und Minimalität des Schlüssels ergibt sich, dass T mindestens ein Nichtschlüsselattribut enthalten muss, um gegen 3NF zu verstoßen. 

---
# 3. Normalform (3NF) informal
> Eine Relation ist 3NF genau dann, wenn die nicht Schlüsselattribute (nicht Teil des Primary Key) beide Eigenschaften haben:

  1. voneinander unabhängig
  2. unwiderruflich abhängig vom Primary Key
---
# 3. Normalform (3NF) informal

![Verstoss gegen 2. Normalform](/img/dbl/verstoss-3nf.png)
  
---
# Boyce-Codd Normalform (BCNF)

> "Eine Relation ist in der Boyce-Codd Normalform, wenn für jede nicht triviale funktionale Abhängigkeit 
> T → A mit T Obermenge eines Schlüssels ist oder A (mindestens) ein Primattribut enthält."

 
* Es gibt keine transitiven funktionalen Abhängigkeiten. 
  Aus S → A darf sich nicht A → T ableiten lassen.
* Alle funktionalen Abhängigkeiten sind vom Primary Key abhängig

---

# Meine Vorgehensweise

* Alles was, gemäss den Anforderungen, eigenständig und unabhängig von 
existierenden Entitäten gemanaged werden muss, ist eine neue eigenständige Entität oder neue Beziehung zwischen Entitäten.


  * Managen heisst: 
   Alles was zu unterschiedlichen Zeiten erst ins System kommt 
   und eigene `insert`, `update`, und `delete` Regeln hat.
---

# Normalisierung: Weitere Vorgehensweisen


* 5 Regeln: http://www.databaseanswers.org/downloads/Marc_Rettig_5_Rules_of_Normalization_Poster.pdf


* J. Celko's 13 Regeln:
   * Wichtigste: If you have to change more than one row to update, insert or delete a simple fact, then the table is not normalized.
---

Mother Celko's Thirteen Normalization Heuristics

* Does the table model either a set of one and only one kind of entity or one and only one relationship? This is what I call disallowing a “Automobiles, Squids and Lady GaGa” table. Following this rule will prevent ‘Multi-valued dependencies’ (MVD) problems and it is the basis for the other heuristics.
* Does the entity table make sense? Can you express the idea of the table in a simple collective or plural noun? To be is to be something in particular; to be everything in general or nothing in particular is to be nothing at all (this is known as the Law of Identity in Greek logic). This is why EAV does not work – it is everything and anything.
* Do you have all the attributes that describe the thing in the table? In each row? The most important leg on a three-legged stool is the leg that is missing.
---
* Are all the columns scalar? Or is a column serving more than one purpose? Did you actually put hat size and shoe size in one column? Or store a CSV list in it?
* Do not store computed values, such as (unit_price * order_qty). You can compute these things in VIEWs or computed columns.
* Does the relationship table make sense? Can you express the idea of the table in a simple sentence, or even better, a name for the relationship? The relationship is “marriage” and not “person_person_legal_thing”
* Did you check to see if the relationship is 1:1, 1:m or n:m? Does the relationship have attributes of its own? A marriage has a date and a license number that does not belong to either  of the people involved. This is why we don't mind tables that model 1:1 relationships.
---
* Does the entity or relationship have a natural key? If it does, then you  absolutely have to model it as the PRIMARY KEY or a UNIQUE constraint. Is there a standard industry identifier for it? Let someone else do all that work for you.
* If you have a lot of NULL-able columns, the table is probably not normalized.
* The NULLs could be non-related entities or relationships.
* Do the NULLs have one and only one meaning in each column?
* If you have to change more than one row to update, insert or delete a simple fact, then the table is not normalized.
* Did you confuse attributes, entities and values? Would you split the Personnel table into “Male_Personnel” and ”Female_Personnel” by splitting out the sex code? No, sex is an attribute and not an entity. Would you have a column for each shoe size? No, a shoe size is a value and not an attribute.



---
class: middle, center

# Danke für die Zusammenarbeit

