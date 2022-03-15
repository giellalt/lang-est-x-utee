
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
|  @R.Part.Bad@ | Require that the first part has been encountered; if a lemma has it, it means that the lemma cannot be part2  

POS is used for filtering derivations and compounds
|  @R.POS.NumCardCompound@ | compound numeral (viis+sada - five hundred)

Case is used for filtering derivations and compounds

Remember there has been some derivation from A or N; for filtering compounds
derivation from V is called paradigmatic and does not result in Der; just a new POS... 

Remember the stem type; for filtering compounds 

A special condition that is used for filtering derivations and compounds

Tokeniser 

Guesser

### Symbols that need to be escaped on the lower side (towards twolc):
Sami GT convention 

* »
* «
* > (escaped with square brackets, to avoid collision with > as morpheme boundary)
* < (escaped with square brackets, to avoid collision with < as morpheme boundary)

* '  7 is the real apostrophe ?? 

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

Guesser

Lexicon-based

strictly simplex word; cannot be a part of a compound
a simplex word, or the first part of a compound

* `  @D.Part@@P.Part.Two@@P.NeedPart.Three@@P.POS.Num@ CardinalNumbersInCompBeg ;   ` 5-autone etc

strictly simplex words; cannot be a part of a compound

* `  Adpositions ;              `
* `  Conjunctions ;             `
* `  NoninflectingVerbs ;       `
* `  NoninflectingAdjectiveVa ; `
* `  NonCompoundingAdverbs ;   `

* `  Abbreviations ;              `
* `  CardinalNumbersSingle ;      `
* `  OrdinalNumbers ;             `
* `  Punctuation ;                `
* `  Symbols     ;                `
* `  SymbolStrings     ;          `   .ee .com -ending strings

* `LEXICON First     ` a simplex word or the first part of a compound 

* `LEXICON FirstOpenClass     ` a simplex word or the first part of a compound 
* `  @P.POS.A@ Adjectives ;              `
* `  @P.POS.A@ NoninflectingAdjectives ; `
* `  @P.POS.AComp@ ComparativeAdjectives ;   `
* `  @P.POS.AComp@ SuperlativeAdjectives ;   `  ! Superl = Comp in compounding
* `  @P.POS.Adv@ CompoundingAdverbs ;                 `
* `  @P.POS.N@ Nouns ;                   `
* `  @P.POS.NProp@@U.Cap.Obl@ ProperNouns ; `  ! always uppercase
* `  @P.POS.NProp@@U.Cap.Opt@ ProperNouns ; `  ! downcased for derivations
* `  @P.POS.IntNum@ IntegerNumerals ;                `
* `  @P.POS.NonIntNum@ NonIntegerNumerals ;                `
* `  @P.POS.NumOrd@ OrdinalNumerals ;                `
* `  @P.POS.V@ Verbs ;                   `
* `  @P.POS.GA@@P.Case.Gen@ GenitiveAttributes ;      `
* `  @P.POS.Pref@ Prefixes ;                `

* `LEXICON FirstClosedClass     ` a simplex word or the first part of a compound 
* `  @P.POS.Pron@ Pronouns ;                `

* `LEXICON FirstWordLike                      ` a word-like string that may (or must) be the first part of a compound
* `  @P.POS.Interj@ Interjections ;           `
* `  @P.POS.ACR@ Acronyms ;                   `
* `  @P.POS.ACRMinus@@P.NeedPart.Two@ Acrominus ;          `

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

<small>This (part of) documentation was generated from [src/fst/root.lexc](https://github.com/giellalt/lang-est-x-utee/blob/main/src/fst/root.lexc)</small>

---

