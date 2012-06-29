
HGID.OLD=`hg -q id`
HGID=`hg parents --template='{node|short}'`
OUT.JS=glossary.js
IN.HTML=glossary.html

make.glossary.js: glossary.html Makefile
	@$(MAKE) OUT.JS=$(OUT.JS) documentation
	@$(MAKE) OUT.JS=$(OUT.JS) hgGlossaryId
	@echo "glossary_string= " >> $(OUT.JS)
	cat $(IN.HTML) | awk '{ print "'\''"  $$0 " '\'' + " }' >> $(OUT.JS)
	echo "' ' ;" >> $(OUT.JS)

hgGlossaryId:
	@echo "glossary_hg='http://dvcs.w3.org/hg/prov/file/$(HGID)/model/working-copy/glossary.html';"  >> $(OUT.JS)

documentation:
	@echo "//Automatically generated file, don't edit!"  > $(OUT.JS)
	@echo "//Include this $(OUT.JS) file in your specification"  >> $(OUT.JS)
	@echo "//  with <script src=\"$(OUT.JS)\" class=\"remove\"></script>"  >> $(OUT.JS)
	@echo "//Insert glossary definitions with the following "  >> $(OUT.JS)
	@echo "// <div class=\"glossary-ref\" ref=\"glossary-generation\"></div>"  >> $(OUT.JS)


# uses html2xhtml
# http://www.it.uc3m.es/jaf/html2xhtml/downloads/html2xhtml-1.1.2-2.tar.gz

WORKDIR=generated

xsl:
	html2xhtml -t 1.1 towards-wd4.html -o $(WORKDIR)/towards-wd4.xhtml
	html2xhtml -t 1.1 prov-dm-constraints.html -o $(WORKDIR)/prov-dm-constraints.xhtml
	grep -v mdash $(WORKDIR)/towards-wd4.xhtml | grep -v "/html" > $(WORKDIR)/towards-wd4-2.xhtml
	cat $(WORKDIR)/prov-dm-constraints.xhtml | sed -e "s/&le/le/g" | sed -e "s/&cup/cup/g" | sed -e "s/&ge/ge/g" | grep -v "/html" > $(WORKDIR)/prov-dm-constraints-2.xhtml
	csplit -f $(WORKDIR)/out $(WORKDIR)/towards-wd4-2.xhtml /body/
	echo "<html>" > $(WORKDIR)/all-divs.html
	xpath $(WORKDIR)/out01 .//div[@class] >> $(WORKDIR)/all-divs.html
	csplit -f $(WORKDIR)/out $(WORKDIR)/prov-dm-constraints-2.xhtml /body/
	xpath $(WORKDIR)/out01 .//div[@class] >> $(WORKDIR)/all-divs.html
	xpath $(WORKDIR)/out01 .//span[@class] >> $(WORKDIR)/all-divs.html
	echo "</html>" >> $(WORKDIR)/all-divs.html
	cat $(WORKDIR)/all-divs.html | sed -e "s/\'/\\\'/g" > $(WORKDIR)/all-divs2.html
	$(MAKE) make.all-divs.js

make.all-divs.js: $(WORKDIR)/all-divs2.html Makefile
	$(MAKE) OUT.JS=all-divs.js IN.HTML=$(WORKDIR)/all-divs2.html make.divs.js

hgDivsId:
	@echo "divs_hg='http://dvcs.w3.org/hg/prov/file/$(HGID)/model/working-copy/towards-wd4.html';"  >> $(OUT.JS)

make.divs.js: 
	@$(MAKE) OUT.JS=$(OUT.JS) documentation
	@$(MAKE) OUT.JS=$(OUT.JS) hgDivsId
	@echo "divs_string= " >> $(OUT.JS)
	cat $(IN.HTML) | awk '{ print "'\''"  $$0 " '\'' + " }' >> $(OUT.JS)
	echo "' ' ;" >> $(OUT.JS)





//	xpath towards-wd4.xhtml //div[@class='anexample']

