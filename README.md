# Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom-durch-Privathaushalte in Deutschland
Das ABM wurde in der gleichnamigen Bachelorarbeit entwickelt und dient insbesondere zur geographisch aufgelösten Modellierung des PV-Ausbaus und der Martkdiffusion von Ökostrom bei Privathaushalten.

In das Modell gehen sowohl diverse Daten aus verschiedensten Quellen als auch Ergebnisse aus dem BENCHv.2 Modell von Leila Niamir (2019) und dem zugehörigen Paper von Niamir et al. (2018) ein. Bei der Initialisierung der Agenten, die Privathaushalte repräsentieren, werden verfügbare Daten zum Einkommen, Immobilienbesitz und der örtlichen Globalstrahlung jeweils auf Landkreisebene berücksichtigt. Im Anschluss an eine Modellkalibrierung simuliert das Modell den Ausbau von PV bei Privathaushalten bis 2050 unter Berücksichtigung verschiedener Szenarien.

Das Modell wurde in NetLogo (Version 6.2.1) geschrieben und benötigt für eine Simulation etwa 5-10 Minuten. Dabei können verschiedene Szenarien bzgl. der Förderung sowie der Entwicklung der Investitionskosten eingestellt werden.

<object data="https://github.com/JonKir/Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom/files/8338962/Ergebnisse_PV.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="https://github.com/JonKir/Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom/files/8338962/Ergebnisse_PV.pdf">
        <p>This browser does not support PDF. Please download the PDF to view it: <a href="https://github.com/JonKir/Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom/files/8338962/Ergebnisse_PV.pdf">Download PDF</a>.</p>
    </embed>
</object>

[Ergebnisse_PV.pdf](https://github.com/JonKir/Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom/files/8338962/Ergebnisse_PV.pdf)

[Karte_Solar.pdf](https://github.com/JonKir/Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom/files/8338971/Karte_Solar.pdf)


Im Repository befinden sich neben dem NetLogo Modell zwei BehaviorSearch Dateien, die für die Kalibrierung verwendet wurden und zwei CSV Dateien - eine zum Eigenverbrauchsanteil und eine für die Szenarien.



## Eine umfangreiche Modellbeschreibung befindet sich in der zugehörigen Bachelorarbeit
Bei Interesse, kann diese vom Autor zur Verfügung gestellt werden. Mail: jonathan.kirchhoff@uni-wuppertal.de 

Niamir, L. (2019). BENCHv.2 model [Version 1.0.0]. CoMSES Computational Model
Library. https://www.comses.net/codebases/2b15a409-72bb-4285-a6e0-
ca30575d36a6/releases/1.0.0/. (Zuletzt abgerufen am: 21.03.2022)

Niamir, L., Filatova, T., Voinov, A. & Bressers, H. (2018). Transition to low-carbon
economy: Assessing cumulative impacts of individual behavioral changes.
Energy Policy, 118, 325–345. https://doi.org/10.1016/j.enpol.2018.03.045 
