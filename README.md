# Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom-durch-Privathaushalte in Deutschland
Das ABM wurde in der gleichnamigen Bachelorarbeit entwickelt und dient insbesondere zur geographisch aufgelösten Modellierung des PV-Ausbaus und der Martkdiffusion von Ökostrom bei Privathaushalten.

In das Modell gehen sowohl diverse Daten aus verschiedensten Quellen als auch Ergebnisse aus dem BENCHv.2 Modell von Leila Niamir (2019) und dem zugehörigen Paper von Niamir et al. (2018) ein. Bei der Initialisierung der Agenten, die Privathaushalte repräsentieren, werden verfügbare Daten zum Einkommen, Immobilienbesitz und der örtlichen Globalstrahlung jeweils auf Landkreisebene berücksichtigt. Im Anschluss an eine Modellkalibrierung simuliert das Modell den Ausbau von PV bei Privathaushalten bis 2050 unter Berücksichtigung verschiedener Szenarien.

Das Modell wurde in NetLogo (Wilensky 1999) (Version 6.2.1) geschrieben und benötigt für eine Simulation etwa 5-10 Minuten. Dabei können verschiedene Szenarien bzgl. der Förderung sowie der Entwicklung der Investitionskosten eingestellt werden.
<div style="width:830; height: 600">
<img src="https://user-images.githubusercontent.com/77612325/159860246-79c3acf8-acc1-4b43-b812-9d980fbbeed9.png" height="300" width="300" >


<img src="https://user-images.githubusercontent.com/77612325/159858613-5bb2c7ad-7538-42ca-a0df-b34ea47da1cb.png" height="300" width="530" >

</div>
Im Repository befinden sich neben dem NetLogo Modell zwei BehaviorSearch (Stonedahl & Wilensky 2010) Dateien, die für die Kalibrierung verwendet wurden und zwei CSV Dateien - eine zum Eigenverbrauchsanteil und eine für die Szenarien.



## Eine umfangreiche Modellbeschreibung befindet sich in der zugehörigen Bachelorarbeit
Bei Interesse, kann diese vom Autor zur Verfügung gestellt werden. Mail: jonathan.kirchhoff@uni-wuppertal.de 

## Datenquellen
Bundesnetzagentur (2022a). Marktstammdatenregister: Aktuelle Einheitenübersicht.
https : / / www . marktstammdatenregister . de / MaStR / Einheit / Einheiten /
OeffentlicheEinheitenuebersicht (Zuletzt abgerufen am: 06.03.2022)
Bundesnetzagentur (2009–2022). Monitoringberichte. Online verfügbar unter https:
//www.bundesnetzagentur.de/DE/Allgemeines/Presse/Mediathek_3/start.html.

Bundesverband der Energie- und Wasserwirtschaft (2022). BDEW-Strompreisanalyse
Januar 2022: Haushalte und Industrie. https : / / www . bdew . de / media /
documents/220124_BDEW-Strompreisanalyse_Januar_2022_24.01.2022_
final.pdf (Zuletzt abgerufen am: 12.03.2022)

Bundeszentrale für politische Bildung (2020a). Einkommensgruppen: Verteilung der
Bevölkerung auf verschiedene Einkommensgruppen in Prozent, 1985 bis 2016.
https://www.bpb.de/nachschlagen/zahlen-und-fakten/soziale-situation-in-
deutschland/61763/einkommensgruppen (Zuletzt abgerufen am: 09.01.2022)

Bundeszentrale für politische Bildung (2020b). Einkommensverteilung: Nach Zehn-
teln (Dezile), Anteile am Gesamteinkommen in Prozent, Personen in Pri-
vathaushalten auf Grundlage des verfügbaren und gewichteten Haushaltsein-
kommens, 1991 und 2016. https://www.bpb.de/nachschlagen/zahlen-und-
fakten/soziale-situation-in-deutschland/61769/einkommensverteilung (Zu-
letzt abgerufen am: 09.01.2022)

Deutscher Wetterdienst Climate Data Center (2022). Rasterdaten der vieljährigen
mittleren Monatssummen und der vieljährigen mittleren Jahressumme für die
Globalstrahlung auf die horizontale Ebene für Deutschland [Version V003].
https://opendata.dwd.de/climate_environment/CDC/grids_germany/
multi_annual/radiation_global/ (Zuletzt abgerufen am: 14.03.2022)

E.ON (2021). E.ON Energieatlas: Ökostromnutzung. https://energieatlas.eon.de/
gruene-energiemeister/oekostromnutzung (Zuletzt abgerufen am: 22.12.2021)

Forschungsgruppe Solarspeichersysteme (o. J.). Unabhängigkeitsrechner. Hochschule
für Technik und Wirtschaft HTW Berlin. https : / / solar . htw - berlin . de /
rechner/unabhaengigkeitsrechner/. (Zuletzt abgerufen am: 12.03.2022)

