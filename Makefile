PREFIX = /usr/local
NAME = weirdpass

all: install

install:
	mkdir -p $(PREFIX)/bin
	cp -f v1.2.0.bash $(PREFIX)/bin/$(NAME)
	chmod 755 $(PREFIX)/bin/$(NAME)

uninstall:
	rm -f $(PREFIX)/bin/$(NAME)

.PHONY: all install uninstall
