LFLAGS = -halt-on-error -interaction=nonstopmode -file-line-error
SRC = $(wildcard figures/*.svg)
OBJ = $(SRC:.svg=.pdf)

all: figures tex
	

tex:
	pdflatex $(LFLAGS) rapport.tex
	makeglossaries rapport
	pdflatex $(LFLAGS) rapport.tex

figures: $(OBJ)

%.pdf: %.svg
	@echo converting $< to $@
	@inkscape $< --export-pdf=$@ --export-text-to-path

clean:
	rm -f figures/*.pdf
	rm -f *.toc
	rm -f *.log
	rm -f *.out
	rm -f *.pdf
	rm -f *.glg
	rm -f *.glo
	rm -f *.gls
	rm -f *.ist
	rm -f *.aux
	rm -f *.swp
