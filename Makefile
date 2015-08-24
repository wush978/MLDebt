all : MLDept1.out

%.out : %.md
	Rscript compile.R $< $@

clean :
	-rm -rf *.out