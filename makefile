intro:
	echo -n "Making introductions..."
	for folder in psyc biol; do \
		[ ! -e $$folder/introduction.tex ] && continue; \
		echo "Making $$folder..."                             >> make.log; \
		pdflatex $$folder/introduction -interaction=batchmode >> make.log && \
		pdflatex $$folder/introduction -interaction=batchmode >> make.log && \
		biber $$folder/introduction                           >> make.log && \
		pdflatex $$folder/introduction -interaction=batchmode >> make.log && \
		echo "Making $$folder... Done"                        >> make.log; \
	done
	echo " Done."
