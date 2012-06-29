#!/bin/bash
#
#3> @prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
#3> @prefix dcterms: <http://purl.org/dc/terms/> .
#3> @prefix doap:    <http://usefulinc.com/ns/doap#> .
#3> @prefix :        <#> .
#3>
#3> <> a doap:Project;
#3>   dcterms:description "Script to process one-step owl:imports of OWL components.";
#3>   dcterms:creator <http://purl.org/twc/id/person/TimLebo>;
#3>   rdfs:seeAlso <http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/component-aggregations/aggregate.sh>;
#3>   :requires [ dcterms:title "rapper";
#3>               doap:download-page <http://librdf.org/raptor/INSTALL.html>;
#3>               doap:download-page <http://download.librdf.org/source/raptor2-1.9.1.tar.gz> ];
#3> .

if [ ! `which md5` ]; then
   echo "`basename $0` needs md5 to proceed"
   exit 1
fi

if [ ! `which rapper` ]; then
   echo "`basename $0` needs rapper to proceed; install http://download.librdf.org/source/raptor2-1.9.1.tar.gz"
   echo "see http://librdf.org/raptor/INSTALL.html "
   exit 1
fi

# Clean up any files we left behind before.
#
rm -f "_"`basename $0`*.tmp

# Decide where to place our temporary file.
#
TEMP="_"`basename $0``date +%s`_$$.tmp

# Build the list of component lists from the command line; if none, just do all of them.
#
component_list=""
while [[ $# -gt 0 && -e "$1" ]]; do
   component_list="$component_list $1"
   shift
done
if [[ ${#component_list} -eq 0 ]]; then
   component_list=`find . -name "*.ttl" | grep -v "\.prov.ttl" | sed 's/^\.\///'`
fi

for component_list_file in $component_list; do
   rm -f $TEMP
   component_list_url="http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/component-aggregations/${component_list_file}"
   component_list_url="${component_list_file}"
   closure_file=`echo $component_list_file | sed 's/.ttl$/.owl/'`
   echo "$component_list_url --=(closure)=--> $closure_file"

   if [ "$closure_file" == $component_list_file ]; then
      echo "ERROR: skipping $component_list_file because it would be overwritten by its closure."
      continue
   fi

   let input_count=0
   echo $components_list_url
   for component in `rapper -g -o ntriples $component_list_url 2> /dev/null | awk '$2 == "<http://www.w3.org/2002/07/owl#imports>"{print $3}' | sed 's/<//;s/>//'`; do
      let input_count=$input_count+1
      genid=`md5 -s $component | awk '{print $4}'`
      echo "   += $component"
      rapper -q -g -o ntriples $component | sed "s/_:genid/_:genid${genid}/g" >> $TEMP
      if [ $input_count -eq 1 ]; then
         echo "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> ."                                        >> $closure_file.prov.ttl
         echo "@prefix nfo:  <http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#> ."                >> $closure_file.prov.ttl
         echo "@prefix prov: <http://www.w3.org/ns/prov-o/> ."                                             >> $closure_file.prov.ttl
         echo "@prefix :     <#> ."                                                                        >> $closure_file.prov.ttl
         id=""
      else
         id="_$input_count"
      fi
      echo ""                                                                                              >> $closure_file.prov.ttl
      echo ":result"                                                                                       >> $closure_file.prov.ttl
      if [ $input_count -eq 1 ]; then
         echo "   nfo:fileURL <$closure_file>;"                                                            >> $closure_file.prov.ttl
         echo "   prov:wasDerivedFrom :component_list;"                                                    >> $closure_file.prov.ttl
      fi
         echo "   prov:wasDerivedFrom :input$id;"                                                          >> $closure_file.prov.ttl
         echo "   prov:qualifiedDerivation ["                                                              >> $closure_file.prov.ttl
         echo "      a prov:Derivation;"                                                                   >> $closure_file.prov.ttl
         echo "      prov:entity :input$id;"                                                               >> $closure_file.prov.ttl
         echo "      prov:time \"`date +%Y-%m-%dT%H:%M:%S%z | sed 's/\(..\)$/:\1/'`\"^^xsd:dateTime;"      >> $closure_file.prov.ttl
         echo "   ];"                                                                                      >> $closure_file.prov.ttl
      if [ $input_count -eq 1 ]; then
         echo "   a prov:Entity;"                                                                          >> $closure_file.prov.ttl
      fi
      echo "."                                                                                             >> $closure_file.prov.ttl
      if [ $input_count -eq 1 ]; then
         echo ""                                                                                           >> $closure_file.prov.ttl
         echo ":component_list"                                                                            >> $closure_file.prov.ttl
         echo "   nfo:fileURL <$component_list_url>;"                                                      >> $closure_file.prov.ttl
         echo "   a prov:Entity;"                                                                          >> $closure_file.prov.ttl
         echo "."                                                                                          >> $closure_file.prov.ttl
      fi
      echo ""                                                                                              >> $closure_file.prov.ttl
      echo ":input$id"                                                                                     >> $closure_file.prov.ttl
      echo "   nfo:fileURL <$component>;"                                                                  >> $closure_file.prov.ttl
      echo "   a prov:Entity;"                                                                             >> $closure_file.prov.ttl
      echo "."                                                                                             >> $closure_file.prov.ttl
   done
   rapper -q -i ntriples -o rdfxml-abbrev $TEMP > $closure_file
   echo "   ==-> $closure_file"
   rm -f $TEMP
done
