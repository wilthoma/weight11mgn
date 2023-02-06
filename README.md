# weight11mgn

This repository contains data and code accompanying our paper "Weight 11 compactly supported cohomology of moduli spaces of curves"

Euler characteristics of the weight 11 compactly supported cohomology of the moduli spaces of curves can be found in the file w11_eulerchar24.pdf.

To compute the Euler characteristics and reproduce the pdf follow the following steps:

1. The mathematica notebook contains code to produce  a table of the Euler characteristics as elements of the ring of symmetric functions, and save them ti file. (Say "test.sage")

2. Then, using sage run

sage dempose.sage test.sage -tex

to convert the Euler characteristic polynimals into an expression with Schur functions and run latex to produce the file "test.sage.pdF".

The result is then also written to polyout.txt for re-import into mathematica.




