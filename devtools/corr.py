#!/usr/bin/python3 -w
# -*- coding: utf8 -*-

import sys

def correlate():
  row = 1
  ins = 0
  i = 0
  pi = 1
  lemma = ""
  la = [[] for i in range(8)]
  try:
   while pi == 1:
      
    ins = 0
    i = 0
    lemma = ""
    la = [[] for i in range(8)]
    pi = 0
    line = sys.stdin.readline() 
    while len(line) > 0:
      l = line.strip() + " "
      if l.find("¶") >= 0:
        row += 1
        pi = 1
        la[ins].append(l)
        break
      if len(l) > 1:
        la[ins].append(l)
        if ins > 0 and len(la[ins-1]) > i:
          if la[ins-1][i][0] == '"' and la[ins-1][i][1] == '<':
            print(la[ins-1][i]) 
          else: 
            print("\t"+la[ins-1][i]+' '+"&correct") 
        if "\"^vastas\"" in l:
          j = i+1
          while ins > 0 and len(la[ins-1]) > j:
            if la[ins-1][j][0] == '"' and la[ins-1][j][1] == '<':
              print(la[ins-1][j]) 
            else: 
              print("\t"+la[ins-1][j]+' '+"&correct") 
            j += 1
          ins += 1
          i = -1
        i += 1
      row += 1
      line = sys.stdin.readline() 

    while ins > 0 and len(la[ins-1]) > i:
      #print(str(ins)+" "+str(len(la[ins-1]))+" "+ str(j)+" "+ str(j))
      if la[ins-1][i][0] == '"' and la[ins-1][i][1] == '<':
        print(la[ins-1][i]) 
      else: 
        print("\t"+la[ins-1][i]+' '+"&correct") 
      i += 1

    i = 0
    for word in la[ins]:
      if word[0] == '"' and word[1] == '<':
        tag = ""
        lemmac = 0
      else:
        lemma = word[:word.find('"', 2)+1]
      for insc in range(ins-1):
        cword = la[insc+1][i]
        if word[0] == '"' and word[1] == '<':
          if len(cword) > 0 and word == cword:
            lemmac = 2
            break 
        else: # lemma-hom synt prs-prt 
          if " Prs " in cword:
            tag += " c@prs" 
          if " Prt " in cword:
            tag += " c@prt" 
          inb = cword.find(" @")
          ine = cword.find(" ", inb+2)
          tag += " c@" + cword[inb+2:ine].lower() 
          
          if lemma in cword:
            if lemmac == 0:
              lemmac = 1
            ind = 1
            hom = 0
            ex = 0
            while ind > 0:
              ind = word.find(" Hom", ind+3)
              if ind > 0:
                hom = 1
                if cword.find(" Hom"+word[ind+4]) > 0:
                  ex = 1
            if hom == 1 and ex == 0 and lemmac == 1:  
              lemmac = 0
            break 

      if word[0] == '"' and word[1] == '<':
        print(word) 
      else: 
        if lemmac == 2 or lemma in "\"¶\"":
          tag += " &correct"
        elif lemmac == 0:
          tag += " &grm-wrong-word"
        print("\t"+word+tag) 
      i += 1
  except IndexError:
    sys.stderr.write("Could not read line nr %i: \n%s\n" % (row, line))
    sys.exit(1)


def usage():
    sys.stderr.write("""
    Usage: python3 corr.py < input > output \n""")

if __name__ == "__main__":

    if len(sys.argv)!=1:
        usage()
        sys.exit(1)
    correlate()

