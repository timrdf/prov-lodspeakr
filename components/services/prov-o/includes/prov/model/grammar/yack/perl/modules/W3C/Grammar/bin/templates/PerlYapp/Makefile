PARSERS = ${Langname}.pm

parsers: $(PARSERS)

$(PARSERS): %.pm: %.yp
	yapp -v -s -o $@ $<

