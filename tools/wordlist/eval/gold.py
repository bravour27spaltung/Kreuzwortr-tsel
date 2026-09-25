import csv,sys,re
TR=str.maketrans({'Ä':'AE','Ö':'OE','Ü':'UE','ß':'SS','ä':'AE','ö':'OE','ü':'UE'})
N=lambda w:w.translate(TR).upper()
JUNK={
 'vorname':"Tina Hans Peter Anna Thomas Klaus Maria Michael Stefan Andreas Martin Sabine Petra Monika Wolfgang Helmut Gerhard Uwe Karin Brigitte Heike Kerstin Dieter Manfred Rolf Frank Bernd Jens Lars Nina Lisa Sarah Julia Laura Tim Erik Ursula Renate Gabriele Christine Sandra Andrea Nicole Claudia Susanne Jutta Ingrid Horst Gunter Norbert Reinhard Lothar Siegfried Ewald Hartmut Olaf Carsten Kevin Jessica Melanie",
 'nachname_person':"Merkel Obama Putin Steinmeier Westerwelle Beckenbauer Klinsmann Mozart Goethe Beethoven Freud Kohl Schroeder Gauck Clinton Bush Trump Sarkozy Berlusconi Hitzfeld Ballack Rehhagel Stoiber Wowereit Chirac Blair Maradona Ronaldo Messi Kafka Nietzsche Wagner Brecht Bismarck Napoleon",
 'marke':"Microsoft Google Facebook Siemens Volkswagen Adidas Nokia Samsung Twitter Youtube Porsche Audi Apple Amazon Lufthansa Telekom Vodafone Skoda Airbus Sony Ikea Nestle Bosch Linux Windows Android Skype Yahoo Ebay Mercedes Toyota",
 'englisch':"Straw Welcome Love Just Thanks Good Have Enjoy Yourself Hello Home Center Corporate Shirt Business Office Road Future Stores Street House Health Water Music World People Time Life",
 'abk':"DJK KWH STD BASF ADAC ZDF ARD BVB FDP CDU SPD USA NATO EZB DGB HTML GPS Lkw Pkw Mio Mrd bzw usw etc Tel Prof NRW BRD DDR EON WWW URL DNA DNS TSV HSV FCB VfB kWh GmbH Mwst ISBN UNO FIFA UEFA OPEC CSU AfD SED KPD ADHS BND CIA FBI NSA",
}
GOOD="""Haus Zeit Hand Kinder Wasser Liebe Angst Leute Eltern Menschen Geld Strasse Radio Grat Ader Gras Fluss Berg Wald Baum Tisch Stuhl Buch Schule Lehrer Arzt Kirche Markt Katze Hund Vogel Pferd Brot Kaese Milch Apfel Birne Sonne Mond Stern Himmel Erde Feuer Luft Wind Regen Schnee Winter Sommer Herbst Fruehling Tag Nacht Morgen Abend Woche Monat Jahr Stunde Minute Sekunde Kopf Arm Bein Herz Auge Ohr Nase Mund Zahn Haar Freund Familie Mutter Vater Bruder Schwester Oma Opa Tante Onkel Arbeit Glueck Frieden Krieg Recht Staat Volk Land Stadt Dorf Weg Bruecke Turm Tor Tuer Fenster Dach Keller Garten Blume Rose Tulpe Kuchen Torte Suppe Salat Wein Bier Kaffee Tee Saft
Bauwerk Brunnen Kellner Schloss Kapitaen Deckel Leiter Nebel Flasche Messer Gabel Loeffel Teller Koffer Tasche Schuhe Handschuh Brille Krawatte Hemd Mantel Hochzeit Gewitter Abenteuer Geduld Vorsicht Wahrheit Freiheit Gesundheit Krankheit Ordnung Bildung Zeitung Wohnung Ausbildung Erfahrung Entwicklung Verhandlung Landschaft Wirtschaft Mannschaft Gesellschaft Werkzeug Fahrzeug Flugzeug Spielzeug Zeugnis Ergebnis Erlebnis Geheimnis Kaefer Schmetterling Eichhoernchen Igel Hase Fuchs Wolf Baer Adler Eule Rabe Taube Ente Gans Huhn Kuh Schwein Schaf Ziege Esel Kamel Elefant Tiger Loewe Affe Delfin Wal Hai Forelle Lachs Hering Krebs Muschel Schnecke Spinne Ameise Biene Wespe Fliege Mucke Kirsche Pflaume Traube Zitrone Banane Orange Erdbeere Himbeere Tomate Gurke Karotte Kartoffel Zwiebel Knoblauch Pilz Nuss Mandel Honig Zucker Salz Pfeffer Butter Sahne Joghurt Nudel Reis Mehl Teig Kuchen Keks Bonbon Schokolade Marmelade Senf Essig Metall Marmor Kupfer Silber Gold Eisen Stahl Beton Glas Holz Stein Sand Lehm Ton Kohle Erdgas Benzin Diesel"""
def main(path):
    kept={};baseline=set()
    for r in csv.DictReader(open(path+'_gefiltert.tsv'),delimiter='\t'): kept[r['wort']]=r
    drop={}
    for r in csv.DictReader(open(path+'_ausgeschlossen.tsv'),delimiter='\t'): drop[r['wort']]=r
    allw=set(kept)|set(drop)
    print('== JUNK-Testset (soll ausgeschlossen werden), nur Woerter, die in der Baseline vorkommen ==')
    tot=ok=0;leak=[]
    for cat,ws in JUNK.items():
        ws=[N(w) for w in ws.split()]
        ws=[w for w in ws if 3<=len(w)<=11 and w in allw]
        d=[w for w in ws if w in drop]; k=[w for w in ws if w in kept]
        tot+=len(ws);ok+=len(d)
        print(f'{cat:16} in Baseline {len(ws):3}  ausgeschlossen {len(d):3} ({len(d)/max(len(ws),1):.0%})  DURCHGERUTSCHT: {k}')
        leak+=k
    print(f'GESAMT Recall Junk: {ok}/{tot} = {ok/tot:.1%}')
    print('\n== GOOD-Testset (soll behalten werden) ==')
    ws=[N(w) for w in GOOD.split()]
    ws=sorted(set(w for w in ws if 3<=len(w)<=11 and w in allw))
    k=[w for w in ws if w in kept]; d=[w for w in ws if w in drop]
    print(f'in Baseline {len(ws)}  behalten {len(k)} ({len(k)/len(ws):.1%})  faelschlich ausgeschlossen {len(d)}:')
    for w in d: print('   ',w,drop[w]['grund'],drop[w]['evidenz'][:90])
    missing=[N(w) for w in GOOD.split() if N(w) not in allw and 3<=len(N(w))<=11]
    print('nicht im Korpus (>=5):',len(set(missing)))
main(sys.argv[1])
