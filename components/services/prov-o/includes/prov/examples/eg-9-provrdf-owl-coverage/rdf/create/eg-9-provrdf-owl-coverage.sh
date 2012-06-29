#!/bin/bash

if [ ! -e rdf ]; then
   mkdir rdf
fi

pushd rdf
   page='http://aquarius.tw.rpi.edu/prov-wg/provrdf-owl-coverage'
   curl $page                                                              > eg-9-provrdf-owl-coverage.html
   curl "http://www.w3.org/2007/08/pyRdfa/extract?format=turtle&uri=$page" > eg-9-provrdf-owl-coverage.html.ttl
popd
