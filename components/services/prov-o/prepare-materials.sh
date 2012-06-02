date > prepared-on.txt

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

#if [ ! -d ../../../static/prov-o-lode ]; then
#   mkdir ../../../static/prov-o-lode
#fi
# Pasted these into html.template
#pushd ../../../static/prov-o-lode
#   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/owl.css'
#   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/Primer.css'
#   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/rec.css'
#   curl -sO 'http://speronitomcat.web.cs.unibo.it:8080/LODE/extra.css'
#popd &> /dev/null

if [ ! -d prov-o-html-sections ]; then
   mkdir prov-o-html-sections
fi
pushd prov-o-html-sections
    curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/prov-o-html-sections/description-starting-points.inc.html
    curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/prov-o-html-sections/description-expanded-terms.inc.html
    curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/prov-o-html-sections/description-qualified-terms.inc.html
    curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/prov-o-html-sections/description-collections.inc.html
popd &> /dev/null

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
 
   touch beforefetch
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-9-provrdf-owl-coverage/rdf/create/rdf/eg-9-provrdf-owl-coverage.html.ttl
   # Examples
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-association.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-derivation.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-generation.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-qualified-usage.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/tip/ontology/khalid-jun-dropbox/eg16-journalism-simple-without-comments.ttl
   curl -sO http://dvcs.w3.org/hg/prov/raw-file/6bbc47ad770e/examples/eg-22-blog-original-source/rdf/eg-22-blog-original-source.ttl
   for ttl in `find . -name "*.ttl" -newer beforefetch`; do
      cat $ttl | sed 's/</\&lt;/g; s/>/\&gt;/g' > b
      mv b $ttl
   done
   rm beforefetch
popd &> /dev/null

cp includes/inverse-names.html ../../../static/
cp includes/inverses.ttl       ../../../static/
