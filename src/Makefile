MAKEFLAGS += --no-print-directory

PREFIX ?= /usr/local
SBINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
PKG_CONFIG ?= pkg-config

MKDIR ?= mkdir -p
INSTALL ?= install
CC ?= "gcc"

CFLAGS ?= -O2 -g
CFLAGS += -Wall 

OBJS = pump_main.o version.o 

ALL = pump

ifeq ($(V),1)
Q=
NQ=true
else
Q=@
NQ=echo
endif

all: $(ALL)

VERSION_OBJS := $(filter-out version.o, $(OBJS))


%.o: %.c version.c pump.h
	@$(NQ) ' CC  ' $@
	$(Q)$(CC) $(CFLAGS) -c -o $@ $<

pump: $(OBJS)
	@$(NQ) ' CC  ' pump
	$(Q)$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o pump

check:
	$(Q)$(MAKE) all CC="REAL_CC=$(CC) CHECK=\"sparse -Wall\" cgcc"

%.gz: %
	@$(NQ) ' GZIP' $<
	$(Q)gzip < $< > $@

install: pump pump.8.gz
	@$(NQ) ' INST pump'
	$(Q)$(MKDIR) $(DESTDIR)$(SBINDIR)
	$(Q)$(INSTALL) -m 755 pump $(DESTDIR)$(SBINDIR)
	@$(NQ) ' INST pump.8'
	$(Q)$(MKDIR) $(DESTDIR)$(MANDIR)/man8/
	$(Q)$(INSTALL) -m 644 pump.8.gz $(DESTDIR)$(MANDIR)/man8/

clean:
	$(Q)rm -f pump *.o *~ *.gz version.c *-stamp
