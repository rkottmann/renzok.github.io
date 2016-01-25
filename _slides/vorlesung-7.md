---
title: "Vorlesung 7"
layout: simple
---

# Normalisierung

Ziel: relationales Datenbank-Model so zu entwerfen, dass keine Update-Anomalien vorkommen können.

Relation (als Tabelle dargestellt): Nicht normale Teilnehmerinnen-Datenbank


## Update-Anomalien 
<!--StartFragment-->

<table class=MsoTableMediumShading1Accent3 border=1 cellspacing=0
 cellpadding=0 width=631 style='width:473.2pt;border-collapse:collapse;
 border:none;mso-border-alt:solid #B0B0B0 1.0pt;mso-border-themecolor:accent3;
 mso-border-themetint:191;mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:-1;mso-yfti-firstrow:yes;height:15.0pt'>
  <td width=53 nowrap valign=top style='width:39.95pt;border:solid #B0B0B0 1.0pt;
  mso-border-themecolor:accent3;mso-border-themetint:191;border-right:none;
  background:#969696;mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;
  height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:5'><b><span style='color:white;
  mso-themecolor:background1'>Name<o:p></o:p></span></b></p>
  </td>
  <td width=70 nowrap valign=top style='width:52.6pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>Nachname<o:p></o:p></span></b></p>
  </td>
  <td width=105 nowrap valign=top style='width:78.6pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>MatrikelNummer<o:p></o:p></span></b></p>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>(Primary Key)<o:p></o:p></span></b></p>
  </td>
  <td width=133 nowrap valign=top style='width:100.0pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>emails<o:p></o:p></span></b></p>
  </td>
  <td width=53 nowrap valign=top style='width:40.05pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>Klausur<o:p></o:p></span></b></p>
  </td>
  <td width=89 valign=top style='width:66.5pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>Aufgabe<o:p></o:p></span></b></p>
  </td>
  <td width=52 valign=top style='width:38.7pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>Strasse<o:p></o:p></span></b></p>
  </td>
  <td width=32 valign=top style='width:23.75pt;border-top:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:none;background:#969696;
  mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>Ort<o:p></o:p></span></b></p>
  </td>
  <td width=44 valign=top style='width:33.05pt;border:solid #B0B0B0 1.0pt;
  mso-border-themecolor:accent3;mso-border-themetint:191;border-left:none;
  background:#969696;mso-background-themecolor:accent3;padding:0cm 5.4pt 0cm 5.4pt;
  height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:1'><b><span style='color:white;
  mso-themecolor:background1'>PLZ<o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:0;height:15.0pt'>
  <td width=53 nowrap valign=top style='width:39.95pt;border-top:none;
  border-left:solid #B0B0B0 1.0pt;mso-border-left-themecolor:accent3;
  mso-border-left-themetint:191;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:
  accent3;mso-border-bottom-themetint:191;border-right:none;mso-border-top-alt:
  solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;mso-border-top-themetint:
  191;background:#E5E5E5;mso-background-themecolor:accent3;mso-background-themetint:
  63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:68'><b>Ricarda<o:p></o:p></b></p>
  </td>
  <td width=70 nowrap valign=top style='width:52.6pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>Huch</p>
  </td>
  <td width=105 nowrap valign=top style='width:78.6pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>123456</p>
  </td>
  <td width=133 nowrap valign=top style='width:100.0pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>huch@stud.hs-bremen.de,
  ric@gmail.com</p>
  </td>
  <td width=53 nowrap valign=top style='width:40.05pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>FALSE</p>
  </td>
  <td width=89 valign=top style='width:66.5pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>Buchhandlung</p>
  </td>
  <td width=52 valign=top style='width:38.7pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>S 1</p>
  </td>
  <td width=32 valign=top style='width:23.75pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>HB</p>
  </td>
  <td width=44 valign=top style='width:33.05pt;border-top:none;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:solid #B0B0B0 1.0pt;mso-border-right-themecolor:
  accent3;mso-border-right-themetint:191;mso-border-top-alt:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;background:
  #E5E5E5;mso-background-themecolor:accent3;mso-background-themetint:63;
  padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>23</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:15.0pt'>
  <td width=53 nowrap valign=top style='width:39.95pt;border-top:none;
  border-left:solid #B0B0B0 1.0pt;mso-border-left-themecolor:accent3;
  mso-border-left-themetint:191;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:
  accent3;mso-border-bottom-themetint:191;border-right:none;mso-border-top-alt:
  solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;mso-border-top-themetint:
  191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:132'><b>Greta<o:p></o:p></b></p>
  </td>
  <td width=70 nowrap valign=top style='width:52.6pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:128'>Garbo</p>
  </td>
  <td width=105 nowrap valign=top style='width:78.6pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:128'>234567</p>
  </td>
  <td width=133 nowrap valign=top style='width:100.0pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:128'>great@web.de,
  garbo@hollywood.com</p>
  </td>
  <td width=53 nowrap valign=top style='width:40.05pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:128'>FALSE</p>
  </td>
  <td width=89 valign=top style='width:66.5pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:128'>Filmsammlung</p>
  </td>
  <td width=52 valign=top style='width:38.7pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:128'>S 1</p>
  </td>
  <td width=32 valign=top style='width:23.75pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:128'>HH</p>
  </td>
  <td width=44 valign=top style='width:33.05pt;border-top:none;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:solid #B0B0B0 1.0pt;mso-border-right-themecolor:
  accent3;mso-border-right-themetint:191;mso-border-top-alt:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;padding:0cm 5.4pt 0cm 5.4pt;
  height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:128'>44</p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;mso-yfti-lastrow:yes;height:15.0pt'>
  <td width=53 nowrap valign=top style='width:39.95pt;border-top:none;
  border-left:solid #B0B0B0 1.0pt;mso-border-left-themecolor:accent3;
  mso-border-left-themetint:191;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:
  accent3;mso-border-bottom-themetint:191;border-right:none;mso-border-top-alt:
  solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;mso-border-top-themetint:
  191;background:#E5E5E5;mso-background-themecolor:accent3;mso-background-themetint:
  63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:68'><b>Emma<o:p></o:p></b></p>
  </td>
  <td width=70 nowrap valign=top style='width:52.6pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>Goldman</p>
  </td>
  <td width=105 nowrap valign=top style='width:78.6pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>345678</p>
  </td>
  <td width=133 nowrap valign=top style='width:100.0pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>libertat@gmx.de</p>
  </td>
  <td width=53 nowrap valign=top style='width:40.05pt;border:none;border-bottom:
  solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:
  191;mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:115%;mso-yfti-cnfc:64'>FALSE</p>
  </td>
  <td width=89 valign=top style='width:66.5pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>Buchhandlung</p>
  </td>
  <td width=52 valign=top style='width:38.7pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>S 3</p>
  </td>
  <td width=32 valign=top style='width:23.75pt;border:none;border-bottom:solid #B0B0B0 1.0pt;
  mso-border-bottom-themecolor:accent3;mso-border-bottom-themetint:191;
  mso-border-top-alt:solid #B0B0B0 1.0pt;mso-border-top-themecolor:accent3;
  mso-border-top-themetint:191;background:#E5E5E5;mso-background-themecolor:
  accent3;mso-background-themetint:63;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>HB</p>
  </td>
  <td width=44 valign=top style='width:33.05pt;border-top:none;border-left:
  none;border-bottom:solid #B0B0B0 1.0pt;mso-border-bottom-themecolor:accent3;
  mso-border-bottom-themetint:191;border-right:solid #B0B0B0 1.0pt;mso-border-right-themecolor:
  accent3;mso-border-right-themetint:191;mso-border-top-alt:solid #B0B0B0 1.0pt;
  mso-border-top-themecolor:accent3;mso-border-top-themetint:191;background:
  #E5E5E5;mso-background-themecolor:accent3;mso-background-themetint:63;
  padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
  <p class=MsoNormal style='mso-yfti-cnfc:64'>44</p>
  </td>
 </tr>
