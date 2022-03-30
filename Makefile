include config.mk

.PHONY: help start list data describe build compare validate create update clean

help: ## Informa breve descrição dos comando
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

start: ## Inicia ambiente para trabalho com conjunto
	@echo 'Iniciando ambiente...'
	@docker run -it -v /$(PWD):/dataset -e CKAN_HOST=$(CKAN_HOST) -e CKAN_KEY=$(CKAN_KEY) gabrielbdornas/dtamg:latest bash

list: ## Lista pacotes instalados em ambiente virtual python
	@echo 'Lista pacotes python instalados...'
	@pip list

data: $(CSV_FILES)  ## Converte arquivos xlsx para csv

$(CSV_FILES): data/%.csv : upload/%.xlsx
	@echo Convertendo upload/$*.xlsx file to data/$*.csv...
	@python /scripts/convert_csv.py $< $@

describe: ## Descreve os metadados de um conjunto de dados
	@echo "Gerando datapackage.yaml"
	@frictionless describe --yaml --type package data/* > datapackage.yaml

build: datapackage.json ## Constroi datapackage.json a partir de datapackage.yaml

datapackage.json: datapackage.yaml $(CSV_FILES) $(SCHEMAS_FILES)
	@echo "Construindo datapackage.json..."
	@frictionless describe --type package --stats --json $< > $@

compare: ## Compara recursos existentes na pasta data com os incluído no datapackage.json
	@echo 'Comparando recursos pasta data e datapackage.json...'
	@python /scripts/compare.py

validate: ## Valida dataset e todos os seus recursos
	@echo 'Validando conjunto...'
	@frictionless validate datapackage.json

create: ## Cria dataset e todos os seus recursos em instância do CKAN
	@echo 'Criando conjunto...'
	@dpckan --datastore dataset create

update: ## Atualiza dataset e todos os seus recursos em instância do CKAN
	@echo "Atualiza conjunto..."
	@dpckan dataset update

clean: ## Limpa dados e datapackage.json para github actions
	@echo "Limpando data e datapackage.json..."
	rm -rf data/*.csv
	rm -rf datapackage.json
