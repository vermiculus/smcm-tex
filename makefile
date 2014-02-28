TEXMFHOME := $(shell kpsewhich -var-value TEXMFHOME)
SMCM_TEX  := $(TEXMFHOME)/tex/latex/smcm-tex/
PACKAGES  := psyc cosc math biol
INSTALL   := install -m 644

default:
	$(info Run 'make install' to install my styles.)
	$(info Run 'sudo make tl-pgf' to update your TikZ to 3.0 (TeXLive, MacTeX).)
	$(info Run '     make mt-pgf' as an administrator; same as tl-, but for MiKTeX.)
	$(info Run 'make clean' to clean up.)

all:
	@$(MAKE) install
	@$(MAKE) util
	@$(MAKE) cosc
	@$(MAKE) math
	@$(MAKE) psyc
	@$(MAKE) biol

install:
	install -m 755 -d $(SMCM_TEX)

cosc:
	$(INSTALL) smcm-tex/cosc/smcm-cosc-smp.cls $(SMCM_TEX)
	$(INSTALL) smcm-tex/cosc/smcm-cosc-danda.sty $(SMCM_TEX)

math:
	$(INSTALL) smcm-tex/math/smcm-math.sty $(SMCM_TEX)

psyc:
	$(INSTALL) smcm-tex/psyc/smcm-psyc-paper.cls $(SMCM_TEX)

biol:
	$(INSTALL) smcm-tex/biol/smcm-biol.sty $(SMCM_TEX)

util:
	$(INSTALL) smcm-tex/util/exam-extensions.sty $(SMCM_TEX)

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
