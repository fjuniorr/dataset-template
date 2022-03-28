XLSX_FILES= $(wildcard upload/*.xlsx)
CSV_FILES= $(patsubst upload/%.xlsx, data/%.csv, $(XLSX_FILES))