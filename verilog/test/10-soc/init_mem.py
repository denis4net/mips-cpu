#!/usr/bin/python

import sys

mem_size = int(sys.argv[2])
mem_file = sys.argv[1]

fd = open(mem_file, "w")
for i in range(mem_size):
    fd.write("00000000\n")
    
fd.close()
