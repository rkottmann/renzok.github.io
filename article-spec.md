---
title: article spec
layout: default
published: false
---

Ein Artikel ist eine kleine Abhandlung zu einem thema.

Viele machen das in blogs, jedoch sind blogs logs, d.h. soe halten fest, 
zu welcher Zeit was veroeffentlicht wurde und sind im wesentlichen danach sortiert.

Jedoch ist das fuer Artikel nachrangieg. Ich moechte die Artikel eher Enzoklypdaeisch 
verwalten und zwar als living Artikel. D.h. ein artikel kann jederzeit geaendert werden. 

Um die Aenderungen fuer jeden Nachvollziehabr zu machen, braucht es eine Versionsverwaltung.

Bei Dokumenten ist es eine gaengige  Praxis jeder neuen Version eine hoehere Nummer im Dateinamen zu geben. Also 1,2,3...

Wann diese Nummern vergeben werden ist dem Autor ueberllassen. 
Ein Kommentar vur Aenderung wird manchmal im dokument selber angeben. 
Diese Methode ist simpel und in den meisten Faellen absolut ausreichend.

Informelle regeln:

* Zu jedem Versionssprung
  * setze die nummer im dateinamen hoch
  * schreib an einer bestimmten Stellen im dokument ein Kommentar zur 
    Versionsaenderung, die der Nummer im Dateinamen entspricht

Reihenfolge der Regeln beliebig. Keine ueberpruefung der einhaltung der REgeln.

Dies ist unstruktiert und es kommt
 schnell und haeufig zu einer inkonsistenten Anwednung und somit Abweichung.
 
 Wie kann man diese VErsionsverwaltungsregeln im kontext von github pages 
 so struktieren, dass sie automatisch ueberpruefbar werden und 
 optimaler weise inksostente Anwendung verhindert?
 
 Problem 1: Automatisiere versionssprung im fileanmen
 
 git hook
 script
 
 github pages implziert einen einfachen Publikationsworkflow:
 
 Wenn auf master branch gepusht wird, dann produziere oefetliche static files.
 
 Das scheint evtl. der beste Punkt zu einhacken zu sein.
 
 
 * die aktuelsste version gibt es immer zweimal:
   1. filename ohne versionsnummer (zum editieren)
   1. fileanme mit versionsnummer (hoechste nummer ist aktuellste version)
   
indem man edieiteren nur im filenamen ohne verisonsnummer zulaesst und aenderungen 
am veriosnfile verhindert, gewinnt man preservation und verisonsnummern automatische versionierung (user muss nicht mehr dran denken)


Problem: veriosnskommentar

hier koennen wir ausdem jekyll md prozessor spec den grossen vorteil ziehen,
dass mit dem yaml teil 1. ein fester platz im dokument definiert ist und weil yaml struktiert ist.


versions: 
 - 1 = slakd;sak
 - 2 = bla
 
 
 
   