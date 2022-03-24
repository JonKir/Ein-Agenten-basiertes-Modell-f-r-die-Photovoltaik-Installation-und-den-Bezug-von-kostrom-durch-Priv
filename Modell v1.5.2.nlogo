extensions [ gis table csv ] ; Die verwendeten Erweiterungen

globals[ ;Globale Variablen für Rechungen, Datenspeicherungen und für die Darstellung auf der Karte
  basiskarte ; Die Karte der Landkreise
  wert ; Der Wert eines Landkreises zur Einfärbung der Karte
  farbwert
  darstellungsfarbe
  jahr; aktuelles Jahr
  max_jahr ; Jahr, in dem die Simulation endet
  daten_eigenbedarf
  daten_szenarien
  oekostromanteil ; Listen zur Speicherung der Anteile der Stromarten
  pvanteil
  oekostrom_wechsel ; zählt die Anzahl der Wechsel
  oekostromanteil_gesamt
  solar_installationen ; zählt die Installationen von PV-Anlagen
  installierte_leistung ; zählt die neu installierte Leistung
  verteilung_anlagengröße; Enthält die Anteile der PV-Anlagen nach Anlagengröße
  abweichung_anlagengröße; Für die Kalibrierung wird hier die Abweichung der Anteile an PV-Anlagen nach Anlagengröße gespeichert
  daten_anlagengröße; Enthält die Marktdaten zur Anlagengröße
  daten_anlagenzahl; Enthält die historischen Daten der Anzahl an privaten PV-Anlagen
  daten_ökostromanteil; Enthält die historischen Daten zum Anteil der Haushalte mit Ökostrom (von 2008 bis 2020)
  abweichung_anlagenzahl; Misst die Abweichung für die Kalibrierung
  abweichung_ökostromanteil
  reststreuung_ökostromanteil ; Jeweilige Reststreuung, wird während der Kalibrierung minimiert
  reststreuung_anlagenzahl
  reststreuung

  leistungen; Liste mit möglichen Anlagengrößen (kWp)
  preisspannen; Preisspannen für die Investitionskosten nach Anlagengröße
  mean_s; Strom, den eine durchschnittliche PV-Anlage (7kWp) erzeugt
  w_eink; Gewichte für die Skalarisierung bei der Nutzenkalkulation
  w_ökol
  w_ökon
  ; Wesentliche Parameter für den Entscheidungsprozess
  schranke_pv ; Schwellenwert für den Gesamtnutzen einer PV-Anlage
  schwelle_bewusst ; Schwellenwert Bewusstsein
  schwelle_pers_norm ; Schwellenwert persönliche Normen
  schwelle_subj_norm ; Schwellenwert subjektiv empfundene Normen
  schwelle_pbc ; Schwellenwert perceived behavioral control
  faktor_schwellen_oeko ; Faktor zur Umrechnung der Schwellenwert von PV auf Ökostrom
  veraenderung_attribute ; Jährliche Veränderung der weichen Faktoren, Mittelwert einer Normalverteilung
  faktor_veraenderung_oeko ; Faktor zur Umrechnung der Stärke der Veränderung von PV auf Ökostrom
; Historische Daten für den Kalibrierungsprozess
  verguetung_liste
  gestehung_liste
  strompreis_liste
  ökostrompreis_liste
  lohnentwicklung
  ; Variablen für simple Rechenoperationen
  M
  rest
  i
]

breed [ households household ] ; Die Agenten repräsentieren Privathaushalte in Deutschland

households-own [ ; Attribute der Agenten, die beim Entscheidungsprozess eine Rolle spielen
  id
  einkommen
  einkommen_2021;
  landkreis
  stromart ; Bezug von konventionellem Strom -> 0 / Bezug von Ökostrom -> 1 / Selbstversorgung über PV -> 2
  pv_potential ; Regionale Globalstrahlung
  eigentum ; 0 -> Miete , 1 -> Eigentum
  schicht ; Einkommensschwach -> 0 , Mittelschicht -> 1, Wohlhabend -> 2
  strombedarf ; Jährlicher Stromverbrauch in kWh, Durchschnitt: 3106 kWh/a
  traegheit_oeko ; Trägheit bzgl. der Entscheidung. Gibt an, wie viele Jahre in Folge eine Handlung als sinnvoll erachtet werden muss, bevor sie umgesetzt wird
  traegheit_pv
  counter_oeko ; Zählvariable für die Trägheit
  counter_pv
  handlungen ; Dokumentiert die Handlungen eines Agenten, indem Einträge auf 1 gesetzt werden
  anlagenleistung ; PV Anlage auf dem Dach installiert -> Variable enthält die Leistung ( < 20kWp)
  eigenbedarf ; Wie viel des selbst erzeugten Stroms für den Eigenbedarf verwendet wird
  ; Psychologische Faktoren, die für die Entwicklung von Motivation und die Erwägung der Optionen wichtig sind
  PBC_pv ; Die Variablen sind analog zu Niamir et al. (2018) benannt, PBC steht für perceived behavioral control, ein Konzept aus der Psychologie,
  PBC_oeko ; das ein Maß dafür ist, wie stark ein Individuum die eigene Kontrolle über eine Handlung bzw. den Ausgang eines Prozesses wahrnimmt
  bewusst_pv
  bewusst_oeko
  wissen
  umweltbewusst
  energiebewusst
  schlechtes_gewissen_pv
  schlechtes_gewissen_oeko
  gesamtbewusstsein
  verantwortung_pv
  verantwortung_oeko
  subj_normen_pv ; Subjektive (soziale) Normen bzgl. der PV-Installation und Ökostrom, Subjektive Normen repräsentieren den empfundenen "gesellschaftlichen Druck" bzgl. einer Handlungsoption
  subj_normen_oeko
  pers_normen_pv ; Persönliche Normen
  pers_normen_oeko
  motivationslevel
  motiv_pv ; Motivation in Photovoltaik zu investieren bzw. Ökostrom zu beziehen -> Likert Skala [1,7]
  motiv_oeko
  motivation_pv ; Motivation in Photovoltaik zu investieren bzw. Ökostrom zu beziehen -> Normalisierte Werte
  motivation_oeko
  opt_pv ; Ob eine PV-Installation bzw. ein Stromanbieterwechsel in Erwägung gezogen wird
  opt_oeko
  ; Kosten Nutzen Abwägung
  prob_oeko; Wahrscheinlichkeit den Stromtarif auf Ökostrom umzustellen (abhängig von Preisunterschied und persönlicher Einstellung)
  G_liste ; Gestehungskosten für den produzierten Solarstrom (Cent/kWh)
  G
  kosten_pv_liste ; Kosten einer PV-Anlage pro Jahr in Euro
  kosten_pv; Kosten der ausgewählten Anlage
  payback_pv_liste ; Amortisationszeit der Anlage je nach Anlagengröße
  amortisationszeit ; Amortisationszeit der ausgewählten PV-Anlage
  u_pv ; Liste mit kalkuliertem Gesamtnutzen für verschiedene Anlagengrößen
  u_ökologisch
  u_ökonomisch
  u_einkommen
  nutzen_pv ; Gesamtnutzen der ausgewählten Anlage
  nutzen_ökol
  nutzen_ökon
  nutzen_eink
  ; Werte auf Landkreisebene, die von den Geodaten eingelesen werden
  temp_eigentum
  temp_oekostrom
  temp_einkommen
  temp_pv_pro_h
]

