cmake_minimum_required(VERSION 2.8.4)

project(Out NONE)
include(cmake/UseLATEX.cmake)

#set(LATEX_OUTPUT_PATH out/)

set(PDFLATEX_COMPILER xelatex)
set(PDFLATEX_COMPILER_OPTIONS -interaction=nonstopmode)

add_latex_document(
    tex/out.tex
    USE_BIBLATEX
    BIBFILES out/my.bib
#    IMAGE_DIRS images
#    USE_INDEX
    )
