


















* Sets for POS sub-categories





* Sets for Semantic tags





* Sets for Morphosyntactic properties






































































































































































* Sets for verbs


- V is all readings with a V tag in them, REAL-V should
be the ones without an N tag following the V.  
The REAL-V set thus awaits a fix to the preprocess V ... N bug.



* The set COPULAS is for predicative constructions







* NP sets defined according to their morphosyntactic features







* The PRE-NP-HEAD family of sets

These sets model noun phrases (NPs). The idea is to first define whatever can
occur in front of the head of the NP, and thereafter negate that with the
expression **WORD - premodifiers**.












The set **NOT-NPMOD** is used to find barriers between NPs.
Typical usage: ... (*1 N BARRIER NPT-NPMOD) ...
meaning: Scan to the first noun, ignoring anything that can be
part of the noun phrase of that noun (i.e., "scan to the next NP head")






* Miscellaneous sets





















* Border sets and their complements













* Syntactic sets




These were the set types.



## HABITIVE MAPPING


* **hab1** 


* **hab2** 

* **hab3** (<hab> @ADVL>) for hab-actor and hab-case; if leat to the right, and Nom to the right of leat. Lots of restrictions.



* **habNomLeft** 


* **hab4** 	



* **hab6** 

* **hab7** 

* **hab8** This is not HAB
* **hab5**  This is not HAB



* **habDain** (<hab> @ADVL>) for (Pron Dem Pl Loc) if leat followed by Nom to the right




* **habGen** (<hab> @<ADVL) hab for Gen; if Gen is located in the end of the sentence and Nom is sentence initial










































































* **spred<obj** (@SPRED<OBJ) for Acc; the object of an SPRPED. Not to be mistaken with OPRED. If SPRED is to the left, and copulas is to the left of it. Nom or Hab are found sentence initially.


* **Hab<spred** (@<SPRED) for Nom; if copulas, goallut or jápmit is FMAINV and habitive or human Loc is found to the left. OR: if Ill or @Pron< followed by HAB are found to the left.

* **Hab>Advlcase<spred** (<ext> @<SUBJ) for Nom; it allows adverbials with Ill/Loc/Com/Ess to be found inbetween HAB and <ext>.

* **Nom>Advlcase<spred** (<ext> @<SUBJ) for Nom; it allows adverbials with Ill/Loc/Com/Ess to be found inbetween Nom and <ext> @<SUBJ.

* **<spred** (<ext> @<SUBJ) for Nom; if copulas to the left, and some kind of adverb, N Loc, time related word or Po to the left of it. OR: if Ill or @Pron< to the left, followed by copulas and the before mentioned to the left of copulas. 

* **<spred** (<ext> @<SUBJ) for Nom, but not for Pers. To the left boahtit or heaŋgát as MAINV, and futher to the left is some kind of place related word, or time related word


* **<spredQst1** (<ext> @<SUBJ) for Nom in a typically question sentence; if A) Hab, some kind of place word, Po or Nom to the left, and Qst followed by copulas to the left. B) same as a, only the Qst-pcle is attached to copulas. C) Qst to the left, with copulas to its left, but not if two Nom:s are found somewhere to the right. D) copulas to the left, and BOS to the left. E) Loc or Ill to the left, and Loc or Hab to the left of this, Qst and copulas to the left. F) Num @>N to the left, Hab, some kind of place word, Po or Nom to the left, and Qst followed by copulas to the left. NOTE) for all these rules; human, Loc or Sem/Plc not allowed to the right.

* **<spredQst2** (@<SPRED) for Nom; in a typically question sentence; differs from <spredQst1 by not beeing as restricted to the right. Though you are not allowed to be Pers or human.

* **Nom<spredQst** (@<SPRED) for Nom; in a typically question sentence. Differs from <spredQst2 by letting Nom be found between SPRED and copulas



* **<spred** (@<SPRED) for A Nom or N Nom if; the subject Nom is on the same side of copulas as you: on the right side of copulas

* **<spredVeara** (@<SPRED) for veara + Nom; if genitive immediately to the right, and intransitive mainverb to the right of genitive

* **leftCop<spred** (@<SPRED) for Nom; if copulas is the main verb to the left, and there is no Ess found to the left of cop (note that Loc is allowed between target and cop). OR: if you are Coll or Sem/Group with copulas to your left. 

* **<spredLocEXPERIMENT** (@<SPRED) for material Loc; if you are to the right of copulas, and the Nom to the left of copulas is not a hab-actor


* **NumTime** (@<SPRED) for A Nom

* **<spredSg** (@<SPRED) for Sg Nom	

* **<spredPg** (@<SPRED) for Pl Nom	

* **<spred** (@<SPRED) for Nom; if copulas to the left, and Nom or sentence boundary to the left of copulas. First one to the right is EOS.

* **<spred** (@<SPRED) for N Ess

* **spredEss>** (@SPRED>) for N Ess; if copulas to the right of you, and if an NP with nom-case first one to your left.

* **HABSpredSg>** (@SPRED>) for Nom; if habitive first one to the left, followed by copulas.

* **GalleSpred>** (@SPRED>) for Num Nom; if sentence initial

* **spredSgMII>** (@SPRED>)

* **r492>** (@SPRED>) for Interr Gen; consisting only of negations. You are not allowed to be MII. You are not allowed to have an adjective or noun to yor right. You are not allowed to have a verb to your right; the exception beeing an aux.



* **AdjSpredSg>** (@SPRED>) for A Sg Nom; if copulas to the right, but not if A or @<SPRED are found to the right of copulas

* **SpredSg>Hab** (@SPRED>) for Nom; if you are sentence initial, copulas is located to the right, and there is a habitive to the right of copulas



* **Spred>SubjInf** (@SPRED>) for Nom; if copulas to the right, and the subject of copulas is an Inf to the right

* **spredCoord** (@<SPRED) coordination for Nom; only if there already is a SPRED to the left of CNP. Not if there is some kind of comparison involved.