to setup
  ca ; Alles zurücksetzen
  clear-plot ; Plots löschen
  file-close-all ; Zuletzt verwendete Dateien schließen
  reset-ticks
  if (file-exists? "household.csv")[
    file-delete "household.csv"; Löscht alle Einträge in der CSV Datei, damit nur neue Daten dort gespeichert werden
  ]
  if (file-exists? "landkreise.csv")[
    file-delete "landkreise.csv"; Löscht alle Einträge in der CSV Datei, damit nur neue Daten dort gespeichert werden
  ]

  if (Experimente = True) [ ; Für Experimente sollen die Pseudo-Zufallszahlen nicht für mehrere Simulationen gleich sein
  set Seed new-seed
  ]
  random-seed Seed
  set jahr 2021
  set mean_s (1100 * 7 * 0.95 * 25) ; Stromproduktion einer durchschnittlichen PV-Anlage 0.95 -> durchschnittliche Leistungsumsetzung während der Lebensdauer (Degradation der PV-Anlage)
  set w_eink 0.415
  set w_ökol 0.355
  set w_ökon 0.23
  set schranke_pv 0.57
  set Mieternutzen 0.80
  set Netzwerkeinfluss_pv 0.032
  set veraenderung_attribute_pv 0.03
  set veraenderung_attribute_oeko 0.07
  set schwelle_bewusst 3.26
  set schwelle_pers_norm 3.54
  set schwelle_subj_norm 2.98
  set schwelle_pbc 2.5
  set faktor_schwellen_oeko 0.88
  set mittlere_traegheit_oeko 3.70
  set mittlere_traegheit_pv 5.91
  set Netzwerkeinfluss_oeko 0.229
  if (Kalibrierung = True)[
    set jahr 2000
    set w_ökon kalibrierung_w_ökon
    set w_eink kalibrierung_w_eink * (1 - w_ökon)
    set w_ökol (1 - (w_ökon + w_eink))
    set schranke_pv kalibrierung_schranke_pv
    set Mieternutzen kalibrierung_mieternutzen
    set Netzwerkeinfluss_pv kalibrierung_netzwerkeinfluss_pv
    set veraenderung_attribute_pv kalibrierung_veraenderung_attribute_pv
    set schwelle_bewusst (1 + 6 * kalibrierung_schwellen) * (5.21 / 4) ; Kalibrierung der Schwellen wird gekoppelt, die einzelnen Schwellenwerte werden skaliert
    set schwelle_pers_norm (1 + 6 * kalibrierung_schwellen) * (5.67 / 4)
    set schwelle_subj_norm (1 + 6 * kalibrierung_schwellen) * (4.77 / 4)
    set schwelle_pbc (1 + 6 * kalibrierung_schwellen) * (4 / 4)
    set faktor_schwellen_oeko kalibrierung_schwellenfaktor_oeko
    set veraenderung_attribute_oeko kalibrierung_veraenderung_attribute_oeko
    set mittlere_traegheit_oeko kalibrierung_mittlere_traegheit_oeko
    set mittlere_traegheit_pv kalibrierung_mittlere_traegheit_pv
    set Netzwerkeinfluss_oeko kalibrierung_netzwerkeinfluss_oeko
  ]
  ; Geodaten laden
  set basiskarte gis:load-dataset "Geodaten.shp" ; Shapefile-Datei, die alle relevanten Daten auf Landkreisebene enthält (wurde vorher in Python verarbeitet)
  gis:set-world-envelope gis:envelope-of basiskarte ;Konfiguration der "Welt", in der sich die Agenten bewegen entsprechend der Landkreise
  gis:set-drawing-color white
  gis:draw basiskarte 0.2
  print "Lade Geodaten und intialisiere Agenten..." ; Dauert etwas länger, daher die Print-Ausgabe
  ; Weitere Daten integrieren
  set leistungen (list 3 4 5 6 7 8 9 10 12.5 17.5) ; Mögliche Anlagengrößen (kWp) 12.5 und 17.5 stehen für Anlagen mit 10-15 bzw. 15-20 kWp
  set verteilung_anlagengröße (list 0 0 0 0 0 0 0 0 0 0)
  set abweichung_anlagengröße (list 0 0 0 0 0 0 0 0 0 0)
  set daten_anlagengröße (list 0.077330691 0.066018743 0.096696756 0.123214751 0.091779652 0.093964695 0.084202129 0.169234804 0.138168232 0.059389548)
  set daten_anlagenzahl (list 13750 31849 46016 62280 94497 141574 187462 239742 316620 428831 579750 750123 870924 961759 1016443 1053394 1092939 1143633 1198552 1285161 1441146 1634283)
  set daten_ökostromanteil (list 0.0468 0.061 0.088 0.117 0.15 0.17 0.172 0.191 0.22 0.237 0.243 0.264 0.297)
  set abweichung_anlagenzahl []; Liste zum Speichern der quadratischen Abweichungen bei der Kalibrierung
  set abweichung_ökostromanteil []
  set daten_eigenbedarf (csv:from-file "eigenbedarf.csv" ";"); Daten zum Eigenverbrauchsanteil in Abhängigkeit der Anlagengröße und dem Strombedarf
  set preisspannen (list ; Relative Abweichungen von den Durchschnittskosten nach Anlagengröße
    (list 0.06896551724137931 0.3517241379310345 )
    (list -0.13793103448275862 0.2896551724137931 )
    (list -0.2206896551724138 0.35172413793103446 )
    (list -0.27586206896551724 0.32413793103448274 )
    (list -0.2551724137931034 0.33793103448275863 )
    (list -0.21379310344827587 0.296551724137931 )
    (list -0.2896551724137931 0.2896551724137931 )
    (list -0.2827586206896552 0.3103448275862069 )
    (list -0.2827586206896552 0.15172413793103445 )
    (list -0.11724137931034483 -0.020689655172413793 )
  )
  ; Historische Daten zur Kalibrierung
  set verguetung_liste (list 50.62 50.62 48.1 45.7 57.4 54.53 51.8 49.21 46.75 43.01 36.34 28.74 20.09 15.29 13.02 12.40 12.31 12.24 12.05 10.72 9.13 7.53)
  set gestehung_liste (list 71.3 67 63.5 62.4 56.3 53.1 50.4 45.2 42 39.6 28.9 25.1 19.6 16 13.1 12.2 11.8 11.4 9.4 9.1 8.8 8.5)
  set strompreis_liste (list 13.94 14.32 16.11 17.19 17.96 18.66 19.46 20.64 21.65 23.21 23.69 25.23 25.89 28.84 29.14 28.70 28.80 29.28 29.47 30.46 31.81 32.16)
  set ökostrompreis_liste (list 15.5 16 18 19 19.8 20.2 21.25 21.9 22.96 24.03 25.31 26.1 27 28.41 28.75 28.35 29.42 29.24 30.42 31.66 32.54 33)
  set lohnentwicklung (list 96.7 96.7 96.7 96.8 95.8 94.5 93.8 93.1 93.5 93.4 94.7 95.8 96.3 96.2 97.9 100 101.8 102.8 104.1 105.3 104.1 104.1)

  set daten_szenarien (csv:from-file "szenarien.csv" ";") ; Einlesen der Daten für die verschiedenen Szenarien
 ; Agenten initialisieren -> Haushalte und ihre Attribute gemäß der Daten auf die Landkreise verteilen
  createAgents "haushalte" ; Als Input wird die Anzahl der Haushalte nach Landkreisen verwendet, um die Anzahl der erzeugenden Haushalte an die Funktion zu übergeben

  if Kalibrierung = True[
      ask households[
      set PBC_pv (PBC_pv - (veraenderung_attribute_pv * 21))
      set PBC_oeko (PBC_oeko - (veraenderung_attribute_oeko * 21))
      set subj_normen_pv (subj_normen_pv - (veraenderung_attribute_pv * 21))
      set pers_normen_pv (pers_normen_pv - (veraenderung_attribute_pv * 21))
      set subj_normen_oeko (subj_normen_oeko - (veraenderung_attribute_oeko * 21))
      set pers_normen_oeko (pers_normen_oeko - (veraenderung_attribute_oeko * 21))
      set bewusst_pv (bewusst_pv - (veraenderung_attribute_pv * 21))
      set bewusst_oeko (bewusst_oeko - (veraenderung_attribute_oeko * 21))
    ]
  ]
end

