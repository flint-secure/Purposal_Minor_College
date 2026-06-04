MAIN = proposal
CLS = ncitproject.cls
LATEX = xelatex
LATEXFLAGS = -interaction=nonstopmode -halt-on-error -file-line-error

UML_SRC = $(wildcard figures/uml/src/*.puml)
UML_PDF = $(patsubst figures/uml/src/%.puml,figures/uml/%.pdf,$(UML_SRC))

.PHONY: all pdf uml clean watch open

all: pdf

uml: $(UML_PDF)

figures/uml/%.pdf: figures/uml/src/%.puml scripts/build-uml.sh
	@chmod +x scripts/build-uml.sh
	@./scripts/build-uml.sh

pdf: uml $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(CLS) sections/*.tex $(UML_PDF)
	$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	$(LATEX) $(LATEXFLAGS) $(MAIN).tex
	$(LATEX) $(LATEXFLAGS) $(MAIN).tex

clean:
	rm -f $(MAIN).{aux,log,out,toc,lof,lot,fls,fdb_latexmk,synctex.gz}
	rm -f figures/uml/*.pdf

pdf-clean: clean pdf

clean-all: clean
	rm -f tools/plantuml.jar

watch:
	@echo "Re-run: make pdf  (or save in the editor with LaTeX Workshop)"
	@while true; do \
		inotifywait -qe modify $(MAIN).tex 2>/dev/null || sleep 2; \
		$(MAKE) pdf; \
	done

open: pdf
	open $(MAIN).pdf
