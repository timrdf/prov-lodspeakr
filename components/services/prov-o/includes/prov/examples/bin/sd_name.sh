#!/bin/bash
# 
# Creates a .sd_name file corresponding to any RDF file in this examples directory.
# The .sd_name files used by https://github.com/timrdf/DataFAQs/blob/master/bin/df-load-triple-store.sh 
# to load each file into a different named graph.
#
# Tim Lebo

BASE="http://dvcs.w3.org/hg/prov/file/tip/examples"
RAW="http://dvcs.w3.org/hg/prov/raw-file/tip/examples"

for example in `find . -type d -name rdf`; do
   example="${example#./}"
   echo
   for dump in `find $example -name "*.rdf" -or -name "*.ttl" -or -name "*.nt" -or -name "*.trig"`; do
      dump="${dump#./}"
      echo " $dump.sd_name"
      echo "$RAW/$dump" > $dump.sd_name
   done
done