to createAgents [ num ] ; Funktion, die die Haushalte gemäß der Daten initialisiert: Zunächst werden entsprechend viele Haushalte erzeugt, anschließend werden den Haushalten anhand der Landkreiswerte individuelle Parameter zugeordnet
  set oekostromanteil [ ]
  set pvanteil [ ]

  foreach gis:feature-list-of basiskarte [ x -> ; Iteriert über die Landkreise
    let anzahl gis:property-value x num
    let N (anzahl / Maßstab) ; Die Anzahl der zu erzeugenden Agenten: 1 Agent repräsentiert dem Maßstab entsprechend viele Haushalte -> Kann im Interface eingestellt werden
    let q floor N ; ganzzahliger Anteil
    let r N - q ; Rest
    set N q
    if (random-float 1 < r)[ ; Hier wird mit der Wahrscheinlichkeit des Restes r die Anzahl der Haushalte um 1 erhöht
      set N N + 1
    ]
; Erzeuge Haushalte in einem Landkreis abhängig von der Einwohnerzahl mit den entsprechenden Attributen
    gis:create-turtles-inside-polygon-manual x households N [["einkommen" "temp_einkommen"]["schluessel" "landkreis"] ["strahlung" "pv_potential"] ["eigentum" "temp_eigentum"] ["oekostrom" "temp_oekostrom"] ["pv_pro_H" "temp_pv_pro_h"]] [
      set shape "person"
      set size 3
      set color red
      ; Anhand der aggregierten Größen wie z.B. das Durchschnittseinkommen erhält jeder Haushalt nun noch einen individuellen Wert
      set einkommen generiere-einkommen temp_einkommen (temp_einkommen / 2) (temp_einkommen / 3) (temp_einkommen * 8) ; Hier wird über die Funktion generiere-einkommen eine "abgeschnittene Normalverteilung" das Einkommen generiert
      set einkommen_2021 einkommen
      set schicht bestimme-einkommensschicht einkommen ; Zu welcher Einkommensschicht der Haushalt gehört
      set strombedarf generiere-strombedarf einkommen (temp_einkommen / 3) 3106 2000 1000 10000 0.5; Mittlerer Strombedarf eines Haushalts: 3106 kWh/a, abhängig vom Einkommen
   ]
; Zuordnung der übrigen Attribute Ökostromkunde (ja/nein), PhotovoltaikbesitzerIn (ja/nein), ImmobilieneigentümerIn (ja/nein) anhand der relativen Häufigkeiten:
    let anzahl_oekostrom (((gis:property-value x "oekostrom" / 100) - gis:property-value x "pv_pro_H")* (count turtles with [landkreis = gis:property-value x "schluessel"]))
    set M floor anzahl_oekostrom ; ganzzahliger Anteil, M wird im Folgenden immer wieder überschrieben
    set rest anzahl_oekostrom - M ; Rest
    if (random-float 1 < rest)[ ; Hier wird mit der Wahrscheinlichkeit des Restes r die Anzahl der Haushalte um 1 erhöht
      set M M + 1
    ]
    if Kalibrierung = False[; Haushalte mit Ökostrom werden bei der Kalibrierung nicht gemäß den aktuellen Daten gesetzt, sondern auf Null
      if (M > 0) [
        ask n-of M households with [landkreis = gis:property-value x "schluessel"][ ; Ordne dem relativen Anteil entsprechend viele Ökostromkunden zu
          set stromart 1
        ]
      ]
    ]
    let anzahl_solarbesitzer ((gis:property-value x "pv_pro_H") * (count turtles with [landkreis = gis:property-value x "schluessel"]))
    set M floor anzahl_solarbesitzer ; ganzzahliger Anteil
    set rest anzahl_solarbesitzer - M ; Rest
    if (random-float 1 < rest)[ ; Hier wird mit der Wahrscheinlichkeit des Restes r die Anzahl der Haushalte um 1 erhöht
      set M M + 1
    ]
    if Kalibrierung = False[; Solaranlagenbesitzer werden bei der Kalibrierung nicht gemäß den aktuellen Daten gesetzt, sondern auf Null
      if (M > 0) [
        ask n-of M households with [landkreis = gis:property-value x "schluessel"][ ; Ordne dem relativen Anteil entsprechend viele Ökostromkunden zu
          set stromart 2
        ]
      ]
    ]
    let anzahl_hausbesitzer (((gis:property-value x "eigentum") / 100) * (count turtles with [landkreis = gis:property-value x "schluessel"]))
    set M floor anzahl_hausbesitzer ; ganzzahliger Anteil
    set rest anzahl_solarbesitzer - M ; Rest
    if (random-float 1 < rest)[ ; Hier wird mit der Wahrscheinlichkeit des Restes r die Anzahl der Haushalte um 1 erhöht
      set M M + 1
    ]
    if (M > 0) [
      ask n-of M households with [landkreis = gis:property-value x "schluessel"][ ; Ordne dem relativen Anteil entsprechend viele ImmobilienbesitzerInnen zu
        set eigentum 1
      ]
    ]

   set oekostromanteil lput (count households with [landkreis = gis:property-value x "schluessel" and stromart = 1] / count households with [landkreis = gis:property-value x "schluessel"]) oekostromanteil
   set pvanteil lput (count households with [landkreis = gis:property-value x "schluessel" and stromart = 2] / count households with [landkreis = gis:property-value x "schluessel"]) pvanteil

  ]; Schließt die Iteration über die Landkreise

  ; Setze die psychologischen Attribute gemäß der Daten aus Niamir et al. (2018)
  ask households with [schicht = 0][
    set PBC_pv randomNumber 1.2 7 0.05
    set PBC_oeko randomNumber 1 7 0.05
    set pers_normen_pv randomNumber 1.5 6.75 0.05
    set pers_normen_oeko randomNumber 1.5 6.75 0.05
    set subj_normen_pv randomNumber 1 6.75 0.05
    set subj_normen_oeko randomNumber 1 6.75 0.05
    set wissen randomNumber 1 7 0.05
    set umweltbewusst randomNumber 1.11 6.89 0.05
    set energiebewusst randomNumber 1.17 7 0.05
    set bewusst_pv ((wissen + umweltbewusst + energiebewusst) / 3); Bewusstsein
    set bewusst_oeko ((wissen + umweltbewusst + energiebewusst) / 3)
  ]
    ask households with [schicht = 1][
    set PBC_pv randomNumber 1.8 7 0.05
    set PBC_oeko randomNumber 1 7 0.05
    set pers_normen_pv randomNumber 2.5 6.75 0.05
    set pers_normen_oeko randomNumber 2.5 6.75 0.05
    set subj_normen_pv randomNumber 1.05 6.75 0.05
    set subj_normen_oeko randomNumber 1.05 6.75 0.05
    set wissen randomNumber 2.8 6.45 0.05
    set umweltbewusst randomNumber 2.95 6.66 0.05
    set energiebewusst randomNumber 1.73 7 0.05
    set bewusst_pv ((wissen + umweltbewusst + energiebewusst) / 3)
    set bewusst_oeko ((wissen + umweltbewusst + energiebewusst) / 3)
  ]
    ask households with [schicht = 2][
    set PBC_pv randomNumber 2 6.5 0.05
    set PBC_oeko randomNumber 1.5 4.5 0.05
    set pers_normen_pv randomNumber 3.12 6.13 0.05
    set pers_normen_oeko randomNumber 3.12 6.13 0.05
    set subj_normen_pv randomNumber 1.5 4.75 0.05
    set subj_normen_oeko randomNumber 1.5 4.75 0.05
    set wissen randomNumber 3.22 5 0.05
    set umweltbewusst randomNumber 3.29 5.89 0.05
    set energiebewusst randomNumber 3.16 6.17 0.05
    set bewusst_pv ((wissen + umweltbewusst + energiebewusst) / 3)
    set bewusst_oeko ((wissen + umweltbewusst + energiebewusst) / 3)
  ]

  ask households [
    set id who
    set traegheit_oeko generiere-traegheit mittlere_traegheit_oeko mittlere_traegheit_oeko / 3
    set traegheit_pv generiere-traegheit mittlere_traegheit_pv mittlere_traegheit_pv / 3
    set handlungen (list 0 0)
  ]
  ask households with [stromart = 1] [set handlungen replace-item 0 handlungen 1]
  ask households with [stromart = 2] [set handlungen replace-item 1 handlungen 1]

end

to-report generiere-traegheit [mu sigma]; Die Trägheit soll ganzzahlig und nicht kleiner als 1 sein
  let result round random-normal mu sigma
  if (result < 1)[
    report generiere-traegheit mu sigma
  ]
  report result
end

to-report generiere-einkommen [ mu sigma mmin mmax] ; Das Einkommen wird von einer Normalverteilung gesamplet
  let result random-normal mu sigma
  if result < mmin or result > mmax ; Zu kleine oder zu große Werte werden aber abgeschnitten
      [ report generiere-einkommen mu sigma mmin mmax] ; Durch geeignete Wahl der Parameter wird die Verteilung linkssteil
  report result
end

to-report generiere-strombedarf [eink sigma_eink mu sigma mmin mmax cor] ; Strombedarf und Einkommen sind positiv korreliert.
  let r_2 (cor * cor) ; Angenommen wird eine mittelstarke Korrelation von 0.5 -> r^2=0.25
  let s sqrt(1 - r_2) ; Residualstreuung ist die Wurzel der Reststreuung
  let z random-normal 0 s ; Generiert Pseudozufallszahl -> Abweichung von Einkommen gemäß Reststreuung
  let strom_normal (cor * ((eink - temp_einkommen) / sigma_eink) + z); Hier Strombedarf standardnormalverteilt mit Korrelation zum Einkommen
  let result (strom_normal * sigma + mu); Inverse z-Transformation macht aus der Standardnormalverteilung eine entsprechend linear transformierte
  if result < mmin or result > mmax ; Auch hier werden zu kleine bzw. zu große Werte abgeschnitten
     [ report generiere-strombedarf eink sigma_eink mu sigma mmin mmax cor]
  report result
