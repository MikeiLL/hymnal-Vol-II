arara hymnal.lytex
xelatex hymnal.tex
find . -maxdepth 1 -type d -name '??' -exec rm -rf {} \;
rm *.aux *.bcf *.dep *.out *.run.xml *.toc tmpx* snippet-map* snippet-names*
open hymnal.pdf
