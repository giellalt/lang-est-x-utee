## Phonology



Sami GT convention 

### Triggers

* **%{W%}:0**  Weak grade trigger 
* **%{F%}:0**  Foreign word flag to prevent application of weak grade trigger, 
so that a rule does not trigger *Fiadi* as the weak grade form of *Fiat*. 
* **%{S%}:0** Strong stem trigger (for short illatives only), 
necessary for words with no stem gradation, having only short illative in a strong grade, 
e.g. *Riia* - *Riiga*, *Rannu* - *Randu*.
(But currently used also for words with stem gradation, e.g. *tuba* - *tuppa*)
Schwa trigger (for -el/er words only) never appears on the surface side.
* **%{id%}:0** Trigger / lexicon flag for pl part possible ending (esseesid/esseid)
* **%{stemill%}:0** Trigger / lexicon flag for short sg ill, formed by stem change (jõgi-jõkke)
* **%{dbl%}:0** Trigger to double the previous letter. Sometimes a phonologically long long kk pp tt  
at the end of a Sg Nom word is written k p t, 
so it must be doubled  (kabinet - kabinetti). 
Also, tulema, panema, surema, olema, minema have tulla, tulles etc...
* **%{no.apo%}:0** trigger for deleting apostrophe (normally used for foreign word inflections) from Sg Nom

Usage tag. It may relate to an individual word in the lexicon, 
or to a set of inflectional forms of some inflectional type, i.e. its sub-paradigm. It never surfaces.
It is used to pair the surface form with the usage tag of the lexical representation.

* **%{rare%}:0** rare or less used form (norm) ; e.g. kingasid

### Special surface side symbols, used in rule contexts

* **%>** Inflectional suffix boundary
* **»** Derivational suffix boundary
* **#** Word boundary for both lexicalised and dynamic compounds
Final hyphen for shortened stems:
```
%-
```
### Apostrophe

Apostrophe is used for separating inflectional affix from a foreign word lemma

* **%{apo%}:0** ... but Sg Nom is without apostrophe

### Morphophonemes

If the sound change is unproductive and difficult to relate to its immediate context,
we use capital letters with numbers to denote them. 
In stems, they typically result from diachronic processes. 
In affixes, they are typically related to the declination or conjugation and the form of the stem they attach to. 

Short stops   

* **G1:g** In strong grade
* **G1:0** In weak grade
* **G1:k** In short illative (lagi lae lakke)
* **B1:b** In strong grade
* **B1:0** In weak grade
* **B1:m** In weak grade after m
* **B1:p** In short illative (tuba toa tuppa)
* **D1:d** In strong grade
* **D1:0** In weak grade
* **D1:l** In weak grade after l
* **D1:n** In weak grade after n
* **D1:r** In weak grade after r
* **D1:t** In short illative (ladu lao lattu)

Orthographic convention: after voiceless (e.g. s or h, or k p t), gbd is written as kpt
e.g. õhk-õhu, vask-vase
K1 also in: uks, jooksma
P1 also in: laps
T1 also in: jätma, katma, kütma, matma, võtma, mõtlema, ütlema

* **K1:k** In strong grade
* **K1:0** In weak grade
* **P1:p** In strong grade ?? EKK: never happens ??
* **P1:0** In weak grade   ?? EKK: never happens ??
* **T1:t** In strong grade
* **T1:0** In weak grade

* **B2:b** In strong grade, e.g. tiib
* **B2:v** In weak grade, e.g. tiiva
* **B2:p** In short illative (tõbi tõppe)

* **K2:k** In strong grade
* **K2:g** In weak grade
* **P2:p** In strong grade
* **P2:b** In weak grade
* **T2:t** In strong grade
* **T2:d** In weak grade

Short stops in stem illatives for words that do not have grade alternation.
They surface (or appear as extra long) in strong grade, expressed by stem illative only. 

* **G3:0** 
* **G3:g** Riia Riiga
* **D3:0** 
* **D3:d** Rannu Randu
* **G4:g** 
* **G4:k** Türgi Türki
* **D4:d** 
* **D4:t** Leedu Leetu
* **B4:b** 
* **B4:p** Abja Apja

* **S1:s** In strong grade, S1 is s
* **S1:0** In weak grade, S1 is 0; before stop, S1 is 0

Unstressed syllable vowels disappear...

* **A2:a** valvas
* **A2:0** valv sa
* **E2:e** laulev
* **E2:0** laul va
* **I2:i** õilis
* **I2:0** õil sa
* **U2:u** hirmus
* **U2:0** hirm sa

A stem vowel in inflectional forms of ne/s words, to make them formally similar in inflection

* **E1:e** soolase, raudset
* **E1:0** soolas t

Ad hoc stem vowels for ne/s words

* **I1:i** an ugly trigger for ne/s words katkine - katkisil
* **A1:a** an ugly trigger for ne/s words pingne - pingsa
* **A1:0** pingne - pingsus