end

to-report bestimme-einkommensschicht [ein] ; Gemäß dem Einkommen wird dem Haushalt eine Einkommensschicht zugeordnet
  let result 0
  if ein < 15719 ;
      [set result 0] ;
  if ein > 15719 and ein < 33684 ; Die Einkommensgrenzen stammen von der Bundeszentrale für politische Bildung aus dem Jahr 2016
      [set result 1] ;
  if ein > 33684 ;
      [set result 2] ;
  report result ;
end

to go ; Wird von Go-Button ausgelöst und beinhaltet die gesamte Simulation
  ifelse (Kalibrierung = True)[set max_jahr 2021][set max_jahr 2050]
  if (jahr > max_jahr) [stop] ; Die Simulation geht bis zum Jahr 2050 bzw. bei der Kalibrierung bis 2021
  if (Kalibrierung = True)[; Bei der Kalibrierung ändern sich die Einflussgrößen gemäß der historischen Daten
    set Strompreis (item (jahr - 2000) strompreis_liste / 100 )
    set Ökostrompreis (item (jahr - 2000) ökostrompreis_liste / 100)
    set Gestehungskosten (item (jahr - 2000) gestehung_liste / 100)
    set Einspeisungsvergütung (item (jahr - 2000) verguetung_liste / 100)
    ask households[
      set einkommen (einkommen_2021 * item (jahr - 2000) lohnentwicklung / 104.1); Skalierung des Einkommens durch Lohnentwicklungsdaten
    ]
  ]
  if (Kalibrierung = False and Szenario != "Aus")[ ; Spalten der CSV werden dem Szenario entsprechend zeilenweise gelesen
    set Einspeisungsvergütung (item 1 item (jahr - 2020) daten_szenarien / 100) ; Zunächst wird das Basisszenario eingestellt und unten entsprechend abgewandelt
    set Gestehungskosten (item 2 item (jahr - 2020) daten_szenarien / 100)
    set Strompreis (item 3 item (jahr - 2020) daten_szenarien / 100)
    set Ökostrompreis (item 4 item (jahr - 2020) daten_szenarien / 100)
    set veraenderung_attribute (0.04 / (ln (e + (jahr - 2021))))
    set Netzwerkeinfluss_pv (0.03 / (ln (e + (jahr - 2021))))
    set Netzwerkeinfluss_oeko (0.206 / (ln (e + (jahr - 2021))))
    ; Die eingelesenden Daten entsprechen nun dem Basisszenario und werden nun den Szenarien entsprechend überschrieben
    if (Szenario = "Geringe Investitionskosten")[set Gestehungskosten (item 5 item (jahr - 2020) daten_szenarien / 100)]
    if (Szenario = "Hohe Investitionskosten")[set Gestehungskosten (item 6 item (jahr - 2020) daten_szenarien / 100)]
    if (Szenario = "Stabilisierung der Vergütung")[set Einspeisungsvergütung (item 7 item (jahr - 2020) daten_szenarien / 100)]
    if (Szenario = "Vergütung als Anreiz")[set Einspeisungsvergütung (item 8 item (jahr - 2020) daten_szenarien) / 100]
  ]
  aktualisiere_und_visualisiere_Daten ; In jedem Schritt werden zunächst die aktuellen Landkreisdaten (Ökostrom und PV) auf der Karte dargestellt
  visualisierung_haushalte; Zum Einblenden der Haushalte auf der Karte
  bewusstsein
  motivation
  erwaege_optionen
  kosten_nutzen_funktion
  handeln
  if (Datenexport = True)[
    exportiere-daten
  ]
  aktualisiere_agentenattribute
  if (Netzwerk = True)[
    ansteckungseffekt
    ;rechenintensiver-ansteckungseffekt ; Diese Art des Ansteckungseffektes auf individueller Ebene übersteigt die Rechenkapazität
  ]
  tick
  set jahr (jahr + 1)
end

to aktualisiere_und_visualisiere_Daten ; Visualisierung der Daten auf der Karte
  set oekostromanteil []
  set pvanteil []
  foreach gis:feature-list-of basiskarte[ x ->
   set oekostromanteil lput (count households with [landkreis = gis:property-value x "schluessel" and stromart = 1] / count households with [landkreis = gis:property-value x "schluessel"]) oekostromanteil
   set pvanteil lput (count households with [landkreis = gis:property-value x "schluessel" and stromart = 2] / count households with [landkreis = gis:property-value x "schluessel"]) pvanteil
  ]

  if (Kartenvariable = "Anteil Ökostromkunden")[
  set darstellungsfarbe 65 ; Grün zur Darstellung des Ökostromanteils
  let mapData (daten_karte oekostromanteil) ; Die Funktion daten_karte bildet die Werte auf eine Farbskala ab
  ]
  if (Kartenvariable = "Anteil der Haushalte mit PV-Anlage")[
  set darstellungsfarbe 45 ; Gelb zur Visualisierung des Photovoltaikausbaus
  let mapData (daten_karte pvanteil)
  ]
end

to-report daten_karte [ liste ]
  set i 0 ; Zählvariable für die Schleife
  let datenliste-fuer-karte [ ] ; Setze die Liste zur Visualisierung zurück und fülle sie mit den aktuellen Daten
  foreach gis:feature-list-of basiskarte [ x ->
    set datenliste-fuer-karte item i liste
    set wert (datenliste-fuer-karte * 100); Anteil von Ökostrom in %
    set farbwert scale-color (darstellungsfarbe) wert 55 -15 ; Setzt die Farbe entsprechend des Wertes
    gis:set-drawing-color farbwert gis:fill x 1.0 ; Farbe des Landkreises wird übernommen
    set i i + 1
    if i = 401 [ ; Bei 401 sind für alle Landkreise die Daten aktualisiert
      set i 0
      report datenliste-fuer-karte
    ]
  ]
end

to visualisierung_haushalte ; Blendet nur die gewünschte Gruppe auf der Karte ein
    if Haushalte_ein_und_ausblenden = "Alle ausblenden"
  [
      ask households [set size 0]
  ]
  if Haushalte_ein_und_ausblenden = "Alle einblenden"
  [
    ask households with [stromart = 0] [set size 3 set color red]
    ask households with [stromart = 1] [set size 3 set color green]
    ask households with [stromart = 2] [set size 3 set color pink]
  ]
  if Haushalte_ein_und_ausblenden = "Nur Ökostromkunden einblenden"
  [
  ask households with [stromart = 0] [set size 0]
    ask households with [stromart = 1] [set size 3 set color green]
  ask households with [stromart = 2] [set size 0]
  ]
  if Haushalte_ein_und_ausblenden = "Nur PV-Besitzer einblenden"
  [
  ask households with [stromart = 0] [set size 0]
  ask households with [stromart = 1] [set size 0]
  ask households with [stromart = 2] [set size 3 set color pink]
  ]
  if Haushalte_ein_und_ausblenden = "Nur nicht-Ökostromnutzer einblenden"
  [
  ask households with [stromart = 0] [set size 3 set color red]
  ask households with [stromart = 1] [set size 0]
  ask households with [stromart = 2] [set size 0]
  ]
end

to bewusstsein ; vgl. knowledge Ablauf bei Niamir et al. (2018)
  ask households [
    if (handlungen = [1 1])[ ; Wenn ein Haushalt bereits Ökostrom bezieht und Solar installiert hat, gibt es keine Optionen mehr
    stop]]

  ask households [
    if (bewusst_pv < schwelle_bewusst)[set schlechtes_gewissen_pv False]
    if (bewusst_pv >= schwelle_bewusst) [set schlechtes_gewissen_pv True]
    if (bewusst_oeko < faktor_schwellen_oeko * schwelle_bewusst)[set schlechtes_gewissen_oeko False]
    if (bewusst_oeko >= faktor_schwellen_oeko * schwelle_bewusst) [set schlechtes_gewissen_oeko True]
  ]
end

