TEXMFHOME := $(shell kpsewhich -var-value TEXMFHOME)
SMCM_TEX  := $(TEXMFHOME)/tex/latex/playtex
PACKAGES  := psyc cosc math biol

default:
	$(info Run 'make install' to install my styles.)
	$(info Run 'sudo make tl-pgf' to update your TikZ to 3.0 (TeXLive, MacTeX).)
	$(info Run '     make mt-pgf' as an administrator; same as tl-, but for MiKTeX.)
	$(info Run 'make clean' to clean up.)

install:
	install -m 755 -d $(SMCM_TEX)
	install -m 644 exam-extensions.sty smcm-danda.sty smcm-math.sty $(SMCM_TEX)

tl-pgf:
	tlmgr update pgf

mt-pgf:
	mpm update=pgf

clean:
	$(info Nothing to do.)

docs:
	$(info Making introductions...)
	for folder in psyc biol; do \
		[ ! -e $$folder/introduction.tex ] && continue;
		arara $$folder/introduction
	done
	$(info Done.)