Few words...

j surfacing and changing

* **E4:e** aeg, soe 
* **E4:j** aja, sooja

* **J1:i** ahi, rohi
* **J1:j** ahju
* **J1:0**      rohu

4 words have h-illative: *sohu*, *suhu*, *öhe*, *pähe*

* **H3:h** sohu, ... 
* **H3:0** soo, suu, ...
* **Y3:u** sohu, suhu
* **Y3:e** öhe, pähe
* **Y3:0** öö, pea

only *hea* and *pea*  

* **A6:a** pea - pähe, päid
* **A6:ä**
* **E6:e** pea - pähe, päid
* **E6:0**

6 words have õ in indicative past

* **Ö6:ü** söö+a - süüa
* **Ö6:ö**
* **Ö6:õ** söö+i - sõi
* **Ö6:0**
* **O6:u** too+a - tuua
* **O6:o**
* **O6:õ** too+i - tõi
* **O6:0**

A handful of words...

* **M1:m** lumi
* **M1:n** lun d

* **N1:n** lään e, kolman da
* **N1:0** lää s,  kolma s

* **K3:k** vennakse
* **K3:0** venna s

Verb affix lexicons are simpler if we introduce these:

Stem vowels for verbs of some inflectional types

* **A7:a** naerab
* **A7:0** naer ma
* **E7:e** jookseb
* **E7:0** jooks ma

Verb affixes have k-g and t-d-0 alternations:

Imperative mood affixes gu/ku, ge/kem etc

* **G7:g**
* **G7:k**
* **G7:0**

Infinitive affixes ta/da/a, and gerund affixes tes/des/es

* **D7:d**
* **D7:t**
* **D7:0**

Impersonal voice affixes tud/tud, takse/dakse etc

* **T7:d**
* **T7:t**

To form past indicative forms and make them pronouncable

* **I7:i** naeris
* **I7:0** naer sin

* **S7:s** naersin
* **S7:0** seisin

Sometimes the choice of an allomorph or allophone is related to the frequency of the word.

For plural partitive, the form is generated either with sg vowel + sid or plural vowel + 0
So we must allow stem vowels for singular and plural to appear and disappear in certain conditions.

Singular stem vowel tag in lexicon

* **%{sg.a%}:a** tüng - tünga
* **%{sg.a%}:0** 

* **%{sg.e%}:e** neem - neeme
* **%{sg.e%}:0** 

* **%{sg.i%}:i** taud - taudi, default sg stem vowel for most types
* **%{sg.i%}:0** 

* **%{sg.u%}:u** koon - koonu 
* **%{sg.u%}:0** 


Plural stem vowel tag in lexicon

* **%{pl.i%}:i** king - kingi
* **%{pl.i%}:0** king - kingasid

* **%{pl.e%}:e** tõug - tõuge, taud - taude, default pl stem vowel for most types
* **%{pl.e%}:0** tõug - tõugusid

* **%{pl.u%}:u** laud - laudu
* **%{pl.u%}:0** laud - laudasid

Inflectional affixes having the same grammatical meaning:
Pl Par endings sid/0, id/sid, Sg Ill endings sse/0.
Their choice depends on triggers in the lexicon,
have to be defined un-naturally letter by letter, 

* **%{i%}:i** i of sid: pl par ending siilisid
* **%{i%}:0**         : pl par ending siile
* **%{d%}:d** d of sid: pl par ending siilisid
* **%{d%}:0**         : pl par ending siile


* **%{s%}:s** s of -sse jõesse; -sid siilisid 
* **%{s%}:0**            jõkke;    siile;   puid
* **%{e%}:e** e of -sse jõesse;  
* **%{e%}:0**            jõkke; 

If the sound change is productive and/or very regularly determined by context
(e.g. by morpheme border), we do not use special symbols to denote the changing phonemes 

ne, s ending words have similar paradigms; only sg nom is different

* **n:n** soolane and other ne-words Sg Nom
* **n:s** soolas+e, soolas+t etc  
* **e:e** soolane
* **e:0** soolas0+e 

-le/-el stem alternations also use e:0, in addition to 0:e (sip0lema-sipel0da)

high vowel lowering in certain contexts

* **i:e**
* **i:i**
* **u:o**
* **u:u**
* **ü:ö**
* **ü:ü** 






































* *kraapi%{W%}>n*
* *kraabi0>n*

* ★*kraapi%{W%}>n* (is not standard language)
* ★*kraapi0>n* (is not standard language)

















































































* *viskoosneE1>t*
* *viskooss0e>t*

* ★*viskoosneE1>t* (is not standard language)
* ★*viskooss00>t* (is not standard language)









































































1.1. plural partitive: -sid vs stem vowel change


















































































































































* * *
<small>This (part of) documentation was generated from [../src/fst/phonology.twolc](http://github.com/giellalt/lang-est/blob/main/../src/fst/phonology.twolc)</small>