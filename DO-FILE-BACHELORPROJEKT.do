****************DO-FILE BACHELOROPGAVE**************************************************

************Kommando til kodning af den uafhængige variabel "politikerkøn”. Randomisering ift. Den tildelte politiker skete ud fra respondenternes fødselsdag*************
recode fødselsdag (1=1) (5=1) (9=1) (13=1) (17=1) (21=1) (25=1) (29=1) (3=1) (7=1) (11=1) (15=1) (19=1) (23=1) (27=1) (31=1) (2=0) (6=0) (10=0) (14=0) (18=0) (22=0) (26=0) (30=0) (4=0) (8=0) (12=0) (16=0) (20=0) (24=0) (28=0), generate(politikerkøn)

label define politikerkønLB 0 "Kvindelig politiker" 1 "Mandlig politiker"

label values politikerkøn politikerkønLB

************Kommando til kodning af den interagerende variabel ”kontekst”. Randomisering ift. Kontekst skete ud fra respondenternes fødselsdag ****************
recode fødselsdag (1=0) (5=0) (9=0) (13=0) (17=0) (21=0) (25=0) (29=0) (2=0) (6=0) (10=0) (14=0) (18=0) (22=0) (26=0) (30=0) (3=1) (7=1) (11=1) (15=1) (19=1) (23=1) (27=1) (31=1) (4=1) (8=1) (12=1) (16=1) (20=1) (24=1) (28=1), generate(kontekst)

label define kontekstLB 0 "kontrol" 1 "Terrortrussel"

label values kontekst kontekstLB

*********Kommando til samkodning af den afhængige variabel og omkodning til 0-1-skala **************************
egen kompetence=rowmean(sørenkontrolkompetence susannekontrolkompetence sørentreatmentkompetence susannetreatmentkompetence)

generate Kompetence2 = (kompetence)/10


******Kommando til regression med tovejs interaktion**********************************
reg Kompetence2 i.politikerkøn##i.kontekst,r


***marginsplot ver sammenhængen******
regress Kompetence2 i.politikerkøn##i.kontekst,r
margins, dydx(politikerkøn) over(kontekst)

marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("") xtitle ("Kontekst") ytitle ("Marginaleffekt af den mandlige politiker") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)










*****************Gennemsnit til min figur over evaluering af lederkompetencer********
mean sørenkontrolkompetence
mean susannekontrolkompetence
mean sørentreatmentkompetence
mean susannetreatmentkompetence





***************MINE ROBUSTHEDSTJEK / TREVEJSINTERAKTIONER***************************************************************

*****frasortering af dem der ikke tænkte på Terrortrussel ***************************************************************************************************
egen tankervurdering=rowmean(tankervurderingsøren tankervurderingsusanne)
tab tankervurdering

label define tankervurderingLB 1 "Danmark under normale omstændigheder" 2 "Terrortrussel mod Danmark" 3 "Den nuværende Corona-situation i Danmark" 4 "Andet"
label values tankervurdering tankervurderingLB






drop if kontekst ==1 & tankervurdering == 1
drop if kontekst ==1 & tankervurdering == 3
drop if kontekst ==1 & tankervurdering == 4



regress Kompetence2 i.politikerkøn##i.kontekst,r


margins, dydx(politikerkøn) over(kontekst)


marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("") xtitle ("Kontekst") ytitle ("Marginaleffekt af den mandlige politiker") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)





************Trevejs-interaktion med respondentens køn. Omkodning af køn med missing values**************************************************

recode køn (0=0) (1=1) (89=.), generate(køn_n)
label define køn_nLB 0 "Kvinde" 1 "Mand"
label values køn_n køn_nLB


reg Kompetence2 i.politikerkøn##i.kontekst##køn_n,r
bysort køn: reg Kompetence2 i.politikerkøn##i.kontekst



reg Kompetence2 i.politikerkøn##i.kontekst if køn_n == 0
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Kvindelige respondenter") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)



reg Kompetence2 i.politikerkøn##i.kontekst if køn_n == 1
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Mandlige respondenter") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)




***********Trevejs-interaktion med respondentens ideologi (kodet i blokke)**********************************************

recode højrevenstreplacering (89/.=.)