to motivation
  ask households[
    if (Entscheidungsprozess = True and schlechtes_gewissen_pv = True)[
      set motiv_pv ((pers_normen_pv + subj_normen_pv) / 2); Mittelwert der persönlichen und der subjektiven Normen
    ]
    if (Entscheidungsprozess = True and schlechtes_gewissen_oeko = True)[
      set motiv_oeko ((pers_normen_oeko + subj_normen_oeko) / 2)
    ]
   if ((pers_normen_pv < schwelle_pers_norm) or (subj_normen_pv < schwelle_subj_norm))[
          set motivationslevel "L"]
   if ((pers_normen_pv >= schwelle_pers_norm) and (subj_normen_pv >= schwelle_subj_norm))[
          set motivationslevel "H"
      set motivation_pv ( motiv_pv / 7) ; Für Haushalte mit hohem Motivationsnivau wird die Motivation quantifiziert [0,1]
          set verantwortung_pv True]

   if ((pers_normen_oeko < schwelle_pers_norm * faktor_schwellen_oeko) or (subj_normen_oeko < schwelle_subj_norm * faktor_schwellen_oeko))[
          set motivationslevel "L"]
   if ((pers_normen_oeko >= schwelle_pers_norm * faktor_schwellen_oeko) and (subj_normen_oeko >= schwelle_subj_norm * faktor_schwellen_oeko))[
          set motivationslevel "H"
          set motivation_oeko ( motiv_oeko / 7)
          set verantwortung_oeko True]
  ]
end

to erwaege_optionen
    ask households[
    if verantwortung_pv = True[ ; Haushalte erwägen die Optionen nur, wenn sie Bewusstsein und Motivation entwickelt haben und daher Verantwortung spüren
      if (PBC_pv < schwelle_pbc) [ ; Installation von Photovoltaik wird in Erwägung gezogen, wenn die wahrgenommene Kontrolle (PBC) ausreichend groß ist
        set opt_pv False]
      if (PBC_pv >= schwelle_pbc) [
        set opt_pv True]
    ]
    if verantwortung_oeko = True[
      if (PBC_oeko < schwelle_pbc) [ ; Ökostrom beziehen wird in Erwägung gezogen, wenn PBC groß genug
        set opt_oeko False]
      if (PBC_oeko >= schwelle_pbc) [
        set opt_oeko True]
    ]
    ]
end

to kosten_nutzen_funktion ; Hier wird die Wahrscheinlichkeit Ökostrom zu beziehen bzw. der Nutzen einer Photvoltaikanlage kalkuliert
  ask households with [opt_oeko = True][
    set prob_oeko entscheidungsmodell_oekostrom PBC_oeko
  ]
  ask households with [opt_pv = True and strombedarf > 2000][
   set kosten_pv_liste bestimme-stromgestehungskosten pv_potential
   set payback_pv_liste bestimme-amortisationszeit pv_potential
   set u_pv bestimme-nutzen-pv payback_pv_liste einkommen pv_potential
  ]
end

to-report entscheidungsmodell_oekostrom [pbc_wert]
  let B (11.34286636 - (pbc_wert - 4)) ; Fitparameter der logistischen Funktion, die an Studiendaten angepasst wurde. Der Wachstumsparameter B wird mit höherem PBC verringert
  let mu 0.28219115
  let x ((Ökostrompreis - Strompreis)/ Strompreis); relative Strompreisdifferenz
  report (-1 / ((1 + exp (- B * x))^(1 / mu)) + 1); Logistische Funktion gibt Wahrscheinlichkeit in Abhängigkeit der Preisdifferenz zurück
end

to-report bestimme-stromgestehungskosten [PV_Pot]
  let result []
  ; Hier werden die aktuellen Stomgestehungskosten kalkuliert
    let G_mean (16.46360174102285 - 0.0074156692056583234 * PV_Pot) * (Gestehungskosten / 0.085) ; Mittlere Gestehungskosten (Cent/kWh) bei der Globalstrahlung
    let v randomNumber 0 1 0.01 ; Parameter zwischen 0 und 1 gibt an, in welchem Bereich der Preisspanne die Gestehungskosten liegen
    foreach range length leistungen [index -> ; Für jede mögliche Leistung ordne die zu erwartenden Gestehungskosten gemäß v und der Preisspanne zu
      set G (G_mean * (1 + item 0 item index preisspannen + v * (item 1 item index preisspannen - item 0 item index preisspannen)))
      let row ((round strombedarf / 100) - 19 ) ; Strombedarf > 2000 -> Entsprechende Zeile in der CSV-Datei mit Daten zum Eigenverbrauchsanteil
      set eigenbedarf (item (index + 1) item row daten_eigenbedarf / 100 )
      let kosten kostenkalkulation_pv item index leistungen Ökostrompreis eigenbedarf G strombedarf pv_potential Einspeisungsvergütung
      set result lput kosten result
    ]
  report result
end

to-report kostenkalkulation_pv [Leist SP EB Gest Strom PV_Pot Ver]; 0.95 Ist die durchschnittliche Leistungsumsetzung während der Lebensdauer (Degradation der PV-Anlage)
  let result ((Gest / 100)  * PV_Pot * Leist * (0.95) + ((Strom - EB * PV_Pot * Leist * (0.95)) * SP) - (PV_Pot * Leist * (0.95)*(1 - EB)) * Ver)
  report (result / (Strom * SP)) ; Vergleich mit den laufenden Stromkosten (Ökostrompreis)
end

to-report bestimme-amortisationszeit [PV_Pot]; Hier wird die Amortisationszeit für die verschiedenen Anlagengrößen kalkuliert
  let result []
    let G_mean (16.46360174102285 - 0.0074156692056583234 * PV_Pot) * (Gestehungskosten / 0.085); Mittlere Gestehungskosten (Cent/kWh) bei der Globalstrahlung
    let v randomNumber 0 1 0.01 ; Parameter zwischen 0 und 1 gibt an, in welchem Bereich der Preisspanne die Gestehungskosten liegen
    foreach range length leistungen [index -> ; Für jede mögliche Leistung ordne die zu erwartenden Gestehungskosten gemäß v und der Preisspanne zu
      set G (G_mean * (1 + item 0 item index preisspannen + v * (item 1 item index preisspannen - item 0 item index preisspannen)))
      let row ((round strombedarf / 100) - 19 ) ; Strombedarf > 2000 -> Entsprechende Zeile in der CSV-Datei mit Daten zum Eigenverbrauchsanteil
      set eigenbedarf (item (index + 1) item row daten_eigenbedarf / 100 )
      if (jahr < 2009)[set eigenbedarf 0] ; Bis 2009 musste man den gesamten Strom ins Stromnetz einspeisen
      let investitionskosten ( (G / 100) * PV_Pot * (item index leistungen) * 0.95 * 25)
      let payback payback_pv investitionskosten item index leistungen Ökostrompreis eigenbedarf G strombedarf pv_potential Einspeisungsvergütung
      set result lput payback result
    ]
  report result
end

to-report payback_pv [Inv Leist SP EB Gest Strom PV_Pot Ver]; 0.985 Umsetzung der Globalstrahlung in Strom , 0.05 Mittlerer Leistungsverlust in der Lebensdauer (von 1 -> 0.9 linear)
  let bilanz []
  let netto (EB * PV_Pot * Leist * 0.95 * SP + PV_Pot * Leist *  0.95 * (1 - EB) * Ver)
  ; Zwischen 2009 und 2012 wurde auch der Eigenverbrauch von Solarstrom vergütet, diese Jahre werden daher gesondert berechnet
  if (jahr = 2009)[set netto (netto + 0.2501 * PV_Pot * Leist *  0.95 * EB)]
  if (jahr = 2010)[
      ifelse (EB < 0.3)
        [set netto (netto + 0.1995 * PV_Pot * Leist *  0.95 * EB)]
        [set netto (netto + 0.2215 * PV_Pot * Leist *  0.95 * EB)]
  ]
  if (jahr = 2011)[
      ifelse (EB < 0.3)
        [set netto (netto + 0.1236 * PV_Pot * Leist *  0.95 * EB)]
        [set netto (netto + 0.1674 * PV_Pot * Leist *  0.95 * EB)]
  ]
  if (jahr = 2012)[ ; 2012 galt die Vergütung nur im ersten Quartal
      ifelse (EB < 0.3)
        [set netto (netto + (0.0805 / 4) * PV_Pot * Leist *  0.95 * EB)]
        [set netto (netto + (0.1243 / 4) * PV_Pot * Leist *  0.95 * EB)]
  ]

  foreach range 26[y -> ; Berechne die Netto-Bilanz für die ersten 25 Jahre
    set bilanz lput (- Inv + y * netto) bilanz
  ]
  ifelse (empty? filter [ u -> u > 0 ] bilanz)
  [report 25] ; Wenn sich die Anlage innerhalb der ersten 25 Jahre nicht rentiert, wird 25 zurückgegeben, der Nutzen ist dann Null
  [report ( position min filter [ u -> u > 0 ] bilanz bilanz )] ; Jahr, in dem die Investitionskosten sich amortisiert haben
