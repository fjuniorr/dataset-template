UNAME:= $(shell uname) | cut -d'_' -f 1
OS:= $(UNAME) | cut -d'_' -f 1
ACTIVATE_LINUX:=. venv/bin/activate
ACTIVATE_WINDOWS:=. venv/Scripts/activate
XLSX_FILES=$(wildcard data/raw/*.xlsx)
CSV_FILES=$(patsubst data/raw/%.xlsx, data/%.csv, $(XLSX_FILES))