#!/bin/bash

if [ ! -e rdf ]; then
   mkdir rdf
fi

pushd rdf
   page='http://aquarius.tw.rpi.edu/prov-wg/prov-o'
   page='https://dvcs.w3.org/hg/prov/raw-file/default/ontology/Overview.html'
   curl $page                                                              > eg-28-prov-o-embedded-in-prov-o-html.html
   curl "http://www.w3.org/2007/08/pyRdfa/extract?format=turtle&uri=$page" > eg-28-prov-o-embedded-in-prov-o-html.ttl
popd
