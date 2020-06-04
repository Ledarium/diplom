#!/bin/bash
if [ -z "$MYTEX_DIR" ]; then
    MYTEX_DIR=.
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [ "$1" == "--full" ]; then
    rm -rf $DIR/out
    mkdir $DIR/out
fi
if [ "$MYTEX_DIR" != "$DIR" ]; then
    cp -f $MYTEX_DIR/CMakeLists.txt $DIR/
    cp -f $MYTEX_DIR/build.sh $DIR/
    cp -f $MYTEX_DIR/tex/preamble.inc.tex $DIR/tex/
fi
cp $DIR/bib/* $DIR/out/
cp $DIR/tex/* $DIR/out/
cp $DIR/img/* $DIR/out/
cd $DIR/out

if [ "$1" == "--full" ]; then
	cmake ..
	make
elif [ "$1" == "--short" ]; then
	xelatex out.tex
else
	xelatex --no-pdf out.tex
	biblatex out.tex
	xelatex out.tex
fi
cd $DIR/
pdftk shit/*.pdf out/out.pdf doc/case/PDF/*.PDF cat output out/full.pdf
pdftk out/out.pdf cat 1 output shit/50-ref.pdf

cd $DIR/slides
./make_slides.sh

cd $DIR/
cp slides/slides.pdf презентация.pdf
cp out/full.pdf диплом.pdf
