all : MLDept.html

%.html : %.md
	pandoc $< -o $@
