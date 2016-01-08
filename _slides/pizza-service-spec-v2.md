---
title: "Pizza Service Spezifikation"
---

# Pizza Service Spezifikation

Mama Mia!

Das ist ein neuer Pizza Lieferservice, welcher demnaechst in Bremen eroeffnen moechte. Der Besitzer Don Corleone moechte eine Datenbank fuer den Service haben. Ihm ist klar, dass man sichere Geschaeftsdaten braucht, um stetig den Service zu verbessern. Daher moechte er, dass diese Datenbank sowohl das ganze Essens-Angebot verwaltet als auch aktuelle und vergangene Bestellungen. Der Firmensitz ist in Deutschland.

## Das Menu

Es soll mehere Pizzagroessen zur Auswahl stehen, die je einen Grundpreis haben. Es wird klassiche Pizzen geben, aber jeder Kunde kann zu jeder Pizza Aenderungswuensche haben oder sich Pizzen auch von Grund auf ganz indivuell zusammenstellen.

Zusaetzlich zu den Pizzen, umfasst das Essens-Angebot Vorspeisen, Salate, Nachspeisen und Getraenke.

Zwecks einfacherer Kommuminkation mit den Kunden und Eingabe in die Kasse, bekommt jeder Eintrag in das Menu eine eindeutige Nummer.

* Zu jeder Pizza muss es ein Bild geben, zumindest ein Platzhalter Bild.

Es soll auch moeglich sein Preisrabbate zu gewaehren. Diese beinhalten Sonderaktionen, Stammkundenrabatte, reduzierter Preis (oder zusaetzliche Waren, wie z.B. extra Limo) bei Selbstabholung, oder Mittagspreise z.B. alles 20% billiger zwischen 12-14 Uhr.


## Bestellungen

Bestellungen koennen im Internet per Telefon oder Vorort getaetigt werden. Bestellungen koennen entweder selber abgeholt werden oder geliefert werden. 

Um die Service Qualitaet beobachten zu koennen, ist es wichtig, dass zu jeder Bestellung erfasst wird:

* wann diese getaetigt wurde, 
* welche Schaetzung ueber die Dauer der Vorbereitung und Lieferung an den Kunden gegeben wurde
* und wann die tatsaechliche Lieferung erfolgte.

Evtl. implementieren wir, wo sich welcher Lieferwagen gerade befindet.

## Kundenverwaltung

Gerade fuer die Lieferungen muessen einige Daten zu den Kunden erfasst werden. Die Adresse wird benoetigt, um zu wissen wohin Lieferungen gehen sollen. Um Kommunikation z.B. bei evtl. Lieferproblemen zu ermoeglichen sollen sowohl email-Adresse, als auch Telefonnummer erfasst werde koennen. 

Jedoch, zwecks Datenschutz ist Datensparsamkeit ratsam, daher soll es moeglich sein, dass Kunden den Lieferservice in Anspruch nehmen koennen ohne mehr als die notwendige Lieferaddresse zu wissen.

## Weitere Aspekte

1. Was sind die Oeffnungszeiten
2. Welchen geographischen Bereich beliefert Mama Mia

## Nicht Bestandteil dieses Projektes

Einige Aspekte eines moeglichen Lieferservices sind sehr interessant, aber nicht bestandteil dieses Projektes:

1. Mitarbeiterdatenbank: Die Erfassung der Mitarbeiter ist erstaml nicht vorgesehen.
1. Lagerverwaltung: Die Erfassung und das Management der Lebensmittel und sonstigen Waren, die zur Herstellung benoetigt werden
1. Live-tracking der Lieferungen, d.h. der Kunde hat die Moeglichkeit z.B. auf einer Web-Seite zu sehen, wo sich gerade die der Leiferwagen mit der eigenen Bestellung befindet.



