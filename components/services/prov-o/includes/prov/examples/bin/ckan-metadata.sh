#!/bin/bash
#
# Prints metadata of the examples in this directory, for listing on CKAN.
#
# e.g., for file eg-11-w3c-publication/asn/convert/rdf/eg-11-w3c-publication.n3.ttl:
#
#  <http://thedatahub.org/dataset/w3c-provenance-working-group-prov-examples>
#    a dcat:Dataset;
#    dcterms:hasPart <http://dvcs.w3.org/hg/prov/file/tip/examples/eg-11-w3c-publication> .
#
#  <http://dvcs.w3.org/hg/prov/file/tip/examples/eg-11-w3c-publication> a dcat:Dataset;
#     dcterms:title "eg-11-w3c-publication";
#     foaf:homepage <http://www.w3.org/mid/EMEW3|dfd9b4f11131321fb55e13247fb34d1ao1GCHn08L.Moreau|ecs.soton.ac.uk|4F3E4569.7000800@ecs.soton.ac.uk>;
#     foaf:homepage <http://www.w3.org/2011/prov/wiki/Eg-11-w3c-publication>;
#  .
#
# Usage:
#   bin/ckan-metadata.sh > meta/w3c-provenance-working-group-prov-examples.void.ttl

BASE="http://dvcs.w3.org/hg/prov/file/tip/examples"
RAW="http://dvcs.w3.org/hg/prov/raw-file/tip/examples"
DATAHUB="http://thedatahub.org/dataset/w3c-provenance-working-group-prov-examples"

echo "@prefix void:    <http://rdfs.org/ns/void#> ."
echo "@prefix dcterms: <http://purl.org/dc/terms/> ."
echo "@prefix dcat:    <http://www.w3.org/ns/dcat#> ."
echo "@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> ."
echo "@prefix foaf:    <http://xmlns.com/foaf/0.1/> ."
echo "@prefix prov:    <http://www.w3.org/ns/prov#> ."

for example in `find . -type d -name "eg-*"`; do
   example="${example#./}"
   echo
   echo "# $example"
   echo "<$DATAHUB>"
   echo "   a dcat:Dataset;"
   echo "   dcterms:hasPart <$BASE/$example> ."
   echo
   echo "<$BASE/$example> a dcat:Dataset;"
   echo "   dcterms:title \"$example\";"
   if [ -e $example/document/homepage ]; then
      for homepage in `cat $example/document/homepage`; do
         echo "   foaf:homepage <$homepage>;"
      done
   fi
   #for format in asn rdf xml json; do
   #done
   echo "."
done

for example in `find . -type d -name rdf`; do
   example="${example#./}"
   num="${example#eg-}"
   num="${num/-*/}"
   echo
   echo "# $example"
   echo "<$DATAHUB>"
   echo "   dcterms:hasPart <$BASE/$example>;"
   echo "."
   echo
   echo "<$BASE/$example>"
   echo "   a dcat:Dataset, void:Dataset;"
   echo "   dcterms:title \"$example\";"
   echo "   prov:hadLocation $num;"
   for dump in `find $example -name "*.rdf" -or -name "*.ttl" -or -name "*.nt" -or -name "*.trig"`; do
      dump="${dump#./}"
      echo "   void:dataDump <$RAW/$dump>;"
   done
   echo "."
   echo "<$RAW/$dump> dcterms:isPartOf <$DATAHUB> ."
done