recode højrevenstreplacering (0=0) (1=0) (2=0) (3=0) (4=0) (5=1) (6=1) (7=1) (8=1) (9=1) (10=1) (89=.), generate(hvplacering_n)
label define hvplacering_nLB 0 "Venstreorienteret" 1 "Højreorienteret"
label values hvplacering hvplacering_nLB

reg Kompetence2 i.politikerkøn##i.kontekst##hvplacering_n,r



reg Kompetence2 i.politikerkøn##i.kontekst if hvplacering_n == 0
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Venstreorienterede respondenter") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)


reg Kompetence2 i.politikerkøn##i.kontekst if hvplacering_n == 1
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Højreorienterede respondenter") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)



testparm i.politikerkøn#i.kontekst#i.hvplacering_n


*********Trevejsinteraktioner - Dem der tænkte på Corona kan have mudret billedet****************************************************

****Slet Corona-observationer****
egen tanker=rowmean(tankervurderingsøren tankervurderingsusanne)
drop if tanker ==3
reg Kompetence2 i.politikerkøn##i.kontekst,r


****Lav en dummy-variabel****
egen tankerreg=rowmean(tankervurderingsøren tankervurderingsusanne)
recode tankerreg (1=1) (2=1) (4=1) (3=0), generate(dummytankerreg)
label define dummytankerregLB 0 "Corona" 1 "Ikke Corona"
label values dummytankerreg dummytankerregLB
reg Kompetence2 i.politikerkøn##i.kontekst##i.dummytankerreg,r


reg Kompetence2 i.politikerkøn##i.kontekst if dummytankerreg == 0
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Tænkte på Corona-situationen i Danmark") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)


reg Kompetence2 i.politikerkøn##i.kontekst if dummytankerreg == 1
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Tænkte ikke på Corona-situationen i Danmark") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)





reg Kompetence2 i.politikerkøn##i.kontekst if tanker2 == 1
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Tænkte på Corona-situationen i Danmark") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)




********************************************Stereotyper på sikkerhedsområdet**************************************************
recode sikkerhedsspørgsmål (89/.=.)


label define sikkerhedsspørgsmålLB 2 "Mænd" 1 "Ingen forskel" 0 "Kvinder"
label values sikkerhedsspørgsmål sikkerhedsspørgsmålLB





reg Kompetence2 i.politikerkøn##i.kontekst##sikkerhedsspørgsmål,r



reg Kompetence2 i.politikerkøn##i.kontekst if sikkerhedsspørgsmål == 0
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Figur 5a: Kvinder er bedst til at håndtere sikkerhedsspørgsmål") xtitle ("Kontekst") ytitle ("Marginaleffekt af den mandlige politiker") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)


reg Kompetence2 i.politikerkøn##i.kontekst if sikkerhedsspørgsmål == 1
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Figur 5b: Ingen forskel") xtitle ("Kontekst") ytitle ("Marginaleffekt af den mandlige politiker") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)


reg Kompetence2 i.politikerkøn##i.kontekst if sikkerhedsspørgsmål == 2
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Figur 5c: Mænd er bedst til at håndtere sikkerhedsspørgsmål") xtitle ("Kontekst") ytitle ("Marginaleffekt af den mandlige politiker") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)






*****Analysen lavet med med dummyvariable*****

recode sikkerhedsspørgsmål (0=0) (1=0) (2=1) (89=.), generate(sikkerdummy)
label define sikkerdummyLB 0 "Ikke-stereotyper" 1 "Stereotyper"
label values sikkerdummy sikkerdummyLB

*****Er det stadig signfikant hvis "Ingen forskel" bliver reference-kategori?*****

recode sikkerhedsspørgsmål (2=2) (1=0) (0=1), generate(NYsikkerhed1)
label define NYsikkerhed1LB 2 "Mænd" 1 "Kvinder" 0 "Ingen forskel"
label values NYsikkerhed1 NYsikkerhed1LB
reg Kompetence2 i.politikerkøn##i.kontekst##i.NYsikkerhed1,r


reg Kompetence2 i.politikerkøn##i.kontekst if NYsikkerhed1 == 0
margins, dydx(politikerkøn) over(kontekst)
marginsplot, recast(scatter) yline(0) xscale(range(-0.5 1.5)) title("Ingen forskel") xtitle ("Kontekst") ytitle ("Marginaleffekt af politikerens køn") legend(on label(1 "95% konfidensinterval") label(2 "Marginaleffekt")) scheme(s1mono)