end

to-report bestimme-nutzen-pv [Pb_liste Eink PV_Pot]
  set u_ökonomisch []
  set u_ökologisch []
  set u_einkommen []
  let u_gesamt []
  foreach range length Pb_liste[ index ->
    let u_ökon ( (exp((- item index Pb_liste + 13) / 2.7)) / (1 + exp( (- item index Pb_liste + 13) / 2.7)) )
    let s (PV_Pot * item index leistungen *  0.95 * 25) ; Strom, den die Anlage in 25 Jahren produziert
    let u_ökol (exp( (s - mean_s) / 5e4) / (1 + exp( (s - mean_s) / 5e4) ))
    let u_eink (exp( (Eink - mean [einkommen] of turtles)/ 7e3) / (1 + exp((Eink - mean [einkommen] of turtles)/ 7e3)))

    set u_ökonomisch lput u_ökon u_ökonomisch
    set u_ökologisch lput u_ökol u_ökologisch
    set u_einkommen lput u_eink u_einkommen

    set u_gesamt lput ( (1 / ( (w_eink * (1 + (item index leistungen / 17.5))) + w_ökol + w_ökon ) ) * (w_eink * (1 + (item index leistungen / 17.5)) * u_eink + w_ökol * u_ökol + w_ökon * u_ökon ) ) u_gesamt
  ]
  report u_gesamt
end

to handeln
  ask households with [stromart = 0 and opt_oeko = True][ ; Alle Haushalte die noch keinen Ökostrom beziehen, diese Option aber erwägen
    let p random-float 1
    if (p < prob_oeko)[
      set counter_oeko (counter_oeko + 1)
    ]
    if counter_oeko >= traegheit_oeko[
     set stromart 1 ; Mit der Wahrscheinlichkeit prob_oeko wird der Tarif umgestellt
     set handlungen replace-item 0 handlungen 1
     set oekostrom_wechsel (oekostrom_wechsel + 1)
    ]
  ]
  ask households with [stromart != 2 and opt_pv = True and strombedarf > 2000][
    ifelse (eigentum = 1)[set nutzen_pv item wähle-leistung u_pv u_pv][set nutzen_pv (Mieternutzen * item wähle-leistung u_pv u_pv)]; Der Nutzen für MieterInnen reduziert sich hier
    if (nutzen_pv > schranke_pv) [
      set counter_pv (counter_pv + 1)
    ]
    if counter_pv >= traegheit_pv[
      set stromart 2
      set handlungen replace-item 1 handlungen 1
      set anlagenleistung item wähle-leistung u_pv leistungen ; Die gemäß der Nutzenmaximierung gewählte Leistung
      set amortisationszeit item wähle-leistung u_pv payback_pv_liste
      set kosten_pv item wähle-leistung u_pv kosten_pv_liste
      set nutzen_ökol item wähle-leistung u_pv u_ökologisch
      set nutzen_ökon item wähle-leistung u_pv u_ökonomisch
      set nutzen_eink item wähle-leistung u_pv u_einkommen
      set solar_installationen (solar_installationen + 1)
      set installierte_leistung (installierte_leistung + anlagenleistung)
    ]
  ]
  if (count turtles with [anlagenleistung > 0] > 0)[
    foreach range length leistungen[index ->
      set verteilung_anlagengröße replace-item index verteilung_anlagengröße ((length filter [u -> u = item index leistungen] [anlagenleistung] of turtles with [anlagenleistung > 0]) / (count turtles with [anlagenleistung > 0]))
      set abweichung_anlagengröße replace-item index abweichung_anlagengröße ((((length filter [u -> u = item index leistungen] [anlagenleistung] of turtles with [anlagenleistung > 0]) / (count turtles with [anlagenleistung > 0])) - item index daten_anlagengröße)^ 2)
    ]
  ]
  set oekostromanteil_gesamt (count turtles with [stromart = 1] / count turtles)
  if Kalibrierung = True[
    set abweichung_anlagenzahl lput ((solar_installationen * Maßstab - item (jahr - 2000) daten_anlagenzahl)^ 2) abweichung_anlagenzahl
    if member? jahr (range 2008 2021)[ ; Die Abweichung des Ökostromanteils kann aufgrund der Datenlage nur für die Jahre 2008 bis 2020 bestimmt werden
      set abweichung_ökostromanteil lput ((oekostromanteil_gesamt - item (jahr - 2008) daten_ökostromanteil)^ 2) abweichung_ökostromanteil
    ]
    set reststreuung_anlagenzahl (sum abweichung_anlagenzahl / 5.799856e12) ; Division mit Gesamtstreuung der Marktdaten
    set reststreuung_ökostromanteil (sum abweichung_ökostromanteil / 0.07455176)
    set reststreuung (0.5 * reststreuung_anlagenzahl + 0.5 * reststreuung_ökostromanteil)
  ]
end

to-report wähle-leistung [nutzenliste]
  let r randomNumber 0 1 0.0001
  let wahrscheinlichkeitsgrenzen cumsum map [b -> b / sum nutzenliste ] nutzenliste
  if r < item 0 wahrscheinlichkeitsgrenzen [report 0]
  foreach (range 1 9) [ index ->
    if (r > item (index - 1) wahrscheinlichkeitsgrenzen and r < item index wahrscheinlichkeitsgrenzen) [report index]
  ]
  if r > item 8 wahrscheinlichkeitsgrenzen [report 9]

end

to aktualisiere_agentenattribute
  ask households[
    set PBC_oeko (PBC_oeko + random-normal veraenderung_attribute_oeko veraenderung_attribute_oeko / 3)
    if (PBC_oeko > 7) [set PBC_oeko 7]
    set PBC_pv (PBC_pv + random-normal veraenderung_attribute_pv veraenderung_attribute_pv / 3)
    if (PBC_pv > 7) [set PBC_pv 7]
    set pers_normen_pv (pers_normen_pv + random-normal veraenderung_attribute_pv veraenderung_attribute_pv / 3)
    if (pers_normen_pv > 7) [set pers_normen_pv 7]
    set pers_normen_oeko (pers_normen_oeko + random-normal veraenderung_attribute_oeko veraenderung_attribute_oeko / 3)
    if (pers_normen_oeko > 7) [set pers_normen_oeko 7]
    set subj_normen_pv (subj_normen_pv + random-normal veraenderung_attribute_oeko veraenderung_attribute_oeko / 3)
    if (subj_normen_pv > 7) [set subj_normen_pv 7]
    set subj_normen_oeko (subj_normen_oeko + random-normal  veraenderung_attribute_oeko veraenderung_attribute_oeko / 3)
    if (subj_normen_oeko > 7) [set subj_normen_oeko 7]
    set bewusst_pv (bewusst_pv + random-normal veraenderung_attribute_pv veraenderung_attribute_pv / 3)
    if (bewusst_pv > 7) [set bewusst_pv 7]
    set bewusst_oeko (bewusst_oeko + random-normal veraenderung_attribute_oeko veraenderung_attribute_oeko / 3)
    if (bewusst_oeko > 7) [set bewusst_oeko 7]

    if (Kalibrierung = False) [set einkommen (einkommen_2021 * (1 + 0.004 * (jahr - 2021)))]; Einkommen wächst hier linear
  ]
end

to rechenintensiver-ansteckungseffekt
  ask households with [stromart != 2][
    let gewichte [1 / (distance myself)] of min-n-of Netzwerkgröße other turtles [distance myself] ; (1 / Distanz) der n (= Netzwerkgröße) nächsten Nachbarn
    let stromarten [stromart] of min-n-of Netzwerkgröße other turtles [distance myself]
    let v 0
    foreach range length stromarten[b ->
      if (item b stromarten = 2)[
        set v (v + item b gewichte)
      ]
    ]
    set v (v / (sum gewichte)); Normalisierung
    set PBC_pv (PBC_pv + Netzwerkeinfluss_pv * v)
  ]

  ask households with [stromart != 1][
    let gewichte [1 / (distance myself)] of min-n-of Netzwerkgröße other turtles [distance myself] ; Anzahl der Nachbarn mit PV-Anlage der n (= Netzwerkgröße) nächsten Nachbarn
    let stromarten [stromart] of min-n-of Netzwerkgröße other turtles [distance myself]
    let v 0
    foreach range length stromarten[b ->
      if (item b stromarten = 1)[
        set v (v + item b gewichte)
      ]
    ]
    set v (v / (sum gewichte)); Normalisierung
    set PBC_oeko (PBC_oeko + Netzwerkeinfluss_oeko * v)
  ]
