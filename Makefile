include config.mk

.PHONY: help start list validate create update data build clean

help: ## Informa breve descrição dos comando
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

start: ## Inicia ambiente para trabalho com conjunto
	@echo 'Iniciando ambiente...'
	@docker run -it -v /$(PWD):/dataset gabrielbdornas/dtamg:latest bash

exit: ## Fecha ambiente para trabalho com conjunto
	@echo 'Fechando ambiente...'
	@exit

list: ## Lista pacotes instalados em ambiente virtual python
	@echo 'Lista pacotes python instalados...'
	@pip list

validate: ## Valida dataset e todos os seus recursos
	@echo 'Validando conjunto...'
	@frictionless validate datapackage.json

create: ## Cria dataset e todos os seus recursos em instância do CKAN
	@echo 'Criando conjunto...'
	@dpckan --datastore dataset create

update: ## Atualiza dataset e todos os seus recursos em instância do CKAN
	@echo "Atualiza conjunto..."
	@dpckan dataset update

data: $(CSV_FILES)  ## Converte arquivos xlsx para csv

$(CSV_FILES): data/%.csv : upload/%.xlsx
	@echo Converting upload/$*.xlsx file to data/$*.csv...
	@python /scripts/convert_csv.py $< $@

build: datapackage.json ## Build datapackage.json from datapackage.yaml

datapackage.json: datapackage.yaml $(CSV_FILES)
	@echo "Construindo datapackage.json..."
	@frictionless describe --type package --stats --json $< > $@

clean:
	rm -rf data/*.csv
	rm -rf datapackage.json
