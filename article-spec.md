---
title: article spec
layout: default
published: false
---

Ein Artikel ist eine kleine Abhandlung eines Thema.

Viele machen das in Form von Blogs, jedoch sind Blogs Logs, d.h. diese halten fest, 
zu welcher Zeit was veroeffentlicht wurde und sind im wesentlichen zeitlich sortiert.

Jedoch ist das fuer Artikel nachrangig. Ich moechte die Artikel eher Enzoklypdaeisch 
verwalten und zwar als living Artikel. D.h. ein artikel kann jederzeit geaendert werden. 

Um die Aenderungen fuer jeden Nachvollziehabr zu machen, braucht es eine Versionsverwaltung.

Bei Dokumenten ist eine gaengige Praxis jeder neuen Version eine hoehere Nummer im Dateinamen zu geben.
 Also 1,2,3... usw.

Wann diese Nummern vergeben werden ist dem Autor ueberlassen. 
Ein Kommentar zur Aenderung wird manchmal im Dokument selber angeben. 

Dieses Vorgehen ist simpel und in vielen Faellen absolut ausreichend.

Informelle Regeln:

* Zu jedem Versionssprung
  * setze die Nummer im Dateinamen hoch
  * schreib an einer bestimmten Stellen im Dokument ein Kommentar zur 
    Versionsaenderung, die der Nummer im Dateinamen entspricht

Reihenfolge der Regeln beliebig. Keine Ueberpruefung der Einhaltung der Regeln.

Dies ist unstruktiert und es kommt schnell und haeufig zu einer inkonsistenten Anwednung und somit Abweichung.
 
Wie kann man diese Versionsverwaltungsregeln im Kontext von GitHub Pages so struktieren,
 dass sie automatisch ueberpruefbar werden und optimaler weise inkonsistente Anwendung verhindert?
 
 Problem 1: Automatisierter Versionssprung im Filenamen
 
 git hook
 script
 
 github pages impliziert einen einfachen Publikationsworkflow:
 
 Wenn auf dem master branch gepusht wird, dann produziere oeffentliche static files.
 
 Das scheint evtl. der beste Punkt zum Einhacken zu sein.
  
 * Die aktuellste Version gibt es immer zweimal:
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
 
 
 
   