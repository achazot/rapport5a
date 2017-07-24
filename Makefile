LFLAGS = -halt-on-error -interaction=nonstopmode -file-line-error
SRC = $(wildcard figures/*.svg)
OBJ = $(SRC:.svg=.pdf)
DOC = rapport
ERRCMD = ./check.sh $(DOC).log

all: figures tex
	

tex:
	@echo "\033[1;32m*** Compiling document\033[0m"
	@echo "\033[0;32m** \033[0m First pass\033[0m"
	@pdflatex $(LFLAGS) $(DOC).tex >/dev/null 2>&1 || $(ERRCMD)
	@echo "\033[0;32m** \033[0m Glossary\033[0m"
	@makeglossaries $(DOC) >/dev/null 2>&1
	@echo "\033[0;32m** \033[0m Final pass\033[0m"
	@pdflatex $(LFLAGS) $(DOC).tex >/dev/null 2>&1 || $(ERRCMD)
	@echo "\033[0;32m**  Done\033[0m"

figures: genmsg $(OBJ) genfmsg
	
genmsg:
	@echo "\033[1;32m*** Generating figures\033[0m"

genfmsg:
	@echo "\033[0;32m**  Done\033[0m"

%.pdf: %.svg
	@echo "\033[0;32m** \033[0m converting $< to $@\033[0m"
	@inkscape $< --export-pdf=$@ --export-text-to-path

clean:
	@echo "\033[1;32m*** Cleaning up\033[0m"
	@echo "\033[0;32m** \033[0m Figures\033[0m"
	@rm -f figures/*.pdf
	@echo "\033[0;32m** \033[0m LaTeX\033[0m"
	@rm -f *.toc
	@rm -f *.log
	@rm -f *.out
	@rm -f *.pdf
	@rm -f *.glg
	@rm -f *.glo
	@rm -f *.gls
	@rm -f *.ist
	@rm -f *.aux
	@rm -f *.swp
	@echo "\033[0;32m**  Done\033[0m"

optimize:
	@echo "\033[0;32m** \033[0m Compressing (2 pass)\033[0m"
	@./optimize.sh $(DOC).pdf >/dev/null 2>&1
	@./optimize.sh $(DOC).pdf >/dev/null 2>&1
