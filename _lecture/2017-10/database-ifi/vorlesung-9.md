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

## [Abfragen auf einer Tabelle](vorlesung-7.html#20)

---

---

# Beispiel-Tabellen
~~~
TabelleA      TabelleB
id name       id  name
-- ----       --  ----
1  Pirate     1   Rutabaga
2  Monkey     2   Pirate
3  Ninja      3   Darth Vader
4  Spaghetti  4   Ninja
~~~
---
class: split-50
# INNER JOIN

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       INNER JOIN 
	   TabelleB as b
    ON a.name = b.name
~~~
~~~
id  name       id   name
--  ----       --   ----
1   Pirate     2    Pirate
3   Ninja      4    Ninja
~~~
]

.column[
![inner-join](/img/dbl/inner-join-small.png)
]
---
class: split-50
# FULL OUTER JOIN

.column[
~~~sql
SELECT * 
  FROM TabelleA as a
       FULL OUTER JOIN 
	   TabelleB as b
    ON a.name = b.name
~~~

~~~
id    name       id    name
--    ----       --    ----
1     Pirate     2     Pirate
2     Monkey     null  null
3     Ninja      4     Ninja
4     Spaghetti  null  null
null  null       1     Rutabaga
null  null       3     Darth Vader
~~~
]

.column[
![inner-join](/img/dbl/full-outer-join-small.png)
]
---
class:split-50
# LEFT OUTER JOIN

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       LEFT OUTER JOIN 
	   TabelleB AS b
    ON a.name = b.name
~~~

~~~
id  name       id    name
--  ----       --    ----
1   Pirate     2     Pirate
2   Monkey     null  null
3   Ninja      4     Ninja
4   Spaghetti  null  null
~~~
]
.column[
![sql-joins-venn](/img/dbl/left-outer-join-small.png)
]
---
class:split-50
#  LEFT OUTER JOIN: nur Zeilen von TabelleA

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       LEFT OUTER JOIN 
	   TabelleB AS b
    ON a.name = b.name
 WHERE b.id IS null
~~~

~~~
id  name       id     name
--  ----       --     ----
2   Monkey     null   null
4   Spaghetti  null   null
~~~
]
.column[
![sql-joins-venn](/img/dbl/left-outer-join-exclusive-small.png)
]
---
class:split-50
#  FULL OUTER JOIN: nur exklusive Zeilen

.column[
~~~sql
SELECT * 
  FROM TabelleA AS a
       FULL OUTER JOIN
	   TabelleB AS b
    ON a.name = b.name
 WHERE a.id IS null
       OR 
	   b.id IS null
~~~

~~~	
id    name       id    name
--    ----       --    ----
2     Monkey     null  null
4     Spaghetti  null  null
null  null       1     Rutabaga
null  null       3     Darth Vader
~~~
]
.column[
![sql-joins-venn](/img/dbl/full-outer-join-exclusive-small.png)
]
---
class:split-50
# CROSS JOIN: Erzeugt kartesiches Produkt

.column[
~~~sql
SELECT * 
  FROM TabelleA
       CROSS JOIN 
	   TabelleB
~~~
]
.column[
![sql-joins-venn](/img/dbl/cartesian-product.png)
]
In einfachen Worten: Verbindet jede Zeile der TabelleA mit jeder Zeile der TabelleB
---

![sql-joins-venn](/img/dbl/sql-join-venn-overview.jpg)

---
# Diskussion zu Visualisierung von SQL-joins

* [Original Artikel mit Venn-Overview](http://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins)
* [Diskussion und alternative Darstellung](http://stackoverflow.com/questions/13997365/sql-joins-as-venn-diagram)
* [Kategorisierung nach JOIN-Typen](http://www.way2tutorial.com/sql/sql_join_types_visual_venn_diagram.php)
---
# laboruebung

---
class: middle, center

# Danke für die Zusammenarbeit

