if [ ! -d ../../../static/prov-o-diagrams ]; then
   mkdir ../../../static/prov-o-diagrams
fi
pushd ../../../static/prov-o-diagrams
   # Diagrams
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/diagram-simple.png
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/Qualified-Association.png
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/involvements.png
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/Starting-points-terms.png
popd &> /dev/null

if [ ! -d ../../../static/prov-o-lode ]; then
   mkdir ../../../static/prov-o-lode
fi
pushd ../../../static/prov-o-lode
   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/owl.css'
   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/Primer.css'
   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/rec.css'
   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/extra.css'
popd &> /dev/null

if [ ! -d includes ]; then
   mkdir includes
fi
pushd includes
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl
   .././cross-reference.py http://dvcs.w3.org/hg/prov/raw-file/default/ontology/ProvenanceOntology.owl ProvenanceOntology.owl prov
 
   touch beforefetch
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-9-provrdf-owl-coverage/rdf/create/rdf/eg-9-provrdf-owl-coverage.html.ttl
   # Examples
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-association.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-derivation.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-generation.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-usage.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-simple-without-comments.ttl
   for ttl in `find . -name "*.ttl" -newer beforefetch`; do
      cat $ttl | sed 's/</\&lt;/g; s/>/\&gt;/g' > b
      mv b $ttl
   done
   rm beforefetch
popd &> /dev/null