end

to ansteckungseffekt
  foreach gis:feature-list-of basiskarte[ x ->
    let anteil_oeko (count households with [landkreis = gis:property-value x "schluessel" and stromart = 1] / count households with [landkreis = gis:property-value x "schluessel"])
    let anteil_solar (count households with [landkreis = gis:property-value x "schluessel" and stromart = 2] / count households with [landkreis = gis:property-value x "schluessel"])
    ask households with [stromart != 2 and landkreis =  gis:property-value x "schluessel"][
      set PBC_pv (PBC_pv + Netzwerkeinfluss_pv * anteil_solar)
      set PBC_oeko (PBC_oeko + Netzwerkeinfluss_oeko * anteil_oeko)
      set bewusst_pv (bewusst_pv + Netzwerkeinfluss_pv * anteil_solar)
      set bewusst_oeko (bewusst_oeko + Netzwerkeinfluss_oeko * anteil_oeko)
      set pers_normen_pv (pers_normen_pv + Netzwerkeinfluss_pv * anteil_solar)
      set pers_normen_oeko (pers_normen_oeko + Netzwerkeinfluss_oeko * anteil_oeko)
      set subj_normen_pv (subj_normen_pv + Netzwerkeinfluss_pv * anteil_solar)
      set subj_normen_oeko (subj_normen_oeko + Netzwerkeinfluss_oeko * anteil_oeko)
    ]
  ]
end

to exportiere-daten
  ask households[
    file-open "household.csv"
    file-print (word jahr "," id "," landkreis "," einkommen "," schicht "," eigentum "," stromart "," pv_potential "," strombedarf "," anlagenleistung); Speichert die Werte für jeden Haushalt zeilenweise
  ]
  file-close
  file-open "landkreise.csv"
  file-print (word jahr "," oekostromanteil "," pvanteil "," solar_installationen "," installierte_leistung)
  file-close
end

; Mathematische Hilfsfunktionen
to-report nprob [x mu sigma]; Dichtefunktion der Normalverteilung
  report (1 / (sqrt(2 * pi) * sigma)) * exp( ( -1 * ( (x - mu) ^ 2))/ (2 * (sigma ^ 2)) )
end

to-report randomNumber [Minimum Maximum Schrittweite]; Pseudozufallszahl nach uniformer Verteilung
  report Minimum + Schrittweite * random (1 + floor ((Maximum - Minimum) / Schrittweite ))
end

to-report cumsum [liste]
  let result []
  let summe 0
  foreach liste [element ->
    set summe (summe + element)
    set result lput summe result
  ]
  report result
end
@#$#@#$#@
GRAPHICS-WINDOW
453
10
1102
340
-1
-1
1.0
1
10
1
1
1
0
0
0
1
0
640
0
320
1
1
1
ticks
30.0

BUTTON
218
56
281
89
Run
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
117
56
212
89
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
124
43
177
65
Schritt 1
11
0.0
1

TEXTBOX
231
43
381
61
Schritt 2
11
0.0
1

PLOT
430
365
923
621
Stromarten
NIL
NIL
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"#Haushalte" 1.0 0 -7500403 true "" "if ticks > 0 [plot count turtles / count turtles]"
"# Ökostrom" 1.0 0 -10899396 true "" "if ticks > 0 [plot count turtles with [stromart = 1] / count turtles]"
"# Konv. Strom" 1.0 0 -2674135 true "" "if ticks > 0 [plot count turtles with [stromart = 0] / count turtles]"
"# Solarprod." 1.0 0 -1184463 true "" "if ticks > 0 [plot count turtles with [stromart = 2] / count turtles]"

PLOT
0
677
200
827
Leistung
NIL
NIL
0.0
20.0
0.0
10.0
true
false
"" ""
PENS
"pen-1" 1.0 1 -7500403 true "" "histogram ([anlagenleistung] of turtles with [anlagenleistung > 0])"

SLIDER
9
106
189
139
Maßstab
Maßstab
1000
10000
10000.0
1000
1
NIL
HORIZONTAL

TEXTBOX
43
363
354
397
Externe Parameter 
14
0.0
1

CHOOSER
861
10
1101
55
Kartenvariable
Kartenvariable
"Anteil der Haushalte mit PV-Anlage" "Anteil Ökostromkunden"
0

CHOOSER
453
11
708
56
Haushalte_ein_und_ausblenden
Haushalte_ein_und_ausblenden
"Alle einblenden" "Alle ausblenden" "Nur Ökostromkunden einblenden" "Nur PV-Besitzer einblenden" "Nur nicht-Ökostromnutzer einblenden"
3

SLIDER
5
489
215
522
Gestehungskosten
Gestehungskosten
0
0.2
0.085
0.001
1
€ / kWh
HORIZONTAL

SLIDER
5
386
215
419
Strompreis
Strompreis
0.25
0.4
0.32159999999999994
0.001
1
€ / kWh
HORIZONTAL

SWITCH
9
144
190
177
Entscheidungsprozess
Entscheidungsprozess
0
1
-1000

SLIDER
5
421
215
454
Ökostrompreis
Ökostrompreis
0.2
0.5
0.33
0.01
1
€ / kWh
HORIZONTAL

PLOT
429
635
924
888
Ökostrom Wechsel
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Anzahl der Wechsel" 1.0 0 -10899396 true "" "plot oekostrom_wechsel"

SLIDER
5
456
215
489
Einspeisungsvergütung
Einspeisungsvergütung
0
0.2
0.0753
0.001
1
€ / kWh
HORIZONTAL

PLOT
939
635
1433
886
Solarinstallationen
NIL
NIL
0.0
30.0
0.0
100.0
true
false
"" ""
PENS
"Solarinstallationen" 1.0 0 -1184463 true "" "plot solar_installationen"

PLOT
206
678
406
828
Gesamtnutzen
NIL
NIL
0.0
1.0
0.0
1.0
true
false
"set-plot-x-range 0 1\nset-histogram-num-bars 10" "set-plot-x-range 0 1\nset-histogram-num-bars 10"
PENS
"default" 1.0 1 -16777216 true "" "histogram ([max u_pv] of turtles with [anlagenleistung > 0])\n"

PLOT
0
832
200
982
Einkommen Nutzen
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.04 1 -16777216 true "" "histogram ([max u_einkommen] of turtles with [anlagenleistung > 0])"

SWITCH
1160
41
1285
74
Experimente
Experimente
0
1
-1000

INPUTBOX
1294
49
1393
109
Seed
-1.296111501E9
1
0
Number

SWITCH
1160
81
1287
114
Kalibrierung
Kalibrierung
0
1
-1000

SLIDER
1160
230
1393
263
kalibrierung_schranke_pv
kalibrierung_schranke_pv
0
1
0.61
0.01
1
NIL
HORIZONTAL

SLIDER
1161
364
1440
397
kalibrierung_veraenderung_attribute_pv
kalibrierung_veraenderung_attribute_pv
0
0.2
0.03
0.01
1
NIL
HORIZONTAL

SLIDER
1161
124
1396
157
kalibrierung_w_eink
kalibrierung_w_eink
0
1
0.644
0.001
1
NIL
HORIZONTAL

SLIDER
1161
158
1397
191
kalibrierung_w_ökon
kalibrierung_w_ökon
0
1
0.355
0.001
1
NIL
HORIZONTAL

SLIDER
8
307
192
340
Netzwerkgröße
Netzwerkgröße
1
20
4.0
1
1
NIL
HORIZONTAL

TEXTBOX
1205
12
1403
46
Kalibrierung & Experimente
14
0.0
1

TEXTBOX
106
12
340
46
Steuerung und Modelleinstellungen
14
0.0
1

CHOOSER
8
186
191
231
Szenario
Szenario
"Aus" "Basis" "Geringe Investitionskosten" "Hohe Investitionskosten" "Stabilisierung der Vergütung" "Vergütung als Anreiz"
1

PLOT
1072
907
1320
1100
Einstellungen Solar
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.2 1 -7171555 true "" "histogram [pbc_pv] of turtles"

PLOT
553
904
809
1097
Einstellungen Ökostrom
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.2 1 -13210332 true "" "histogram [pbc_oeko] of turtles"

SLIDER
232
107
415
140
Netzwerkeinfluss_pv
Netzwerkeinfluss_pv
0
2
0.032
0.01
1
NIL
HORIZONTAL

SLIDER
232
144
415
177
Mieternutzen
Mieternutzen
0
1
0.8
0.01
1
NIL
HORIZONTAL

