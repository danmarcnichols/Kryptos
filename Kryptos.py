# -*- coding: utf-8 -*-
"""
Created on Mon Feb 25 21:39:26 2019

@author: Danma
"""
#from pycipher import Vigenere
import numpy as np
import pandas as pd
#print Vigenere('KRYPTOS').decipher('EMUFPHZLRFAXYUSDJKZLDKRNSHGNFIVJYQTQUXQBQVYUVLLT\
#                              REVJYQTMKYRDMFDVFPJUDEEHZWETZYVGWHKKQETGFQJNCEGG\
#                              WHKK?DQMCPFQZDQMMIAGPFXHQRLGTIMVMZJANQLVKQEDAGDV\
#                              FRPJUNGEUNAQZGZLECGYUXUEENJTBJLBQCRTBJDFHRRYIZET\
#                              KZEMVDUFKSJHKFWHKUWQLSZFTIHHDDDUVH?DWKBFUFPWNTDF\
#                              IYCUQZEREEVLDKFEZMOQQJLTTUGSYQPFEUNLAVIDXFLGGTEZ\
#                              ?FKZBSFDQVGOGIPUFXHHDRKFFHQNTGPUAECNUVPDJMQCLQUM\
#                              UNEDFQELZZVRRGKFFVOEEXBDMVPNFQXEZLGREDNQFMPNZGLF\
#                              LPMRJQYALMGNUVPDXVKPDQUMEBEDMHDAFMJGZNUPLGEWJLLAE\
#                              TG')

inp = 'EMUFPHZLRFAXYUSDJKZLDKRNSHGNFIVJYQTQUXQBQVYUVLLTREVJYQTMKYRDMFDVFPJUDEE\
HZWETZYVGWHKKQETGFQJNCEGGWHKK?DQMCPFQZDQMMIAGPFXHQRLGTIMVMZJANQLVKQEDAGDVFRPJU\
NGEUNAQZGZLECGYUXUEENJTBJLBQCRTBJDFHRRYIZETKZEMVDUFKSJHKFWHKUWQLSZFTIHHDDDUVH?\
DWKBFUFPWNTDFIYCUQZEREEVLDKFEZMOQQJLTTUGSYQPFEUNLAVIDXFLGGTEZ?FKZBSFDQVGOGIPUF\
XHHDRKFFHQNTGPUAECNUVPDJMQCLQUMUNEDFQELZZVRRGKFFVOEEXBDMVPNFQXEZLGREDNQFMPNZGL\
FLPMRJQYALMGNUVPDXVKPDQUMEBEDMHDAFMJGZNUPLGESWJLLAETG'

# segment K1 and K2 so that they can be processes independently
inpt = list(inp)[:63]
inpt2 =list(inp)[63:]
q = [i for i, x in enumerate(inpt) if x == "?"]
q2 = [i for i, x in enumerate(inpt2) if x == "?"]
ques = len(q)
ques2 = len(q2)
q.reverse()
q2.reverse()
for i in q:
    del inpt[i]
    
for i in q2:
    del inpt2[i]
# %% K1 Panel
full = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
al = list(full)
first = list('KRYPTOS')
second = list('PALIMPSEST')

headings = al
for i in first:
    headings.remove(i)
headings = first + headings
total = []
for i in second:
    lc = headings.index(i)
    temp = headings[lc:] + headings[:lc]
    total = total + temp
    
tot = np.array(total)
x = np.reshape(tot,(len(second),26))

df = pd.DataFrame(x, columns=headings)
                   
i = 0
out = []
k = 0
while i < len(inpt):

    tt = list(df.iloc[k,:])
    out = out + [headings[tt.index(inpt[i])]]
    k+= 1
    if k > len(second)-1:
        k=0
    i += 1

print (out)

# %% K2 Panel
full = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
al = list(full)
first = list('KRYPTOS')
third = list('ABSCISSA')

headings = al
for i in first:
    headings.remove(i)
headings = first + headings
total = []
for i in third:
    lc = headings.index(i)
    temp = headings[lc:] + headings[:lc]
    total = total + temp
    
tot = np.array(total)
x = np.reshape(tot,(len(third),26))
df = pd.DataFrame(x, columns=headings)
                   
i = 0
out = []
k = 0
while i < len(inpt2):

    tt = list(df.iloc[k,:])
    out = out + [headings[tt.index(inpt2[i])]]
    k+= 1
    if k > len(third)-1:
        k=0
    i += 1

print (out)