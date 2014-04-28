#!/usr/bin/python

import sys

def error(errcode=-1):
	print("cmd.py <i|r> <e|d> <cmd specific fields>")
	sys.exit(-1)

if __name__ == "__main__":
	if (len(sys.argv) < 3):
		error()

	itype = sys.argv[1]
	act = sys.argv[2]
	
	if itype == "i":
		if act == "e":
			op = int(sys.argv[3], 16)
			rs = int(sys.argv[4], 16)
			rt = int(sys.argv[5], 16)
			imm = int(sys.argv[6], 16)

			comm = ((op & 63) << 25 ) | ((rs & 31) << 20 ) | (( rt & 31) << 15 ) | (imm & 0xFFFF)
			print(hex(comm))
		elif act == "d":
			error()
		else:
			error()

	elif itype == "r":
		if act == "e":
			error()
		elif act == "d":
			command = int(sys.argv[3], 16)
			decoded = {}
			decoded["op"] = hex( (command >> 26) & 63)
			decoded["rs"] = hex( (command >> 21) & 31)
			decoded["rt"] = hex( (command >> 16) & 31)
			decoded["rd"] = hex( (command >> 11) & 31)
			decoded["shamt"] = hex( (command >> 6 ) & 31)
			decoded["funct"] = hex( (command) & 63 )
			print(decoded)
		else:
			error()
	else:
		error()


	