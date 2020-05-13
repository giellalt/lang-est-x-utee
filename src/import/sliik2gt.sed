#!/bin/sed -f

s/!\\A\\/!\\+A\\/g
s/!\\B\\/!\\+A\\/g
s/!\\C\\/!\\+A+Comp\\/g
s/!\\D\\/!\\+Adv\\/g

s/!\\G\\/!\\+N+Sg+Gen\\/g

s/!\\H\\/!\\+N+Prop\\/g
s/!\\I\\/!\\+Interj\\/g

/aga/s/!\\J\\!/!\\+CC\\!/
/ega/s/!\\J\\!/!\\+CC\\!/
/ehk/s/!\\J\\!/!\\+CS\\!/
/<ehkki/s/!\\J\\!/!\\+CC\\!/
/elik/s/!\\J\\!/!\\+CC\\!/
/<ent/s/!\\J\\!/!\\+CC\\!/
/<et/s/!\\J\\!/!\\+CS\\!/
/ja/s/!\\J\\!/!\\+CC\\!/
/j<ust_k<ui/s/!\\J\\!/!\\+CS\\!/
/kuid/s/!\\J\\!/!\\+CC\\!/
/kuigi/s/!\\J\\!/!\\+CS\\!/
/kui/s/!\\J\\!/!\\+CS\\!/
/kuna/s/!\\J\\!/!\\+CS\\!/
/kuni/s/!\\J\\!/!\\+CC\\!/
/nagu/s/!\\J\\!/!\\+CS\\!/
/ning/s/!\\J\\!/!\\+CC\\!/
/olgugi/s/!\\J\\!/!\\+CS\\!/
/otse_k<ui/s/!\\J\\!/!\\+CS\\!/
/s<est/s/!\\J\\!/!\\+CS\\!/
/s<iis/s/!\\J\\!/!\\+CS\\!/
/v<aid/s/!\\J\\!/!\\+CC\\!/
/või/s/!\\J\\!/!\\+CC\\!/

s/!\\K\\!/!\\+Adp\\!/g
s/!\\N\\/!\\+Num+Card\\/g
s/!\\O\\/!\\+Num+Ord\\/g
s/!\\P\\/!\\+Pron\\/g
s/!\\S\\/!\\+N\\/g
s/!\\U\\/!\\+A+Superl\\/g
s/!\\V\\/!\\+V\\/g
s/!\\X\\!/!\\+Adv\\!/g

