include config.mk

.PHONY: help update-upstream start list data describe json compare frictionless validate create update clean

help: ## Informa breve descrição dos comando
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

update-upstream: ## Atualiza repositório a partir do dataset template
	@echo "Adicionando dataset template upstream remote..."
	@-git remote rm upstream
	@-git remote add upstream https://github.com/dados-mg/dataset-template.git
	@git pull upstream main -X ours

start: ## Inicia ambiente para trabalho com conjunto
	@echo 'Iniciando ambiente...'
	@docker run -it -v /$(PWD):/work_dir -e CKAN_HOST=$(CKAN_HOST) -e CKAN_KEY=$(CKAN_KEY) gabrielbdornas/dtamg:latest bash

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

json: datapackage.json ## Constroi datapackage.json a partir de datapackage.yaml

datapackage.json: datapackage.yaml $(CSV_FILES) $(SCHEMAS_FILES)
	@echo "Construindo datapackage.json..."
	@frictionless describe --type package --stats --json $< > $@

compare: ## Compara recursos existentes na pasta data com os incluído no datapackage.json
	@echo 'Comparando recursos pasta data e datapackage.json...'
	@python /scripts/compare.py

frictionless: ## Valida dataset e todos os seus recursos
	@echo 'Validando conjunto...'
	@frictionless validate datapackage.json

validate: data json compare frictionless

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
