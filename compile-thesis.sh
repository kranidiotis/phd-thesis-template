#!/bin/bash
# A script to compile the PhD Thesis - Krishna Kumar 
# Updated to use xelatex Demitris G. Anastasiou 
# Distributed under GPLv2.0 License

compile="compile";
xelatex="xelatex";
clean="clean";
#mknomencl="mknomencl";

if test -z "$2"
then
if [ $1 = $clean ]; then
	echo "Cleaning please wait ..."
	rm -f *~
	rm -rf *.aux
	rm -rf *.bbl
	rm -rf *.blg
	rm -rf *.d
	rm -rf *.fls
	rm -rf *.ilg
	rm -rf *.ind
	rm -rf *.toc*
	rm -rf *.lot*
	rm -rf *.lof*
	rm -rf *.log
	rm -rf *.idx
	rm -rf *.out*
	rm -rf *.nlo
	rm -rf *.nls
	rm -rf $filename.pdf
	rm -rf $filename.ps
	rm -rf $filename.dvi
	rm -rf *#* 
	echo "Cleaning complete!"
	exit
else
	echo "Shell script for compiling the PhD Thesis"
	echo "Usage: sh ./compile-thesis.sh [OPTIONS] [filename]"
	echo "[option]  compile: Compiles the PhD Thesis"
	echo "[option]  xelatex: Compile the PhD thesis using xelatex"
	echo "[option]  clean: removes temporary files no filename required"
#	echo "[oprion]  mknomecl: run after the first run for nomeclatures"
	exit
fi
fi

filename=$2;

if [ $1 = $clean ]; then
	echo "Cleaning please wait ..."
	rm -f *~
	rm -rf *.aux
	rm -rf *.bbl
	rm -rf *.blg
	rm -rf *.d
	rm -rf *.fls
	rm -rf *.ilg
	rm -rf *.ind
	rm -rf *.toc*
	rm -rf *.lot*
	rm -rf *.lof*
	rm -rf *.log
	rm -rf *.idx
	rm -rf *.out*
	rm -rf *.nlo
	rm -rf *.nls
	rm -rf $filename.pdf
	rm -rf $filename.ps
	rm -rf $filename.dvi
	rm -rf *#* 
	echo "Cleaning complete!"
	exit
elif [ $1 = $compile ]; then
	echo "Compiling your PhD Thesis...please wait...!"
	pdflatex -interaction=nonstopmode $filename.tex
	bibtex $filename.aux 	
	makeindex $filename.aux
	makeindex $filename.idx
	makeindex $filename.nlo -s nomencl.ist -o $filename.nls
	pdflatex -interaction=nonstopmode $filename.tex
	makeindex $filename.nlo -s nomencl.ist -o $filename.nls
	pdflatex -interaction=nonstopmode $filename.tex
	echo "Success!"
	exit
elif [ $1 = $xelatex ]; then
	echo "Compiling your PhD Thesis...please wait...!"
# 	latexmk -pdf -e '$pdflatex=q/xelatex %O %S/' $filename
# 	makeindex $filename.aux
# 	makeindex $filename.idx
# 	makeindex $filename.nlo -s nomencl.ist -o $filename.nls
#	latexmk -pdf -e '$pdflatex=q/xelatex %O %S/' $filename   # <<-- old compilation style
	latexmk -xelatex $filename.tex				# <<-- NEW compilation after 26 May 17
	makeindex $filename.nlo -s nomencl.ist -o $filename.nls
	latexmk -xelatex -g -f $filename.tex


	echo "Success!"
	exit
#elif [ $1 = $mknomencl ]; then
#	echo "Compiling nlo files...please wait...!"
#	makeindex $filename.nlo -s nomencl.ist -o $filename.nls
#	echo "Success!"
#	exit
else
	echo "Shell script for compiling the PhD Thesis"
	echo "Usage: sh ./compile-thesis.sh [OPTIONS] [filename]"
	echo "[option]  compile: Compiles the PhD Thesis"
	echo "[option]  xelatex: Compile the PhD thesis using xelatex"
	echo "[option]  clean: removes temporary files no filename required"
#	echo "[option]  mknomencl: run after the first run for nomeclatures"
	exit
fi


if test -z "$3"
then
	exit
fi
