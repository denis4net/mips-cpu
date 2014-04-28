#!/usr/bin/python3


import sys

if __name__ == "__main__":
	fd = open(sys.argv[1], "r")
	fw = open(sys.argv[2], "w")
	c = fd.read()

	counter = 0 
	bytes = []
	for b in c.split():
		if b[0] == "@":
			continue

		bytes.append(b)
		counter += 1
		if counter == 4:
			counter = 0
			fw.write("%s%s%s%s\n" %(bytes[-1], bytes[-2], bytes[-3], bytes[-4]))

	fw.close()
	fd.close()