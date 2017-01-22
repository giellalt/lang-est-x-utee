#!/usr/bin/python -w
# -*- coding: utf8 -*-

import sys
from collections import defaultdict

ignore1 = {"minä", "mikin", "minäkin", "sinä", "sinäkin", "hän", "hänkin", "me", "mekin", "te", "tekin", "he", "hekin", "ei", "olla"} # lemla
ignore2 = {"mina", "ma", "sina", "sa", "tema", "ta", "meie", "me", "teie", "te", "nemad", "nad", "ei", "olema"}

class Wordform:
  def __init__(self, w="", l="", m=""):
    self.word = w 	 # empty in biltrans and postchnk
    self.lemma = l
    self.lemla = l.lower().replace('Ä', 'ä').replace('Ö', 'ö').replace('Ü', 'ü').replace('Õ', 'õ')
    self.morph = m
    i = m.find('>')
    if i > 1:
      self.pos = m[1:i]
    else:
      self.pos = "?"

  def prints(self):
    if self.word == "":  # empty in biltrans and postchnk
      return self.lemma + self.morph
    else:
      return self.lemma + self.morph
      #return self.word + '/' + self.lemma + self.morph - word in wordunit

class Wordunit:
  def __init__(self, unit="", ab='a'): # ab=a analysed, ab=b biltrans
    self.biltr = ab
    self.main = Wordform()
    self.readings = []
    self.cat = "notfound" # category
    self.tosource = -1 # index of SOURAN wordunit
    self.totransl = -1 # index of TRANAN wordunit
    self.totarget = -1 # index of TARGAN wordunit
    self.tobiltrs = -1 # index of BILTRS wordunit
    self.compound = False
    self.mwe = False
    self.guess = ""
    self.color = ""
    if len(unit) > 0:
      if unit.find("¤") == 0:
        unit = unit[2:]
        self.compound = True
    if len(unit) > 0:
      if unit[0] == '^':
        if unit[-1] == '$':
          inl = unit[1:-1]
        else:
          inl = unit[1:]
      elif unit[-1] == '$':
        inl = unit[:-1]
      else:
        inl = unit
      wf = ""
      lem = ""
      mrf = ""
      j = -1
      for item in inl.split('/'):
        j += 1
        i = item.find('<') # start of morph
        if i > 0:
          lem = item[:i]
          mrf = item[i:]
        elif len(item) > 0:
          if item[0] == '#': # maybe not a correct form
            self.guess = "#"
            lem = item[1:]
          elif item[0] == '*': # not a lemma in fact, but accidentally may be
            self.guess = "*"
            lem = item[1:]
          else:        
            lem = item
          if lem[-1] == '#':
            lem = lem[:-1] 
          if '/' not in inl: # txt or pchnk "gümnaasiumi ^lõpetanu/lõpetanu<n><pl><gen>$"
            wf = lem
            lem = ""
          mrf = ""
        if j == 0: # diff in an and bi
          if ab == 'a': # analysed
            if '/' in inl:
              wf = item
            else: # else postchnk
              self.main = Wordform(wf, lem, mrf)
              self.readings.append(self.main)
          else: # biltrans
            self.main = Wordform(wf, lem, mrf)
            if '/' not in unit: # ^ylioppilas<n><pl><gen>/gümnaasiumi$ ^lõpetanu<n><pl><gen>$
              self.compound = True # + more
        elif j == 1 and ab == 'a': # analysed, 1st reading
          self.main = Wordform(wf, lem, mrf)
          self.readings.append(self.main)
        else: # all readings (analysed) or translations (biltrans)
          self.readings.append(Wordform(wf, lem, mrf))
    if len(self.main.lemma) > 0 and self.main.lemma[0] in '...,:;()?..!.."/@\'+=\\#¤%&[]£${}^|<>0123456789' or (len(self.main.lemma) > 1 and self.main.lemma[0] in "*-" and self.main.lemma[1] in "/<") or (len(self.main.word) == 1 and self.main.word[0] in "*-") or "<cm>" in self.main.morph or "<sent>" in self.main.morph or "<punct>" in self.main.morph or "<guio>" in self.main.morph or "<quot>" in self.main.morph or len(self.main.lemma) == 0 and len(self.main.word) > 0 and self.main.word[0] in '...,:;()?..!.."/@\'+=\\¤%&[]£${}^|<>0123456789':
      # filter numbers & punctuation
      self.cat = "punct"
      self.compound = False 
    elif self.main.lemla in ignore1 or self.main.lemla in ignore2:
      self.cat = "ignore"

  def printr(self):
    readingstr = ""
    for rd in self.readings:
      readingstr = readingstr + '/' + rd.prints()
    return readingstr

  def prints(self, no=False):
    prefix = "^"
    if self.compound == True:
      prefix = "+^"
    elif self.mwe == True:
      prefix = "++^"
    postfix = "$"
    if self.totarget >= 0:
      postfix = "$tar" + str(self.totarget)
    if self.tobiltrs >= 0:
      postfix = postfix + "bi" + str(self.tobiltrs)
    if self.totransl >= 0:
      postfix = postfix + "tr" + str(self.totransl)
    if self.tosource >= 0:
      postfix = postfix + "s" + str(self.tosource)
    if self.color != "":
      postfix = postfix + self.color
    if self.biltr == 'b':  # biltrans
      return prefix + self.main.prints() + self.printr() + postfix
    elif self.main.word == "":  # postchnk
      if no == False:
        return prefix + self.main.prints() + postfix
      else:
        return prefix + self.main.prints() + '#' + str(self.tobiltrs) + self.cat + postfix
    elif self.main.lemma == "":  # txt
      return self.main.word 
    else:                 # mrf analysed
      return prefix + self.main.word + self.printr() + postfix

L1 = "FIN"
L2 = "EST"

SOURCE = 0
TARGET = 1
TRANSL = 2
BILTRS = 3
SOURAN = 4
TARGAN = 5
TRANAN = 6

