XLSX_FILES=$(wildcard data/raw/*.xlsx)
CSV_FILES=$(patsubst data/raw/%.xlsx, data/%.csv, $(XLSX_FILES))