 #!/usr/bin/env python

 import sys

 if __name__ == "__main__":
 	command = int(sys.argv[1], 16)

 	decoded = {}
 	decoded["op"] = hex( (command >> 26) & 63)
 	decoded["rs"] = hex( (command >> 21) & 31)
 	decoded["rt"] = hex( (command >> 16) & 31)
 	decoded["rd"] = hex( (command >> 11) & 31)
 	decoded["shamt"] = hex( (command >> 6 ) & 31)
 	deocded["funct"] = hex( (command) & 63 )
