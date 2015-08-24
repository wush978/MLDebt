all : MLDept.html

%.html : %.md %.bib
	pandoc $< -o $@ --bibliography=MLDept.bib
