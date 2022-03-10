.PHONY: help venv-create-linux venv-create-windows venv-activate-linux venv-activate-windows

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

venv-create-linux: ## Cria ambiente virtual python em sistema operacional linux
	@echo 'Criando ambiente virtual python...'
	@python3 -m venv venv

venv-create-windows: ## Cria ambiente virtual python em sistema operacional windows
	@echo 'Criando ambiente virtual python...'
	@python -m venv venv

venv-activate-linux: ## Ativa ambiente virtual python em sistema operacional linux
	@echo 'Ativando ambiente virtual python...'
	@source venv/bin/activate

venv-activate-windows:  ## Ativa ambiente virtual python em sistema operacional windows
	@echo 'Ativando ambiente virtual python...'
	@source venv/Scripts/activate

install-packages: ## Instala pacotes python necessários para publicação de daos
	@echo 'Ativando ambiente virtual python...'
	@pip install -r requirements.txt

dataset-validate: ## Valida dataset e todos os seus recursos
	@echo 'Validando dataset...'
	@frictionless validate datapackage.json

dataset-create:
	@dpckan dataset create


