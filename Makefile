include config.mk

.PHONY: help venv list validate create update data build clean test

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

test: ## testa
	@echo $(OS)

venv: ## Cria ambiente virtual python e instala pacotes.
	@echo 'Criando ambiente virtual python e instalando pacotes...'
	@rm -rf venv
	@if [ $(OS) = "Linux" ]; then\
	  python3 -m venv venv;\
	  $(ACTIVATE_LINUX); pip install -r requirements.txt;\
	fi
	@if [ $(OS) = "MINGW64" ]; then\
	  python -m venv venv;\
	  $(ACTIVATE_WINDOWS); pip install -r requirements.txt;\
	fi

list: ## Lista pacotes instalados em ambiente virtual python.
	@echo 'Listando pacotes instalados em ambiente virtual python....'
	@if [ $(OS) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); pip list;\
	fi
	@if [ $(OS) = "MINGW64" ]; then\
	  $(ACTIVATE_WINDOWS); pip list;\
	fi

validate: ## Valida dataset e todos os seus recursos
	@echo 'Validando conjunto...'
	@if [ $(OS) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); frictionless validate datapackage.json;\
	fi
	@if [ $(OS) = "MINGW64" ]; then\
	  $(ACTIVATE_WINDOWS); frictionless validate datapackage.json;\
	fi

create: ## Cria dataset e todos os seus recursos em instância do CKAN
	@echo 'Criando conjunto...'
	@if [ $(OS) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); dpckan dataset create;\
	fi
	@if [ $(OS) = "MINGW64" ]; then\
	  $(ACTIVATE_WINDOWS); dpckan --datastore dataset create;\
	fi

update: ## Atualiza dataset e todos os seus recursos em instância do CKAN
	@echo 'Criando conjunto...'
	@if [ $(OS) = "Linux" ]; then\
	  $(ACTIVATE_LINUX); dpckan dataset update;\
	fi
	@if [ $(OS) = "MINGW64" ]; then\
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