Kost, C., Shammugam, S., Fluri, V., Peper, D., Memar, A. D. & Schlegl, T. (2021).
Stromgestehungskosten erneuerbare Energien (Fraunhofer-Institut für sola-
re Energiesysteme ISE, Hrsg.). https://www.ise.fraunhofer.de/content/
dam / ise / de / documents / publications / studies / DE2021 _ ISE _ Studie _
Stromgestehungskosten_Erneuerbare_Energien.pdf (Zuletzt abgerufen am:
15.01.2022)

Niamir, L. (2019). BENCHv.2 model [Version 1.0.0]. CoMSES Computational Model
Library. https://www.comses.net/codebases/2b15a409-72bb-4285-a6e0-
ca30575d36a6/releases/1.0.0/. (Zuletzt abgerufen am: 21.03.2022)

Niamir, L., Filatova, T., Voinov, A. & Bressers, H. (2018). Transition to low-carbon
economy: Assessing cumulative impacts of individual behavioral changes.
Energy Policy, 118, 325–345. https://doi.org/10.1016/j.enpol.2018.03.045 

Märtel, C. (2021). Die Kosten für eine Photovoltaikanlage. Solaranlagen-Portal.
https://www.solaranlagen- portal.com/photovoltaik/kosten. (Zuletzt ab-
gerufen am: 15.01.2022)

Rügamer, J. & Fricke, J. (2018). Sachstandsbericht Solarenergie für den Wirtschafts-
raum Augsburg. https : / / www . landkreis - augsburg . de / fileadmin / user _
upload/Klimaschutz/Sachstandsbericht- Solar- Region- Augsburg.pdf (Zu-
letzt abgerufen am: 20.03.2022)

Solarenergie Förderverein Deutschland (o. J.). Die aktuelle Einspeisevergütung in
Ct/kWh. https://sfv.de/eeg-verguetungen (Zuletzt abgerufen am: 12.03.2022)

Solarenergie Förderverein Deutschland (2017). Historische Solarstrom-Vergütungen
im Überblick. https://www.sfv.de/lokal/mails/sj/verguetu (Zuletzt abgeru-
fen am: 12.03.2022)

Statistische Ämter des Bundes und der Länder (2021). Regionalatlas Deutschland:
Verfügbares Einkommen je Einwohner (Stand 2018), Eigentümerquote (Stand
2011). https://regionalatlas.statistikportal.de/# (Zuletzt abgerufen am:
06.03.2022)
55
Statistisches Bundesamt (o. J.). Reallöhne und Nettoverdienste: Reallohnindex. https:
//www.destatis.de/DE/Themen/Arbeit/Verdienste/Realloehne-Nettoverdienste/
Tabellen/liste-reallohnindex.html (Zuletzt abgerufen am: 12.03.2022)

Statistisches Bundesamt (2021a). Kreisfreie Städte und Landkreise nach Fläche, Be-
völkerung und Bevölkerungsdichte am 31.12.2020. https://www.destatis.
de / DE / Themen / Laender - Regionen / Regionales / Gemeindeverzeichnis /
Administrativ/04-kreise.html (Zuletzt abgerufen am: 13.03.2022)

Statistisches Bundesamt (2021b). Stromverbrauch der privaten Haushalte nach Haus-
haltsgrößenklassen. https://www.destatis.de/DE/Themen/Gesellschaft-
Umwelt/Umwelt/UGR/private-haushalte/Tabellen/stromverbrauch-haushalte.
html (Zuletzt abgerufen am: 09.01.2022)

Steinfeldt, A. & Weißbach, A. (2021). Stromspiegel: Verbrauchen Sie zu viel Strom?
(co2online, Hrsg.). https://www.stromspiegel.de/fileadmin/ssi/stromspiegel/
Broschuere/stromspiegel-2021.pdf (Zuletzt abgerufen am: 12.03.2022)

Stonedahl, F. & Wilensky, U. (2010). BehaviorSearch [Computer Software]. Center
for Connected Learning and Computer Based Modeling, Northwestern Uni-
versity, Evanston, IL. Online verfügbar unter http://behaviorsearch.org/ 

Wilensky, U. (1999). NetLogo [Computer Software]. Center for Connected Learning
and Computer Based Modeling, Northwestern University, Evanston, IL. On-
line verfügbar unter http://ccl.northwestern.edu/netlogo/ 

Wirth, H. (2021). Aktuelle Fakten zur Photovoltaik in Deutschland, Fassung vom
16.12.2021. Fraunhofer-Institut für Solare Energiesysteme ISE. https://www.
ise.fraunhofer.de/content/dam/ise/de/documents/publications/studies/
aktuelle-fakten-zur-photovoltaik-in-deutschland.pdf. (Zuletzt abgerufen am:
22.12.2021)

Zinke, G. (2020). Lohnentwicklung in Deutschland und Europa. Bundeszentrale für
politische Bildung. https://www.bpb.de/themen/arbeit/arbeitsmarktpolitik/
322503/lohnentwicklung- in- deutschland- und- europa/. (Zuletzt abgerufen
am: 12.03.2022)
57