</table>


Diese Tabelle ist nicht normal, sie hat alle Anomalien! 

### Anomalien

1.	Modifikation: Die Datenbank muss an mehreren Stellen geändert werden, um Einträge zu ändern. Beispiel: wenn der Name der Aufgabe von Buchhandlung in Buchhandlungen geändert werden soll.
2.	Einfügung: Um einen Eintrag in eine Tabelle vorzunehmen, müssen nicht reale Werte erfunden werden. Beispiel: Um eine neue Aufgabe einzufügen, muss eine 'MatrikelNummer' erfunden werden, da MatrikelNummer Primärschlüssel ist.
3.	Löschung: Um einen Eintrag zu löschen, müssen auch ungewollt andere Einträge gelöscht werden: Beispiel: Um die Aufgabe 'Filmsammlung' zu löschen, muss MatrikelNummer (und somit die gesamte Zeile) gelöscht werden.



## Funktionale Abhängigkeiten

> Definition: seien A und B beliebige Teilmengen der Attribute einer Relation/Tabelle R. 
> Dann ist A von B funktional abhängig, wenn gilt
> für jede Wertekombination von A gibt es – zu einem gegebenen Zeitpunkt – nur eine Wertekombination von B.


Wenn die Werte von A feststehen, stehen auch die Werte von B fest. Auch wenn B noch nicht bekannt ist, kann es nur eine Wertekombination von A zu B geben.

Anders herum formuliert: Es kann zu keinem Zeitpunkt zweimal dieselben Werte für A geben, aber jeweils verschiedene Werte für B.