SWITCH
8
272
192
305
Netzwerk
Netzwerk
0
1
-1000

SLIDER
1160
197
1333
230
kalibrierung_schwellen
kalibrierung_schwellen
0
1
0.25
0.01
1
NIL
HORIZONTAL

SWITCH
8
235
191
268
Datenexport
Datenexport
1
1
-1000

SLIDER
231
182
416
215
Netzwerkeinfluss_oeko
Netzwerkeinfluss_oeko
0
2
0.229
0.01
1
NIL
HORIZONTAL

SLIDER
1160
409
1400
442
kalibrierung_schwellenfaktor_oeko
kalibrierung_schwellenfaktor_oeko
0.5
2
0.88
0.001
1
NIL
HORIZONTAL

SLIDER
231
253
417
286
mittlere_traegheit_oeko
mittlere_traegheit_oeko
1
6
3.64
0.1
1
NIL
HORIZONTAL

SLIDER
231
218
416
251
mittlere_traegheit_pv
mittlere_traegheit_pv
0
6
5.91
0.01
1
NIL
HORIZONTAL

SLIDER
1162
509
1454
542
kalibrierung_veraenderung_attribute_oeko
kalibrierung_veraenderung_attribute_oeko
0
0.5
0.07
0.001
1
NIL
HORIZONTAL

SLIDER
1161
296
1354
329
kalibrierung_mieternutzen
kalibrierung_mieternutzen
0
1
0.8
0.01
1
NIL
HORIZONTAL

SLIDER
1162
330
1395
363
kalibrierung_netzwerkeinfluss_pv
kalibrierung_netzwerkeinfluss_pv
0
1
0.032
0.001
1
NIL
HORIZONTAL

SLIDER
1161
263
1401
296
kalibrierung_mittlere_traegheit_pv
kalibrierung_mittlere_traegheit_pv
1
7
5.91
0.01
1
NIL
HORIZONTAL

SLIDER
1161
443
1413
476
kalibrierung_mittlere_traegheit_oeko
kalibrierung_mittlere_traegheit_oeko
1
6
3.64
0.01
1
NIL
HORIZONTAL

SLIDER
231
289
417
322
veraenderung_attribute_oeko
veraenderung_attribute_oeko
0
0.5
0.07
0.01
1
NIL
HORIZONTAL

SLIDER
1161
476
1407
509
kalibrierung_netzwerkeinfluss_oeko
kalibrierung_netzwerkeinfluss_oeko
0
1
0.229
0.001
1
NIL
HORIZONTAL

SLIDER
230
324
417
357
veraenderung_attribute_pv
veraenderung_attribute_pv
0
0.2
0.03
0.001
1
NIL
HORIZONTAL

@#$#@#$#@
## Kurzbeschreibung
In diesem ABM repräsentieren die Agenten Privathaushalte in Deutschland. Sie werden zunächst unter Einbezug aktueller Geodaten initialisiert und durchlaufen anschließend einen Entscheidungsprozess für den Bezug von Ökostrom und die Installation einer PV-Anlage.
Das Modell verfügt über die Möglichkeit Parameter manuell zu variieren und/oder Szenarien auszuwählen. Die Kalibrierung wesentlicher Parameter kann über das Einstellen der Schalter Kalibrierung und Experimente und die Ausführung der Suchkonfiguration im Behavior Search nachvollzogen werden.
Die Kalibrierungsergebnisse sowie die Ergebnisse der Simulation für alle Szenarien können über die entsprechenden Experimente im Behavior Space nachvollzogen werden. 

Für eine detaillierte Beschreibung des Modells wird auf die zugehörige Bachelorarbeit "Ein Agenten-basiertes Modell für die Photovoltaik-Installation und den Bezug von Ökostrom durch Privathaushalte in Deutschland" verwiesen, die vom Autor zur Verfügung gestellt werden kann. E-Mail: jonathan.kirchhoff@uni-wuppertal.de

Teile des Modells (der Entscheidungsprozess nach der Normaktivierungstheorie unter Einbezug pyscholoogischer Faktoren sowie die Zuordnung der Daten für diese Faktoren) sind aus dem BENCHv.2 Modell von Leila Niamir entnommen bzw. dem zugehörigen Paper entnommen: 
Niamir, L. (2019). BENCHv.2 model [Version 1.0.0]. CoMSES Computational Model
Library. https://www.comses.net/codebases/2b15a409-72bb-4285-a6e0-
ca30575d36a6/releases/1.0.0/. (Zuletzt abgerufen am: 21.03.2022)

Niamir, L., Filatova, T., Voinov, A. & Bressers, H. (2018). Transition to low-carbon
economy: Assessing cumulative impacts of individual behavioral changes.
Energy Policy, 118, 325–345. https://doi.org/10.1016/j.enpol.2018.03.045 


## Benutzung

(1) Modellmaßstab einstellen "Setup" Button drücken, um die nötigen Geodaten zu laden.

(2) Modellparameter manuell einstellen Einflussgrößen wie z.B. Strompreis, Einspeisungsvergütung etc. oder Szenario auswählen

(3) "Run" Button drücken, um eine Simulation zu starten.

(4) Über das Behavior Space Tool (Str+Shift+B) Experimente aufrufen und ggf. weitere Erstellen

@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="szenarien" repetitions="10" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="30"/>
    <metric>count turtles</metric>
    <metric>count turtles with [stromart = 2] * Maßstab</metric>
    <metric>installierte_leistung * Maßstab</metric>
    <metric>installierte_leistung / solar_installationen</metric>
    <metric>mean [amortisationszeit] of turtles with [amortisationszeit &gt; 0]</metric>
    <metric>mean [einkommen] of turtles with [anlagenleistung &gt; 0]</metric>
    <metric>[einkommen] of turtles with [anlagenleistung &gt; 0]</metric>
    <metric>[amortisationszeit] of turtles with [amortisationszeit &gt; 0]</metric>
    <metric>[nutzen_pv] of turtles with [anlagenleistung &gt; 0]</metric>
    <metric>[nutzen_ökol] of turtles with [anlagenleistung &gt; 0]</metric>
    <metric>[nutzen_ökon] of turtles with [anlagenleistung &gt; 0]</metric>
    <metric>[nutzen_eink] of turtles with [anlagenleistung &gt; 0]</metric>
    <metric>mean [mean payback_pv_liste] of turtles with [payback_pv_liste != 0]</metric>
    <metric>count turtles with [stromart = 1] / count turtles</metric>
    <metric>pvanteil</metric>
    <metric>oekostromanteil</metric>
    <enumeratedValueSet variable="Szenario">
      <value value="&quot;Basis&quot;"/>
      <value value="&quot;Geringe Investitionskosten&quot;"/>
      <value value="&quot;Hohe Investitionskosten&quot;"/>
      <value value="&quot;Stabilisierung der Vergütung&quot;"/>
      <value value="&quot;Vergütung als Anreiz&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Kalibrierung">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Netzwerk">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_mieternutzen">
      <value value="0.88"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Seed">
      <value value="13"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Datenexport">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Experimente">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Maßstab">
      <value value="10000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_mittlere_traegheit_pv">
      <value value="5.06"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mieternutzen">
      <value value="0.88"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_schwellen">
      <value value="0.38"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_mittlere_traegheit_oeko">
      <value value="3.64"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Netzwerkeinfluss_pv">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Entscheidungsprozess">
      <value value="true"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="kalibrierungsergebnisse" repetitions="20" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="21"/>
    <metric>oekostrom_wechsel / count turtles</metric>
    <metric>solar_installationen * Maßstab</metric>
    <metric>verteilung_anlagengröße</metric>
    <metric>pvanteil</metric>
    <enumeratedValueSet variable="Kalibrierung">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Szenario">
      <value value="&quot;Aus&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Netzwerk">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Datenexport">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Experimente">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Entscheidungsprozess">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Maßstab">
      <value value="5000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Seed">
      <value value="1473489371"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_w_eink">
      <value value="0.644"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_w_ökon">
      <value value="0.355"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_mieternutzen">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_schranke_pv">
      <value value="0.61"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_veraenderung_attribute_pv">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_netzwerkeinfluss_pv">
      <value value="0.032"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_mittlere_traegheit_pv">
      <value value="5.91"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_schwellen">
      <value value="0.25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_netzwerkeinfluss_oeko">
      <value value="0.229"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_veraenderung_attribute_oeko">
      <value value="0.07"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_schwellenfaktor_oeko">
      <value value="0.88"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="kalibrierung_mittlere_traegheit_oeko">
      <value value="3.7"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
