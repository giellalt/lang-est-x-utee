#!/bin/sh

cd $GTHOME/langs/est/src/morphology


sort -u stems.lexc > stems-u.lexc

(echo 'LEXICON Adjectives'; egrep '+A[:+]' stems-u.lexc) > stems/adjectives.lexc
(echo 'LEXICON Adverbs'; egrep '+Adv[:+]' stems-u.lexc) > stems/adverbs.lexc
(echo 'LEXICON Interjections'; egrep '+I[:+]' stems-u.lexc) > stems/interjections.lexc
(echo 'LEXICON Nouns'; egrep '+S[:+]' stems-u.lexc) > stems/nouns.lexc
(echo 'LEXICON Numerals'; egrep '+(Num|Ord)[:+]' stems-u.lexc) > stems/numerals.lexc
(echo 'LEXICON PrePostPositions'; egrep '+K[:+]' stems-u.lexc) > stems/prepostpos.lexc
(echo 'LEXICON Pronouns'; egrep '+Pron[:+]' stems-u.lexc) > stems/pronouns.lexc
(echo 'LEXICON Verbs'; egrep '(_V |+V[:+])' stems-u.lexc) > stems/verbs.lexc
(echo 'LEXICON GenAttributes'; egrep '+G[:+]' stems-u.lexc) > stems/genitive-attributes.lexc
(echo 'LEXICON ProperNames'; egrep '+H[:+]' stems-u.lexc) > stems/proper-names.lexc
(echo 'LEXICON Conjunctions'; egrep '+J[:+]' stems-u.lexc) > stems/conjunctions.lexc
(echo 'LEXICON NonInflectionals'; egrep '+X[:+]' stems-u.lexc) > stems/noninfectionals.lexc

