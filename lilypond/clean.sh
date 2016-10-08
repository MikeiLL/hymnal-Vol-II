shopt -s extglob
rm sandbox.!(lytex)
rm hymnal.!(lytex)
find . -maxdepth 1 -type d -name '??' -exec rm -rf {} \;
rm tmp*
rm *.aux *.bcf *.dep *.out *.run.xml *.toc tmpx* *.sxd *.sbx snippet-map* snippet-names*