def get_sentence(infile, cmp_file, ab='a'):
  # one from infiles: [source, target, transl, biltrans, source_an, target_an, transl_an] 
  txt = infile.readline().strip()
  if not txt or txt == "":
    return None, None
  if txt[0] == '^' or txt[1] == '^':
    txt = txt.replace("¹", "").replace("$^", "$ ¤^").replace("(^", "$( ^").replace("$)", "$ )").replace(")^", ") ^")
  else:
    txt = txt.replace('.', " .").replace(',', " ,").replace('# ,', " #,").replace(':', " :").replace(';', " ;").replace('!', " !").replace('?', " ?").replace(" *", " ").replace(" #", " ").replace("(", "$( ").replace(")#", ")").replace(")", " ) ") .replace("-", " - ").replace(" -  ", "- ").replace("  - ", " -")
  sentence = []
  borders = []
  i = -1
  for item in txt.split():
    i += 1

    if ab == 'a' and '/' in item and ">+" in item:
      ites = item.split('/')
      beg = ites[0] # don't change at the moment
      j = 0
      for cp in ites[1].split('+'):
        sentence.append(Wordunit(beg + "/" + cp, ab))
        #cmp_file.write("\ncmp " + item + "\t" + beg + "/" + cp + "\t" + sentence[-1].prints())
        if j > 0:
          sentence[-1].compound = True 
          i += 1
        j += 1
    else:
      sentence.append(Wordunit(item, ab))
      #if sentence[-1].cat == "punct":
      #  cmp_file.write("\npunct " + sentence[-1].prints())
    neww = sentence[-1].main.word
    if ab == 'a' and len(sentence) > 1 and sentence[-2].main.morph == "" and sentence[-2].main.word == "" and "punct" not in sentence[-2].cat and "punct" not in sentence[-1].cat and ">+" in txt: 
      sentence[-1].compound = True # pchnk "gümnaasiumi ^lõpetanu/lõpetanu<n><pl><gen>$", in some cases, check 
    if neww == "": 
      neww = sentence[-1].main.lemma
    if (len(neww) == 1 or len(neww) > 1 and neww[1] in '<0123456789') and neww[0] in ':;,':
      borders.append(i)
  return sentence, borders

def get_phrases(infilenames, cmp_file):
  # infiles: [source, target, transl, biltrans, source_an, target_an, transl_an]
  infiles = []
  for i in range(len(infilenames)):
    infiles.append(file(infilenames[i]))
  
  sentno = 0
  borders = []
  sentences = []
  sentence, border = get_sentence(infiles[SOURCE], cmp_file)
  while sentence:
    sentno += 1
    borders = [border]
    sentences = [sentence]
    for i in range(len(infiles)-1):
      if i+1 == BILTRS:
        sentence, border = get_sentence(infiles[i+1], cmp_file, 'b')
      else:
        sentence, border = get_sentence(infiles[i+1], cmp_file)
      if sentence:
        sentences.append(sentence)
        borders.append(border)
    #yield sentences # if want whole sentences, then need only 3 last lines after this
    
    if len(borders[SOURAN]) == 0 or len(borders[TARGAN]) == 0:
      yield sentences
    else:
      diff = len(borders[TARGAN]) - len(borders[SOURAN])
      if diff > 0: # change target, targan
        #cmp_file.write("\n" + str(borders))
        for i in range(len(borders[SOURAN])):
          if abs(abs(borders[TARGAN][i] - borders[SOURAN][i]) - abs(borders[TARGAN][i+1] - borders[SOURAN][i])) < 3: # check
            if borders[SOURAN][i] > 0 and len(sentences[BILTRS][borders[BILTRS][i]-1].readings) > 0 and sentences[SOURAN][borders[SOURAN][i]-1].main.lemma in sentences[BILTRS][borders[BILTRS][i]-1].main.lemma and sentences[TARGAN][borders[TARGAN][i+1]-1].main.lemma in sentences[BILTRS][borders[BILTRS][i]-1].readings[0].lemma or borders[SOURAN][i] < len(sentences[SOURAN])-1 and sentences[SOURAN][borders[SOURAN][i]+1].main.lemma in sentences[BILTRS][borders[BILTRS][i]+1].main.lemma and sentences[TARGAN][borders[TARGAN][i+1]+1].main.lemma in sentences[BILTRS][borders[BILTRS][i]+1].readings[0].lemma:
              sentences[TARGAN][i].color = "grey"
              borders[TARGAN].pop(i)
              borders[TARGET].pop(i)
          elif abs(borders[TARGAN][i] - borders[SOURAN][i]) > abs(borders[TARGAN][i+1] - borders[SOURAN][i]):
            sentences[TARGAN][i].color = "grey"
            borders[TARGAN].pop(i)
            borders[TARGET].pop(i)
          if len(borders[TARGAN]) == len(borders[SOURAN]):
            break
        i = -1
        while len(borders[TARGAN]) > len(borders[SOURAN]): 
            sentences[TARGAN][i].color = "grey"
            borders[TARGAN].pop()
            borders[TARGET].pop()
            i -= 1
        #cmp_file.write("\n" + str(borders))
      elif diff < 0: # change source, souran, transl, tranan, biltrs
        #cmp_file.write("\n" + str(borders))
        for i in range(len(borders[TARGAN])):
          if abs(abs(borders[TARGAN][i] - borders[SOURAN][i]) - abs(borders[TARGAN][i] - borders[SOURAN][i+1])) < 3: # check
            if borders[TARGAN][i] > 0 and len(sentences[BILTRS][borders[BILTRS][i]-1].readings) > 0 and sentences[SOURAN][borders[SOURAN][i+1]-1].main.lemma in sentences[BILTRS][borders[BILTRS][i+1]-1].main.lemma and sentences[TARGAN][borders[TARGAN][i]-1].main.lemma in sentences[BILTRS][borders[BILTRS][i+1]-1].readings[0].lemma or borders[SOURAN][i] < len(sentences[SOURAN])-1 and sentences[SOURAN][borders[SOURAN][i+1]+1].main.lemma in sentences[BILTRS][borders[BILTRS][i+1]+1].main.lemma and sentences[TARGAN][borders[TARGAN][i]+1].main.lemma in sentences[BILTRS][borders[BILTRS][i+1]+1].readings[0].lemma:
              sentences[TRANAN][i].color = "grey"
              borders[SOURCE].pop(i)
              borders[SOURAN].pop(i)
              borders[TRANSL].pop(i)
              borders[TRANAN].pop(i)
              borders[BILTRS].pop(i)
          elif abs(borders[TARGAN][i] - borders[SOURAN][i]) > abs(borders[TARGAN][i] - borders[SOURAN][i+1]):
              sentences[TRANAN][i].color = "grey"
              borders[SOURCE].pop(i)
              borders[SOURAN].pop(i)
              borders[TRANSL].pop(i)
              borders[TRANAN].pop(i)
              borders[BILTRS].pop(i)
          if len(borders[TARGAN]) == len(borders[SOURAN]):
            break
        i = -1
        while len(borders[TARGAN]) < len(borders[SOURAN]): 
            sentences[TRANAN][i].color = "grey"
            borders[SOURCE].pop()
            borders[SOURAN].pop()
            borders[TRANSL].pop()
            borders[TRANAN].pop()
            borders[BILTRS].pop()
            i -= 1
        #cmp_file.write("\n" + str(borders))

      if len(borders[SOURAN]) == 0 or len(borders[TARGAN]) == 0:
        yield sentences
      else:
        for j in range(len(borders[SOURAN])+1):
          phrases = []
          for i in range(len(infiles)):
            if j == 0:
             newph = sentences[i][:borders[i][0]]
            elif j < len(borders[i]):
              newph = sentences[i][borders[i][j-1]+1:borders[i][j]]
            else:
              newph = sentences[i][borders[i][-1]+1:]
            phrases.append(newph)
          yield phrases
    
    sentence, border = get_sentence(infiles[SOURCE], cmp_file)
  for i in range(len(infiles)):
    infiles[i].close()


