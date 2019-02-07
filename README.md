# Automatenfolien
Folien zum Kurs „Automatentheorie und ihre Anwendungen“

## Überblick
* Einführung und Kapitel 1–5 sind auf die Ordner <code>0</code>–<code>5</code> aufgeteilt.
* In jedem Ordner finden sich jeweils die Quelldateien.
* PDF-Dateien und eingebundene Bilder sind in Unterordnern <code>img</code> bzw. <code>PDF</code>.

## Wegweiser
Pro Foliensatz gibt es 5 Versionen jeder <code>.tex</code>- bzw. <code>.pdf</code>-Datei:

* <code>Aut\<n\>\_handout</code> – für Ausdrucke, ohne Overlays
* <code>Aut\<n\>\_handout\_4</code> – dito, aber mit 4 Seiten pro Blatt
* <code>Aut\<n\>\_slides</code> – für die Präsentation, mit Overlays
* <code>Aut\<n\>\_notes</code> – zur Präsentation gehörige Presenter Notes
* <code>Aut\<n\>\_pres</code> – die letzteren beiden nebeneinander in einem Dokument

Der eigentliche Inhalt steht in <code>Aut\<n\>.tex</code> bzw. der davon importierten Dateien. Zum Erzeugen der PDFs muss <code>pdflatex</code> mit einer der fünf oben genannten Dateien aufgerufen werden (ggf. bis zu 3 Mal, bis alle Labels und Inhaltsverzeichnisse aktualisiert sind).
In Kapiteln 2–5 wird es jeweils LaTeX-Fehlermeldungen geben, weil
einige Bilder fehlen, die mit der GPLv3-Lizenz inkompatibel sind (Fehlermeldungen ignorieren oder mich kontaktieren).

## Anmerkungen zum Präsentieren

Wenn ein Projektor oder externer Bildschirm an ein Notebook angeschlossen ist, können die Folien auf Projektor/Bildschirm und die Presenter Notes (LaTeX-Befehl <code>\note</code>) auf dem Notebook angezeigt werden. Unter macOS kann man dazu wie folgt vorgehen:

### mit [<code>Skim</code>](https://skim-app.sourceforge.io/) 

* Öffne <code>Aut\<n\>\_notes.pdf</code> und dann <code>Aut\<n\>\_slides.pdf</code>.
* Gehe zu „View“ –> „Presentation Options“ und stelle unter „Synchronized Notes Document“ die Datei <code>Aut\<n\>\_notes.pdf</code> ein
* Beginne die Präsentation („View“ –> „Presentation“) für <code>Aut\<n\>\_slides.pdf</code> .

Diese Vorgehensweise funktioniert nur, wenn beide Dokumente gleich viele Seiten haben, also muss man akribisch für jeden Frame (auch z.&thinsp;B. Titelseite oder Inhaltsverzeichnis) einen <code>\note</code>-Befehl einfügen, notfalls mit leerem Argument.

Leider verpixelt Skim seit ein paar OS-Versionen jede Transition; das liegt wohl an Apples PDFkit, und eine Lösung ist nicht in Sicht [[hier](https://tex.stackexchange.com/questions/431423/os-x-blurry-beamer-presentations-on-sierra-high-sierra),[hier](https://apple.stackexchange.com/questions/325622/what-pdf-viewer-can-be-used-to-present-slides-on-high-sierra)]. Deshalb verwende ich <code>dspdfviewer</code>:

### mit [<code>dspdfviewer</code>](http://dspdfviewer.danny-edel.de/)

* Wechsle auf Kommandozeile in den jeweiligen Ordner <code>PDF</code>.
* Rufe <code>dspdfviewer Aut\<n\>\_pres.pdf</code> auf.

Ein Nachteil an der allgemeinen Vorgehensweise mit den Presenter Notes ist, dass mensch für jede Präsentation auf den eigenen Rechner angewiesen ist.


