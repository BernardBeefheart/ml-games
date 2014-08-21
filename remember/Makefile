#
# Makefile
# pour créer les exécutables du répertoire 'remember'

MLC = mlton

EXES = o/remember.exe o/fibo.exe o/TestSig.exe

all: odir $(EXES)

o/%.exe: %.mlb %.sml
	$(MLC) -output $@ $<

odir: o

o:
	mkdir -p o

clean:
	rm -rfv $(EXES)

.PHONY: all odir clean
