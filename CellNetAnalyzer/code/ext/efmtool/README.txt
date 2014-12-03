This directory contains a modified version of EFM Tool V2.33.00
For more information about EFM Tool consult
http://www.csb.ethz.ch/tools/efmtool
tmp is a symbolic link to /tmp; make sure to change this into something appropriate
if necessary; note that this directory will contain (possibly large) files with the
elementary modes after computation.
Some functions in CalculateFluxModes.m were modified; EFM Tool is now executed
in an external JVM when called from CellNetAnalyzer (the original file is
CalculateFluxModes.m.orig). java.opts contains the options for the external JVM. 
Do not use the original CalculateFluxModes.m together with CellNetAnalyzer as this
will result in malfunctioning of the latter (due to weird side effects of Matlab's
Java initialization procedure).
