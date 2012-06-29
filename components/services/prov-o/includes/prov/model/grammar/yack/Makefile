PARSERS = prov_n_LL.pm

parsers: $(PARSERS)

$(PARSERS): %.pm: %.yp
	yapp -v -s -o $@ $<