def print_phrase(phrase, no=False):
  phrasestr = ""
  for i in range(len(phrase)):
    phrasestr = phrasestr + phrase[i].prints(no) + ' '
  return phrasestr + '\n'
  
def print_phrases(phrases):
  phrasestr = ""
  for i in range(len(phrases)):
    phrasestr = phrasestr + print_phrase(phrases[i], False)
  print phrasestr + '\n'
  #return phrasestr + '\n'


def compare(infilenames):
  # Usage: python comp.py [source] [target] [transl] [biltrans] [source_an] [target_an] [transl_an] \n""")
  # python com.py soome.txt eesti.txt soome.tolge soome.biltr soome.mrf eesti.mrf soome.pchnk

  cmp_file = open(infilenames[TRANSL]+".nlg", 'w')
  lex_file = open(infilenames[TRANSL]+".ndx", 'w')
  rul_file = open(infilenames[TRANSL]+".nrl", 'w')
  cmp_file.write("Category\t  MT translation\t- Human translation\t- Inner bitranslation\n\n")

  """mtags = defaultdict(str)
  slex_file = file("~/svn-giellatekno/main/langs/fin/src/morphology/lexicon.lexc")
  tlex_file = file("~/svn-giellatekno/main/langs/est/src/morphology/lexicon.lexc")
  dlex_file = file("~/svn-apertium/apertium-fin-est/apertium-fin-est.fin-est.dix")
  l = mrf_file.readline()    
  while l:
    tags = l.strip().split("\t")
    if tags[0][0] != '-': 
      mtags[' '+tags[0]+' '] = tags[1]    
    l = mrf_file.readline()    
  """#for key in mtags: 
  #  print key, mtags[key]

  all_words = 0
  ccor_words = 0
  csel_words = 0
  cinc_words = 0
  cspn_words = 0
  nf_words = 0
  pron_words = 0
  comp_parts = 0

  cor_words = 0
  diff_form = 0
  diff_lemma = 0
  sel_words = 0
  inc_words = 0
  spn_words = 0
  punct = 0
  other = ""

  """cor_sents = 0
  ord_sents = 0
  inc_sents = 0
  """

  sentno = 0
  phrases_itr = get_phrases(infilenames, cmp_file)
  phrases = phrases_itr.next()

  try:
    while phrases:
      sentno += 1
      print str(sentno)
      print_phrases(phrases)
      print str(sentno)

      # # # # # # # # # # # #
      cr = "CORR"
      rd = ""
      jor = 0 # first unattached in source (biltrans)
      kor = 0 # first unattached in target (est_mrf)
      cor = 0
      itr = 0
      pos = ""
      itrsl = 0
      while itr < len(phrases[TRANAN]): # word in chunk I
        if itrsl < len(phrases[TRANSL]) and "punct" not in phrases[TRANAN][itr].cat:
          while itrsl < len(phrases[TRANSL]) and "punct" in phrases[TRANSL][itrsl].cat: #  not phrases[TRANSL][itrsl].compound and
            itrsl += 1 
          if itrsl >= len(phrases[TRANSL]): break
          phrases[TRANAN][itr].main.word = phrases[TRANSL][itrsl].main.word 
          itrsl += 1 
        
        for sousent in phrases[SOURAN]: # find mrf correspondence in source
          if phrases[TRANAN][itr].main.word == sousent.main.word:
            if phrases[TRANAN][itr].main.morph == "": # missing in bidix, patch (pääsee)
              phrases[TRANAN][itr].main.pos = sousent.main.pos
              #missng phrases[TRANAN][itr].main.lemma = sousent.main.lemma
              #missng phrases[TRANAN][itr].main.word = sousent.main.word
              #missng phrases[TRANAN][itr].main.morph = sousent.main.morph
            break
        print "1", phrases[TRANAN][itr].prints()
        pos = phrases[TRANAN][itr].main.pos
        lemma = phrases[TRANAN][itr].main.lemma
        lemla = phrases[TRANAN][itr].main.lemla
        if "punct" not in phrases[TRANAN][itr].cat and "ignore" not in phrases[TRANAN][itr].cat:  # word, not punctuation or ignored word
          j = jor 
          while j < len(phrases[BILTRS]): # find correspondence in biltrans
            i = 0
            for sousent in phrases[SOURAN]: # find mrf correspondence in source
              #cmp_file.write("\nSou\t" + phrases[TRANAN][itr].main.word +'\t' + phrases[BILTRS][j].main.word +'\t'+ sousent.main.word)
              if phrases[BILTRS][j].main.lemma == sousent.main.word:
                if phrases[BILTRS][j].main.morph == "": # missing in bidix, patch (pääsee)
                  phrases[BILTRS][j].main.pos = sousent.main.pos
                  phrases[BILTRS][j].main.lemma = sousent.main.lemma
                  phrases[BILTRS][j].main.lemla = sousent.main.lemla
                  phrases[BILTRS][j].main.word = sousent.main.word
                  phrases[BILTRS][j].main.morph = sousent.main.morph
              if phrases[BILTRS][j].main.lemma in sousent.main.lemma: # inclusion!
                phrases[BILTRS][j].tosource = i
                break
              i += 1

            if phrases[BILTRS][j].totransl < 0:
              for rs in phrases[BILTRS][j].readings:
                if lemla == rs.lemla: 
                  phrases[TRANAN][itr].tobiltrs = j
                  phrases[BILTRS][j].totransl = itr
                  while jor < len(phrases[BILTRS]) and phrases[BILTRS][jor].totransl >= 0:
                    jor += 1
                  break
              if len(phrases[BILTRS][j].readings) == 1 and phrases[BILTRS][j].readings[0].morph == "":
                if phrases[TRANAN][itr].main.word == phrases[BILTRS][j].main.word: 
                  phrases[TRANAN][itr].tobiltrs = j
                  phrases[BILTRS][j].totransl = itr
            j += 1
          #cmp_file.write("biltrs" + print_phrase(phrases[TRANAN], True))

          print "2"
          #if itr >= 0:
          j = cor 
          while "notfound" in phrases[TRANAN][itr].cat and phrases[TRANAN][itr].guess != "*" and j < len(phrases[TARGAN]): # find correspondence in target
            if "notfound" in phrases[TARGAN][j].cat:
                
              ok = 0
              if phrases[TARGAN][j].totransl < 0:
                for rt in phrases[TRANAN][itr].readings:
                  for rd in phrases[TARGAN][j].readings:
                    if rt.lemla == rd.lemla: 
                      cor_words += 1			 
                      phrases[TRANAN][itr].cat = "wordok1 " # lemmas same, forms are compared later
                      phrases[TRANAN][itr].totarget = j
                      phrases[TARGAN][j].totransl = itr
                      cor = j+1
                      ok = 1
                      break
                  if ok == 1:
                      break
                if ok == 1:
                  while kor < len(phrases[TARGAN]) and phrases[TARGAN][kor].totransl >= 0:
                    kor += 1
                  break

              print "2.1"
              if phrases[TARGAN][j].totransl < 0:
                #cmp_file.write("\n2.1 wordforms\t" + phrases[TARGAN][j].main.word +'\t'+ phrases[TRANAN][itr].main.word)
                if phrases[TARGAN][j].main.word == phrases[TRANAN][itr].main.word: # compare surface forms
                  cor_words += 1
                  phrases[TRANAN][itr].cat = "wordok2 "  
                  ok = 1
                else:
                  for lemtar in phrases[TARGAN][j].readings: # check lemmas in target
                    for lembil in phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].readings: # against lemmas in biltrs
                      if lemtar.lemla == lembil.lemla:
                        sel_words += 1
                        phrases[TRANAN][itr].cat = "lexsel "  # includes also form and compounding differences
                        ok = 1
                        break
                    if ok == 1:
                      break
                if ok == 1:
                  phrases[TRANAN][itr].totarget = j
                  phrases[TARGAN][j].totransl = itr
                  while kor < len(phrases[TARGAN]) and phrases[TARGAN][kor].totransl >= 0:
                    kor +=  1
                    ok = 1
                    break
              if ok == 1:
                break
            j += 1

          print "2.2"
          print phrases[TRANAN][itr].totarget, phrases[TRANAN][itr-1].totarget, phrases[TRANAN][itr-1].cat
          if itr > 1 and phrases[TRANAN][itr].totarget > -1 and phrases[TRANAN][itr-1].totarget == -1 and (pos == "n" or pos == "np") and "notfound" in phrases[TRANAN][itr-1].cat:
            #cmp_file.write("\n2.2 wordforms\t" + phrases[TRANAN][itr].main.word +'\t'+ str(phrases[TRANAN][itr].tobiltrs-1) +'\t'+ str(phrases[TRANAN][itr].totarget-1))
            pbiltr = phrases[BILTRS][phrases[TRANAN][itr].tobiltrs-1]
            if "notfound" in pbiltr.cat and ("<adj>" in pbiltr.main.morph or "<dem>" in pbiltr.main.morph or "<attr>" in pbiltr.main.morph): 
              phrases[TRANAN][itr-1].totarget = phrases[TRANAN][itr].totarget - 1
              phrases[TARGAN][phrases[TRANAN][itr].totarget-1].totransl = itr - 1
              phrases[TRANAN][itr-1].cat = "syn&wrong1 " 
              inc_words += 1
          #print "target", str(itr), str(phrases[TRANAN][itr].totarget), str(phrases[TARGAN][j].totransl)
        itr += 1  

      gaps = 0
      gapl = []
      trgapl = []
      print "3"
      #print "gp"
      verb = -1
      comp = -1
      i = 0
      while i < len(phrases[TARGAN]):
        if "punct" not in phrases[TARGAN][i].cat:
          if verb < 0 and "vblex" == phrases[TARGAN][i].main.pos and "<neg>" not in phrases[TARGAN][i].main.morph: 
            verb = i
          elif comp < 0 and phrases[TARGAN][i].compound == True: 
            comp = i
          #cmp_file.write("i" + str(i) + str(phrases[TARGAN][i].prints()) + str(phrases[TARGAN][i-1].totransl))
          if phrases[TARGAN][i].totransl < 0 and "ignore" not in phrases[TARGAN][i].cat:

            print "3.1", str(i)
            if phrases[TARGAN][i].compound == True and i > 0 and phrases[TARGAN][i-1].totransl+1 < len(phrases[TRANAN]) and phrases[TRANAN][phrases[TARGAN][i-1].totransl+1].totarget < 0 and "notfound" in phrases[TRANAN][phrases[TARGAN][i-1].totransl+1].cat:
              phrases[TARGAN][i].totransl = phrases[TARGAN][i-1].totransl + 1
              phrases[TRANAN][phrases[TARGAN][i].totransl].totarget = i
              phrases[TRANAN][phrases[TARGAN][i].totransl].cat = "wordokC"
              i += 1
              continue
            print "3.2"
            if i+1 < len(phrases[TARGAN]) and phrases[TARGAN][i+1].compound == True and phrases[TARGAN][i+1].totransl-1 >= 0 and phrases[TRANAN][phrases[TARGAN][i+1].totransl-1].totarget < 0 and "notfound" in phrases[TRANAN][phrases[TARGAN][i+1].totransl-1].cat:
              phrases[TARGAN][i].totransl = phrases[TARGAN][i+1].totransl - 1
              phrases[TRANAN][phrases[TARGAN][i].totransl].totarget = i
              phrases[TRANAN][phrases[TARGAN][i].totransl].cat = "wordokC"
              i += 1
              continue
            print "3.3"
            if phrases[TARGAN][i].compound == True and i > 0 and phrases[TARGAN][i-1].totransl+1 < len(phrases[TRANAN]) and phrases[TRANAN][phrases[TARGAN][i-1].totransl+1].totarget >= 0:
              phrases[TARGAN][i].totransl = phrases[TARGAN][i-1].totransl 
              #phrases[TRANAN][phrases[TARGAN][i].totransl].totarget same
              i += 1
              continue
            print "3.4"
            #if i+1 < len(phrases[TARGAN]) and phrases[TARGAN][i+1].compound == True and phrases[TARGAN][i+1].totransl-1 >= 0:
            #  cmp_file.write("\ncomp " + str(phrases[TRANAN][phrases[TARGAN][i+1].totransl-1].totarget) + phrases[TRANAN][phrases[TARGAN][i+1].totransl-1].prints())
            #if i+1 < len(phrases[TARGAN]):
            #  cmp_file.write("\ncomp " + str(i) + str(phrases[TARGAN][i+1].totransl-1))
            if i+1 < len(phrases[TARGAN]) and phrases[TARGAN][i+1].compound == True and phrases[TARGAN][i+1].totransl-1 >= 0 and phrases[TRANAN][phrases[TARGAN][i+1].totransl-1].totarget >= 0:
              phrases[TARGAN][i].totransl = phrases[TARGAN][i+1].totransl
              #phrases[TRANAN][phrases[TARGAN][i].totransl].totarget same
              i += 1
              continue

            lemta = phrases[TARGAN][i].main.lemla
            if lemta != "":
              # try to fill - phrases[TARGAN][i].totransl < 0 
              if i > 0 and phrases[TARGAN][i-1].totransl > 0 and "notfound" in phrases[TRANAN][phrases[TARGAN][i-1].totransl].cat: 
                 print "3.1"
                 if phrases[TARGAN][i-1].totransl+1 < len(phrases[TRANAN]) and "punct" not in phrases[TRANAN][phrases[TARGAN][i-1].totransl+1].cat and "ignore" not in phrases[TRANAN][phrases[TARGAN][i-1].totransl+1].cat and phrases[TARGAN][i].main.pos == phrases[TRANAN][phrases[TARGAN][i-1].totransl+1].main.pos: # try next
                   phrases[TARGAN][i].totransl = phrases[TARGAN][i-1].totransl + 1
                   phrases[TRANAN][phrases[TARGAN][i].totransl].totarget = i
                   phrases[TRANAN][phrases[TARGAN][i].totransl].cat = "syn&wrong3 " 
                   inc_words += 1
                   if phrases[TARGAN][i].main.word == phrases[TRANAN][phrases[TARGAN][i].totransl].main.word:
                     phrases[TRANAN][phrases[TARGAN][i].totransl].cat = "wordok4 " # lemmas don't match, but wordforms do ("silmad", "lapsile/lastele")
                 elif verb >= 0 and "<adv>" in phrases[TARGAN][i].main.morph: # findverb
                   phrases[TARGAN][i].totransl = phrases[TARGAN][verb].totransl
                   phrases[TRANAN][phrases[TARGAN][i].totransl].cat = "adverb " 
                   inc_words += 1
                 elif phrases[TARGAN][i].totransl < 0:
                   gaps += 1
                   gapl.append(i)
              elif phrases[TARGAN][i].totransl < 0:
                 gaps += 1
                 gapl.append(i)
        i += 1
       

      r = 0
      maxr = 3       
      print "4"
      while gaps > 0 and r < maxr: # gaps match
           for gap in trgapl:
             cmp_file.write("\ngapl" + str(gap)+"\tw\t" + phrases[TRANAN][gap].prints() + "\t" + str(phrases[TRANAN][gap].totarget))
           trgapl = []
           i = 0
           while i < len(phrases[TRANAN]): # gaps in translation
             if phrases[TRANAN][i].totarget < 0 and "notfound" in phrases[TRANAN][i].cat:
               if comp > 0 and phrases[TARGAN][comp].totransl < 0 and "punct" not in phrases[TARGAN][comp].cat and (phrases[BILTRS][phrases[TRANAN][i].tobiltrs].compound == True or phrases[TRANAN][i].tobiltrs+1 < len(phrases[BILTRS]) and phrases[BILTRS][phrases[TRANAN][i].tobiltrs+1].compound == True):
                 phrases[TARGAN][comp].totransl = i
                 phrases[TRANAN][i].totarget = comp
                 phrases[TRANAN][i].cat = "syn&wrongC " 
                 if i > 0 and phrases[TRANAN][i-1].totarget < 0 and "notfound" in phrases[TRANAN][i-1].cat:
                   phrases[TARGAN][comp-1].totransl = i-1
                   phrases[TRANAN][i-1].totarget = comp-1
                   phrases[TRANAN][i-1].cat = "syn&wrongC " 
                   if i-1 in trgapl:
                     trgapl.remove(i-1)
                   if comp-1 in gapl:
                     gapl.remove(comp-1)
                     gaps -= 1
                 else: 
                   phrases[TARGAN][comp-1].totransl = i
                 if comp in gapl:
                   gapl.remove(comp)
                   gaps -= 1
               else:
                 trgapl.append(i)
             i += 1
           if gaps < 1: break
           r += 1
           print "4.1"
           if gaps == 1 or (gaps == 2 and gapl[0] + 1 == gapl[1]): # add more variants with sparse parts
             if len(trgapl) == 1:
                    phrases[TRANAN][trgapl[0]].totarget = gapl[0]
                    phrases[TRANAN][trgapl[0]].cat = "syn&wrong41 "
                    inc_words += 1
                    #cmp_file.write("\ngIIa\t" + phrases[TRANAN][trgapl[0]r].prints())
                    phrases[TARGAN][gapl[0]].totransl = trgapl[0]
                    if gaps == 2:
                      phrases[TARGAN][gapl[1]].totransl = trgapl[0]
                      if phrases[TARGAN][gapl[1]].compound != True:
                        phrases[TARGAN][gapl[1]].mwe = True
                    gaps = 0
             else:
               itr = 0
               while itr < len(phrases[TRANAN]): # word in chunk IIa
                 if phrases[TRANAN][itr].totarget == -1 and "notfound" in phrases[TRANAN][itr].cat:
                    phrases[TRANAN][itr].totarget = gapl[0]
                    phrases[TRANAN][itr].cat = "syn&wrong4 "
                    inc_words += 1
                    #cmp_file.write("\ngIIa\t" + phrases[TRANAN][itr].prints())
                    phrases[TARGAN][gapl[0]].totransl = itr
                    gaps = 0
                    if phrases[TARGAN][gapl[0]].main.word == phrases[TRANAN][itr].main.word: 
                      phrases[TRANAN][itr].cat = "wordok5 " # lemmas don't match, but wordforms do ("minu meelest")
                 itr += 1    
           cmp_file.write("\ngaps" + str(gapl)+"\ttrgaps" + str(trgapl))
           if gaps == 0:
           	 continue      
    
           i = 0
           istr = ""
           print "4.2"
           while i < len(gapl):  
             if phrases[TARGAN][gapl[i]].totransl == -1 and "notfound" in phrases[TARGAN][gapl[i]].cat:
                 lpos = phrases[TARGAN][i].main.pos 
                 istr += lpos
             i += 1
           #cmp_file.write("\n" +"istr " + istr)
           i = 0
           print "4.3"
           while i < len(gapl):  
             lpos = phrases[TARGAN][i].main.pos 
             if phrases[TARGAN][gapl[i]].totransl == -1 and "notfound" in phrases[TARGAN][gapl[i]].cat and lpos not in istr: 
               j = 0
               vb = 0
               while j < len(trgapl): 
                 lpos = phrases[TARGAN][i].main.pos 
                 rpos = phrases[TRANAN][j].main.pos
                 if rpos == "vblex":
                   vb = j
                 if lpos == rpos: 
                   cmp_file.write("\nastr\t" +phrases[TARGAN][i].prints() + "\t" + phrases[TRANAN][j].prints())
                   phrases[TRANAN][j].totarget = gapl[i]
                   phrases[TRANAN][j].cat = "syn&wrongs "
                   inc_words += 1
                   cmp_file.write("\ngIIa\t" + phrases[TRANAN][j].prints())
                   phrases[TARGAN][gapl[i]].totransl = j
                   gaps -= 1
                   gapl.remove(gapl[i])
                 j += 1
               if phrases[TARGAN][gapl[i]].totransl == -1 and lpos == "adv":
                   cmp_file.write("\nastr\t" +phrases[TARGAN][i].prints() + "\t" + phrases[TRANAN][vb].prints())
                   phrases[TRANAN][vb].totarget = gapl[i]
                   phrases[TRANAN][vb].cat = "syn&wrongs "
                   inc_words += 1
                   cmp_file.write("\ngIIa\t" + phrases[TRANAN][vb].prints())
                   phrases[TARGAN][gapl[i]].totransl = vb
                   gaps -= 1
                   gapl.remove(gapl[i])
             i += 1

           #print "gps"
           print "5"
           itr = 0
           while itr < len(phrases[TRANAN]): # word in chunk IIb
            # more general form - 2 adjacent words
            if itr > 0 and "notfound" in phrases[TRANAN][itr].cat and phrases[TRANAN][itr].totarget > 0 and "notfound" in phrases[TRANAN][itr-1].cat and phrases[TARGAN][phrases[TRANAN][itr].totarget - 1].totransl == -1:
                  ind = phrases[TRANAN][itr].totarget - 1
                  phrases[TRANAN][itr-1].totarget = ind
                  phrases[TARGAN][ind].totransl = itr - 1
                  phrases[TRANAN][itr-1].cat = "syn&wrong2 " 
                  inc_words += 1
                  wf = phrases[TARGAN][ind].main.word
                  wfl = wf.lower().replace('Ä', 'ä').replace('Ö', 'ö').replace('Ü', 'ü').replace('Õ', 'õ')
                  if wf == phrases[TRANAN][itr-1].main.word or wfl == phrases[TRANAN][itr-1].main.word:
                    cmp_file.write("\n" + "wf "+ phrases[TRANAN][itr].prints())
                    phrases[TRANAN][itr-1].cat = "wordok3 " # lemmas don't match, but wordforms do ("Ü/ülikoolis")
    
            print "5.1"
            if phrases[TRANAN][itr].totarget == -1 and "notfound" in phrases[TRANAN][itr].cat: 
              j = cor 
              while j < len(phrases[TARGAN]) and phrases[TRANAN][itr].totarget == -1: 
                if (phrases[TARGAN][j].totransl == -1 and "notfound" in phrases[TARGAN][j].cat and (phrases[TRANAN][itr].tobiltrs >=0 and phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].guess == "*" or phrases[TRANAN][itr].main.pos == phrases[TARGAN][j].main.pos) or phrases[TRANAN][itr].main.pos in {"<cnjsub>", "<prn>", "<n>", "<a>", "<adv>", "VPcle"} and phrases[TARGAN][j].main.pos in {"<cnjsub>", "<prn>", "<n>", "<a>", "<adv>", "VPcle"}): # can look more precisely (prn vs adv, n vs adv, a vs n)
                 print "kor", phrases[TARGAN][j].prints()
                 t_lemla = phrases[TARGAN][j].main.lemla
                 if "notfound" in phrases[TARGAN][j].cat:
    
                  print "5.2"
                  if phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].guess == "*":
                    phrases[TRANAN][itr].cat = "spell&new " 
                    spn_words += 1
                  else:
                    phrases[TRANAN][itr].cat = "syn&wrong5 " 
                    inc_words += 1
                  phrases[TRANAN][itr].totarget = j
                  phrases[TARGAN][j].totransl = itr

                  if j+1 < len(phrases[TARGAN]) and phrases[TARGAN][j+1].compound == True and itr+1 < len(phrases[TRANAN]) and phrases[TRANAN][itr+1].compound == True:
                    phrases[TARGAN][j+1].totransl = itr + 1
                    phrases[TRANAN][itr+1].totarget = j + 1
                    phrases[TRANAN][itr].cat = "syn&wrongC " 
                    if j+1 in gapl:
                      gapl.remove(j+1)
                      gaps -= 1
                    if itr+1 in trgapl:
                      trgapl.remove(itr+1)
                  elif j+1 < len(phrases[TARGAN]) and phrases[TARGAN][j+1].compound == True: # and (itr+1 >= len(phrases[TRANAN]) or phrases[TRANAN][itr+1].compound == False):
                    phrases[TARGAN][j+1].totransl = itr
                    if itr+1 < len(phrases[TRANAN]) and phrases[TRANAN][itr+1].main.lemma == phrases[TARGAN][j+1].main.lemma:
                      phrases[TARGAN][j+1].totransl = itr + 1
                      phrases[TRANAN][itr+1].totarget = j + 1 
                      phrases[TRANAN][itr+1].cat = "wordokC " 
                      if itr+1 in trgapl:
                        trgapl.remove(itr+1)
                    if j+1 in gapl:
                      gapl.remove(j+1)
                      gaps -= 1

                  if  j in gapl:
                    gapl.remove(j)
                    gaps -= 1
                  if  itr in trgapl:
                    trgapl.remove(itr)
                  while kor >=0 and kor < len(phrases[TARGAN]) and phrases[TARGAN][kor].totransl >= 0:
                    kor += 1
                  break
                j += 1
            itr += 1  
           print "5.3"
           # lisa mwe, kus mitmene vastavus
      # end of gaps match

      s = -1
      ps = -1
      itr = 0
      print "6" # generate entries
      while itr < len(phrases[TRANAN]): # word in chunk IIIb
           if ("syn&wrong" in phrases[TRANAN][itr].cat or "spell&new" in phrases[TRANAN][itr].cat) and phrases[TRANAN][itr].tobiltrs >= 0 and phrases[TRANAN][itr].totarget >= 0: 
              lpos = "?"
              ps = s
              s = phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].tosource
              if s >= 0 and ps == s:
                itr += 1  
                continue
              bpos = phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].main.pos
              if s >= 0:
                bpos = phrases[SOURAN][s].main.pos
              if bpos == "?":
                bpos = "n" 
              if phrases[TRANAN][itr].main.pos != "np":
                lembtr = phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].main.lemla
              else:
                lembtr = phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].main.lemma
              if s >= 0:
                if phrases[TRANAN][itr].main.pos != "np":
                  lembtr = phrases[SOURAN][s].main.lemla
                else:
                  lembtr = phrases[SOURAN][s].main.lemma
              # add <prefix> if it is present
              lemtarr = ""              
              if phrases[TRANAN][itr].totarget+1 < len(phrases[TARGAN]) and phrases[TARGAN][phrases[TRANAN][itr].totarget+1].totransl == -1 and "notfound" in phrases[TARGAN][phrases[TRANAN][itr].totarget+1].cat:
            	lpos = phrases[TARGAN][phrases[TRANAN][itr].totarget+1].main.pos
                lemtarr = "__"+phrases[TARGAN][phrases[TRANAN][itr].totarget+1].main.lemma
              if phrases[TRANAN][itr].totarget+1 < len(phrases[TARGAN]):
                cmp_file.write("gener " +  phrases[TARGAN][phrases[TRANAN][itr].totarget].main.lemma + " " +  phrases[TARGAN][phrases[TRANAN][itr].totarget+1].main.lemma)
              if phrases[TRANAN][itr].totarget+1 < len(phrases[TARGAN]) and (phrases[TARGAN][phrases[TRANAN][itr].totarget+1].compound == True or phrases[TARGAN][phrases[TRANAN][itr].totarget+1].mwe == True): # and phrases[TARGAN][phrases[TRANAN][itr].totarget+1].main.pos == bpos:
                lemtar = phrases[TARGAN][phrases[TRANAN][itr].totarget].main
                lemtarr = phrases[TARGAN][phrases[TRANAN][itr].totarget+1].main                
                lpos = lemtarr.pos 
                if "<prefix>" in lemtarr.morph: # 1st!
                  lpos = lpos + '"/><s n="prefix'
                if phrases[TARGAN][phrases[TRANAN][itr].totarget+1].mwe == True:
                  lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemma+"__"+lemtarr.lemma+'<s n="'+lpos+'"/></r></p></e>\n') # + morph ?
                else:
                  lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemma+lemtarr.lemma+'<s n="'+lpos+'"/></r></p></e>\n')
              elif (phrases[TARGAN][phrases[TRANAN][itr].totarget].compound == True or phrases[TARGAN][phrases[TRANAN][itr].totarget].mwe == True): # and phrases[TARGAN][phrases[TRANAN][itr].totarget].main.pos == bpos:
                lemtar = phrases[TARGAN][phrases[TRANAN][itr].totarget-1].main
                lemtarr = phrases[TARGAN][phrases[TRANAN][itr].totarget].main
                lpos = lemtarr.pos 
                if "<prefix>" in lemtarr.morph: # 1st!
                  lpos = lpos + '"/><s n="prefix'
                if phrases[TARGAN][phrases[TRANAN][itr].totarget].mwe == True:
                  lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemma+"__"+lemtarr.lemma+'<s n="'+lpos+'"/></r></p></e>\n') # + morph ?
                else:
                  lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemma+lemtarr.lemma+'<s n="'+lpos+'"/></r></p></e>\n')
              elif lemtarr == "" and phrases[TARGAN][phrases[TRANAN][itr].totarget].main.pos == bpos:
                for lemtar in phrases[TARGAN][phrases[TRANAN][itr].totarget].readings:  # new bidix candidate (dif compounds! pos+form! gaps both ways!)
            	  lpos = lemtar.pos 
                  if "<prefix>" in lemtar.morph:
                    lpos = lpos + '"/><s n="prefix'
                  if bpos == lemtar.pos:
                    if bpos == "np":
                      lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemma+lemtarr+'<s n="'+lpos+'"/></r></p></e>\n')
                    else:
                      lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemla+lemtarr+'<s n="'+lpos+'"/></r></p></e>\n')
              else: # all 
                for lemtar in phrases[TARGAN][phrases[TRANAN][itr].totarget].readings:  # new bidix candidate (dif compounds! pos+form! gaps both ways!)
            	  lpos = lemtar.pos 
                  if bpos == "?":
                      bpos = "n"
                  if lpos == "?":
                      lpos = "n"
                  if bpos == lpos:
                    if "<prefix>" in lemtar.morph:
                      lpos = lpos + '"/><s n="prefix'
                    if bpos == "np":
                      lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemma+lemtarr+'<s n="'+lpos+'"/></r></p></e>\n')
                    else:
                      lex_file.write('    <e><p><l>'+lembtr+'<s n="'+bpos+'"/></l><r>'+lemtar.lemla+lemtarr+'<s n="'+lpos+'"/></r></p></e>\n')
           itr += 1  

      itr = 0
      print "7" # output relations
      i = 0
      pi2 = -1
      trlen = len(phrases[TRANAN])
      tarlen = len(phrases[TARGAN])
      while i < trlen: # nos
        if phrases[TRANAN][i].totarget < 0:
            phrases[TRANAN][i].color = "red"
        elif "punct" in phrases[TRANAN][i].cat or "ignore" in phrases[TRANAN][i].cat:
            phrases[TRANAN][i].color = "grey"
        else:
          pi1 = pi2 
          pi2 = phrases[TRANAN][i].totarget
          if i > 0 and pi1 >= 0 and pi2 >= 0:
            if pi1 <= pi2:
              phrases[TRANAN][i-1].color = "green"
              if i == trlen - 1:
                phrases[TRANAN][i].color = "green"  
            else:
              phrases[TRANAN][i-1].color = "blue"
              if i == trlen - 1:
                phrases[TRANAN][i].color = "blue"
        i += 1
      i = 0
      pi2 = -1
      while i < tarlen:
        if phrases[TARGAN][i].totransl < 0:
            phrases[TARGAN][i].color = "red"
        elif "punct" in phrases[TARGAN][i].cat or "ignore" in phrases[TARGAN][i].cat:
            phrases[TARGAN][i].color = "grey"
        else:
          pi1 = pi2 
          pi2 = phrases[TARGAN][i].totransl
          if pi2 < 0:
              phrases[TARGAN][i].color = "red"
          if i > 0 and pi1 >= 0 and pi2 >= 0:
            if pi1 <= pi2:
              phrases[TARGAN][i-1].color = "green"
              if i == tarlen - 1:
                phrases[TARGAN][i].color = "green"
            else:
              phrases[TARGAN][i-1].color = "blue"
              if i == tarlen - 1:
                phrases[TARGAN][i].color = "blue"
        i += 1

      while itr < len(phrases[TRANAN]): # word in chunk

        # cat   translation  -  target  -  biltrans
        cmp_file.write("\n" + phrases[TRANAN][itr].cat + "\t" + phrases[TRANAN][itr].main.word + ' ' + phrases[TRANAN][itr].prints() + "\t- ")
        for jj in range(len(phrases[TARGAN])): # can be multiple correspondences in target (gaps!)
          if jj > 0 and phrases[TARGAN][jj].totransl == -1 and phrases[TARGAN][jj-1].totransl == itr: # gap
            cmp_file.write(phrases[TARGAN][jj].prints() + ' ')
          if phrases[TARGAN][jj].totransl == itr: 
            cmp_file.write(phrases[TARGAN][jj].prints() + ' ')
        if "wordokc" not in phrases[TRANAN][itr].cat and phrases[TRANAN][itr].tobiltrs >= 0: 
          cmp_file.write("\t- " + phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].prints())
        else:
          cmp_file.write("\t- not related")
        print "8"

        # compounds
        #if phrases[TRANAN][itr].compound == True: 
        if phrases[TRANAN][itr].totarget >= 0 and phrases[TARGAN][phrases[TRANAN][itr].totarget].compound == True and phrases[TARGAN][phrases[TRANAN][itr].totarget-1].compound == False: 
          comp_parts += 1
          if phrases[TARGAN][phrases[TRANAN][itr].totarget-1].totransl == itr-1: 
            phrases[TRANAN][itr].compound = True # can be one word if one in biltrans (whole word in bidix: toidupood)
          ir = itr - 1
          if ir < 0:
            ir = 0
          #print phrases[TRANAN][ir].totarget, phrases[TRANAN][itr].totarget, len(phrases[TARGAN])
          if itr+1 < len(phrases[TRANAN]) and phrases[TRANAN][itr].totarget+1 < len(phrases[TARGAN]) and phrases[TARGAN][phrases[TRANAN][itr].totarget+1].compound == True: 
            rul_file.write("\n\n" + phrases[TRANAN][ir].main.word + "\t- " + phrases[TRANAN][itr].main.word + "\t- " + phrases[TRANAN][itr+1].main.word + "\t- " + phrases[TRANAN][ir].main.lemma + "\t- " + phrases[TRANAN][itr].main.lemma + "\t- " + phrases[TRANAN][itr+1].main.lemma)
          else: 
            rul_file.write("\n\n" + phrases[TRANAN][ir].main.word + "\t- " + phrases[TRANAN][itr].main.word + "\t- " + phrases[TRANAN][ir].main.lemma + "\t- " + phrases[TRANAN][itr].main.lemma)
          if phrases[TRANAN][ir].totarget >= 0 and phrases[TRANAN][ir].totarget+1 < len(phrases[TARGAN]): 
            rul_file.write("\n  " + phrases[TARGAN][phrases[TRANAN][ir].totarget].main.lemma + "  " + phrases[TARGAN][phrases[TRANAN][ir].totarget+1].main.lemma)
          elif phrases[TRANAN][ir].totarget >= 0: 
            rul_file.write("\n  " + phrases[TARGAN][phrases[TRANAN][ir].totarget].main.lemma)
          if phrases[TRANAN][itr].totarget >= 0 and phrases[TRANAN][itr].totarget > 0: 
            rul_file.write("\n  " + phrases[TARGAN][phrases[TRANAN][itr].totarget-1].main.lemma + "  " + phrases[TARGAN][phrases[TRANAN][itr].totarget].main.lemma)
          elif phrases[TRANAN][itr].totarget >= 0: 
            rul_file.write("\n  " + phrases[TARGAN][phrases[TRANAN][itr].totarget].main.lemma)
          
          if phrases[TRANAN][ir].tobiltrs >= 0 and len(phrases[BILTRS][phrases[TRANAN][ir].tobiltrs].readings) > 1: 
            rul_file.write("\n    " + phrases[BILTRS][phrases[TRANAN][ir].tobiltrs].prints())
          if phrases[TRANAN][itr].tobiltrs >= 0 and len(phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].readings) > 1: 
            rul_file.write("\n    " + phrases[BILTRS][phrases[TRANAN][itr].tobiltrs].prints())

        # count units
        print "8.5"
        if "punct" in phrases[TRANAN][itr].cat:
          punct += 1
        else:
          all_words += 1
          if "wordok" in phrases[TRANAN][itr].cat:
            ccor_words += 1  # forms are same
            if "1" not in phrases[TRANAN][itr].cat: 
              diff_lemma += 1
            if phrases[TRANAN][itr].main.word == phrases[TARGAN][phrases[TRANAN][itr].totransl].main.word: 
              diff_form += 1
              phrases[TRANAN][itr].cat = "wordok0 " # forms are different
          elif "lexsel" in phrases[TRANAN][itr].cat:
            csel_words += 1
          elif "syno" in phrases[TRANAN][itr].cat:
            syno_words += 1
          elif "syn&wrong" in phrases[TRANAN][itr].cat:
            cinc_words += 1
          elif "spell&new" in phrases[TRANAN][itr].cat:
            cspn_words += 1
          elif "ignore" in phrases[TRANAN][itr].cat:
            pron_words += 1
          elif "notfound" in phrases[TRANAN][itr].cat:
            nf_words += 1
          else:
            other =  other + ' ' + phrases[TRANAN][itr].cat
        itr = itr + 1      
    
      print "8.7"
      cmp_file.write("\n" + L1 + ":  " + print_phrase(phrases[SOURCE]) + L2 + ":  " + print_phrase(phrases[TARGET]) + "MT:   " + print_phrase(phrases[TRANSL]) + "BIL:\t" + print_phrase(phrases[BILTRS]) + L1 + " A:\t" + print_phrase(phrases[SOURAN]) + L2 + " A:\t" + print_phrase(phrases[TARGAN])+ "MT A:\t" + print_phrase(phrases[TRANAN]) + "\n\n")
      """cmp_file.write("\n" + cr + rd + "\n\t" + sou + "\n\t" + tar + "\n\t" + trans + "\n\t" + biltr + "\n\t" + sou_an + "\n\t" + tar_an + "\n\n")
      if rd == "ORD":
        ord_sents = ord_sents + 1
      if cr == "CORR":
        cor_sents = cor_sents + 1
      else:
        inc_sents = inc_sents + 1
      """
      print "8.8"
      try:
        phrases = phrases_itr.next()
      except StopIteration:
        break

  except IndexError:
    sys.stderr.write("Could not read phrase nr %i: \n%s" % (sentno, print_phrases(phrases)))
    sys.exit(1)

  print "9" 
  cmp_file.write("\n\n\nWords all(atomic): "+str(all_words)+"\tcorr:"+"\t"+str(ccor_words)+"\tincl diff lemma:"+"\t"+str(diff_lemma)+"\tincl diff forms:"+"\t"+str(diff_form)+"\tlexsel:"+"\t"+str(csel_words)+"\tincorr:"+"\t"+str(cinc_words)+"\tspell&new:"+"\t"+str(cspn_words)+"\tnotfound:"+"\t"+str(nf_words)+"\tpronouns:"+"\t"+str(pron_words)+"\tcompound parts (incl in all):"+"\t"+str(comp_parts)+"\tpunct\t"+str(punct)+str(other)+"\n")  # how many props?

  cmp_file.close()
  lex_file.close()
  rul_file.close()

def usage():
    sys.stderr.write("""Finds new bidictionary entries based on previous incomplete translations.  
    Usage: python comp.py [source] [target] [transl] [biltrans] [source_an] [target_an] [transl_an] \n""")

if __name__ == "__main__":

    if len(sys.argv)!=8:
        usage()
        sys.exit(1)
    sys.stderr.write(sys.argv[1] + " " + sys.argv[2] + " " + sys.argv[3] + " " + sys.argv[4] + " " + sys.argv[5] + " " + sys.argv[6] +  " " + sys.argv[7] + "\n")
    compare(sys.argv[1:8])

