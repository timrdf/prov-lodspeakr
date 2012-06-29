#!/bin/bash

for term in `cat extended-terms.txt`; do 
   count=`grep $term *.ttl | wc -l`
   echo $count $term
done
