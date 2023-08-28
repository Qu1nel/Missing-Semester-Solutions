paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	./plot.py -i "$*.dat" -o "$@"

clean:
	rm -vrf paper.log
	rm -vrf paper.aux
	rm -vrf plot-data.png
	rm -vrf paper.pdf
