#!/bin/bash

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
cp -f $MYTEX_DIR/out/my.bib $DIR/out/
cp -f $MYTEX_DIR/CMakeLists.txt $DIR/
cp -f $MYTEX_DIR/build.sh $DIR/
cp -f $MYTEX_DIR/UseLATEX.cmake $DIR/cmake/
cp -f $MYTEX_DIR/tex/preamble.inc.tex $DIR/tex/
cp $DIR/tex/* $DIR/out/
cp $DIR/img/* $DIR/out/
cd $DIR/out
if [ "$1" == "--full" ]; then
	cmake ..
	make
else
	xelatex --no-pdf out.tex
	biblatex out.tex
	xelatex out.tex
fi
cp out.pdf $DIR/out.pdf