***********Omkodning til fire treatmentgrupper*************************************
recode fødselsdag (1=1) (5=1) (9=1) (13=1) (17=1) (21=1) (25=1) (29=1) (2=2) (6=2) (10=2) (14=2) (18=2) (22=2) (26=2) (30=2) (3=3) (7=3) (11=3) (15=3) (19=3) (23=3) (27=3) (31=3)(4=4) (8=4) (12=4) (16=4) (20=4) (24=4) (28=4), generate(defiregrupper)

label define defiregrupperLB 1 "Mand - kontrol" 2 "Kvinde - kontrol" 3 "Mand - treatment" 4 "Kvinde - treatment"

label values defiregrupper defiregrupperLB




**************BALANCETABEL*************
*****T-test. Denne er alternativ, da jeg helst vil**********
ttest højrevenstreplacering, by (detogrupper)
ttest alder, by (detogrupper)

*****Udregning af gennemsnit og herefter chi-i-anden-test*********************


recode højrevenstreplacering (89/.=.)
mean højrevenstreplacering, over (defiregrupper)
tab højrevenstreplacering defiregrupper, chi

mean alder, over (defiregrupper)
tab alder defiregrupper, chi


recode køn (89/.=.)
mean køn, over (defiregrupper)
tab køn defiregrupper, chi




tab uddannelsesniveau defiregrupper, chi
tabulate uddannelsesniveu defiregrupper, row


tab geografi defiregrupper, chi







****FORUDSÆTNIGNSTESTS************************************************
*****Varianshomogenitet**********************************************
reg Kompetence2 i.politikerkøn##i.kontekst,r
estat imtest,white

****Normaltfordelt fejlled******************************************
reg Kompetence2 i.politikerkøn##i.kontekst,r
predict tempresrid, residuals 
histogram tempresrid, normal 

reg Kompetence2 i.politikerkøn##i.kontekst,r
lvr2plot

****Indflydelsesrige observationer************************************
reg Kompetence2 i.politikerkøn##i.kontekst
predict tempcooksd, cooksd
display 4/e(N)
summarize tempcooksd if tempcooksd >(4/e(N))

drop if tempcooksd >(4/e(N))

reg Kompetence2 i.politikerkøn##i.kontekst
qreg Kompetence2 i.politikerkøn##i.kontekst
sqreg Kompetence2 i.politikerkøn##i.kontekst





*** MANIPULATIONSTJEK*********************************************************************
*** Feminin maskulin for de fire grupper - feminin maskulin samkodet og herefter tjek *************************************************

egen femimask=rowmean(femimasksøren femimasksusanne)

mean femimask, over (politikerkøn)
ttest femimask, by (politikerkøn)


*****Terrortreatment og kontrolgruppe****************************************************************************************
egen tankervurdering=rowmean(tankervurderingsøren tankervurderingsusanne)
tab tankervurdering

label define tankervurderingLB 1 "Danmark under normale omstændigheder" 2 "Terrortrussel mod Danmark" 3 "Den nuværende Corona-situation i Danmark" 4 "Andet"
label values tankervurdering tankervurderingLB


drop if kontekst ==1 & tankervurdering == 1
drop if kontekst ==1 & tankervurdering == 3
drop if kontekst ==1 & tankervurdering == 4



regress Kompetence2 i.politikerkøn##i.kontekst,r













generate byte treatfikterror =.
replace treatfikterror = 1 if kontekst ==1 & tankervurdering == 2
tab treatfikterror

generate byte konterror =.
replace konterror = 1 if kontekst ==0 & tankervurdering == 2
tab konterror





***Den egentlige signifikanstest***************************
tab tanker defiregrupper, chi




**************GRAF TIL MANIPULATIONSTJEKKET*************

recode tankervurdering (1=1) (2=2) (3=3) (4=4), generate(tankervurdering2)

label define tankervurdering2LB 1 "DK under normale omstændigheder" 2 "Terrortrussel mod DK" 3 "Nuværende Corona-situation i DK" 4 "Andet"
label values tankervurdering2 tankervurdering2LB




graph bar (count) konntrolgrp treatgrp2, over(tankervurdering)

*******udregning af justeret r2*******************************
regress Kompetence2 i.politikerkøn##i.kontekst,r
r2_a
