all:
	pdflatex rapport.tex
	makeglossaries rapport
	pdflatex rapport.tex
