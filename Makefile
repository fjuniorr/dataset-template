include config.mk

.PHONY: help venv list validate create update data build clean

UNAME := $(shell uname)
ACTIVATE_LINUX:=. venv/bin/activate
ACTIVATE_WINDOWS:=. venv/Scripts/activate

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

venv: ## Cria ambiente virtual python e instala pacotes.
	@echo 'Criando ambiente virtual python e instalando pacotes...'
	@rm -rf venv
	@if [ $(UNAME) = "Linux" ]; then\
	  python3 -m venv venv;\
	  $(ACTIVATE_LINUX); pip install -r requirements.txt;\
	fi
	@if [ $(UNAME) = "MINGW64_NT-10.0-18362" ]; then\
	  python -m venv venv;\
	  $(ACTIVATE_WINDOWS); pip install -r requirements.txt;\
	fi

list: ## Lista pacotes instalados em ambiente virtual python.
	@echo 'Listando pacotes instalados em ambiente virtual python....'
	@if [ $(UNAME) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); pip list;\
	fi
	@if [ $(UNAME) = "MINGW64_NT-10.0-18362" ]; then\
	  $(ACTIVATE_WINDOWS); pip list;\
	fi

validate: ## Valida dataset e todos os seus recursos
	@echo 'Validando conjunto...'
	@if [ $(UNAME) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); frictionless validate datapackage.json;\
	fi
	@if [ $(UNAME) = "MINGW64_NT-10.0-18362" ]; then\
	  $(ACTIVATE_WINDOWS); frictionless validate datapackage.json;\
	fi

create: ## Cria dataset e todos os seus recursos em instância do CKAN
	@echo 'Criando conjunto...'
	@if [ $(UNAME) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); dpckan dataset create;\
	fi
	@if [ $(UNAME) = "MINGW64_NT-10.0-18362" ]; then\
	  $(ACTIVATE_WINDOWS); dpckan dataset create;\
	fi

update: ## Atualiza dataset e todos os seus recursos em instância do CKAN
	@echo 'Criando conjunto...'
	@if [ $(UNAME) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); dpckan dataset update;\
	fi
	@if [ $(UNAME) = "MINGW64_NT-10.0-18362" ]; then\
	  $(ACTIVATE_WINDOWS); dpckan dataset update;\
	fi

data: ## Converte arquivos xls ou xlsx in csv
	@echo Converting xls or xlsx to csv...
	@dtamg-py template convert

build: datapackage.json

datapackage.json: datapackage.yaml $(CSV_FILES) ## Build datapackage.json from datapackage.yaml
	@echo "Building datapackage.json..."
	@frictionless describe --type package --stats --json $< > $@

clean:
	rm -rf data/*.csv
	rm -rf datapackage.json
