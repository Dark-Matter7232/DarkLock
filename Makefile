# Darklock- Awesome yet  stupidly simple screen locker
# See LICENSE file for copyright and license details.

include config.mk

SRC = Darklock.c ${COMPATSRC}
OBJ = ${SRC:.c=.o}

all: options Darklock

options:
	@echo Darklock build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk arg.h util.h

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

Darklock: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f Darklock ${OBJ} Darklock-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p Darklock-${VERSION}
	@cp -R LICENSE Makefile README Darklock.1 config.mk \
		${SRC} explicit_bzero.c config.def.h arg.h util.h Darklock-${VERSION}
	@tar -cf Darklock-${VERSION}.tar Darklock-${VERSION}
	@gzip Darklock-${VERSION}.tar
	@rm -rf Darklock-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f Darklock ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/Darklock
	@chmod u+s ${DESTDIR}${PREFIX}/bin/Darklock
	@cp -f dilock ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dilock
	@chmod u+s ${DESTDIR}${PREFIX}/bin/dilock	
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" <Darklock.1 >${DESTDIR}${MANPREFIX}/man1/Darklock.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/Darklock.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/Darklock
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/Darklock.1

.PHONY: all options clean dist install uninstall