* **subj>Sgnr1** (@SUBJ>) for Nom Sg, including Indef Nom if; VFIN + Sg3 or Pl3 to the right (VFIN not allowed to the left) 

* **subj>Du** (@SUBJ>) for dual nominatives, including Coll Nom. VFIN + Du3 to the right. 
* **subj>Pl** (@SUBJ>) for plural nominatives, including Coll and Sem/Group. VFIN + Pl3 to the right.

* **subj>Pl** (@SUBJ>) for plural nominatives


* **subj>Sgnr2** (@SUBJ>) for Nom Sg; if VFIN + Sg3 to the right.

* **<subjSg** (@<SUBJ) for Nom Sg; if VFIN Sg3 or Du2 to the left (no HAB allowed to the left).




















* **f<advl** (@-F<ADVL) for infinite adverbials

* **f<advl** (@-F<ADVL) for infinite adverbials



* **s-boundary=advl>** (@ADVL>) for ADVL that resemble s-booundaries. Mainverb to the right.




* **-fobj>** (@-FOBJ>) for Acc 

* **-fobj>** (@-FOBJ>) for Acc




* **advl>mainV** (@ADVL>) if; finite mainverb not found to the left, but the finite mainverb is found to the right.


* **<advl** (@<ADVL) if; finite mainverb found to the left. Not if a comma is found immediately to the left and a finite mainverb is located somewhere to the right of this comma.




* **<advlPoPr** (@<ADVL) if mainverb to the left.
* **advlPoPr>** (@<ADVL) if mainverb to the right.



* **advlEss>** (@<ADVL) for weather and time Ess, if FMAINV to the left.






* **advl>inbetween** (@ADVL>) for Adv; if inbetween two sentenceboundaries where no mainverb is present.

* **comma<advlEOS** (@<ADVL) if; comma found to the left and the finite mainverb to the left of comma. To the right is the end of the sentence.



* **advlBOS>** (@ADVL>) if; you are N Ill and found sentnece initially. First one to your right is a clause.


* **<advlPoEOS** (@<ADVL) for Po; if you are found at the very end of a sentence. A mainverb is needed to the right though.



* **cleanupILL<advl** (@<ADVL) for N Ill if; there are no boundarysymbols to your left, if you arent already @N< OR @APP-N<, and no mainverb is to yor left.











* **<opredAAcc** (@<OPRED) for A Acc; if an other accusative to the left, and a transtive verb to the left of it. OR: if a transitive verb to the left, and an accusative to the left of it.


### sma object









* **<advlEss** (@<ADVL) for ESS-ADVL if; FMAINV to the left
* **<spredEss** (@<SPRED) for N Ess if; FMAINV to the left is intransitive or bargat





## SUBJ MAPPING - leftovers

## OBJ MAPPING - leftovers


## HNOUN MAPPING
