Das heißt: 
> A determiniert B funktional: A → B

### Beispiele:

Sei X die Menge aller Attribute der Relation Teilnehmerinnen.

1.	A = {MatrikelNummer}, dann gilt A → X denn A ist Primärschlüssel
2.	B = {Name}, dann gilt **nicht** B → X. Denn es kann mehrere Teilnehmerinnen mit demselben Namen geben.
3.	O = {Ort, Strasse}, P = {PLZ}, dann gilt O → P

**Frage**: Gilt P → O ?

## 1. Normalform

> Eine Datenbank ist in 1. Normalform (1NF), wenn alle Attribute atomar sind.

D.h. jedes Attribut enthält nur einen Wert der immer als Ganzes betrachtet wird.

## 2. Normalform

> Eine Relation ist in 2. Normalform (2NF), wenn sie 1NF erfüllt und jedes Attribut, das nicht zum Primärschlüssel gehört, voll von diesem abhängig ist.

### Merksatz

> „Alle Attribute, die nicht Teil des Schluessels sind, haengen voll funktional von diesem ab.“

* Ist der Primärschlüssel einfach, so ist 2NF trivialerweise erfüllt.
* Daher ist die obige Tabelle schon in 2NF.

Folgendes schematisches Beispiel soll dies verdeutlichen:

![2NF-Verstoss](/img/dbl/verstoss-2nf.png)


## 3. Normalform

> Eine Relation ist in der dritten Normalform, wenn für jede nicht triviale funktionale Abhängigkeit T → A mit T Obermenge eines Schlüssels ist oder A (mindestens) ein Schlüssel-Attribut enthält.

* aus 2NF und Minimalität des Schlüssels ergibt sich, dass T mindestens ein Nichtschlüsselattribut enthalten muss, um gegen 3NF zu verstoßen. 
 
Es gibt keine transitiven funktionalen Abhängigkeiten. Aus S → A darf sich nicht A → T ableiten lassen.

### Merksatz

> Eine Relation ist 3NF genau dann, wenn die nicht Schlüsselattribute (nicht Teil des Primary Key) folgende Eigenschaften haben:

> a)	voneinander unabhängig

> b)	unwiderruflich abhängig vom Primary Key

![verstiss 3NF](/img/dbl/verstoss-3nf.png)

## Zusammenfassung

Es gibt sehr viel Literatur und Diskussion zum Thema Datenbank-Normalisierung. Sehr lange gab es die Ueberlegung, ob es einen implementierbaren Algorithmus geben kann, der jede Normalisierung jedes Datenbankschemas automatisch duchfuehren kann. Es hat sich rausgestellt, dass es einfach ist die einzelnen Schritte zur Normalisierung zu formalisieren. Jedoch ist es sehr schwierig bzw. wurde keine Loesung gefunden, um die korrekte Menge an funktionalen Abhaengigkeiten automatisch zu finden, denn was und wie eine funktionale Abhaengigkeit zu definieren ist, haengt zum Einen von der zu modelierenden Mini-Welt und den dazu entscheidenen [Geschaeftsregeln](https://en.wikipedia.org/wiki/Business_rule) ab und zum Anderen erfordert es haeufig Expertenwissen.

Zum Beispiel haengt es von der der Mini-Welt ab, ob eine Adresse als eine elementare Einheit betrachtet wird oder es in Ort, Strasse, Hausnummer, Postleitzahl aufgeteilt wird. 

**Merkregel**: Sobald es erforderlich ist nach einzelnen Bestandteilen zu suchen, wie z.B. "in welcher Strasse wohnt Norma Li. Sierung", ist es besser, Adressen in einzelne Attribute zu teilen.

**Tip**: Da man am Anfang haeufig nicht weiss, welche Anfragen bzw. Abfragen an die Datenbank gestellt werden, ist es im Zweifel ratsam erst in Attribute zu teilen. Falls sich spaeter raustellt, dass man diese Teilung nicht braucht, ist es wesentlich einfacher die Teile wieder zusammenzufuehren als umgedreht.

Hat man Adressen aufgeteilt braucht man Expertenwissen, um zu bestimmen ob:

{ort} → {postleitzahl} und/oder

{postleitzahl} → {ort}

gilt.

**Frage**: Sind diese beiden Bestimmungen relevant fuer die obige Teilnehmerinnen-Datenbank? 

## Fazit

Haeufig sind gute Modelle schon in 3NF. Normalisierung hilft dies zu ueberpruefen und gegebenenfalls uebersehene und unerwuenschte funktionale Abhaengigkeiten nachtraeglich zu normalisieren.

# Referenzen

Beide Bilder aus:

* M. Unterstein and G. Matthiessen, Relationale Datenbanken und SQL in
  Theorie und Praxis. Berlin, Heidelberg: Springer Berlin Heidelberg,
  2012.
