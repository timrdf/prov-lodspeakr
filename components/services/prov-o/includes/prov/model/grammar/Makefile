
lr.provn:
	cd yack; PERL5LIB=perl/modules perl/modules/W3C/Grammar/bin/yacker -stubs -short -lang perl -o prov_n prov-n.bnf 
	cd yack; $(MAKE)

ll.provn:
	cd yack; PERL5LIB=perl/modules perl/modules/W3C/Grammar/bin/yacker -stubs -short -lang perl -o prov_n_LL prov-n-LL.bnf 
	cd yack; $(MAKE)

man.provn:
	cd yack; perldoc prov_n.pm

run.provn:
	cd yack; perl -Mprov_n -e test < sample.in 3> sample.trace

go.turtle:
	cd yack; PERL5LIB=perl/modules perl/modules/W3C/Grammar/bin/yacker -stubs -lang perl -o turtle turtle.bnf 
	cd yack; $(MAKE)

html:
	export QUERY_STRING="uploads/prov_n_LL/lang=perl&markup=html"; cd yack; PERL5LIB=perl/modules perl/modules/W3C/Grammar/bin/yacker DEBUG 10


do.ll.html:
	echo "<!DOCTYPE table [<!ENTITY nbsp   \"&#160;\">]> " > ll.html
	cat yack/prov-n-LL.bnf.html >> ll.html
#	xpath ll.html .//a[@id]/../../..
#	xpath ll.html .//a/@id
#	xpath ll.html .//a[@id == "term-prov_n_LL-PASSED_TOKENS"]/@id

OUT.JS=ll.js
IN.HTML=ll.html
IN2.HTML=tmp/ll2.html

do.ll.js: ll.provn do.ll.html
	@echo "grammar_string= " > $(OUT.JS)
	@cat $(IN.HTML) | sed -e "s/\d039/\\\'/g" | sed -e "s/prod-prov_n_LL/prod/g"  | sed -e "s/term-prov_n_LL/prod/g" | sed -e "s/((/(/g" | sed -e "s/))/)/g"   | sed -e "s/timeZZ/time/g" | sed -e "s/\d035prod-PN_PREFIX/http:\d047\d047www.w3.org\d047TR\d047rdf-sparql-query\d047\d035rPN_LOCAL/g" | sed -e "s/\d035prod-PN_CHARS_U/http:\d047\d047www.w3.org\d047TR\d047rdf-sparql-query\d047\d035rPN_CHARS_U/g"  | sed -e "s/\d035prod-ECHAR/http:\d047\d047www.w3.org\d047TR\d047rdf-sparql-query\d047\d035rECHAR/g"  | sed -e "s/\d035prod-STRING_LITERAL2/http:\d047\d047www.w3.org\d047TR\d047rdf-sparql-query\d047\d035rSTRING_LITERAL2/g" | sed -e "s/\d035prod-IRI_REF/http:\d047\d047www.w3.org\d047TR\d047rdf-sparql-query\d047\d035rIRI_REF/g"  | sed -e "s/\d035prod-PN_CHARS\"/http:\d047\d047www.w3.org\d047TR\d047rdf-sparql-query\d047\d035rPN_CHARS\"/g" > $(IN2.HTML)
	@cat $(IN2.HTML) | awk '{ print "'\''"  $$0 " '\'' + " }' >> $(OUT.JS)
	@echo "' ' ;" >> $(OUT.JS)


run1:
	cd yack; perl -Mprov_n -e test < sample2.in 3> sample2.trace


run2:
	cd yack; perl -Mprov_n -e test < sample3.in 3> sample3.trace



