touch beforefetch
curl -O http://dvcs.w3.org/hg/prov/raw-file/tip/examples/eg-9-provrdf-owl-coverage/rdf/create/rdf/eg-9-provrdf-owl-coverage.html.ttl
for ttl in `find . -newer beforefetch`; do
   cat $ttl | sed 's/</\&lt;/g; s/>/\&gt;/g' > b
   mv b $ttl
done
rm beforefetch
