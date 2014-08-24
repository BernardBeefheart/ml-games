#
# Makefile
# pour créer les exécutables du répertoire 'remember'

MLC = mlton
FSC = fsharpc --warn:5 --consolecolors+ --standalone --tailcalls+ --optimize+ 
# --out:fsfibo.exe fibo.fs
#
SMLEXES = o/remember.exe o/fibo.exe o/TestSig.exe
FSEXES = o/fsfibo.exe

fsexes: odir $(FSEXES)

smlexes: odir $(SMLEXES)

all: odir fsexes smlexes


o/%.exe: %.mlb %.sml
	$(MLC) -output $@ $<

o/fs%.exe: %.fs
	$(FSC) --out:$@ $<

odir: o

o:
	mkdir -p o

clean:
	rm -rfv $(SMLEXES) $(FSEXES)

.PHONY: all odir clean fsexes smlexes
