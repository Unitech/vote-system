#!/usr/bin/python -O

import Image
import sys

if len(sys.argv) <= 1:
    sys.exit(1)
    
bop = Image.open(sys.argv[1])
a = bop.load()
print 'rgb' + str(a[0,0])
