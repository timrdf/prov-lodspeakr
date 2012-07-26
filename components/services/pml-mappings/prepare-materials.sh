if [ ! -d includes ]; then
   mkdir includes
fi
pushd includes
   if [ ! -e prov ]; then
      hg clone https://dvcs.w3.org/hg/prov/
   else
      pushd prov &> /dev/null
         hg pull
         hg update
         changeset=`hg log | head -1 | sed 's/^.*://'`
      popd &> /dev/null
   fi

   echo $changeset > changeset.txt
   owlURLversion="http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl"
   owlURLversion="http://dvcs.w3.org/hg/prov/raw-file/$changeset/ontology/ProvenanceOntology.owl"
   #owlURLversion="http://dvcs.w3.org/hg/prov/raw-file/cf7deb6c5f3e/ontology/ProvenanceOntology.owl"
   curl -sO $owlURLversion
   .././cross-reference.py $owlURLversion ProvenanceOntology.owl prov
 
popd &> /dev/null
