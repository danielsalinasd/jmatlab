# convert an augmented matrix into a set of equations
# this module was made under the assumption that numpy has not been installed.
# i.e. do not use if you have numpy

def main(infile, outfile, namef):
	fh = open(infile,"r")
	ofh = open(outfile, "w")
	nfh = open(namef,"r")
	name = [ "r" + n.lstrip().rstrip() for n in nfh.readlines()[0].split(',') ]
	nfh.close()
	
	# read in each line, and process it.
	# the output of the processing is a tuple. the first is a list and the second is a coefficient.
	# see processing functions for more
	for l in fh.readlines():
		eq = getEquation(l)
		writeEq(eq, name, ofh)
	
	fh.close()
	ofh.close()

# returns a tuple
# first element is a list of tuples. the first element of these tuples is a nonzero coefficient and the second is the index of that coefficient.
# the second element is the last coefficient of the line.
# the list is supposed to encode an equation. for example, if the csv line reads '1,1,0,0'
# the resulting list should be [(1,0), (1,1)]
# and the last coefficient is a zero. 
# the equation this encondes is x0 + x1 = 0
# note: the last coefficient will always be excluded from the list of tuples, even if it is nonzero.
def getEquation(csvline):
	allcoeff = [ float(coeff) for coeff in csvline.split(',') ]
	return [ (coeff,index) for index, coeff in enumerate(allcoeff[:-1]) if coeff != 0 ], allcoeff[-1]

# expects a tuple
# first element is a list of tuples. the first element of these tuples is a nonzero coefficient and the second is the index of that coefficient.
# the second element is the last coefficient of the line.
# the list is supposed to encode an equation. for example, if the csv line reads '1,1,0,0'
# the resulting list should be [(1,0), (1,1)]
# and the last coefficient is a zero. 
# the equation this encondes is x0 + x1 = 0
# the variable names will be customized to the list provided. e.g. names = ["kk","jj"] yields kk + jj = 0
def writeEq(equation, name, outfile):
	eq = ""
	if not equation[0] :
		eq = "free variable"
	else :
		eq = " + ".join([ str(c) + name[i] for c, i in equation[0] ])
		eq = eq + " = " + str(equation[1]) + "\n"
	print equation
	outfile.write(eq)
	print eq
	return eq

# open csv that was given in the command line if the module is run from the command line
if __name__ == "__main__" :
	from sys import argv
	main(argv[1], argv[2], argv[3])

