intro:
	echo "Making all files
	for FOLDER in `ls`
	do
		[ ! -e $FOLDER/introduction.tex ] && continue
		pdflatex $FOLDER/introduction
		pdflatex $FOLDER/introduction
		biber $FOLDER/introduction
		pdflatex $FOLDER/introduction
	done
