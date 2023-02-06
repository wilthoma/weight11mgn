
import argparse
import os

parser = argparse.ArgumentParser(
    description='Decompose symmetric functions in q[j] into Schur polynomials.')
parser.add_argument('filename', default="poly.sage", nargs="?",
                    help='name of the input file')
parser.add_argument(
    "-tex", help="Run latex on output file.", action="store_true")
parser.add_argument("-rows", type=int, nargs='?',
                    help="Maximum number of rows in table.", default=100)
parser.add_argument("-columns", type=int, nargs='?',
                    help="Maximum number of columns in table.", default=100)


args = parser.parse_args()

s = SymmetricFunctions(QQ).schur()
e = SymmetricFunctions(QQ).elementary()
q = SymmetricFunctions(QQ).power()

# load("poly.sage")
load(args.filename)

pd = [[s(f) for f in flist] for flist in p]

outs = "{" + ",".join(map(lambda l: "{" +
                      ",".join([str(f) for f in l]) + "}", pd)) + "}"

# To read back into mathematica...not used currently
o = open("polyout.txt", "w")
o.write(outs)
o.close()

nCols = min(maxC, args.columns)
nRows = min(maxC, args.rows)

outtex = "\\begin{tabular}{|g|" + "|".join(["M" for i in range(nCols+1)]) + "|} \\hline \\rowcolor{Gray}" + \
    " g,n & " + " & ".join([str(i)
                           for i in range(nCols+1)]) + "\\\\ \n\\hline\n"
for g in range(nRows+1):
    outtex += str(g)
    for n in range(nCols+1):
        outtex += " & $" + (latex(pd[g][n]) if g+n <= maxC and len(pd)>g and len(pd[g])>n else " ") + "$"
    outtex += " \\\\  \n\\hline\n"
outtex += "\\hline\n\\end{tabular}"
#"\\table" + ",".join( map(lambda l: "{" + ",".join( [latex(f) for f in l  ] ) + "}" , pd ) ) + "}"

o = open("table.tex", "w")
o.write(outtex)
o.close()

if (args.tex):
    os.system("pdflatex tabledoc.tex")
    os.system("cp tabledoc.pdf "+args.filename+".pdf")
