FLUX=/usr/local/bin/flux
CURL=/usr/bin/curl

all: install

clean:
	-rm install_flux.sh

install: $(FLUX)

$(FLUX): | install_flux.sh
	./$|

install_flux.sh: | $(CURL)
	$(CURL) -fsSLo $@ https://fluxcd.io/install.sh
	chmod +x $@