#!/bin/bash
#
# Script to setup directory structure according to
# http://www.w3.org/2011/prov/wiki/PROV_examples_-_directory_conventions
# Run without arguments for usage.

if [[ $# -eq 0 || "$1" == "--help" ]]; then
   echo "usage: bin/`basename $0` [-n] title-using-dashes {asn, rdf, xml, json}+"
   echo "  invoke from http://dvcs.w3.org/hg/prov/file/tip/examples"
   echo "  -n : dry run; do not make the directory"
   exit 1
fi

dryRun="no"
if [ "$1" == "-n" ]; then
   dryRun="yes" 
   shift
fi

if [ "$1" == "--id" ]; then # Hidden feature
   count="$2"
   shift 2
else
   count=`find . -maxdepth 1 -name "eg-*" | wc -l`
   let "count=count+1"
fi

title="$1"
shift

eg="eg-$count-$title" 
echo $eg

echo "   $eg/document/homepage"
if [ $dryRun == "no" ]; then
   mkdir -p $eg/document
   echo "http://www.w3.org/2011/prov/wiki/E${eg#e}"         > $eg/document/homepage
   echo "http://dvcs.w3.org/hg/prov/file/tip/examples/$eg" >> $eg/document/homepage
fi

while [ $# -gt 0 ]; do
   format="$1"

   echo
   echo "   $eg/$format"
   if [ $dryRun == "no" ]; then
      mkdir -p $eg/$format
   fi

   for stub in `find eg-?-$format-stub/$format -name "eg-?-$format-stub.*"`; do
      ext=${stub#*stub.}
      echo "   $eg/$format/$eg.$ext <- $stub"
      if [ $dryRun == "no" ]; then
         if [ $format == "rdf" ]; then
            cat $stub | sed "s/eg-2-rdf-stub/$eg/g" > $eg/$format/$eg.$ext
         else
            cp $stub $eg/$format/$eg.$ext
         fi
      fi
   done

   shift
done

echo
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
echo "Go start your wiki page at http://www.w3.org/2011/prov/wiki/E${eg#e}, putting this into the page:"
echo
echo "{{PROV example}}"
echo
echo "* author:"
echo
echo "== Identify the problem =="
echo "== The use of provenance =="
echo "== The PROV example =="
echo "* http://dvcs.w3.org/hg/prov/file/tip/examples/$eg"
echo "== How PROV is accessed and queried? =="
echo
echo "[[Category:PROV example]]"
