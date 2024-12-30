# MYORG is a string that identifies the configuration
MYORG ?= myorg
CACHEPATH=~/Library/AutoPkg/Cache/com.github.gallen.pkg.SplunkForwarder
PKG=$(CACHEPATH)/$(MYORG)-SplunkForwarder-*.pkg

PKG_EXPAND_PATH=$(CACHEPATH)/expand
PKG_EXPAND=$(PKG_EXPAND_PATH)/Bom

all: pkg

clean:
	rm -f $(PKG)
	rm -rf $(PKG_EXPAND_PATH)

realclean:
	rm -rf $(CACHEPATH)

.PHONY: clean realclean expand install

pkg: $(PKG)
$(PKG):
	autopkg run -vvv -k NAME=$(MYORG)-SplunkForwarder -k SPLUNK_LOCAL=$(MYORG)_splunk_local SplunkForwarder.pkg

expand: $(PKG_EXPAND)
$(PKG_EXPAND) : $(PKG)
	pkgutil --expand $< `dirname $@`
	@cd `dirname $@` && cpio -i -I Payload
	@cd `dirname $@` && lsbom Bom > Bom.txt

install: $(PKG)
	installer -pkg $< -target / -verbose
