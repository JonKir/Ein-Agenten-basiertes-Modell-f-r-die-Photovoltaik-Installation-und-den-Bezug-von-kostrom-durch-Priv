# Ein-Agenten-basiertes-Modell-fuer-die-Photovoltaik-Installation-und-den-Bezug-von-Oekostrom-durch-Privathaushalte in Deutschland
Das ABM wurde in der gleichnamigen Bachelorarbeit entwickelt und dient insbesondere zur geographisch aufgelösten Modellierung des PV-Ausbaus und der Martkdiffusion von Ökostrom bei Privathaushalten.

In das Modell gehen sowohl diverse Daten aus verschiedensten Quellen als auch Ergebnisse aus dem BENCHv.2 Modell von Leila Niamir (2019) und dem zugehörigen Paper von Niamir et al. (2018) ein. Bei der Initialisierung der Agenten, die Privathaushalte repräsentieren, werden verfügbare Daten zum Einkommen, Immobilienbesitz und der örtlichen Globalstrahlung jeweils auf Landkreisebene berücksichtigt. Im Anschluss an eine Modellkalibrierung simuliert das Modell den Ausbau von PV bei Privathaushalten bis 2050 unter Berücksichtigung verschiedener Szenarien.

Das Modell wurde in NetLogo (Version 6.2.1) geschrieben und benötigt für eine Simulation etwa 5-10 Minuten. Dabei können verschiedene Szenarien bzgl. der Förderung sowie der Entwicklung der Investitionskosten eingestellt werden.
<div style="width:830; height: 600">
<img src="https://user-images.githubusercontent.com/77612325/159860246-79c3acf8-acc1-4b43-b812-9d980fbbeed9.png" height="300" width="300" >


<img src="https://user-images.githubusercontent.com/77612325/159858613-5bb2c7ad-7538-42ca-a0df-b34ea47da1cb.png" height="300" width="530" >

</div>
Im Repository befinden sich neben dem NetLogo Modell zwei BehaviorSearch Dateien, die für die Kalibrierung verwendet wurden und zwei CSV Dateien - eine zum Eigenverbrauchsanteil und eine für die Szenarien.



## Eine umfangreiche Modellbeschreibung befindet sich in der zugehörigen Bachelorarbeit
Bei Interesse, kann diese vom Autor zur Verfügung gestellt werden. Mail: jonathan.kirchhoff@uni-wuppertal.de 

Niamir, L. (2019). BENCHv.2 model [Version 1.0.0]. CoMSES Computational Model
Library. https://www.comses.net/codebases/2b15a409-72bb-4285-a6e0-
ca30575d36a6/releases/1.0.0/. (Zuletzt abgerufen am: 21.03.2022)

Niamir, L., Filatova, T., Voinov, A. & Bressers, H. (2018). Transition to low-carbon
economy: Assessing cumulative impacts of individual behavioral changes.
Energy Policy, 118, 325–345. https://doi.org/10.1016/j.enpol.2018.03.045 
