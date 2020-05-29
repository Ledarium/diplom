pandoc -t beamer -V theme:metropolis --pdf-engine=xelatex slides.md -o out.pdf --template beamer.tex

pdftk out.pdf cat 1-end 1 output slides.pdf
