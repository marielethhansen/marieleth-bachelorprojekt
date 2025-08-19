# Marie Leth - bachelorprojekt
## Introduktion til projektet
Dette repository indeholder do-fil og dataanalyser til mit bachelorprojekt fra 2020 på Institut for Statskundskab ved Aarhus Universitet. Projektet omhandler danske vælgeres evaluering af politiske lederes kompetencer.

Forskningsdesign og den primære analyse: I projektet benyttes et eksperimentelt undersøgelsesdesign, udformet som et survey-eksperiment. Analysen undersøgte den kausale effekt af at læse beskrivelsen af en fiktiv politiker på evaluering af lederens kompetencer i udgangspunktet og under en terrortrussel. Konkret er analysen udført ved brug af OLS-regression med tovejs-interaktion. Grafer er opstillet for at illustrere analysens resultater. 

Robusthedstjek: Projektet indeholder en række robusthedstjek af analysens resultater for at undersøge hvorvidt effekterne er fordelt ligeligt på tværs af stikprøven. Disse robusthedstjek er foretaget via tre-vejsinteraktioner. Det er blevet undersøgt hvorvidt respondentens eget køn og ideologi påvirkede resultaterne samt hvorvidt respondenten havde Corona-virus i tankerne under eksperimentet påvirkede undersøgelsens resultater. Derudover er det via trevejsinteraktion blevet undersøgt om terrortruslen vil have den forventede effekt for nogle af respondentgrupperne i stikprøven samt hvorvidt terrortrussel har den forventede effekt på sammenhængen hos respondenter som generelt har stereotypiske opfattelser af politikeres kompetencer.

Balancetabeller: Idet automatisk randomisering i SurveyXact ikke var muligt, er der også opstillet en række balancetabeller for at teste om randomisering ud fra fødselsdag var succesfuld. Konkret er dette gjort ved udregning af gennemsnit for baggrundsvariablene: ideologi, alder, køn, uddannelsesniveau, geograf og chi-i-anden-test foretaget. 

Forudsætningstest: Der er foretaget relevante forudsætningstest; herunder White’s test for homoskedasticitet samt test for normalfordelte fejlled og undersøgelse af indflydelsesrige observationer via Cooks D.

Manipulationstjek: Som en del af projektet er det blevet undersøgt om manipulation af den uafhængige variabel og den interagerende variabel har virket efter hensigten. Her er det undersøgt om manipulationen af den fiktive politiker var succesfuld og om terrortrussel har ført til den tilsigtede forskel i hvorvidt respondenterne tænkte på en terrortrussel ved vurderingen af politikerne. 

Do-filen er struktureret på baggrund af ovenstående beskrivelse.

## Indhold
- `DO-FILE-BACHELORPROJEKT.do`: Stata-kode til dataanalysen
- `README.md`: Denne fil

 ## Data
Analysens data er indsamlet fra april-maj 2020 igennem et onlinespørgeskema. 720 respondenter indgår datasættet. Selve datafilen er ikke inkluderet i dette repository. Data kan fremsendes efter ønske. 

## Kontakt
Hvis du har spørgsmål til projektet, er du velkommen til at skrive til mig på marielhansen94@gmail.com
  
