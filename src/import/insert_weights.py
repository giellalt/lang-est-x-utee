#!/usr/bin/env python3

import sys
import math
#import os
#import inspect

class WEIGHTS:
    max_weight=0 # max weight in dict; any word not in dict should get weight bigger than that
    rank={}

    def read_dict(self, rank_dict):
         for line in rank_dict:
            line = line.strip()
            if len(line)==0:
                continue
            parts = line.split(' ')
            if len(parts) != 2:
                print('Rank file input line error: "'+line+'" --> ', parts, file=sys.stderr)
                sys.exit(0)
            self.rank[parts[1]] = parts[0]
            if int(parts[0]) > int(self.max_weight):
                self.max_weight = parts[0]

    def insert_weights(self, fin, fout):
        """
        :param fin: sisendfail, selle järgi arvutame sagedusastaku; sõnad on sageduse järgi järjestatud
        :param fout: väljundfail, siia kirjutame leitud sagedusastaku
        """
        for line in fin:
            piece = line.split(';',1)  # split the line in two so that weight can be inserted
            if len(piece)==0:
                print(line, file=fout, end='')
                continue
            lexical = piece[0].split('+',1)  # lexical side (lemma etc)
            if len(lexical) < 2:
                print(line, file=fout, end='')
                continue
            tt = lexical[0].split('!',1)  # is it a comment ?
            if len(tt) != 1:
                print(line, file=fout, end='')
                continue
            tt = lexical[0].rsplit('@', 1)
            lemma = tt[len(tt)-1]
            lemma = lemma.strip()
            #ww = self.max_weight + 1
            ww = self.max_weight
            if lemma in self.rank:
                ww = self.rank[lemma]
            print(piece[0], "\"weight:", ww, "\" ;", piece[1], file=fout, end='')




def usage(self, exit_value):
    print('süntaks:', sys.argv[0], "astakute_fail {-|algne_lexifail} {-|kaaludega_lexifail}\n", file=sys.stderr)
    sys.exit(exit_value)


if __name__ == "__main__":
    weights=WEIGHTS()
    if len(sys.argv) != 4:
        usage(0)

    fin=sys.stdin       # from std-in
    fout=sys.stdout     # to std-out
    try:
        rank_dict = open(sys.argv[1], 'r')
    except IOError:
        print("Ei suuda avada astakute faili:", sys.argv[1], file=sys.stderr)
        usage(0)
    if (sys.argv[2] != '-'):
        try:
            fin = open(sys.argv[2], 'r')
        except IOError:
            print("Ei suuda avada sisendfaili:", sys.argv[2], file=sys.stderr)
            usage(0)

    if (sys.argv[3] != '-'):
        try:
            fout = open(sys.argv[3], 'w')
        except IOError:
            print("Ei suuda luua väljundfaili:", sys.argv[3], file=sys.stderr)
            usage(0)

    weights.read_dict(rank_dict)
    weights.insert_weights(fin, fout)