* * *
<small>This (part of) documentation was generated from [../src/cg3/functions.cg3](http://github.com/giellalt/lang-est/blob/main/../src/cg3/functions.cg3)</small>## Phonology



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

* **%{s%}:s** s of sid: pl par ending siilisid 
* **%{s%}:0**         : pl par ending siile;  
* **%{i%}:i** i of sid: pl par ending siilisid
* **%{i%}:0**         : pl par ending siile
* **%{d%}:d** d of sid: pl par ending siilisid
* **%{d%}:0**         : pl par ending siile


* **%{ss%}:s** s of -sse jõesse; 
* **%{ss%}:0**            jõkke;
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
<small>This (part of) documentation was generated from [../src/fst/phonology.twolc](http://github.com/giellalt/lang-est/blob/main/../src/fst/phonology.twolc)</small>Acronyms








* * *
<small>This (part of) documentation was generated from [../src/fst/stems/acronyms.lexc](http://github.com/giellalt/lang-est/blob/main/../src/fst/stems/acronyms.lexc)</small>








































































:%. # ;
: ABBRDOT ;






















































































flag diacritics can be used for remembering the case 















flag diacritics are used for remembering the case for compounding; 
not all the cases must be distinguished












































* **LEXICON DOT   ** - number ending with a dot may be ordinal, or ordinal/cardinal followed by a full stop










* * *
<small>This (part of) documentation was generated from [../src/fst/affixes/regular_declinations.lexc](http://github.com/giellalt/lang-est/blob/main/../src/fst/affixes/regular_declinations.lexc)</small>inflectional types and analogue rules for nouns, adjectives and other declinables
VVS stands for Ü. Viks "Väike vormisõnastik" for reference purposes


































































































































































* * *
<small>This (part of) documentation was generated from [../src/fst/affixes/exceptional_declinations.lexc](http://github.com/giellalt/lang-est/blob/main/../src/fst/affixes/exceptional_declinations.lexc)</small>
# Verb inflection























































LEXICON SAAMA  is a lexicon for saama-type words. ! VVS 37   saama, jääma































































































* * *
<small>This (part of) documentation was generated from [../src/fst/affixes/verbs.lexc](http://github.com/giellalt/lang-est/blob/main/../src/fst/affixes/verbs.lexc)</small>stressing affix gi/ki can be appended to almost any word form

liide gi/ki
this ensures that downcasing derivation (helveetslane) works



*hfstol: examples:*
* *siilgi:* `siil+N+Sg+Nom+Foc/gi`
* *kottki:* `kott+N+Sg+Nom+Foc/gi`


* * *
<small>This (part of) documentation was generated from [../src/fst/affixes/gi.lexc](http://github.com/giellalt/lang-est/blob/main/../src/fst/affixes/gi.lexc)</small>
# Morphology

## Multicharacter symbols


### Sõnaliik / Part of speech

* `+N `: nimisõna		/ substantive		
* `+A `: omadussõna		/ adjective		
* `+Num `: arvsõna		/ numeral
* `+Pron `: asesõna		/ pronoun		
* `+V `: tegusõna 		/ verb			
* `+Adv `: määrsõna		/ adverb		
* `+Interj `: hüüdsõna		/ interjection		
* `+CC `: rinnastav sidesõna		/ co-ordinating conjunction
* `+CS `: alistav sidesõna		/ subordinating conjunction		
* `+Adp `: kaassõna	/ adposition, i.e. pre/postposition	
* `+Pref `: prefiks         / prefix				

Genitiivatribuut pole eraldi kategooria / No special tag for genitive attribute : *angoora+N+Sg+Gen*	

### Alamkategooriad / Sub-pos categories

* `+Prop `: pärisnimi	/ proper name		
* `+Card `: põhiarvsõna	/ cardinal numeral
* `+Ord `: järgarvsõna	/ ordinal numeral

### Võrdlusastmed / Comparation

* `+Comp `: komparatiiv	/ comparative
* `+Superl `: superlatiiv	/ superlative


*hfstol: examples:*
* *asi:* `asi+N+Sg+Nom` (Eng. # thing)
* *Jaan:* `Jaan+N+Prop+Sg+Nom`
* *asjalik:* `asjalik+A+Sg+Nom` (Eng. # serious)
* *parem:* `parem+A+Comp+Sg+Nom` (Eng. # better)
* *parim:* `parim+A+Superl+Sg+Nom` (Eng. # best)
* *kaks:* `kaks+Num+Card+Sg+Nom` (Eng. # two)
* *teine:* `teine+Num+Ord+Sg+Nom` (Eng. # second)
* *see:* `see+Pron+Sg+Nom` (Eng. # that)
* *asjastama:* `asjastama+V+Pers+Sup+Ill` (Eng. # objectify)
* *asjatult:* `asjatult+Adv` (Eng. # in vain)
* *hei:* `hei+Interj` (Eng. # hi)
* *ja:* `ja+CC` (Eng. # and)
* *et:* `et+CS` (Eng. # that)
* *kaudu:* `kaudu+Adp` (Eng. # via)
* *eba-:* `eba+Pref` (Eng. # un-, non-)

### Sõnamuutus / Inflection

### Käändsõna             / Noun

### Arv 			/ number

* `+Sg `: ainsus	/ singular
* `+Pl `: mitmus	/ plural

### Kääne	/ Case

* `+Nom `: nimetav			/ nominative	
* *part:* `part+N+Sg+Nom`
* *maja:* `maja+N+Sg+Nom`
* *pardid:* `part+N+Pl+Nom`
* *majad:* `maja+N+Pl+Nom`

* `+Gen `: omastav 			/ genitive	
* *pardi:* `part+N+Sg+Gen`
* *maja:* `maja+N+Sg+Gen`
* *partide:* `part+N+Pl+Gen`
* *majade:* `maja+N+Pl+Gen`

* `+Par `: osastav			/ partitive	
* *parti:* `part+N+Sg+Par`
* *maja:* `maja+N+Sg+Par`
* *parte:* `part+N+Pl+Par`
* *partisid:* `part+N+Pl+Par+Usage/Rare`
* *maju:* `maja+N+Pl+Par`
* *majasid:* `maja+N+Pl+Par+Usage/Rare`

* `+Ill `: sisseütlev			/ illative	
* *parti:* `part+N+Sg+Ill`
* *majja:* `maja+N+Sg+Ill`
* *pardisse:* `part+N+Sg+Ill+Usage/Hyp`
* *majasse:* `maja+N+Sg+Ill+Usage/Rare`
* *partidesse:* `part+N+Pl+Ill`
* *majadesse:* `maja+N+Pl+Ill`
Lühike sisseütlev e suunduv pole eraldi kääne (*parti*, *majja*) / Short illative or additive is not a separate case 

* `+Ine `: seesütlev			/ inessive	
* *pardis:* `part+N+Sg+Ine`
* *majas:* `maja+N+Sg+Ine`
* *partides:* `part+N+Pl+Ine`
* *majades:* `maja+N+Pl+Ine`

* `+Ela `: seestütlev			/ elative	
* *pardist:* `part+N+Sg+Ela`
* *majast:* `maja+N+Sg+Ela`
* *partidest:* `part+N+Pl+Ela`
* *majadest:* `maja+N+Pl+Ela`

* `+All `: alaleütlev			/ allative	
* *pardile:* `part+N+Sg+All`
* *majale:* `maja+N+Sg+All`
* *partidele:* `part+N+Pl+All`
* *majadele:* `maja+N+Pl+All`

* `+Ade `: alalütlev			/ adessive	
* *pardil:* `part+N+Sg+Ade`
* *majal:* `maja+N+Sg+Ade`
* *partidel:* `part+N+Pl+Ade`
* *majadel:* `maja+N+Pl+Ade`

* `+Abl `: alaltütlev			/ ablative	
* *pardilt:* `part+N+Sg+Abl`
* *majalt:* `maja+N+Sg+Abl`
* *partidelt:* `part+N+Pl+Abl`
* *majadelt:* `maja+N+Pl+Abl`

* `+Tra `: saav				/ translative	
* *pardiks:* `part+N+Sg+Tra`
* *majaks:* `maja+N+Sg+Tra`
* *partideks:* `part+N+Pl+Tra`
* *majadeks:* `maja+N+Pl+Tra`

* `+Trm `: rajav				/ terminative	
* *pardini:* `part+N+Sg+Trm`
* *majani:* `maja+N+Sg+Trm`
* *partideni:* `part+N+Pl+Trm`
* *majadeni:* `maja+N+Pl+Trm`

* `+Ess `: olev				/ essive	
* *pardina:* `part+N+Sg+Ess`
* *majana:* `maja+N+Sg+Ess`
* *partidena:* `part+N+Pl+Ess`
* *majadena:* `maja+N+Pl+Ess`

* `+Abe `: ilmaütlev			/ abessive	
* *pardita:* `part+N+Sg+Abe`
* *majata:* `maja+N+Sg+Abe`
* *partideta:* `part+N+Pl+Abe`
* *majadeta:* `maja+N+Pl+Abe`

* `+Com `: kaasaütlev			/ comitative	
* *pardiga:* `part+N+Sg+Com`
* *majaga:* `maja+N+Sg+Com`
* *partidega:* `part+N+Pl+Com`
* *majadega:* `maja+N+Pl+Com`

### Verb

Verbil on finiitsed (pöördelised) ja infiniitsed (nn käänduvad) vormid. 
Pöördelistel vormidel on kategooriad: 
tegumood, aeg, kõneviis, isik, arv, kõneliik
(tegumood ja aeg on ka mõnedel infiniitsetel vormidel).

Verbs have finite (conjugable) and infinite ("declinable") forms.
The finite forms have categories: 
voice, tense, mood, person, number, negation
(some infinite forms also have voice and tense).

### Pöördelised vormid / Conjugable forms

### Tegumood		/ Voice

* `+Impers `: umbisikuline	/ impersonal
* `+Pers `: isikuline	/ personal

### Aeg			/ Tense

* `+Prs `: olevik	/ present
* `+Prt `: minevik	/ past (i.e. not present)

Lihtminevik = minevik / Past imperfect = past

Täisminevik / Past perfect: *olema* (pres) + *nud/tud/dud* (*olen teinud*)

Enneminevik / Past pluperfect: *olema* (impf) + *nud/tud/dud* (*olin teinud*)

### Kõneviis		/ Mood

* `+Ind `: kindel	/ indicative
* `+Cond `: tingiv	/ conditional
* `+Imprt `: käskiv	/ imperative / jussive
* `+Quot `: kaudne	/ quotative

### Pööre ja arv	/ Person and number

* `+Sg1 `: ainsuse 1. pööre	/ singular 1st person
* `+Sg2 `: ainsuse 2. pööre	/ singular 2nd person
* `+Sg3 `: ainsuse 3. pööre	/ singular 3rd person
* `+Pl1 `: mitmuse 1. pööre	/ plural   1st person
* `+Pl2 `: mitmuse 2. pööre	/ plural   2nd person
* `+Pl3 `: mitmuse 3. pööre	/ plural   3rd person

### Kõneliik		/ Polarity

* `+Aff `: jaatav kõne	/ affirmative
* `+Neg `: eitav kõne	/ negative

### Infiniitsed (nn käänduvad) verbivormid / Infinite ("declinable") verb forms

* `+Sup `: ma-tegevusnimi / supine (ma-infinitive)

* `+Inf `: da-tegevusnimi / infinitive (da-infinitive)a

* `+Ger `: des-vorm	 / gerund (des-form)	

* `+Prc `: kesksõna	 / participle


### Kategooriate võimalikud kombinatsioonid / Possible combinations of categories

allikas / source :
[Heiki-Jaan Kaalep. Eesti verbi vormistik. Keel ja kirjandus 1/2015 lk 1-15.](http://kjk.eki.ee/ee/issues/2015/1/582) 

The categories are given in the order in which the allomorphs (if they can be
distinguished) that represent them are attached to the word stem (note that the
treatment of allomorphs is sloppy here). The justification is that the
categories are not equal, but form an hierarchy: those closer to the word end 
tend to be more optional, more often non-specified.   

1. **voice:** personal vs. impersonal (0-morph vs. *t/d(aiu)*), eg. *elaks* vs.
*elataks*, *elav* vs. *elatav*
1. **tense:** present vs. past (0-morph vs. *s/si/nu*), e.g. *elan* vs. *elasin*,
*elaks* vs. *elanuks*
1. **mood:** indicative vs. conditional vs imperative vs quotative
(0-morph vs. *ks* vs. *k/g(ue)* vs. *vat*)
1. **person+number:** notice that in personal present and past conditional, imperative 
and quotative moods one form is underspecified for person+number
1. **negation:** affirmative vs. negative. It manifests itself via
lexical means: it is either present in an exceptional wordform (some forms of
*olema*) or gets adhered to a form, normally used in affirmative,
from an immediately preceding word *ei*, *ega* or *ära* (e.g. *ei elaks*).
The only case when negation has a dedicated form of its own is impersonal
present indicative negative (e.g. *ei elata*).  

The forms of negative words *pole* and *ära* are included in order to capture really all 
the combinations; 
also note that for *olema*, there are some constellations of categories that are the same for
a wordform beginning with *ole-* and *pole-* 

### ---- Personal finite forms ----

* *elan:* `elama+V+Pers+Prs+Ind+Sg1+Aff`
* *elad:* `elama+V+Pers+Prs+Ind+Sg2+Aff`
* *elab:* `elama+V+Pers+Prs+Ind+Sg3+Aff`
* *elame:* `elama+V+Pers+Prs+Ind+Pl1+Aff`
* *elate:* `elama+V+Pers+Prs+Ind+Pl2+Aff`
* *elavad:* `elama+V+Pers+Prs+Ind+Pl3+Aff`

\\
* *ela:* `elama+V+Pers+Prs+Ind+Neg`
* *pole:* `olema+V+Pers+Prs+Ind+Neg`
* *ole:* `olema+V+Pers+Prs+Ind+Neg`

NB! *ei ole* = *pole*


* *elaksin:* `elama+V+Pers+Prs+Cond+Sg1+Aff`
* *elaksid:* `elama+V+Pers+Prs+Cond+Sg2+Aff`
* *elaks:* `elama+V+Pers+Prs+Cond`
* *elaksime:* `elama+V+Pers+Prs+Cond+Pl1+Aff`
* *elaksite:* `elama+V+Pers+Prs+Cond+Pl2+Aff`
* *elaksid:* `elama+V+Pers+Prs+Cond+Pl3+Aff`

\\
* *poleksin:* `olema+V+Pers+Prs+Cond+Sg1+Neg`
* *poleksid:* `olema+V+Pers+Prs+Cond+Sg2+Neg`
* *poleks:* `olema+V+Pers+Prs+Cond+Neg`
* *poleksime:* `olema+V+Pers+Prs+Cond+Pl1+Neg`
* *poleksite:* `olema+V+Pers+Prs+Cond+Pl2+Neg`
* *poleksid:* `olema+V+Pers+Prs+Cond+Pl3+Neg`

\\
* *ela:* `elama+V+Pers+Prs+Imprt+Sg2`
* *elagu:* `elama+V+Pers+Prs+Imprt`
* *elagem:* `elama+V+Pers+Prs+Imprt+Pl1`
* *elage:* `elama+V+Pers+Prs+Imprt+Pl2`

\\
* *ära:* `ära+V+Pers+Prs+Imprt+Sg2+Neg`
* *ärgu:* `ära+V+Pers+Prs+Imprt+Neg`
* *ärgem:* `ära+V+Pers+Prs+Imprt+Pl1+Neg`
* *ärme:* `ära+V+Pers+Prs+Imprt+Pl1+Neg+Usage/Rare`
* *ärge:* `ära+V+Pers+Prs+Imprt+Pl2+Neg`

\\
* *elavat:* `elama+V+Pers+Prs+Quot`
* *polevat:* `olema+V+Pers+Prs+Quot+Neg`

\\ 
* *elasin:* `elama+V+Pers+Prt+Ind+Sg1+Aff`
* *elasid:* `elama+V+Pers+Prt+Ind+Sg2+Aff`
* *elas:* `elama+V+Pers+Prt+Ind+Sg3+Aff`
* *elasime:* `elama+V+Pers+Prt+Ind+Pl1+Aff`
* *elasite:* `elama+V+Pers+Prt+Ind+Pl2+Aff`
* *elasid:* `elama+V+Pers+Prt+Ind+Pl3+Aff`

\\
* *elanud:* `elama+V+Pers+Prt+Ind+Neg`
* *polnud:* `olema+V+Pers+Prt+Ind+Neg`
* *olnud:* `olema+V+Pers+Prt+Ind+Neg`

NB! *ei olnud* = *polnud*


* *elanuksin:* `elama+V+Pers+Prt+Cond+Sg1+Aff`
* *elanuksid:* `elama+V+Pers+Prt+Cond+Sg2+Aff`
* *elanuks:* `elama+V+Pers+Prt+Cond`
* *elanuksime:* `elama+V+Pers+Prt+Cond+Pl1+Aff`
* *elanuksite:* `elama+V+Pers+Prt+Cond+Pl2+Aff`
* *elanuksid:* `elama+V+Pers+Prt+Cond+Pl3+Aff`

\\
* *polnuksin:* `olema+V+Pers+Prt+Cond+Sg1+Neg`
* *polnuksid:* `olema+V+Pers+Prt+Cond+Sg2+Neg`
* *polnuks:* `olema+V+Pers+Prt+Cond+Neg`
* *polnuksime:* `olema+V+Pers+Prt+Cond+Pl1+Neg`
* *polnuksite:* `olema+V+Pers+Prt+Cond+Pl2+Neg`
* *polnuksid:* `olema+V+Pers+Prt+Cond+Pl3+Neg`

\\
elanud: elama+V+Pers+Prt+Imprt: 1.11.2016 ei genereerita ega tunta ära / not recognized nor generated as of Nov 1, 2016
* *ärnud:* `ära+V+Pers+Prt+Imprt+Neg`

\\
* *elanuvat:* `elama+V+Pers+Prt+Quot`
* *polnuvat:* `olema+V+Pers+Prt+Quot+Neg`

### ---- Personal infinite forms ----

* *elav:* `elama+V+Pers+Prs+Prc`
* *elanud:* `elama+V+Pers+Prt+Prc`

(on, oli, ...) + V+Pers+Prt+Prc = some analytical personal form 

* *elama:* `elama+V+Pers+Sup+Ill`
* *elamas:* `elama+V+Pers+Sup+Ine`
* *elamast:* `elama+V+Pers+Sup+Ela`
* *elamaks:* `elama+V+Pers+Sup+Tra`
* *elamata:* `elama+V+Pers+Sup+Abe`

### ---- Impersonal finite forms ----

* *elatakse:* `elama+V+Impers+Prs+Ind+Aff`
* *elata:* `elama+V+Impers+Prs+Ind+Neg`

* *polda:* `olema+V+Impers+Prs+Ind+Neg`
* *olda:* `olema+V+Impers+Prs+Ind+Neg`

NB! ei olda = polda

* *elataks:* `elama+V+Impers+Prs+Cond`
* *poldaks:* `olema+V+Impers+Prs+Cond+Neg`

\\
* *elatagu:* `elama+V+Impers+Prs+Imprt`
* *ärdagu:* `ära+V+Impers+Prs+Imprt+Neg`

\\
* *elatavat:* `elama+V+Impers+Prs+Quot`
* *poldavat:* `olema+V+Impers+Prs+Quot+Neg`

\\
* *elati:* `elama+V+Impers+Prt+Ind+Aff`
* *elatud:* `elama+V+Impers+Prt+Ind+Neg`

* *poldud:* `olema+V+Impers+Prt+Ind+Neg`
* *oldud:* `olema+V+Impers+Prt+Ind+Neg`

NB! ei oldud = poldud

* *elatuks:* `elama+V+Impers+Prt+Cond`
* *polduks:* `olema+V+Impers+Prt+Cond+Neg`

### ---- Impersonal infinite forms ----

* *elatav:* `elama+V+Impers+Prs+Prc`
* *elatud:* `elama+V+Impers+Prt+Prc`

(*on*, *oli*, ...) + V+Impers+Prt+Prc = some analytical personal form 


* *elatama:* `elama+V+Impers+Sup`

### ---- Infinite forms with no voice category ----

* *elada:* `elama+V+Inf`
* *elades:* `elama+V+Ger`

### Exceptional cases:

personal present (Prs not implemented????), 3 words:  *kuulukse*, *tunnukse*, *näikse*

* *kuulukse:* `kuulukse+V`

### Negation verb 

* *ei:* `ei+V+Neg`

Analytical forms (*olen elanud*, *olin elanud*, *oleksin elanud*, *ei olnud elanud*,
*ei olnuks elanud* etc) are not treated here...

### Partikkel -gi/-ki / Particle -gi/-ki

* `+Foc/gi `
* *pulkki:* `pulk+N+Sg+Nom+Foc/gi`

###  Kasutust (sagedust jm) iseloomustavad märgendid / Usage-related tags

* `+Emph `: long inflectional forms of personal pronouns *mina*, *sina*, *tema*, *meie*, *teie*, *nemad*
* *temale:* `tema+Pron+Sg+All+Emph`

### Paralleelvormide erinevat kasutussagedust iseloomustavad / Usage info for parallel forms (either correct according to the norm, or incorrect)

* `+Usage/Rare `: norm, but rare 
* *puusid:* `puu+N+Pl+Par+Usage/Rare`

* `+Usage/Hyp `:  norm, but so rare that norm is probaly wrong 
* *tiivasse:* `tiib+N+Sg+Ill+Usage/Hyp`

* `+Usage/NotNorm `:  not norm, but sometimes used 
* *pöidlates:* `pöial+N+Pl+Ine+Usage/NotNorm`

* `+Usage/CommonNotNorm `:  not norm, and used more than norm 
* *kööment:* `köömen+N+Sg+Par+Usage/CommonNotNorm`

Oletatav analüüs / Guessed analysis
* `+Guess `: guessed analysis

### Tuletus / Derivation

### Eesliited on harvad, aga ikkagi ... / Prefixes are seldom used, but still...

* `+Pref `
* *taasriigistama:* `taas+Pref#riigistama+V+Pers+Sup+Ill`
* *reinvesteerima:* `re+Pref#investeerima+V+Pers+Sup+Ill`

### Järelliited / Suffixes

V --> N

* `+Der/mine `
* *jahumine:* `jahuma+V+Der/mine+N+Sg+Nom`

* `+Der/ja `
* *jahuja:* `jahuma+V+Der/ja+N+Sg+Nom`

* `+Der/nu `
* *elanu:* `elama+V+Der/nu+N+Sg+Nom`

* `+Der/mus `
* *küllastumus:* `küllastuma+V+Der/mus+N+Sg+Nom`

* `+Der/ng `
* *devalveering:* `devalveerima+V+Der/ng+N+Sg+Nom`

* `+Der/is `
* *arveldis:* `arveldama+V+Der/is+N+Sg+Nom`

V --> A

* `+Der/v `
* *jahuv:* `jahuma+V+Der/v+A+Sg+Nom`

* `+Der/tav `
* *öeldav:* `ütlema+V+Der/tav+A+Sg+Nom`

* `+Der/nud `
* *elanud:* `elama+V+Der/nud+A+Sg+Nom`

* `+Der/mata `
* *elamata:* `elama+V+Der/mata+A`

* `+Der/matu `
* *segamatu:* `segama+V+Der/matu+A+Sg+Nom`

* `+Der/tamatu `
* *mõeldamatu:* `mõtlema+V+Der/tamatu+A+Sg+Nom`

* `+Der/tu `
* *elatu:* `elama+V+Der/tu+A+Sg+Nom`

* `+Der/tud `
* *elatud:* `elama+V+Der/tud+A`

N --> A

* `+Der/lik `
* *kotkalik:* `kotkas+N+Der/lik+A+Sg+Nom`

* `+Der/line `
* *põõsaline:* `põõsas+N+Der/line+A+Sg+Nom`
* *onomastiline:* `onomastika+N+Der/line+A+Sg+Nom`
* *apooriline:* `apooria+N+Der/line+A+Sg+Nom`

* `+Der/ne `

A --> Adv

* `+Der/lt `
* *roosalt:* `roosa+A+Der/lt+Adv`

* `+Der/sti `
* *valusasti:* `valus+A+Der/sti+Adv`

* `+Der/ini `
* *paremini:* `parem+A+Comp+Der/ini+Adv`

A --> A

* `+Der/m `
* *valusam:* `valus+A+Der/m+A+Comp+Sg+Nom`

* `+Der/im `
* *valusaim:* `valus+A+Der/im+A+Superl+Sg+Nom`

N --> N

* `+Der/nna `
* *õmblejanna:* `õmbleja+N+Der/nna+N+Sg+Nom`

* `+Der/kond `
* *vaatajaskond:* `vaatama+V+Der/ja+N+Der/kond+N+Sg+Nom`

* `+Der/ist `
* *kapitalist:* `kapitalism+N+Der/ist+N+Sg+Nom`

A --> N, V --> N

* `+Der/us `
* *porisus:* `porine+A+Der/us+N+Sg+Nom`
* *õpetus:* `õpetama+V+Der/us+N+Sg+Nom`

N --> Adv

* `+Der/ti `
* *lauati:* `laud+N+Der/ti+Adv`

* `+Der/lane `:  helveetslane:Helveetsia+N+Prop+Der/lane+N+Sg+Nom
* *firenzelane:* `Firenze+N+Prop+Der/lane+N+Sg+Nom`
* *helveetslane:* `Helveetsia+N+Prop+Der/lane+N+Sg+Nom`

N --> N, A --> A

* `+Dim/ke `:  diminutive 
* *põõsake:* `põõsas+N+Dim/ke+Sg+Nom`

* `+Der/minus `:  shortening stem 
* *vaatamis-:* `vaatamine+N+Der/minus`
* *astraal-:* `astraalne+A+Der/minus`

Num --> N

* `+Der/kas `
* *kolmekas:* `kolm+Num+Card+Der/kas+N+Sg+Nom`


### Muud / Other tags
Copied from Sami root.lexc

### Symbols that need to be escaped on the lower side (towards twolc):

* »
* «
* > (escaped with square brackets, to avoid collision with > as morpheme boundary)
* < (escaped with square brackets, to avoid collision with < as morpheme boundary)


* '  7 is the real apostrophe ?? 

* `+Use/Circ `: for arabic and roman numerals; 
* `+Use/PMatch `: for tokenisation with pmatch
* `+Use/-PMatch `: for tokenisation with pmatch

* `+ABBR `: Lühend / Abbreviation
* +Symbol = independent symbols in the text stream, like £, €, ©
* `+ACR `: Suurtähtlühend / Acronym
* `+CLB `: Osalause piir (punkt, koma) / Clause border (full stop, comma..)
* `+PUNCT `: Kirjavahemärk / Punctuation
* `+LEFT `: Kirjavahemärgi asetus / Punctuation orientation
* `+RIGHT `: Kirjavahemärgi asetus / Punctuation orientation
* `+Err/Orth `: Ortograafiaviga (genereeritud failide sümbol)/ orthography error

## Flag diacritics
Use the following flag diacritics to control downcasing of derived proper
nouns (e.g. Finnish Pariisi -> pariisilainen). See e.g. North Sámi for how to use
these flags. There exists a ready-made regex that will do the actual down-casing
given the proper use of these flags.
|  @U.Cap.Obl@ | Allowing downcasing of derived names: deatnulasj.
|  @U.Cap.Opt@ | Allowing downcasing of derived names: deatnulasj.

These are used for limiting the number of components in a compound word
(the compound transducer is cyclic, but in reality there is a limit to the length of words)
|  @D.Part@ | No part of a compound should have been encountered yet
|  @P.Part.One@ | Indicate that this could be the first part of a compound
|  @R.Part.One@ | Require that the first part has been encountered; if a lemma has it, it means that the lemma cannot be part2 or part3 of a compound
|  @D.Part.One@ | Require that the first part has NOT been encountered 
|  @P.Part.Two@ | Indicate that this could be the second part of a compound
|  @R.Part.Two@ | Require that the second part has been encountered
|  @P.Part.Three@ | Indicate that this could be the third part of a compound
|  @P.Part.Bad@ | Indicate that this cannot be a part of a compound

POS is used for filtering derivations and compounds
|  @R.POS.NumCardCompound@ | compound numeral (viis+sada - five hundred)

Case is used for filtering derivations and compounds

Remember there has been some derivation from A or N; for filtering compounds
derivation from V is called paradigmatic and does not result in Der; just a new POS... 

Remember the stem type; for filtering compounds 


A special condition that is used for filtering derivations and compounds


Tokeniser 

Guesser






































Legitimate strings that are not words: numbers, acronyms, ...




## Lexicons  

* `LEXICON Root ` is the starting point of everything

This is actually a loop, formed after applying Kleene star 
concatenation on the simple word transducer with itself.
When looping, it remembers which paths it has taken in every loop. 
For remembering it sets up flags on the path:
1. flag the first 3 loops (thus forbidding any more loops)
2. in every loop, flag the POS and inflection, to be used in the following loop
Different paths may result in the same output string, 
e.g. mootoriõlilik = (mootori+õli)+lik and (mootori)+(õli+lik)

strictly simplex word; cannot be a part of a compound
a simplex word, or the first part of a compound


* `@D.Part@@P.Part.Two@@P.NeedPartThree.On@@P.POS.Num@ CardinalNumbersInCompBeg ;   ` 5-autone etc



strictly simplex words; cannot be a part of a compound

* `  Abbreviations ;             `
* `  Adpositions ;             `
* `  Conjunctions ;            `
* `  NoninflectingVerbs ;      `
* `  CardinalNumbersSingle ;      `
* `  OrdinalNumbers ;          `
* `  Punctuation ;          `
* `  Symbols     ;          `

* `LEXICON First     ` a simplex word or the first part of a compound 

* `  @P.POS.A@ Adjectives ;              `
* `  @P.POS.A@ NoninflectingAdjectives ; `
* `  @P.POS.AComp@ ComparativeAdjectives ;   `
* `  @P.POS.AComp@ SuperlativeAdjectives ;   `  ! Superl = Comp in compounding
* `  @P.POS.Adv@ Adverbs ;                 `
* `  @P.POS.N@ Nouns ;                   `
* `  @P.POS.NProp@@U.Cap.Obl@ ProperNouns ; `  ! always uppercase
* `  @P.POS.NProp@@U.Cap.Opt@ ProperNouns ; `  ! downcased for derivations
* `  @P.POS.IntNum@ IntegerNumerals ;                `
* `  @P.POS.NonIntNum@ NonIntegerNumerals ;                `
* `  @P.POS.NumOrd@ OrdinalNumerals ;                `
* `  @P.POS.Pron@ Pronouns ;                `
* `  @P.POS.V@ Verbs ;                   `
* `  @P.POS.Interj@ Interjections ;           `
* `  @P.POS.GA@@P.Case.Gen@ GenitiveAttributes ;      `
* `  @P.POS.Pref@ Prefixes ;                `
* `  @P.POS.ACR@ Acronyms ;          `
* `  @P.POS.ACRMinus@ Acrominus ;          `


* `LEXICON Latter ` the latter part of a compound









































* `  @P.POS.A@@C.Der@@C.Stem@ Adjectives ;              `


* `  @P.POS.A@@C.Der@@C.Stem@ Adjectives_ne ;              `
järguline	järk+N+Der/line+A  redellik redel+N+Der/lik+A     NOT -autone


* `  @P.POS.A@@C.Der@@C.Stem@ Adjectives_v ;              `


* `  @P.POS.A@@C.Der@@C.Stem@ PlainAdjectives ;              `


* `  @P.POS.AComp@@C.Der@@C.Stem@ ComparativeAdjectives ;              `
* `  @P.POS.AComp@@C.Der@@C.Stem@ SuperlativeAdjectives ;              `







* `  @P.Case.Gen@ LatterVerb ;                   `


* `  @P.POS.V@@C.Der@@P.Stem.Verb@ Verbs ;                   `




* * *
<small>This (part of) documentation was generated from [../src/fst/root.lexc](http://github.com/giellalt/lang-est/blob/main/../src/fst/root.lexc)</small>









:kümmend+Use/NG  LOHKAIM ;  Analyzed but not generated








































% komma% :,      Root ;
% tjuohkkis% :%. Root ;
% kolon% :%:     Root ;
% sárggis% :%-   Root ; 
% násti% :%*     Root ; 





* * *
<small>This (part of) documentation was generated from [../src/transcriptions/transcriptor-numbers-digit2text.lexc](http://github.com/giellalt/lang-est/blob/main/../src/transcriptions/transcriptor-numbers-digit2text.lexc)</small>


We describe here how abbreviations are in Estonian are read out, e.g.
for text-to-speech systems.

For example:

* s.:syntynyt # ;  
* os.:omaa% sukua # ;  
* v.:vuosi # ;  
* v.:vuonna # ;  
* esim.:esimerkki # ; 
* esim.:esimerkiksi # ; 


* * *
<small>This (part of) documentation was generated from [../src/transcriptions/transcriptor-abbrevs2text.lexc](http://github.com/giellalt/lang-est/blob/main/../src/transcriptions/transcriptor-abbrevs2text.lexc)</small>
ESTONIAN  GRAMMAR   CHECKER









# DELIMITERS


# TAGS AND SETS



## Tags


This section lists all the tags inherited from the fst, and used as tags
in the syntactic analysis. The next section, **Sets**, contains sets defined
on the basis of the tags listed here, those set names are not visible in the output.




### Beginning and end of sentence
BOS
EOS



### Parts of speech tags

N
A
Adv
V
Pron
CS
CC
CC-CS
Po
Pr
Pcle
Num
Interj
ABBR
ACR
CLB
LEFT
RIGHT
WEB
QMARK
PPUNCT
PUNCT

COMMA
¶



### Tags for POS sub-categories

Pers
Dem
Interr
Indef
Recipr
Refl
Rel
Coll
NomAg
Prop
Allegro
Arab
Romertall


### Tags for morphosyntactic properties

Nom
Gen
Ill
Com
Ess
Ess

Sg
Du
Pl
Cmp/SplitR
Cmp/SgNom Cmp/SgGen
Cmp/SgGen

Comp
Superl
Attr
Ord
Qst
IV
TV
Prt
Prs
Ind
Pot
Cond
Imprt

Sg1
Sg2
Sg3
Pl1
Pl2
Pl3

Inf
ConNeg
Neg
PrfPrc
PrsPrc
Ger
Sup




Err/Orth



### Semantic tags

Sem/Act
Sem/Ani
Sem/Atr
Sem/Body
Sem/Clth
Sem/Domain
Sem/Feat-phys
Sem/Fem
Sem/Group
Sem/Lang
Sem/Mal
Sem/Measr
Sem/Money
Sem/Obj
Sem/Obj-el
Sem/Org
Sem/Perc-emo
Sem/Plc
Sem/Sign
Sem/State-sick
Sem/Sur
Sem/Time
Sem/Txt

HUMAN

HAB-ACTOR
HAB-ACTOR-NOT-HUMAN


PROP-ATTR
PROP-SUR



TIME-N-SET


###  Syntactic tags

@+FAUXV
@+FMAINV
@-FAUXV
@-FMAINV
@-FSUBJ>
@-F<OBJ
@-FOBJ>
@-FSPRED<OBJ
@-F<ADVL
@-FADVL>
@-F<SPRED
@-F<OPRED
@-FSPRED>
@-FOPRED>
@>ADVL
@ADVL<
@<ADVL
@ADVL>
@ADVL
@HAB>
@<HAB
@>N
@Interj
@N<
@>A
@P<
@>P
@HNOUN
@INTERJ
@>Num
@Pron<
@>Pron
@Num<
@OBJ
@<OBJ
@OBJ>
@OPRED
@<OPRED
@OPRED>
@PCLE
@COMP-CS<
@SPRED
@<SPRED
@SPRED>
@SUBJ
@<SUBJ
@SUBJ>
SUBJ
SPRED
OPRED
@PPRED
@APP
@APP-N<
@APP-Pron<
@APP>Pron
@APP-Num<
@APP-ADVL<
@VOC
@CVP
@CNP
OBJ
<OBJ
OBJ>
<OBJ-OTHERS
OBJ>-OTHERS
SYN-V
@X





## Sets containing sets of lists and tags

This part of the file lists a large number of sets based partly upon the tags defined above, and
partly upon lexemes drawn from the lexicon.
See the sourcefile itself to inspect the sets, what follows here is an overview of the set types.



### Sets for Single-word sets

INITIAL


### Sets for word or not

WORD
REAL-WORD
REAL-WORD-NOT-ABBR
NOT-COMMA


### Case sets

ADLVCASE

CASE-AGREEMENT
CASE

NOT-NOM
NOT-GEN


### Verb sets


NOT-V

### Sets for finiteness and mood

REAL-NEG

MOOD-V

NOT-PRFPRC


### Sets for person

SG1-V
SG2-V
SG3-V
DU1-V
DU2-V
DU3-V
PL1-V
PL2-V
PL3-V





### Pronoun sets

















### Adjectival sets and their complements




### Adverbial sets and their complements




### Sets of elements with common syntactic behaviour


### NP sets defined according to their morphosyntactic features








### The PRE-NP-HEAD family of sets

These sets model noun phrases (NPs). The idea is to first define whatever can
occur in front of the head of the NP, and thereafter negate that with the
expression **WORD - premodifiers**.





















### Border sets and their complements












Grammarchecker rules begin here 




### Grammarchecker sets




## Grammarchecker rules



### Speller rules



### Agreement rules
















### Negation verb rules



















### Postposition rules



### Punctuation rules


















* * *
<small>This (part of) documentation was generated from [../tools/grammarcheckers/grammarchecker.cg3](http://github.com/giellalt/lang-est/blob/main/../tools/grammarcheckers/grammarchecker.cg3)</small>