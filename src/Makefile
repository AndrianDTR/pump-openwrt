MAKEFLAGS += --no-print-directory

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
PKG_CONFIG ?= pkg-config

MKDIR ?= mkdir -p
INSTALL ?= install
CC ?= "gcc"

CFLAGS ?= -O2 -g
CFLAGS += -Wall 

SOURCES=pump.c pump.h version.h 
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE = pump

ifeq ($(V),1)
Q=
NQ=true
else
Q=@
NQ=echo
endif

all: $(EXECUTABLE) $(SOURCES) 

version.h:
	@$(NQ) ' Generate  ' $@
	$(Q)./version.sh $@
	
%.o: %.c version.h pump.h
	@$(NQ) ' CC  ' $@
	$(Q)$(CC) $(CFLAGS) -c -o $@ $<

pump: $(OBJECTS)
	@$(NQ) ' CC  ' $(EXECUTABLE)
	$(Q)$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $(EXECUTABLE)

check:
	$(Q)$(MAKE) all CC="REAL_CC=$(CC) CHECK=\"sparse -Wall\" cgcc"

%.gz: %
	@$(NQ) ' GZIP' $<
	$(Q)gzip < $< > $@

install: $(EXECUTABLE) pump.8.gz
	@$(NQ) ' INST pump'
	$(Q)$(MKDIR) $(DESTDIR)$(BINDIR)
	$(Q)$(INSTALL) -m 755 $(EXECUTABLE) $(DESTDIR)$(BINDIR)
	@$(NQ) ' INST pump.8'
	$(Q)$(MKDIR) $(DESTDIR)$(MANDIR)/man8/
	$(Q)$(INSTALL) -m 644 pump.8.gz $(DESTDIR)$(MANDIR)/man8/

clean:
	$(Q)rm -f $(EXECUTABLE) *.o *~ *.gz version.h *-stamp
